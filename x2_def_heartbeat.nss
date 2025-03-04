//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    //ExecuteScript("nw_c2_default1", OBJECT_SELF);
    ExecuteScript("j_ai_onheartbeat", OBJECT_SELF);
    ExecuteScript("tsw_def_tun_move", OBJECT_SELF);

    if (GetLocalInt(OBJECT_SELF,"iHeartBeatMobFunc") != 0)
    {
        ExecuteScript("tsw_lib_hbeat", OBJECT_SELF);
    }
}
