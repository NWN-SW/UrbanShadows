//::///////////////////////////////////////////////
//:: Cure Light Wounds
//:: NW_S0_CurLgtW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// When laying your hand upon a living creature,
// you channel positive energy that cures 1d8 points
// of damage plus 1 point per caster level (up to +5).
// Since undead are powered by negative energy, this
// spell inflicts damage on them instead of curing
// their wounds. An undead creature can attempt a
// Will save to take half damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Brennon Holmes
//:: Created On: Oct 12, 2000
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 26, 2001

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
    string sElement = "Holy";
    object oHeal;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nHeal = GetFirstLevelDamage(oHeal, nCasterLvl, nMetaMagic, "Single");

    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
    int nDC = GetSpellSaveDC();
    int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
    nDC = nDC + nBonusDC;
    nHeal = GetFocusDmg(OBJECT_SELF, nHeal, sElement);
    if(nHeal > 90)
    {
        nHeal = 90;
    }

    //Function call
    spellsCure(nHeal, 0, nHeal, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_S, GetSpellId());
}

