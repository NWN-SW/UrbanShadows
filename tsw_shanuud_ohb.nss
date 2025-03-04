#include "inc_timer"

void main()
{
    object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 60.0, GetLocation(OBJECT_SELF));
    int nCheck = 0;
    effect eVis = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    while(oPC != OBJECT_INVALID)
    {
        if(GetIsPC(oPC) && GetTimerEnded("SHANUUD_WARNING_TIMER"))
        {
            ExecuteScript("tsw_playshanwarn", oPC);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oPC));
            nCheck = 1;

        }
        oPC = GetNextObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF));
    }

    if(nCheck == 1)
    {
        SetTimer("SHANUUD_WARNING_TIMER", 60);
    }

    ExecuteScript("x2_def_heartbeat");
}
