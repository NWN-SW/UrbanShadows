#include "tsw_faction_func"

void main()
{
    object oPC = GetClickingObject();
    string sFaction = GetFaction(oPC);
    object oWP;

    if(sFaction == "Illuminati")
    {
        oWP = GetWaypointByTag("ILLU_TRAINING_ENT");
        AssignCommand(oPC, ClearAllActions());
        DelayCommand(0.25, AssignCommand(oPC, ActionJumpToObject(oWP)));
    }

    if(sFaction == "Dragon")
    {
        oWP = GetWaypointByTag("DRAG_TRAINING_ENT");
        AssignCommand(oPC, ClearAllActions());
        DelayCommand(0.25, AssignCommand(oPC, ActionJumpToObject(oWP)));
    }

    if(sFaction == "Templar")
    {
        oWP = GetWaypointByTag("TEMP_TRAINING_ENT");
        AssignCommand(oPC, ClearAllActions());
        DelayCommand(0.25, AssignCommand(oPC, ActionJumpToObject(oWP)));
    }

    if(sFaction == "")
    {
        oWP = GetWaypointByTag("tp_recall");
        AssignCommand(oPC, ClearAllActions());
        DelayCommand(0.25, AssignCommand(oPC, ActionJumpToObject(oWP)));
    }
}
