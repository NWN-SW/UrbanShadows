//::///////////////////////////////////////////////
//:: Destruction
//:: NW_S0_Destruc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The target creature is destroyed if it fails a
    Fort save, otherwise it takes 10d6 damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 13, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

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
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    effect eDeath = EffectDeath();
    effect eDam;
    effect eVis = EffectVisualEffect(234);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DESTRUCTION));
        //Make SR check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Roll damage for each target
            nDamage = GetSeventhLevelDamage(oTarget, nLevel, nMetaMagic, "Single");

            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            string sElement = "Nega";
            int nDC = GetSpellSaveDC();
            int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
            nDC = nDC + nBonusDC;
            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            nDamage = GetFortDamage(oTarget, nDC, nDamage);

            eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);

            //Apply VFX impact
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}
