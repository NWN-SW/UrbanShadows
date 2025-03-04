#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    if(oSummon == OBJECT_INVALID)
    {
        SendMessageToPC(OBJECT_SELF, "You must have an active summon to use this ability.");
        return;

    }

    //Major variables
    object oCaster = OBJECT_SELF;
    int nAmount = GetHighestAbilityModifier(oCaster);
    effect eAC = EffectACIncrease(2);
    effect eDamage = EffectDamageIncrease(GetPureDamage(nAmount));
    float fDuration = GetExtendSpell(120.0);

    //Fire cast spell at event for the specified target
    SignalEvent(oSummon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    effect eVis = EffectVisualEffect(1075);
    //Apply the VFX impact and damage effect
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oSummon);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oSummon, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage, oSummon, fDuration);

    //Class mechanics
    DoClassMechanic("Buff", "Single", nAmount, oSummon);
}
