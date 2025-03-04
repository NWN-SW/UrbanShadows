//::///////////////////////////////////////////////
//:: FileName pc_give_recall
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Alexander Gates
//:: Created On: 8/25/2020
//:://////////////////////////////////////////////
#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetEnteringObject();
    int nBagCheck = SQLocalsPlayer_GetInt(oPC, "HAS_DICEBAG");

    //Check recall
    //object oRecall = GetItemPossessedBy(oPC, "OrbOfRecall");

    if (oPC != OBJECT_INVALID && nBagCheck != 1)
    {
        CreateItemOnObject("rb_dicebag", oPC);
        CreateItemOnObject("d_boots", oPC);
        CreateItemOnObject("orbofrecall", oPC);
        GiveGoldToCreature(oPC, 3000);
        SQLocalsPlayer_SetInt(oPC, "HAS_DICEBAG", 1);

        //Remove intro weapon
        object oWeap = GetItemPossessedBy(oPC, "INTRO_CLUB");
        DestroyObject(oWeap);
    }
}
