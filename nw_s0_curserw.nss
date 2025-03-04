//::///////////////////////////////////////////////
//:: Cure Serious Wounds
//:: NW_S0_CurSerW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// As cure light wounds, except cure moderate wounds
// cures 3d8 points of damage plus 1 point per caster
// level (up to +15).
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18, 2000
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 25, 2001

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

    //Roll heal
    object oTarget = OBJECT_SELF;
    object oHeal;
    string sElement = "Holy";
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nHeal = GetThirdLevelDamage(oHeal, nCasterLvl, nMetaMagic, "Single");

    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
    int nDC = GetSpellSaveDC();
    int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
    nDC = nDC + nBonusDC;
    nHeal = GetFocusDmg(OBJECT_SELF, nHeal, sElement);
    if(nHeal > 150)
    {
        nHeal = 150;
    }

    //Function call
    spellsCure(nHeal, 0, nHeal, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_S, GetSpellId());
}

