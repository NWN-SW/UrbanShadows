//::///////////////////////////////////////////////
//:: Flame Strike by Alexander G.
//::///////////////////////////////////////////////

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
    object oTarget;
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDamage, nDamage2;

    //Custom spell size
    float fSize = GetSpellArea(6.0);

    effect eStrike = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eHoly;
    effect eFire;
    string sTargets;
    string sElement;
    int nReduction;
    int nFinalDamage;

    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), FALSE, OBJECT_TYPE_CREATURE);

  //Apply the location impact visual to the caster location instead of caster target creature.
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
  //Cycle through the targets within the spell shape until an invalid object is captured.
  while ( GetIsObjectValid(oTarget) )
  {
       if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
       {
            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetFourthLevelDamage(oTarget, nCasterLvl, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Fire";
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_STRIKE));

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            // Apply effects to the currently selected target.
            eFire =  EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);
            if(nDamage > 0)
            {
                DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize,GetSpellTargetLocation(), FALSE, OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    string sSpellType = "Force";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
}
