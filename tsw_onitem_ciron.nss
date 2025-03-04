#include "nw_i0_2q4luskan"
#include "x0_i0_position"
#include "utl_i_sqlplayer"

void SpawnWithVFX(string eSpawnResRef, effect eVFXParam, location lLocationParam)
{

   object oNewPal = CreateObject(OBJECT_TYPE_CREATURE,eSpawnResRef, lLocationParam);
   ApplyEffectToObject(2,eVFXParam,oNewPal);

}

void main()
{
	// Get the object that was used
    object oItem = GetItemActivated();
	object oUsed = GetItemActivatedTarget();
    object oPCUsedBy = GetItemActivator();
	
	// Variables for the QuestProgression within the area.
	int iPaintingN = GetLocalInt(oUsed, "iPaintingNumber");
	object oArea = GetArea(oUsed);
	int iProgressQuest = GetLocalInt(oArea, "iProgress");
	
	//Check if valid target
	string sValidTarget = GetTag(oUsed);
	if(sValidTarget != "est_painting01" && sValidTarget != "est_painting02" )
    {
        SendMessageToPC(oPCUsedBy, "This does nothing!");
        return;
    }
	
	// Check if character has already completed quest.
	int nCheck = SQLocalsPlayer_GetInt(oPCUsedBy, "Q_FEYEST01");
	
	if (nCheck >= 12) {
		SendMessageToPC(oPCUsedBy, "// You can not activate the painting, as you have already completed this quest.");
		return;
	}
	
    // Check if the placeable is on cooldown
    if (GetLocalInt(oUsed, "ON_COOLDOWN"))
    {
       FloatingTextStringOnCreature("This object appears to be like any other. . .",oPCUsedBy,FALSE);
       return;
    }
	
	//Set Quest State Progress in Area
	int ncounter = (iProgressQuest + 1);
	SetLocalInt(oArea,"iProgress", ncounter);
	
	//Debug
	//SendMessageToPC(oPCUsedBy, (IntToString(iProgressQuest)));
	
	//feedback messages for estate quest progress.
	switch (iProgressQuest) {	
		case 0: {
			FloatingTextStringOnCreature("You feel the power of the estate weakening. . .",oPCUsedBy,TRUE);
			break;
		}
		case 1: {
			FloatingTextStringOnCreature("You feel the power of the estate weakening. . .",oPCUsedBy,TRUE);
			break;
		}
		case 2: {
			FloatingTextStringOnCreature("You feel the power of the estate weakening. . .",oPCUsedBy,TRUE);
			break;
		}
		case 3: {
			
			FloatingTextStringOnCreature("You feel the power of the estate weakening. . .",oPCUsedBy,TRUE);
			break;
		}
		case 4: {
			FloatingTextStringOnCreature("You feel the power of the estate weakening. . .",oPCUsedBy,TRUE);
			break;
		}
		case 5: {
			FloatingTextStringOnCreature("The power of the estate has diminished significantly. Not many paintings will remain.",oPCUsedBy,TRUE);
			break;
		}
		case 6: {
			FloatingTextStringOnCreature("The power of the estate has diminished significantly. Not many paintings will remain.",oPCUsedBy,TRUE);
			break;
		}
		case 7: {
			FloatingTextStringOnCreature("The power of the estate has diminished significantly. Not many paintings will remain.",oPCUsedBy,TRUE);
			break;
		}
		case 8: {
			FloatingTextStringOnCreature("The power of the estate has grown very faint. The power drawn from the paintings has been severed.",oPCUsedBy,TRUE);
			break;
		}
		case 9: {
			FloatingTextStringOnCreature("It is comming...",oPCUsedBy,TRUE);
			break;
		}
		default:
			break;
	
	}
		

    string sToSpawn = GetLocalString(oUsed,"sCreaToSpawn");
    int iNumberToSpawn = GetLocalInt(oUsed,"iCreaSwarm");
	effect eVFXToSpawn=EffectVisualEffect(315,FALSE,1.0f);
    effect eVFXOnSpawn=EffectVisualEffect(10,FALSE,1.0f);
	
	
    // Create the glowing effect on the placeable

    effect eGlow = EffectVisualEffect((512+Random(54)),FALSE,1.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlow, oUsed, 300.0f); // Effect duration in seconds
    SetPlaceableIllumination(oUsed);
    RecomputeStaticLighting(GetArea(oUsed));
    // Spawn the creature at the location of the placeable
    location lLocation = GetLocation(oUsed);

    int i;
    for (i=0; i<=iNumberToSpawn-1;i++)
    {
        DelayCommand(i*2.0f, ApplyEffectToObject(0,eVFXToSpawn,oUsed));
        DelayCommand(iNumberToSpawn*2.0f, SpawnWithVFX(sToSpawn,eVFXToSpawn,lLocation));
    }

    AssignCommand(oUsed,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    //DelayCommand(300.0f, AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));    //commmeted out for estate quest
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVFXToSpawn,lLocation);

    // Set the placeable on cooldown
    SetLocalInt(oUsed, "ON_COOLDOWN", TRUE);

    // Create a delayed action to reset the cooldown
    //DelayCommand(300.0f, DeleteLocalInt(oUsed, "ON_COOLDOWN"));     //commmeted out for estate quest
	
}
