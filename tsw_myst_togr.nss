//::///////////////////////////////////////////////
//:: Touch of Grace by Alexander G.
//:://////////////////////////////////////////////

#include "tsw_class_func"
#include "spell_dmg_inc"

void main()
{
   //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = 0;
    object oCaster = OBJECT_SELF;

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nHeal = 100;

        //Buff damage by Amplification elvel
        nHeal = GetAmp(nHeal);

        //Get the Alchemite resistance reduction
        string sElement = "Holy";
        int nReduction = GetFocusReduction(oCaster, sElement);

        //Buff damage bonus on Alchemite
        nHeal = GetFocusDmg(oCaster, nHeal, sElement);
    //End Custom Spell-Function Block


    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HEAL);
    if(!GetIsReactionTypeHostile(oTarget) && oTarget != OBJECT_SELF)
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        nHeal = nHeal / 10;

        effect eHeal = EffectHeal(nHeal);
        //Apply the VFX impact and damage effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
    else if(!GetIsReactionTypeHostile(oTarget) && oTarget == OBJECT_SELF)
    {
        SendMessageToPC(oCaster, "Cannot target self.");
    }
}




