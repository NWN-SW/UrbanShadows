///////////////////////////////////////////////////
//Theurgist Sun domain by Alexander G.
///////////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // End of Spell Cast Hook


    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nDamage2;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    effect eVis2 = EffectVisualEffect(VFX_IMP_GOOD_HELP);
    effect eFireStorm = EffectVisualEffect(VFX_FNF_SUNBEAM, FALSE, 0.5);
    effect eBlind = EffectBlindness();
    effect eBuff = EffectACIncrease(6);
    float fDelay = 1.0;
    float fSize = GetSpellArea(RADIUS_SIZE_COLOSSAL);
    string sTargets;
    int nFinalDamage;
    int nTargetCheck;
    object oMainTarget;
    string sElement;
    object oCaster = OBJECT_SELF;
    int nReduction;

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBEAM));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSeventhLevelDamage(oTarget, nCasterLevel, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Holy";
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetWillDamage(oTarget, nReduction, nDamage);

            nFinalDamage = nFinalDamage / 2;
            nDamage2 = nFinalDamage;

            if(nDamage > 0)
            {
                  // Apply effects to the currently selected target.  For this spell we have used
                  //both Divine and Fire damage.
                  effect eDivine = EffectDamage(nDamage2, DAMAGE_TYPE_DIVINE);
                  effect eFire = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDivine, oTarget));
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                  float fDuration = GetExtendSpell(12.0);
                  fDuration = GetWillDuration(oTarget, nReduction, fDuration);
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, fDuration));
            }
        }
        else if(!GetIsReactionTypeHostile(oTarget))
        {
            float fDuration = GetExtendSpell(12.0);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBuff, oTarget, fDuration));
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }
    //Apply Fire and Forget Visual in the area;
    DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF)));

    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Buff", sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Control", sTargets, nFinalDamage, oMainTarget);
}
