#include "utl_i_sqlplayer"
#include "inc_timer"

void main()
{
    //Get player
    object oPC = GetEnteringObject();

    if(!GetIsPC(oPC))
    {
        return;
    }

    //Execute door portraits
    ExecuteScript("tsw_setdoor_port");

    //Get current area of the trigger
    object oArea = GetArea(oPC);

    //Check if PC has already spawned a gnome here
    string sName = GetName(oPC);
    sName = GetStringLeft(sName, 10);
    int nSpawner = GetLocalInt(oArea, "GNOME_" + sName);
    if(nSpawner == 1)
    {
        return;
    }

    //Get quest stage
    int nQuest = SQLocalsPlayer_GetInt(oPC, "GNOME_QUEST");

    //SendMessageToPC(oPC, "My quest stage is: " + IntToString(nQuest));

    //Make sure a gnome hasn't already spawned
    int nCheck = GetLocalInt(oArea, "GNOME_IS_SPAWNED");
    if(nQuest >= 2 && nQuest < 12 && nCheck != 1 && GetTimerEnded("GNOME_TIMER", oArea))
    {
        //SendMessageToPC(oPC, "I have spawned a gnome.");

        //Get spawn waypoint
        object oWP = GetNearestObjectByTag("GNOME_SPAWN_SPOT", oPC);

        //Get sound effect for spawn
        object oSound = GetNearestObjectByTag("GnomeQuestSound", oWP);
        location lLoc = GetLocation(oWP);

        //Create the object at location
        object oGnome = CreateObject(OBJECT_TYPE_PLACEABLE, "questgnomemain", lLoc);

        //Set spawned flag
        SetLocalInt(oArea, "GNOME_IS_SPAWNED", 1);

        //Enable sound
        SoundObjectPlay(oSound);

        //Despawn after 30 minutes
        DelayCommand(1800.0, DestroyObject(oGnome));
        DelayCommand(1800.0, SoundObjectStop(oSound));
        DelayCommand(1800.0, SetLocalInt(oArea, "GNOME_IS_SPAWNED", 0));
    }
}
