//::///////////////////////////////////////////////
//New Divine Wrath by Alexander G.
//:://////////////////////////////////////////////

#include "nw_i0_spells"

void main()
{
    //Declare major variables
    object oTarget = OBJECT_SELF;
    int nDuration = GetLevelByClass(32) / 3;
    //Check that if nDuration is not above 0, make it 1.
    if(nDuration <= 0)
    {
        FloatingTextStrRefOnCreature(100967,OBJECT_SELF);
        return;
    }

    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    eVis = EffectLinkEffects(EffectVisualEffect(VFX_IMP_GOOD_HELP),eVis);
    effect eAttack, eDamage, eSaving, eReduction;
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 621, FALSE));

    int nAttackB = 3;
    int nDamageB = DAMAGE_BONUS_10;
    int nSaveB = 3 ;
    int nDmgRedB = 5;
    int nDmgRedP = DAMAGE_POWER_PLUS_TWENTY;

    // --------------- Epic Progression ---------------------------

    int nLevel = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oTarget) ;
    int nLevelB = (nLevel / 5)-1;
    if (nLevelB <=0)
    {
        nLevelB =0;
    }
    else
    {
        nAttackB += (nLevelB*2); // +2 to attack every 5 levels past 5
        nSaveB += (nLevelB*2); // +2 to saves every 5 levels past 5
    }

    if (nLevelB >6 )
    {
        nDmgRedP = DAMAGE_POWER_PLUS_TWENTY;
        nDmgRedB = 7*5;
        nDamageB = DAMAGE_BONUS_20;
    }
    else if (nLevelB >5 )
    {
        nDmgRedP = DAMAGE_POWER_PLUS_TWENTY;
        nDmgRedB = 6*5;
        nDamageB = DAMAGE_BONUS_20;
    }
    else if (nLevelB >4 )
    {
        nDmgRedP = DAMAGE_POWER_PLUS_TWENTY;
        nDmgRedB = 5*5;
        nDamageB = DAMAGE_BONUS_20;
    }
    else if (nLevelB >3)
    {
        nDmgRedP = DAMAGE_POWER_PLUS_TWENTY;
        nDmgRedB = 4*5;
        nDamageB = DAMAGE_BONUS_20;
    }
    else if (nLevelB >2)
    {
        nDmgRedP = DAMAGE_POWER_PLUS_TWENTY;
        nDmgRedB = 3*5;
        nDamageB = DAMAGE_BONUS_20;
    }
    else if (nLevelB >1)
    {
        nDmgRedP = DAMAGE_POWER_PLUS_TWENTY;
        nDmgRedB = 2*5;
        nDamageB = DAMAGE_BONUS_20;
    }
    else if (nLevelB >0)
    {
        nDamageB = DAMAGE_BONUS_20;
    }
    //--------------------------------------------------------------
    //
    //--------------------------------------------------------------

    eAttack = EffectAttackIncrease(nAttackB,ATTACK_BONUS_MISC);
    eDamage = EffectDamageIncrease(nDamageB, DAMAGE_TYPE_DIVINE);
    eSaving = EffectSavingThrowIncrease(SAVING_THROW_ALL,nSaveB, SAVING_THROW_TYPE_ALL);
    eReduction = EffectDamageReduction(nDmgRedB, nDmgRedP);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eAttack, eDamage);
    eLink = EffectLinkEffects(eSaving,eLink);
    eLink = EffectLinkEffects(eReduction,eLink);
    eLink = EffectLinkEffects(eDur,eLink);
    eLink = SupernaturalEffect(eLink);

    // prevent stacking with self
    RemoveEffectsFromSpell(oTarget, GetSpellId());


    //Apply the armor bonuses and the VFX impact
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
