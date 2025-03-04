//::///////////////////////////////////////////////
//Technomancer Buff by Alexander G.
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget;
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);


    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_10);

    int nScale = (GetCasterLevel(OBJECT_SELF) / 2);
    // * must fall between +1 and +5
    if (nScale < 1)
        nScale = 1;
    else
    if (nScale > 5)
        nScale = 5;
    // * determine the damage bonus to apply
    effect eAttack = EffectAttackIncrease(nScale);
    effect eDamage = EffectDamageIncrease(nScale, DAMAGE_TYPE_MAGICAL);


    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eDamage);
    eLink = EffectLinkEffects(eLink, eDur);

    int nDuration = GetCasterLevel(OBJECT_SELF); // * Duration 1 turn
    //nDuration = nDuration / 2;
    if ( nMetaMagic == METAMAGIC_EXTEND )
    {
        nDuration = nDuration * 2;
    }

    //Apply Impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = OBJECT_SELF;

    //Fire spell cast at event for target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 414, FALSE));
    //Apply VFX impact and bonus effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(2));

}

