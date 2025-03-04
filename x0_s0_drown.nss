//::///////////////////////////////////////////////
//:: Drown
//:: [X0_S0_Drown.nss]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    if the creature fails a FORT throw.
    Does not work against Undead, Constructs, or Elementals.

January 2003:
 - Changed to instant kill the target.
May 2003:
 - Changed damage to 90% of current HP, instead of instant kill.

*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 26 2002
//:://////////////////////////////////////////////
//:: Last Update By: Andrew Nobbs May 01, 2003

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

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
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    int nMetaMagic = GetMetaMagicFeat();
    //Set visual effect
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eDam;
    //Check faction of target
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 437));
        //Make SR Check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Roll damage for each target
            nDamage = GetSixthLevelDamage(oTarget, nCasterLevel, nMetaMagic, "Single");

            //Adjust the damage
            string sElement = "Cold";
            int nDC = GetSpellSaveDC();
            int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
            nDC = nDC + nBonusDC;
            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            nDamage = GetReflexDamage(oTarget, nDC, nDamage);
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
            //Apply the VFX impact and damage effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        }
    }
}





