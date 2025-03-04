//::///////////////////////////////////////////////
//:: Serpentsoul by Alexander G.
//:://////////////////////////////////////////////

#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{
    //Declare major variables
    int nAmount = GetHighestAbilityModifier(OBJECT_SELF);

    //Double effect for Talonstrike
    int nCheck = GetLocalInt(OBJECT_SELF, "TALONSTRIKE_ACTIVE");
    if(nCheck > 0)
    {
        nAmount = nAmount * 2;
        DeleteLocalInt(OBJECT_SELF, "TALONSTRIKE_ACTIVE");
    }

    if(nCheck > 20)
    {
        nCheck = 20;
    }

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;
    //Custom spell size
    float fSize = GetSpellArea(10.0);
    effect eVisBad = EffectVisualEffect(1078);
    effect eVisGood = EffectVisualEffect(500);
    effect eImpact = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    effect eSavesGood = EffectSavingThrowIncrease(SAVING_THROW_ALL, nAmount);
    effect eSavesBad = EffectSavingThrowDecrease(SAVING_THROW_ALL, nAmount);
    string sTargets;
    string sElement;
    int nTotalDamage;
    int nReduction;
    int nSpell = GetSpellId();
    //Apply Fire and Forget Visual in the area;
    if(GetHasFeat(MAAR_PATH_OF_BALANCE))
    {
        eImpact = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(OBJECT_SELF));

    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    // Calculate the duration
    float fDuration = GetExtendSpell(60.0);
    float fFinalDuration;

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (GetIsReactionTypeHostile(oTarget) && oTarget != OBJECT_SELF && GetHasFeat(MAAR_PATH_OF_RUIN))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));

            //Start Custom Spell-Function Block
                sTargets = "AOE";

                //Get the Alchemite resistance reduction
                sElement = "Soni";
                nReduction = GetFocusReduction(OBJECT_SELF, sElement);
            //End Custom Spell-Function Block

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust duration
            fFinalDuration = GetWillDuration(oTarget, nReduction, fDuration);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisBad, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSavesBad, oTarget, fFinalDuration);
        }

        if (!GetIsReactionTypeHostile(oTarget) && GetHasFeat(MAAR_PATH_OF_BALANCE))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell, FALSE));

            //Start Custom Spell-Function Block
                sTargets = "AOE";

                //Get the Alchemite resistance reduction
                sElement = "Bludge";
                nReduction = GetFocusReduction(OBJECT_SELF, sElement);
            //End Custom Spell-Function Block

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisGood, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSavesGood, oTarget, fDuration);
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    string sType = "Debuff";

    if(GetHasFeat(MAAR_PATH_OF_BALANCE))
    {
        sType = "Buff";
    }
    DoMartialMechanic("Tactic", sTargets, 0, oMainTarget);
    DoClassMechanic(sType, sTargets, 0, oMainTarget);
}


