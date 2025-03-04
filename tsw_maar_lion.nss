//Martial Artists Lionheart Aura by Alexander G.

#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eVis2 = EffectVisualEffect(VFX_IMP_PULSE_WATER);
    effect eAura = EffectVisualEffect(VFX_DUR_AURA_COLD);
    object oTarget = OBJECT_SELF;
    int nCount = 0;
    float fDuration = GetExtendSpell(60.0);

    if(GetHasFeat(MAAR_PATH_OF_RUIN))
    {
        eAura = EffectVisualEffect(276);
        eVis2 = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    }

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Set and apply AOE object
    effect eAOE = EffectRunScript("", "", "tsw_maar_aura", 2.0);
    eAOE = EffectLinkEffects(eAOE, eAura);
    //Make the effect supernatural
    eAOE = SupernaturalEffect(eAOE);
    //Add a tag to the effect for removal later
    eAOE = TagEffect(eAOE, "LIONHEART_AURA_ORIGIN");

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
    //Class mechanics
    string sSpellType = "Tactic";
    DoMartialMechanic(sSpellType, "AOE", 0, oTarget);
    DoClassMechanic("Buff", "AOE", 0, oTarget);
}
