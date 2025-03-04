#include "nw_i0_plotwizard"


void SendPlayerPartyAway()
{

    object oPCSpeaker = GetLastSpeaker();
    PWSetMinLocalIntParty(oPCSpeaker,"iIsInTaxiParty",1);
    SendMessageToPC(GetFirstPC(),IntToString(GetLocalInt(oPCSpeaker,"iIsInTaxiParty")));
    object oNearbyPC = GetFirstObjectInShape(SHAPE_SPHERE,15.0f,GetLocation(OBJECT_SELF));
    string sWPDestination = GetLocalString(OBJECT_SELF,"sWaypointTP");

    //Debug
    //SendMessageToPC(oPCSpeaker, sWPDestination);

    object oWP = GetWaypointByTag(sWPDestination);

    while ( GetIsObjectValid(oNearbyPC))
    {
        if ( GetIsPC(oNearbyPC) && GetLocalInt(oNearbyPC,"iIsInTaxiParty") ==1)
        {

            AssignCommand(oNearbyPC,JumpToObject(oWP));
            DeleteLocalInt(oNearbyPC,"iIsInTaxiParty");
            SendMessageToPC(GetFirstPC(),IntToString(GetLocalInt(oPCSpeaker,"iIsInTaxiParty")));
        }
        oNearbyPC = GetNextObjectInShape(SHAPE_SPHERE,15.0f,GetLocation(OBJECT_SELF));
    }
}

void main()
{


  int iFNPCFunc = GetLocalInt(OBJECT_SELF,"iFNPCFunc");

        switch (iFNPCFunc){

        default:
        break;

        case 1:
            SendPlayerPartyAway();
        break;

        case 2:
        break;

        }

}
