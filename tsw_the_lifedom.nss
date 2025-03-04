///////////////////////////////////////////////////
//Theurgist Life domain by Alexander G.
///////////////////////////////////////////////////

#include "NW_I0_SPELLS"
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
  object oHeal;
  object oCaster = OBJECT_SELF;
  int nCasterLvl = GetCasterLevel(OBJECT_SELF);
  int nDamage, nModify, nHP;
  int nMetaMagic = GetMetaMagicFeat();
  effect eKill;
  effect eHeal;
  effect eVis = EffectVisualEffect(VFX_FNF_MASS_HEAL);
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_X);
  effect eImpact = EffectVisualEffect(VFX_FNF_WORD);
  float fDelay;
  float fSize = GetSpellArea(RADIUS_SIZE_COLOSSAL);
  string sTargets;
  string sElement;
  int nReduction;
  int nFinalDamage;


  //Limit caster level
  if (nCasterLvl > 20)
  {
    nCasterLvl = 20;
  }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    //Get first target in shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();

        // * May 2003: Heal Neutrals as well
        if(!GetIsReactionTypeHostile(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetFifthLevelDamage(oTarget, nCasterLvl, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Holy";
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Set healing effect
            eHeal = EffectHeal(nDamage);
            //Apply heal effect and VFX impact
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
        }
        //Get next target in the shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation());
    }

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, "AOE", 0, oTarget);
}
