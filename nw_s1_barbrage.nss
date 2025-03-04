//::///////////////////////////////////////////////
//:: Barbarian Rage
//:: NW_S1_BarbRage
//:://////////////////////////////////////////////
/*
    The Attack, Damage, and Health of the Barbarian increases,
    Will Save are +2, AC -2.
    Greater Rage starts at level 15.
*/
//:://////////////////////////////////////////////
//:: Created By: Alexander Gates
//:: Created On: September 12, 2020
//:://////////////////////////////////////////////

#include "x2_i0_spells"

void main()
{
    if(!GetHasFeatEffect(FEAT_BARBARIAN_RAGE))
    {
        //Declare major variables
        int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
        int nDamageIncrease;
        int nAttackIncrease;
        int nHP;
        int nSave;
        //Barbarians below level 15 get these stats, else they get more.
        if (nLevel < 15)
        {
            nDamageIncrease = 4;
            nAttackIncrease = 4;
            nHP = 100;
            nSave = 4;
        }
        else
        {
            nDamageIncrease = DAMAGE_BONUS_8;
            nAttackIncrease = 8;
            nHP = 200;
            nSave = 6;
        }
        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        //Determine the duration by getting the CON modifier
        int nCon = 3 * GetAbilityModifier(ABILITY_CONSTITUTION);
        if(nCon < 3)
        {
            nCon == 3;
        }
        //Create effects based on nIncrease, nHP, and nSave
        effect eAtk = EffectAttackIncrease(nAttackIncrease, ATTACK_BONUS_MISC);
        effect eDam = EffectDamageIncrease(nDamageIncrease, DAMAGE_TYPE_MAGICAL);
        effect eHP = EffectTemporaryHitpoints(nHP);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nSave);
        effect eAC = EffectACDecrease(2, AC_DODGE_BONUS);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

        effect eLink = EffectLinkEffects(eAtk, eDam);
        //eLink = EffectLinkEffects(eLink, eHP);
        eLink = EffectLinkEffects(eLink, eSave);
        eLink = EffectLinkEffects(eLink, eAC);
        eLink = EffectLinkEffects(eLink, eDur);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BARBARIAN_RAGE, FALSE));
        //Make effect extraordinary
        eLink = ExtraordinaryEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE); //Change to the Rage VFX

        if (nCon > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, OBJECT_SELF, RoundsToSeconds(nCon));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;

        // 2003-07-08, Georg: Rage Epic Feat Handling
        CheckAndApplyEpicRageFeats(nCon);
        }
    }
}

