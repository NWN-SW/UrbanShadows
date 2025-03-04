//::///////////////////////////////////////////////
//:: Frenzy by Alexander G.
//::///////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables

    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nDamage;
    int nFinalDamage;
    float fDelay = 1.0;
    string sTargets;
    string sElement;
    int nReduction;
    float fSize = GetSpellArea(10.0);
    effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
    if(GetGender(OBJECT_SELF) == GENDER_FEMALE)
    {
        eExplode = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    }
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
    effect eVis2 = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL);
    effect eDam;
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect ePara = EffectStunned();
    effect eStun = EffectVisualEffect(VFX_IMP_STUN);
    location lJump;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();

    //Track the first valid target for class mechanics
    object oMainTarget = GetSpellTargetObject();
    int nTargetCheck = 0;

    //Teleport to Enemy
    lJump = GetNewRandomLocation(GetLocation(oMainTarget), 1.0);
    DelayCommand(0.75, JumpToLocation(lJump));

    //Sound Effects
    PlaySoundByStrRef(16778143, FALSE);

    //Visual effects on Caster
    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF));
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplode, OBJECT_SELF));

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeHostile(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = 1.0;

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetEighthLevelDamage(oTarget, nCasterLvl, sTargets);
                nDamage = nDamage / 2;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Slash";
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            float fDuration = GetWillDuration(oTarget, nReduction, 6.0);

            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_SLASHING);
            // * caster can't be affected by the spell
            if((nDamage > 0))
            {
                //Sound Effects
                DelayCommand(0.6, PlaySoundByStrRef(16778116, FALSE));

                //Paralysis effect
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oTarget, fDuration));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fDuration));
                SetLocalInt(oTarget, "BRAWLER_FRENZY_TARGET", 1);

                //Slowly lift target into air
                DelayCommand(0.75, ExecuteScript("tsw_braw_jump", oTarget));

                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));

                //Undolift
                DelayCommand(fDelay, ExecuteScript("tsw_reset_height", oTarget));
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Sound Effects
    PlaySoundByStrRef(16778142, FALSE);
    DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, GetLocation(OBJECT_SELF)));

    //Attack Nearest Enemy
    DelayCommand(0.8, AttackNearest(3.0, OBJECT_SELF));

    //Class mechanics
    DoMartialMechanic("Assault", sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Control", sTargets, nFinalDamage, oMainTarget);
}





