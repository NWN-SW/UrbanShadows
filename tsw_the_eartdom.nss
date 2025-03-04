//::///////////////////////////////////////////////
//Theurgist Earth Domain by Alexander G.
//:://////////////////////////////////////////////

void RockDamage(location lImpact);

#include "spell_dmg_inc"
#include "x0_i0_spells"
#include "tsw_class_func"

void main()
{
    //Do damage here...//354 for impact
    effect eImpact = EffectVisualEffect(354);
    effect eImpac1 = EffectVisualEffect(460);
    location lImpact = GetSpellTargetLocation();

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lImpact);
    DelayCommand(0.2,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpac1, lImpact));
    RockDamage(lImpact);
}

void RockDamage(location lImpact)
{
    float fDelay;
    int nDamage;
    effect eDam;
    string sTargets;
    int nFinalDamage;
    int nTargetCheck;
    object oMainTarget;
    string sElement;
    object oCaster = OBJECT_SELF;
    int nReduction;
    float fSize = GetSpellArea(7.0);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lImpact, TRUE, OBJECT_TYPE_CREATURE);

    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeHostile(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lImpact, GetLocation(oTarget))/20;

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSeventhLevelDamage(oTarget, nCasterLvl, sTargets);
                nDamage = nDamage / 2;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Acid";
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_BLUDGEONING);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            }
        }
        else
        {
            //Declare major variables
            effect eStone;
            //effect eVis = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
            effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

            effect eLink;
            int nAmount = GetHighestAbilityModifier(OBJECT_SELF) * 10;
            float fDuration = GetExtendSpell(60.0);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

            //Define the damage reduction effect
            eStone = EffectDamageReduction(10, DAMAGE_POWER_PLUS_TEN, nAmount);
            //Link the effects
            //eLink = EffectLinkEffects(eStone, eVis);
            eLink = EffectLinkEffects(eStone, eDur);

            RemoveEffectsFromSpell(oTarget, GetSpellId());

            //Apply the linked effects.
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
        }

        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lImpact, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    string sSpellType = "Force";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Buff", sTargets, nFinalDamage, oMainTarget);
}
