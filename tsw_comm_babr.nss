//Battle Brother by Alexander G.

#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_comm_clearbb"

void main()
{
    ClearBattleBrother(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();
    int nBattleBrother = GetLocalInt(oTarget, "BATTLE_BROTHER");
    effect eVis = EffectVisualEffect(1087);
    eVis = TagEffect(eVis, "BATTLE_BROTHER_EFFECT");

    if(nBattleBrother != 1 && oTarget != OBJECT_SELF)
    {
        SetLocalInt(oTarget, "BATTLE_BROTHER", 1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, TurnsToSeconds(10));
        SetLocalObject(OBJECT_SELF, "BATTLE_BROTHER_CURRENT", oTarget);
        //AssignCommand(oTarget, DelayCommand(0.5, PlaySoundByStrRef(16778133, FALSE)));

        //Class mechanics
        string sSpellType = "Tactic";
        DoMartialMechanic(sSpellType, "Single", 0, oTarget);
    }
    else if(nBattleBrother == 1 && oTarget != OBJECT_SELF)
    {
        SendMessageToPC(OBJECT_SELF, "They are already your battle brother!");
    }
    else if(nBattleBrother != 1 && oTarget == OBJECT_SELF)
    {
        SendMessageToPC(OBJECT_SELF, "You cannot be your own Battle Brother.");
    }
}
