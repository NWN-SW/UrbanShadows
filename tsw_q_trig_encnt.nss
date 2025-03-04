// Purpose: Spawn Encounter only at a certain quest stage.
// Location:  Goes in the OnEnter of a generic trigger to activate an encounter.
//
// How to Use:
// - Place a generic trigger completely around an encounter trigger.
// - Make it a single shot encounter and uncheck the "active" box.
// - Place a string on the generic trigger with the unique tag of the encounter that you want to fire.  Call the
//   string "ENCOUNTER_TAG".  That way you can use this one script for every encounter that you want to make random.
//
// How it Works:
// - Will roll the dice to check for a percentage, change the dice size if you want a different percentage.
// - Will activate the trigger on a 1.

#include "utl_i_sqlplayer"

void main()
{
   //check if player is player character.
   object oPC = GetEnteringObject();
   if(FALSE == GetIsPC(oPC))
   {   return;     }

   object oTrigger = OBJECT_SELF;
   // Gets the variable off of the trigger that tells what the quest is.
   string sQuestName = GetLocalString(oTrigger,"sQuestSQLName");
   // Gets the variable off of the trigger that tells what the required quest states are. Set both to the same int if only one quest state is acceptable.
   int nQuestState1 = GetLocalInt(oTrigger,"nQuestSQLState1");
   int nQuestState2 = GetLocalInt(oTrigger,"nQuestSQLState2");
   // Gets the variable off of the trigger that tells what the tag of the encounter is.
   string sEncounterTag = GetLocalString(oTrigger, "sEncounter");

   // Gets the current quest state of the quest, and compares if it is correct.
   int nCheck = SQLocalsPlayer_GetInt(oPC, sQuestName);

   if(nQuestState1 == nCheck || nQuestState2 == nCheck) {

      //SendMessageToPC(GetFirstPC(), "Debug 1");
      SetEncounterActive(TRUE, GetNearestObjectByTag(sEncounterTag));
   }

    //DEBUG MESSAGES
    //SendMessageToPC(GetFirstPC(), sQuestName);
    //SendMessageToPC(GetFirstPC(), IntToString(nQuestState1));
    //SendMessageToPC(GetFirstPC(), IntToString(nQuestState2));
    //SendMessageToPC(GetFirstPC(), sEncounterTag);
    //SendMessageToPC(GetFirstPC(), IntToString(nCheck));

}
