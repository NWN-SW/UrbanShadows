//::///////////////////////////////////////////////
//Placeable conversation for TSW
// By Alexander G.
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPlaceableLastClickedBy();
    if(GetDistanceToObject(oPC) <= 5.0)
    {
        ActionStartConversation(oPC, "", TRUE, TRUE);
    }
}
