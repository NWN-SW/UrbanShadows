#include "nw_i0_2q4luskan"
#include "x0_i0_position"

void TriggerPhaseTwo (int iHeatlthThreshold)
{

    int iHealthBoss = GetCurrentHitPoints(OBJECT_SELF);
    int iHealthBossPercent = ((iHealthBoss*100)/iHealthBoss);
    if (GetLocalInt(OBJECT_SELF,"iPhaseTwo") == 0 )
    {
        if ( iHealthBossPercent < iHeatlthThreshold )
        {

            SetLocalInt(OBJECT_SELF,"iPhaseTwo",1);

        }
    }
}

void DevourFirstSummonFound()
{
    int iHeartBeatCounter = GetLocalInt(OBJECT_SELF,"iHeartBeatCounter") + GetLocalInt(OBJECT_SELF,"iPhaseTwo");
    if (iHeartBeatCounter >=2)
    {
        object oEnemySummon = GetFirstObjectInShape(SHAPE_SPHERE, 15.0f, GetLocation(OBJECT_SELF), TRUE);
        while (GetIsObjectValid(oEnemySummon))
        {

            if (GetIsEnemy(oEnemySummon) && !GetIsPC(oEnemySummon))
            {
                 int iDrain = GetMaxHitPoints(oEnemySummon);
                 effect eDrainSummonHP = EffectDamage(iDrain, DAMAGE_TYPE_POSITIVE);
                 eDrainSummonHP = EffectLinkEffects(eDrainSummonHP, EffectVisualEffect(217,FALSE,3.0f));
                 DelayCommand(5.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDrainSummonHP, oEnemySummon));
                 eDrainSummonHP = EffectHeal(iDrain);
                 eDrainSummonHP = EffectLinkEffects(eDrainSummonHP,EffectVisualEffect(91,FALSE,3.0f));
                 DelayCommand(6.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDrainSummonHP, OBJECT_SELF));
                 int iCount;
                 for (iCount=0;iCount <3;iCount++)
                 {
                    DelayCommand(iCount*1.5f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(146,FALSE, 2.0f),GetLocation(OBJECT_SELF)));
                 }

                 if ( GetLocalInt(OBJECT_SELF,"iPhaseTwo")==2)
                 {

                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectImmunity(IMMUNITY_TYPE_NONE), OBJECT_SELF,6.0f);

                 }
                 break;

            }
            else
            {
                oEnemySummon = GetNextObjectInShape(SHAPE_SPHERE, 15.0f, GetLocation(OBJECT_SELF), TRUE);
            }

        }
        SetLocalInt(OBJECT_SELF,"iHeartBeatCounter",0);

    }
    else
    {
     SetLocalInt(OBJECT_SELF, "iHeartBeatCounter", iHeartBeatCounter+1);
    }

     if ( GetLocalInt(OBJECT_SELF,"iPhaseTwo")!=1)
         {

              TriggerPhaseTwo(50);

         }
}

void EffectRayOnRandomPlayer()
{

    effect eBeamToPlayer = EffectBeam(213,OBJECT_SELF,20);
    effect eChainEffect = EffectLinkEffects(eBeamToPlayer,eChainEffect);
    eChainEffect = EffectLinkEffects(eChainEffect, EffectConfused());
    object oPlayer = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
    if (GetIsObjectValid(oPlayer))
    {
        if (GetDistanceBetween(OBJECT_SELF,oPlayer) <= 15.0f)
        {
            ApplyEffectToObject(1,eChainEffect,oPlayer,9.0f);
        }
    }

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


void WhirldwindBlades()
{
		location lLocScaleZ = Location(GetArea(OBJECT_SELF),GetPosition(OBJECT_SELF)+Vector(0.0,0.0,1.0f),GetFacing(OBJECT_SELF));
		ApplyEffectAtLocation(0,EffectVisualEffect(1077,FALSE,1.80f),lLocScaleZ);
		object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 5.0f, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);

		
		while(GetIsObjectValid(oTarget))
		{
			if (GetIsEnemy(oTarget) && oTarget != OBJECT_SELF)
			{
				ApplyEffectToObject(0,EffectDamage(30,DAMAGE_TYPE_SLASHING),oTarget);
			}
			oTarget = GetNextObjectInShape(SHAPE_SPHERE, 5.0f, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
		}
		
}

void TurnReversed()
{
	
	object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 25.0f, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);	
		while(!GetIsPC(oTarget))
		{

			oTarget = GetNextObjectInShape(SHAPE_SPHERE, 25.0f, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
		}
		TurnToFaceObject(oTarget);
		AssignCommand(OBJECT_SELF,SetFacing(GetOppositeDirection(GetFacing(OBJECT_SELF))));
}

void RollForFunction()
{
    int iRollFunc = Random(20)+1;
	 

    switch (iRollFunc){
    default :
    DeleteLocalInt(OBJECT_SELF,"iPhaseTwo");
    DeleteLocalInt(OBJECT_SELF,"iHeartBeatCounter");

    break;
	case 1:
    SetLocalInt(OBJECT_SELF,"iPhaseTwo",1);
    SetLocalInt(OBJECT_SELF,"iHeartBeatCounter",2);
    DevourFirstSummonFound();
    break;
    case 2:
    EffectRayOnRandomPlayer();
    break;
	case 3:
	TurnPlaceableToObject(18.0f);
	break;
	case 4:
	ApplyEffectAtLocation(0,EffectVisualEffect(185),GetLocation(OBJECT_SELF));
	DelayCommand(2.0f,WhirldwindBlades());
	break;
	case 5:
	TurnReversed();
	break;
	
    }
}

void main()
{

    object oPlayer = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
    if (!GetIsObjectValid(oPlayer) ||  (GetDistanceBetween(oPlayer,OBJECT_SELF)>15.0f))
    {
		return;
    }

      int iHeartbeatMobFunc = GetLocalInt(OBJECT_SELF,"iHeartBeatMobFunc");

        switch (iHeartbeatMobFunc){

        default:
        break;

        case 1:
        DevourFirstSummonFound();
        break;

        case 2:
        RollForFunction();
        break;

        }
}
