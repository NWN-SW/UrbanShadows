#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetEnteringObject();
    int nBagCheck = SQLocalsPlayer_GetInt(oPC, "HAS_DICEBAG");
    //Clear inventory
    if(nBagCheck != 1)
    {
        object oItem = GetFirstItemInInventory(oPC);
        while(oItem != OBJECT_INVALID)
        {
            DestroyObject(oItem);
            oItem = GetNextItemInInventory(oPC);
        }
    }

    //Intro quest step
    int nQuest = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    if(nQuest == 0)
    {
        AddJournalQuestEntry("Prologue_Quest", 1, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "Prologue_Quest", 1);
    }
}
