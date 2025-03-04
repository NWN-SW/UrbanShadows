void UnsetEnteringObjectAsLocal()
{

    object oObjectInside = GetExitingObject();

    if (GetIsObjectValid(oObjectInside) && GetIsPC(oObjectInside))
    {
       int iCount=0;
       int iGetNthObject=GetLocalInt(OBJECT_SELF,"iNthToEnter");
       object oEnteredPC = GetLocalObject(OBJECT_SELF,IntToString(iCount));
       while (oEnteredPC != oObjectInside )
       {
		 iCount++;
			oEnteredPC = GetLocalObject(OBJECT_SELF,IntToString(iCount));
       }
        SetLocalInt(OBJECT_SELF,"iNthToEnter", (iGetNthObject-1));
		DeleteLocalString(oEnteredPC,"sTriggerTag");
        DeleteLocalObject(OBJECT_SELF,IntToString(iCount));
    }
	

}



void main ()
{
    int iTriggerExitFunc = GetLocalInt(OBJECT_SELF,"iTriggerExitFunc");

        switch (iTriggerExitFunc){

            default:
            break;

            case 1:
            UnsetEnteringObjectAsLocal();

            break;

            case 2:

            break;

        }
        SendMessageToPC(GetFirstPC(),"Ppl in trigger after exit: " + IntToString(GetLocalInt(OBJECT_SELF,"iNthToEnter")));
}
