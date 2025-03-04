#include "tsw_get_rndmloc"
#include "tsw_class_func"

void main()
{
    object oPC = OBJECT_SELF;
    string sName = GetName(oPC);
    object oParty = GetFirstFactionMember(oPC);
    effect eVis = EffectVisualEffect(1102);
    location lLoc;
    object oArea = GetArea(oPC);
    string sAreaTag = GetTag(oArea);

    if(sAreaTag == "TheEnd_WZ" || sAreaTag == "PLAYER_PRISON")
    {
        SendMessageToPC(oPC, "You are alone in this place. No help can reach you.");
    }

    FloatingTextStringOnCreature("Summoning allies in five seconds...", oPC);

    while(oParty != OBJECT_INVALID)
    {
        if(oParty != oPC && GetArea(oParty) == oArea)
        {
            lLoc = GetNewRandomLocation(GetLocation(oPC), 5.0);
            FloatingTextStringOnCreature("You are being summoned to aid " + sName + " in five seconds. Prepare.", oParty);
            DelayCommand(1.0, FloatingTextStringOnCreature("...Four", oParty));
            DelayCommand(2.0, FloatingTextStringOnCreature("...Three", oParty));
            DelayCommand(3.0, FloatingTextStringOnCreature("...Two", oParty));
            DelayCommand(4.0, FloatingTextStringOnCreature("...One", oParty));
            DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oParty));
            DelayCommand(5.0, AssignCommand(oParty, ActionJumpToLocation(lLoc)));
            DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc));
        }

        //Get Next Party Member
        oParty = GetNextFactionMember(oPC);
    }

    DoClassMechanic("Invocation", "AOE", 50, oParty);
}
