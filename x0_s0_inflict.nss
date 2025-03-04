//::///////////////////////////////////////////////
//:: [Inflict Wounds]
//:: [X0_S0_Inflict.nss]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
//:: This script is used by all the inflict spells
//::
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:

#include "X0_I0_SPELLS" // * this is the new spells include for expansion packs
#include "spell_dmg_inc"
#include "x2_inc_spellhook"

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

    //Roll damage
    object oTarget = GetSpellTargetObject();
    string sElement = "Nega";
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;

    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
    int nDC = GetSpellSaveDC();
    int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
    nDC = nDC + nBonusDC;

    int nSpellID = GetSpellId();
    switch (nSpellID)
    {
/*Minor*/     case 431:
                spellsInflictTouchAttack(1, 0, 1, 246, VFX_IMP_HEALING_G, nSpellID);
                break;
/*Light*/     case 432: case 609:
                nDamage = GetFirstLevelDamage(oTarget, nCasterLvl, nMetaMagic, "Single");
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
                spellsInflictTouchAttack(nDamage, 0, 60, 246, VFX_IMP_HEALING_G, nSpellID);
                break;
/*Moderate*/  case 433: case 610:
                nDamage = GetSecondLevelDamage(oTarget, nCasterLvl, nMetaMagic, "Single");
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
                spellsInflictTouchAttack(nDamage, 0, 80, 246, VFX_IMP_HEALING_G, nSpellID);
                break;
/*Serious*/   case 434: case 611:
                nDamage = GetThirdLevelDamage(oTarget, nCasterLvl, nMetaMagic, "Single");
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
                spellsInflictTouchAttack(nDamage, 0, 120, 246, VFX_IMP_HEALING_G, nSpellID);
                break;
/*Critical*/  case 435: case 612:
                nDamage = GetFourthLevelDamage(oTarget, nCasterLvl, nMetaMagic, "Single");
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
                spellsInflictTouchAttack(nDamage, 0, 160, 246, VFX_IMP_HEALING_G, nSpellID);
                break;

    }
}
