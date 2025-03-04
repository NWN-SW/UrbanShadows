#include "tsw_get_rndmloc"

void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    string sName = GetName(oPC);
    object oParty = GetFirstFactionMember(oPC);
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    location lLoc;
    object oArea = GetArea(oPC);
    string sAreaTag = GetTag(oArea);

    if(GetTag(oItem) != "ReinforcementBeacon1")
    {
        return;
    }

    if(sAreaTag == "TheEnd_WZ" || sAreaTag == "PLAYER_PRISON")
    {
        SendMessageToPC(oPC, "You are alone in this place. No help can reach you.");
    }

    FloatingTextStringOnCreature("Request received. Summoning allies in five seconds...", oPC);

    while(oParty != OBJECT_INVALID)
    {
        if(oParty != oPC)
        {
            lLoc = GetNewRandomLocation(GetLocation(oPC), 5.0);
            FloatingTextStringOnCreature("You are being summoned to aid " + sName + " in five seconds. Prepare for translocation.", oParty);
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
}
