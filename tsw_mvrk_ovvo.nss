//::///////////////////////////////////////////////
//:: Overwhelming Volley by Alexander G.
//::///////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{
    //Leave if not ranged weapon
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    int nType = GetBaseItemType(oWep);
    if(!GetWeaponRanged(oWep))
    {
        SendMessageToPC(OBJECT_SELF, "Requires a ranged weapon.");
        return;
    }


    //Declare major variables
    float fDist;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    float fSize = GetSpellArea(10.0);
    object oTarget;
    object oCaster = OBJECT_SELF;
    effect eFire;
    string sTargets;
    string sElement;
    int nReduction;
    int nFinalDamage;
    location lSpellTarget = GetSpellTargetLocation();

    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_FNF_SOUND_BURST_SILENT);
    effect eImpact = EffectVisualEffect(VFX_COM_HIT_SONIC);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SONIC, FALSE, 1.5, [0.0, 0.0, 1.5]);

    //Apply the forward explosions
    float fDelay2;
    location lVFX;
    int nVFXCounter;
    while(nVFXCounter < 5)
    {
        fDelay2 = fDelay2 + 0.15;
        lVFX = GetNewRandomLocation(lSpellTarget, 6.0);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lVFX));
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis2, lVFX));
        nVFXCounter = nVFXCounter + 1;
    }

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, fSize, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetEighthLevelDamage(oTarget, nCasterLevel, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Soni";
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Signal spell cast at event to fire.
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BURNING_HANDS));
            //Calculate the delay time on the application of effects based on the distance
            //between the caster and the target
            fDist = GetDistanceBetween(OBJECT_SELF, oTarget)/20;

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            eFire = EffectDamage(nFinalDamage, DAMAGE_TYPE_SONIC);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, fSize, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    DoClassMechanic("Force", sTargets, nFinalDamage, oMainTarget);
    DoMartialMechanic("Assault", sTargets, nFinalDamage, oMainTarget);

    //Play weapon shot sounds
    int nSound = GetWeaponSound(OBJECT_SELF);
    int nCount = 0;
    float fShotDelay = 0.15;
    float fIncrement = 0.15;
    PlaySoundByStrRef(nSound, FALSE);
    while(nCount <= 5)
    {
        DelayCommand(fShotDelay, PlaySoundByStrRef(nSound, FALSE));
        nCount = nCount + 1;
        fShotDelay = fShotDelay + fIncrement;
    }
}
