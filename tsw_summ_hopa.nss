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

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nHeal = 500;

        //Buff damage by Amplification elvel
        nHeal = GetAmp(nHeal);

        //Get the Alchemite resistance reduction
        string sElement = "Magi";
        int nReduction = GetFocusReduction(oCaster, sElement);

        //Buff damage bonus on Alchemite
        nHeal = GetFocusDmg(oCaster, nHeal, sElement);
        nHeal = nHeal / 10;
    //End Custom Spell-Function Block

    //Fire cast spell at event for the specified target
    SignalEvent(oSummon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    effect eHeal = EffectHeal(nHeal);
    effect eVis = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);
    //Apply the VFX impact and damage effect
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oSummon);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oSummon);

    //Class mechanics
    DoClassMechanic("Buff", sTargets, nHeal, oSummon);
}
