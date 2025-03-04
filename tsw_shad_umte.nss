#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    location lMark = GetLocation(OBJECT_SELF);
    int nCheck = GetLocalInt(OBJECT_SELF, "SHADOW_MARK_SET");
    effect eVis = EffectVisualEffect(VFX_DUR_DEATH_ARMOR);
    location lLocation;

    if(nCheck != 1)
    {
        SetLocalInt(OBJECT_SELF, "SHADOW_MARK_SET", 1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, lMark, 2.0);
        SetLocalLocation(OBJECT_SELF, "SHADOW_MARK_LOC", lMark);
        SendMessageToPC(OBJECT_SELF, "Location marked.");
    }
    else
    {
        DeleteLocalInt(OBJECT_SELF, "SHADOW_MARK_SET");
        lLocation = GetLocalLocation(OBJECT_SELF, "SHADOW_MARK_LOC");
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, 1.0);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, lLocation, 2.0);
        DelayCommand(0.5, AssignCommand(OBJECT_SELF, ActionJumpToLocation(lLocation)));
        DeleteLocalLocation(OBJECT_SELF, "SHADOW_MARK_LOC");
        //Class mechanics
        DoMartialMechanic("Guile", "Single", 0, OBJECT_SELF);
    }
}
