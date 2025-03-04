//::///////////////////////////////////////////////
//:: Cloudkill: On Enter
//:: NW_S0_CloudKillA.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All creatures with 3 or less HD die, those with
    4 to 6 HD must make a save Fortitude Save or die.
    Those with more than 6 HD take 1d10 Poison damage
    every round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 17, 2001
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "spell_dmg_inc"

void main()
{


    //Declare major variables
    object oTarget = GetEnteringObject();
    int nHD = GetHitDice(oTarget);
    effect eDeath = EffectDeath();
    effect eVis =   EffectVisualEffect(VFX_IMP_DEATH);
    effect eNeg = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eSpeed = EffectMovementSpeedDecrease(50);
    effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eSpeed, eVis2);

    float fDelay= GetRandomDelay(0.5, 1.5);
    effect eDam;
    int nDamage;
    int nMetaMagic = GetMetaMagicFeat();

    //Roll damage for each target
    int nCasterLvl = GetCasterLevel(GetAreaOfEffectCreator());
    nDamage = GetFifthLevelDamage(oTarget, nCasterLvl, nMetaMagic, "AOE");

    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
    string sElement = "Nega";
    int nDC = GetSpellSaveDC();
    int nBonusDC = GetFocusDC(GetAreaOfEffectCreator(), sElement);
    nDC = nDC + nBonusDC;
    nDamage = GetFocusDmg(GetAreaOfEffectCreator(), nDamage, sElement);
    nDamage = nDamage / 6;
    nDamage = GetReflexDamage(oTarget, nDC, nDamage);

    eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    if(spellsIsTarget(oTarget,SPELL_TARGET_STANDARDHOSTILE , GetAreaOfEffectCreator()) )
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CLOUDKILL));
        //Make SR Check
        if(!MyResistSpell(GetAreaOfEffectCreator(), oTarget, fDelay))
        {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eNeg, oTarget));
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeed, oTarget);
            }
        }
    }
}
