//::///////////////////////////////////////////////
//:: Swarm Shot by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

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
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nDamage;
    int nFinalDamage;
    float fDelay;
    float fMissDelay;
    float fSize = GetSpellArea(10.0);
    effect eMissile = EffectVisualEffect(837);
    effect eImpact = EffectVisualEffect(VFX_IMP_SONIC);
    effect eDam;
    float fDist;
    float fIncrement = 0.1;
    string sTargets;
    string sElement;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    object oMainTarget;
    int nTargetCheck = 0;
    int nTargetCount;

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Get distance and do calculation for delay before impact
            float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
            float fDelay = fDist/(3.0 * log(fDist) + 2.0);

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSixthLevelDamage(oTarget, nCasterLvl, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Soni";
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_SONIC);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
                nTargetCount = nTargetCount + 1;
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    }

    //Class mechanics
    DoClassMechanic("Force", sTargets, nFinalDamage, oMainTarget);
    DoMartialMechanic("Assault", sTargets, nFinalDamage, oMainTarget);

    //Play weapon shot sounds
    int nSound = GetWeaponSound(OBJECT_SELF);
    int nCount = 0;
    float fShotDelay = 0.1;
    fIncrement = 0.1;
    PlaySoundByStrRef(nSound, FALSE);
    while(nCount <= nTargetCount)
    {
        DelayCommand(fShotDelay, PlaySoundByStrRef(nSound, FALSE));
        nCount = nCount + 1;
        fShotDelay = fShotDelay + fIncrement;
    }
}


