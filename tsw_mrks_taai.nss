#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    //Leave if not ranged weapon
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    int nType = GetBaseItemType(oWep);
    if(!GetWeaponRanged(oWep))
    {
        SendMessageToPC(OBJECT_SELF, "Requires a ranged weapon.");
        return;
    }

    //Check if already under effect
    int nCheck = GetLocalInt(OBJECT_SELF, "MARKSMAN_CRIT");
    if(nCheck == 1)
    {
        SendMessageToPC(OBJECT_SELF, "You already have Take Aim active.");
        return;
    }

    effect eVis = EffectVisualEffect(1048);
    effect eIcon = EffectIcon(11);
    PlaySoundByStrRef(16778127, FALSE);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "MARKSMAN_CRIT", 1);

    DoMartialMechanic("Tactic", "Single", 0, OBJECT_SELF);
}
