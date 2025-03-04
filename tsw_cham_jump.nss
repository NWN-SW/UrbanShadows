#include "tsw_get_rndmloc"

void main()
{
    //Jump variables
    object oMainTarget = GetLocalObject(OBJECT_SELF, "CHAMP_JUMP_TARGET");
    object oEnemy = GetLocalObject(OBJECT_SELF, "CHAMP_CASTER");
    location lTarget = GetLocation(oMainTarget);
    location lLoc = GetNewRandomLocation(lTarget, 2.0);
    ClearAllActions();
    ActionJumpToObject(oMainTarget);
    DelayCommand(4.0, ActionAttack(oEnemy));
}
