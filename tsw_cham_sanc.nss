//::///////////////////////////////////////////////
//:: Sanctio by Alexander G.
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    object oTarget = GetSpellTargetObject();
    location lTarget = GetLocation(oTarget);
    int nCasterLvl = 5;
    float fSize = GetSpellArea(8.0);
    float fDuration = GetExtendSpell(6.0);

    effect eVis = EffectVisualEffect(VFX_COM_HIT_FIRE);
    effect eExplosion = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
    effect eStun = EffectStunned();
    effect eRooted = EffectEntangle();
    effect eBeam = EffectBeam(VFX_BEAM_CHAIN, OBJECT_SELF, BODY_NODE_CHEST, FALSE, 2.0);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosion, OBJECT_SELF);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        int nStartingDamage = GetFourthLevelDamage(oTarget, nCasterLvl, sTargets);
        nStartingDamage = nStartingDamage /2;

        //Buff damage by Amplification elvel
        nStartingDamage = GetAmp(nStartingDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Fire";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        int nDamage = GetFocusDmg(OBJECT_SELF, nStartingDamage, sElement);

        //Adjust damage based on Alchemite and Saving Throw
        int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

        //Track the first valid target for class mechanics
        object oMainTarget = oTarget;
        int nTargetCheck = 0;
    //End Custom Spell-Function Block

    //Debug Line
    //string sDC = IntToString(nDC);
    //string sDmg = IntToString(nDamage);
    //SendMessageToPC(oCaster, "Your final DC is: " + sDC + " and your final damage is: " + sDmg);

    //Damage Effect
    effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, 1.5);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, 0.75f*fDuration);

    //New beam effect from main target to secondary ones
    eBeam = EffectBeam(VFX_BEAM_CHAIN, oMainTarget, BODY_NODE_CHEST, FALSE, 2.0);

    if ( oTarget  == GetLocalObject(OBJECT_SELF,"oChampionsBanner") && oTarget != OBJECT_INVALID)
    {

            effect eSpikeSlow = EffectSlow();
            effect eSpikeVis = EffectVisualEffect(VFX_IMP_SPIKE_TRAP);
            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
            //Get the Alchemite resistance reduction
            string sSpikeElement = "Piercing";
            int nSpikeReduction = GetFocusReduction(OBJECT_SELF, sElement);

            //Buff damage bonus on Alchemite
            int nSpikeDamage = FloatToInt(0.75*GetFocusDmg(OBJECT_SELF, nStartingDamage, sSpikeElement));

            //Adjust damage based on Alchemite and Saving Throw
            int nSpikeFinalDamage = GetReflexDamage(oTarget, nSpikeReduction, nSpikeDamage);

            effect eSpikeDam = EffectDamage(nSpikeFinalDamage, DAMAGE_TYPE_PIERCING);
         while(GetIsObjectValid(oTarget))
        {
            if(GetIsEnemy(oTarget))
            {
                fDuration = GetReflexDuration(oTarget, nReduction, fDuration);
                DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpikeVis, oTarget));
                DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpikeSlow, oTarget, 2.5f*fDuration));
                DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpikeDam, oTarget));

            }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        }
    }

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            fDuration = GetReflexDuration(oTarget, nReduction, fDuration);
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, 1.5*fDuration);
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRooted, oTarget, 1.5f*fDuration));

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Assign target to jump to
            SetLocalObject(oTarget, "CHAMP_JUMP_TARGET", oMainTarget);
            SetLocalObject(oTarget, "CHAMP_CASTER", OBJECT_SELF);
            SetLocalObject(oTarget, "CHAMP_JUMP_TARGET", oMainTarget);
            SetLocalObject(oTarget, "CHAMP_CASTER", OBJECT_SELF);

            //Do jump script
            DelayCommand(0.65, ExecuteScript("tsw_cham_jump", oTarget));
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    DoMartialMechanic("Assault", sTargets, nFinalDamage, oTarget);
    DoClassMechanic("Control", sTargets, nFinalDamage, oTarget);
}
