#include "utl_i_sqlplayer"
#include "inc_timer"

void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oGnome = GetItemActivatedTarget();
    object oWand = GetItemActivated();
    object oArea = GetArea(oPC);

    if(GetTag(oItem) != "GnomeBeatStick")
    {
        return;
    }

    if(oGnome == OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "You must target an evil gnome!");
        return;
    }

    if(GetTag(oWand) == "GnomeBeatStick" && GetTag(oGnome) == "QuestGnomeMain")
    {
        //Do non-player specific stuff
        object oSound = GetNearestObjectByTag("GnomeQuestSound", oGnome);
        SoundObjectStop(oSound);
        DestroyObject(oGnome);
        location lLoc = GetLocation(oGnome);
        effect eBoom = EffectVisualEffect(135);
        effect eBoom2 = EffectVisualEffect(VFX_FNF_FIREBALL);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom2, lLoc);
        SetTimer("GNOME_TIMER", 600, oArea);
        SetLocalInt(oArea, "GNOME_IS_SPAWNED", 0);

        //Do player stuff
        object oPlayer = GetFirstFactionMember(oPC);
        while(oPlayer != OBJECT_INVALID)
        {
            int nQuest = SQLocalsPlayer_GetInt(oPlayer, "GNOME_QUEST");
            object oPartyArea = GetArea(oPlayer);

            //Go ahead if area matches and quest is in right stage
            if(oPartyArea == oArea && nQuest >= 2 && nQuest <= 9)
            {
                nQuest = nQuest + 1;
                SQLocalsPlayer_SetInt(oPlayer, "GNOME_QUEST", nQuest);
                AddJournalQuestEntry("Gnome_Quest", nQuest, oPlayer, FALSE);

                //Set gnome respawn prevention
                string sName = GetName(oPlayer);
                sName = GetStringLeft(sName, 10);
                SetLocalInt(oArea, "GNOME_" + sName, 1);
            }

            oPlayer = GetNextFactionMember(oPC);
        }
    }
}
