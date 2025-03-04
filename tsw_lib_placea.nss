#include "nw_i0_2q4luskan"
#include "x0_i0_position"
#include "X0_I0_SPELLS"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "utl_i_sqlplayer"

void SpawnWithVFX(string eSpawnResRef, effect eVFXParam, location lLocationParam)
{

   object oNewPal = CreateObject(OBJECT_TYPE_CREATURE,eSpawnResRef, lLocationParam);
   ApplyEffectToObject(2,eVFXParam,oNewPal);

}

void SpawnOnUse()
{
    // Get the object that was used
    object oUsed = OBJECT_SELF;
    object oPCUsedBy = GetLastUsedBy();

    // Check if the placeable is on cooldown
    if (GetLocalInt(oUsed, "ON_COOLDOWN"))
    {
       FloatingTextStringOnCreature("This object appears to be like any other. . .",oPCUsedBy,FALSE);
        return;
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

    AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    DelayCommand(300.0f, AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVFXToSpawn,lLocation);

    // Set the placeable on cooldown
    SetLocalInt(oUsed, "ON_COOLDOWN", TRUE);

    // Create a delayed action to reset the cooldown
    DelayCommand(300.0f, DeleteLocalInt(oUsed, "ON_COOLDOWN"));
}


void SpawnOnUseFeyP()
{
    // Get the object that was used
    object oUsed = OBJECT_SELF;
    object oPCUsedBy = GetLastUsedBy();
	
	// Variables for the QuestProgression within the area.
	int iPaintingN = GetLocalInt(oUsed, "iPaintingNumber");
	object oArea = GetArea(OBJECT_SELF);
	int iProgressQuest = GetLocalInt(oArea, "iProgress");
	
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
	SendMessageToPC(oPCUsedBy, (IntToString(iProgressQuest)));
	
	//feedback messages for estate quest progress.
	switch (iProgressQuest) {	
		case 0: {
			FloatingTextStringOnCreature("You feel the power of the estate weakening. . .",oPCUsedBy,FALSE);
			break;
		}
		case 1: {
			FloatingTextStringOnCreature("You feel the power of the estate weakening. . .",oPCUsedBy,FALSE);
			break;
		}
		case 2: {
			FloatingTextStringOnCreature("You feel the power of the estate weakening. . .",oPCUsedBy,FALSE);
			break;
		}
		case 3: {
			FloatingTextStringOnCreature("You feel the power of the estate weakening. . .",oPCUsedBy,FALSE);
			break;
		}
		case 4: {
			FloatingTextStringOnCreature("You feel the power of the estate weakening. . .",oPCUsedBy,FALSE);
			break;
		}
		case 5: {
			FloatingTextStringOnCreature("The power of the estate has diminished significantly. Not many paintings will remain.",oPCUsedBy,FALSE);
			break;
		}
		case 6: {
			FloatingTextStringOnCreature("The power of the estate has diminished significantly. Not many paintings will remain.",oPCUsedBy,FALSE);
			break;
		}
		case 7: {
			FloatingTextStringOnCreature("The power of the estate has diminished significantly. Not many paintings will remain.",oPCUsedBy,FALSE);
			break;
		}
		case 8: {
			FloatingTextStringOnCreature("The power of the estate has grown very faint. The power drawn from the paintings has been severed.",oPCUsedBy,FALSE);
			break;
		}
		case 9: {
			FloatingTextStringOnCreature("It is comming...",oPCUsedBy,FALSE);
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

    AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    //DelayCommand(300.0f, AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));    //commmeted out for estate quest
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVFXToSpawn,lLocation);

    // Set the placeable on cooldown
    SetLocalInt(oUsed, "ON_COOLDOWN", TRUE);

    // Create a delayed action to reset the cooldown
    //DelayCommand(300.0f, DeleteLocalInt(oUsed, "ON_COOLDOWN"));     //commmeted out for estate quest
}

void ScaleAndMoveZ(float fScale, float fMoveZ, object oSubjectParam)
{
  SetObjectVisualTransform(oSubjectParam,OBJECT_VISUAL_TRANSFORM_SCALE,fScale);
  SetObjectVisualTransform(oSubjectParam,OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z,fMoveZ);
}

void TurnPlaceableToObject(float fDelay=600.0f)
{
    object oSelfRef = OBJECT_SELF;
    object oPlayer = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
    if (GetIsObjectValid(oPlayer))
    {

            object oSelfRef = OBJECT_SELF;
            string sObjectResRef = GetLocalString(oSelfRef,"sCreaToSpawn");
            int iVFXID = GetLocalInt(oSelfRef,"iVFXID");
            location lPlaceableLoc = GetLocation(oSelfRef);
            effect eVFXPlaceable = EffectVisualEffect(iVFXID,FALSE, 2.0f);



            if (GetLocalInt(oSelfRef,"iCreaSpawned") == 0)
            {
                ApplyEffectAtLocation(0, eVFXPlaceable,lPlaceableLoc);
                ScaleAndMoveZ(0.0f,-20.0f,oSelfRef);
                object oDebris = CreateObject(OBJECT_TYPE_PLACEABLE,"debris",lPlaceableLoc);
                TurnToFaceObject(oPlayer,oDebris);

                object oNewPal = CreateObject(OBJECT_TYPE_CREATURE, sObjectResRef, GetRandomLocation(GetArea(oSelfRef),oSelfRef,2.0f));
                location lDebrisLoc = GetLocation(oDebris);
                SetLocalInt(oSelfRef,"iCreaSpawned",1);
                TurnToFaceObject(oPlayer,oNewPal);
                ApplyEffectToObject(1,EffectKnockdown(),oNewPal,2.0f);
                DeleteLocalInt(oSelfRef,"iHeartBeatMobFunc");
                DelayCommand(fDelay, SetLocalInt(oSelfRef,"iHeartBeatMobFunc",2));
                DelayCommand(2.5f,AssignCommand(oNewPal,ActionAttack(oPlayer)));
                DelayCommand(fDelay,ApplyEffectAtLocation(0, eVFXPlaceable,lDebrisLoc));
                DelayCommand(fDelay,ScaleAndMoveZ(1.0f,0.0f,oSelfRef));
                DelayCommand(fDelay,DestroyObject(oDebris));
                DelayCommand(fDelay,DeleteLocalInt(oSelfRef,"iCreaSpawned"));
				DelayCommand((fDelay - 0.5f), ApplyEffectToObject(0, eVFXPlaceable,oNewPal));
				DelayCommand(fDelay-1.0f,DestroyObject(oNewPal));

            }
    }
}

void TeleportUserToWaypoint()
{

    string sWPDestination = GetLocalString(OBJECT_SELF,"sWaypointTP");
    object oWP = GetWaypointByTag(sWPDestination);
    AssignCommand(GetLastUsedBy(),ActionJumpToObject(oWP));

}

void TechSentryHeartBeat()
{	
	
    object oTechniCaster = GetLocalObject(OBJECT_SELF,"oOwner");
    string sTargetType = "Single";
    int nCasterLvl = GetCasterLevel(oTechniCaster);

    object oTarget = oTechniCaster;

  /*  while (!GetIsReactionTypeHostile(oTarget,oTechniCaster))
    {
		if (!GetIsObjectValid(oTarget))
		{
			return;
		}
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,45.0f,GetLocation(OBJECT_SELF),TRUE);
		
    }*/

    int nDamage = GetFirstLevelDamage(oTarget, nCasterLvl, sTargetType);

    //Buff damage by Amplification elvel
    nDamage = GetAmp(nDamage);
	nDamage = FloatToInt(nDamage*0.5);
    //Get the Alchemite resistance reduction
    string sElement = "Sonic";
    int nReduction = GetFocusReduction(oTechniCaster, sElement);

    //Buff damage bonus on Alchemite
    nDamage = GetFocusDmg(oTechniCaster, nDamage, sElement);
                //Adjust damage based on Alchemite and Saving Throw
    int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
// Apply effects to the currently selected target.
    effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_SONIC);
    effect eVFXHit= EffectVisualEffect(284,FALSE,1.2f);
    effect eVFXBang = EffectVisualEffect(118,FALSE,10.0f);

    int iGetHPR = GetLocalInt(OBJECT_SELF,"iHPR");
    int iCount = 0;
	
	if (iGetHPR <24)
	{
		DelayCommand(12.0f,SetLocalInt(OBJECT_SELF,"iHPR",(iGetHPR)+10));
	}

    for(iCount=0;iCount<iGetHPR;iCount++)
    {
		TurnToFaceObject(oTechniCaster);
		AssignCommand(OBJECT_SELF,SetFacing(GetOppositeDirection(GetFacing(OBJECT_SELF))));
        DelayCommand(0.25*iCount,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eVFXBang,GetLocation(OBJECT_SELF),3.0f));
        DelayCommand(0.30*iCount,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFXHit,oTarget));
        DelayCommand(0.30*iCount,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oTarget));

    }
}

void main()
{
		SendMessageToPC(GetFirstPC(),"Heartbeat");
      int iPlaceableFunc = GetLocalInt(OBJECT_SELF,"iPlaceableFunc");

        switch (iPlaceableFunc){

        default:
        break;

        case 3:
        TeleportUserToWaypoint();
        break;

        case 1:
        SpawnOnUse();
        break;
		
		case 4:
        SpawnOnUseFeyP();
        break;

        case 2:
        TurnPlaceableToObject();
        break;

        case 101:
        TechSentryHeartBeat();
		break;

        }


}
