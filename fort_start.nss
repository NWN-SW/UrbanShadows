#include "inc_timer"

void main()
{
    string sVarName = "DEFENSE_START";
    object oFort = GetObjectByTag("TheEnd_WZ");
    int nEvent = GetLocalInt(oFort, sVarName);
    int nRand = Random(600);
    string sTimerName = "OTHERWORLD_EVENT_TRIGGER";

    if(nEvent == 1 && GetTimerEnded(sTimerName))
    {
        ExecuteScript("othwld_sirens", OBJECT_SELF);
        SetEventScript(OBJECT_SELF, 4000, "");
        SetLocalInt(oFort, sVarName, nRand);
        SetTimer(sTimerName, 3600);
    }
    else
    {
        SetLocalInt(oFort, sVarName, nRand);
    }
}
