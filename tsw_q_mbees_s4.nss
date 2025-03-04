#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetLastUsedBy();
    int nCheck = SQLocalsPlayer_GetInt(oPC, "Q_MBEES");

    if(nCheck == 3)
    {
		object oItem = GetItemPossessedBy(oPC, "MBeePhone");
		if(oItem == OBJECT_INVALID)
		{
			CreateItemOnObject("mbeephone", oPC);
			SQLocalsPlayer_SetInt(oPC, "Q_MBEES", 4);
			AddJournalQuestEntry("Q_MBees", 4, oPC, FALSE);
		}  
    }

	return;
}
