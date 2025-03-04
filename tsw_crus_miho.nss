//::///////////////////////////////////////////////
//Might and Honour by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

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
    //Declare major variables
    object oCaster = OBJECT_SELF;
    float fSize = GetSpellArea(10.0);
    effect eDam;
    string sTargets;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    object oMainTarget;
    int nTargetCheck = 0;
    int nAmount = GetPureDamage(GetHighestAbilityModifier(OBJECT_SELF));
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eBoom = EffectVisualEffect(VFX_IMP_GOOD_HELP, FALSE, 1.0);
    effect eDamage;
    float fDuration = GetExtendSpell(60.0);
    float fDelay;
    string sElement;
    //Apply Fire and Forget Visual in the area;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, OBJECT_SELF);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (!GetIsReactionTypeHostile(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

            //Bonus damage equals highest modifier
            eDamage = EffectDamageIncrease(nAmount, DAMAGE_TYPE_DIVINE);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            // Apply effects to the currently selected target.
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }

    DoClassMechanic("Buff", "AOE", 0, oMainTarget);
    DoMartialMechanic("Tactic", "AOE", 0, oMainTarget);
}
