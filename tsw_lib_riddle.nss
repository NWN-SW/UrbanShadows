void CreateThingAtPlace(object oNearestWP,location lWPLoc)
{
	object oNewThing = CreateObject(OBJECT_TYPE_PLACEABLE,GetLocalString(oNearestWP,"sObjectLinked"),lWPLoc);
	SetObjectVisualTransform(oNewThing,OBJECT_VISUAL_TRANSFORM_SCALE,2.0f);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(0),oNewThing);
	string sGetConnectedTP = GetLocalString(oNearestWP,"sWaypointTP");
	SetLocalString(oNewThing,"sWaypointTP",sGetConnectedTP);
	
}

void SetRiddleStages (object oPCSpeaker)
{
    object oSpeakersArea = GetArea(oPCSpeaker);
    int iWhichStage = GetLocalInt(oSpeakersArea,"iRiddleStage");
    int iWhichRiddle = GetLocalInt(oSpeakersArea,"iWhichRiddle");
    string sNextRiddleStage;


    switch (iWhichRiddle)
    {
        default:
        break;

        case 1:
        if (iWhichStage == 0)
            {sNextRiddleStage = "Thy realm of chill, thy land of ice.";}
        else if (iWhichStage == 1)
            {sNextRiddleStage = "Grant us passage through this rite.";}
        else if (iWhichStage == 2)
            {sNextRiddleStage = "By spectral winds and frozen sighs.";}
        else if (iWhichStage == 3)
            {sNextRiddleStage = "Let us breach the frostbound skies.";}
        else if (iWhichStage == 4)
            {sNextRiddleStage = "So that in thy grace we might arise.";}
        break;

        case 2:
        break;

    }

 SetLocalString(oSpeakersArea,"sRiddleToSolve",sNextRiddleStage);
}

void main()
{
        object oPCSpeaker = GetPCChatSpeaker();
        object oSpeakersArea = GetArea(oPCSpeaker);
        string sPCSpeakerCurrentTrigger = GetLocalString(oPCSpeaker,"sTriggerTag");
        object oTriggerObj = GetObjectByTag(sPCSpeakerCurrentTrigger);
        string sObjectToActivate = GetLocalString(oTriggerObj,"sObjectLinked");
        SetRiddleStages(oPCSpeaker);
       if (GetIsInSubArea(oPCSpeaker, oTriggerObj))
       {

            string sPCMsg = GetPCChatMessage();

            string sRiddleToSolve = GetLocalString(oSpeakersArea,"sRiddleToSolve");
            if (sPCMsg == sRiddleToSolve)
            {

                 int iWhichStage = GetLocalInt(oSpeakersArea,"iRiddleStage")+1;

                 if (iWhichStage==5)
                 {
                     object oNearestWP = GetNearestObject(OBJECT_TYPE_WAYPOINT,oTriggerObj);
                     location lWPLoc = GetLocation(oNearestWP);
                     DelayCommand(3.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,EffectVisualEffect(425,FALSE,5.0f),lWPLoc,6.0f));
					 DelayCommand(5.5f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(246),lWPLoc));
                     DelayCommand(6.0f, CreateThingAtPlace(oNearestWP,lWPLoc));
                 }

                 object oNearestNthPlaceableFromTag = GetNearestObjectByTag(sObjectToActivate,oTriggerObj,iWhichStage);

                 int iCount =0;
                 for (iCount=0; iCount<3;iCount++)
                 {
                 DelayCommand(iCount*1.0,ApplyEffectToObject(0,EffectVisualEffect(258+iCount,FALSE,0.10f*(iCount+1)),oNearestNthPlaceableFromTag));
                 }

                 DelayCommand((iCount-1)*1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(463,FALSE,0.33f),oNearestNthPlaceableFromTag));
                 AssignCommand(oNearestNthPlaceableFromTag,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

                 SetLocalInt(oSpeakersArea,"iRiddleStage",iWhichStage);


            }



       }



}
