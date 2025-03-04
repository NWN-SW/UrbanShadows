//::///////////////////////////////////////////////
//:: Power Word, Kill
//:: NW_S0_PWKill
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// When power word, kill is uttered, you can either
// target a single creature or let the spell affect a
// group.
// If power word, kill is targeted at a single creature,
// that creature dies if it has 100 or fewer hit points.
// If the power word, kill is cast as an area spell, it
// kills creatures in a 15-foot-radius sphere. It only
// kills creatures that have 20 or fewer hit points, and
// only up to a total of 200 hit points of such
// creatures. The spell affects creatures with the lowest.
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Dec 18, 2000
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001
//:: Update Pass By: Preston W, On: Aug 3, 2001
#include "X0_I0_SPELLS"
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


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    int nMetaMagic;
    int nHitpoints, nMin;
    object oWeakest;
    effect eDeath = EffectDeath();
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eWord =  EffectVisualEffect(VFX_FNF_PWKILL);
    effect eVis2 = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    float fDelay;
    int bKill;
    //Apply the VFX impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eWord, GetSpellTargetLocation());
    //Check for the single creature or area targeting of the spell
    if (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_POWER_WORD_KILL));
            //Roll damage for each target
            nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, nMetaMagic, "Single");

            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            int nDC = GetSpellSaveDC();
            string sElement = "Nega";
            int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
            nDC = nDC + nBonusDC;
            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            nDamage = GetFortDamage(OBJECT_SELF, nDC, nDamage);
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        }
    }
    else
    {
        //Get the first target in the spell area
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation(), FALSE, OBJECT_TYPE_CREATURE);
        while (GetIsObjectValid(oTarget))
        {
            //Make SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget) && spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
               {
                    //Roll damage for each target
                    nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, nMetaMagic, "AOE");

                    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                    int nDC = GetSpellSaveDC();
                    string sElement = "Nega";
                    int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
                    nDC = nDC + nBonusDC;
                    nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
                    nDamage = GetFortDamage(OBJECT_SELF, nDC, nDamage);
                    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
                }
            //Get next target in the spell area
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation(), FALSE, OBJECT_TYPE_CREATURE);
        }
    }
}
