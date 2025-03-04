//::///////////////////////////////////////////////
//:: Blade Barrier: On Enter
//:: NW_S0_BladeBarA.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a wall 10m long and 2m thick of whirling
    blades that hack and slice anything moving into
    them.  Anything caught in the blades takes
    2d6 per caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 20, 2001
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

void main()
{




    //Declare major variables
    object oTarget = GetEnteringObject();
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = GetCasterLevel(GetAreaOfEffectCreator());
    int nDamage;

    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
    {
        //Fire spell cast at event
        SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_BLADE_BARRIER));
        //Roll damage for each target
        nDamage = GetSixthLevelDamage(oTarget, nCasterLvl, nMetaMagic, "AoE");

        //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
        string sElement = "Magi";
        int nDC = GetSpellSaveDC();
        int nBonusDC = GetFocusDC(GetAreaOfEffectCreator(), sElement);
        nDC = nDC + nBonusDC;
        nDamage = GetFocusDmg(GetAreaOfEffectCreator(), nDamage, sElement);
        nDamage = GetReflexDamage(oTarget, nDC, nDamage);
        nDamage = nDamage / 3;
        //Make SR Check
        if (!MyResistSpell(GetAreaOfEffectCreator(), oTarget) )
        {
            //Set damage effect
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING);
            //Apply damage and VFX
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}

