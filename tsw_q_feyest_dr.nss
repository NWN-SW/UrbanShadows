//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Main Quest
//:: SQL Name: Q_FEYEST01
//:: Journal Name: Q_FeyEst01
//:: Questgiver NPC: Phonecall Trigger (Bria's) or Cassie in Edinburgh
//:: Location: Edinburgh
//:://////////////////////////////////////////////

//:: Checks if players are ready to progress beyond the attic door.



#include "nw_i0_tool"
#include "utl_i_sqlplayer"


void main()
{
	
	// Get the object that was used
    object oDoor = OBJECT_SELF;
    object oPC = GetClickingObject();
	object oArea = GetArea(OBJECT_SELF);
	int iProgressQuest = GetLocalInt(oArea, "iProgress");
	int nCheck = SQLocalsPlayer_GetInt(oPC, "Q_FEYEST01");
	
	
	if (iProgressQuest < 9) {	
		FloatingTextStringOnCreature("A supernatural force is barring the door. . .",oPC,FALSE);	
		effect eGlow = EffectVisualEffect((512+Random(54)),FALSE,1.0f);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlow, oDoor, 6.0f); // Effect duration in seconds
		SetPlaceableIllumination(oDoor);
		RecomputeStaticLighting(GetArea(oDoor));
		return;
	}
	
	else if (nCheck == 13) {
		SendMessageToPC(oPC, "// You can not unlock the door, as you have already completed this quest.");
	}
	
	else if (iProgressQuest >= 9) {
		FloatingTextStringOnCreature("What ever force tried to barr the door has grown too weak to do so. . .",oPC,FALSE);
		ActionDoCommand(SetLocked(oDoor, FALSE));	
		AssignCommand(oDoor, ActionOpenDoor(oDoor));
       return;
	}
	
	return;
}
