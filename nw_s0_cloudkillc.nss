//::///////////////////////////////////////////////
//:: Cloudkill: Heartbeat
//:: NW_S0_CloudKillC.nss
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
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = d10();
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    object oTarget;
    float fDelay;

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

   //--------------------------------------------------------------------------
    // GZ 2003-Oct-15
    // When the caster is no longer there, all functions calling
    // GetAreaOfEffectCreator will fail. Its better to remove the barrier then
    //--------------------------------------------------------------------------
    if (!GetIsObjectValid(GetAreaOfEffectCreator()))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }


    //Set damage effect
    eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    //Get the first object in the persistant AOE
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();
        if(spellsIsTarget(oTarget,SPELL_TARGET_STANDARDHOSTILE , GetAreaOfEffectCreator()) )
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CLOUDKILL));
            if(!MyResistSpell(GetAreaOfEffectCreator(), oTarget, fDelay))
            {
                //Apply VFX impact and damage
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Get the next target in the AOE
        oTarget = GetNextInPersistentObject();
    }
}
