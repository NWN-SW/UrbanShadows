
void main() {

object oPCExiting = GetExitingObject();
string sGetMessage = GetLocalString(OBJECT_SELF,"sTriggerMessageExit");

    if (GetIsPC(oPCExiting)&& GetLocalInt(oPCExiting,sGetMessage) ==0)
    {
		
		 SetLocalInt(oPCExiting,sGetMessage,1);
		 DelayCommand(180.0f,DeleteLocalInt(oPCExiting,sGetMessage));
         int iSingleUse = GetLocalInt(OBJECT_SELF,"iSingleUseExit");

         string sGetScript = GetLocalString(OBJECT_SELF,"sTriggerScriptExit");
         if (sGetMessage != "" && iSingleUse == 0)
         {
            FloatingTextStringOnCreature(sGetMessage, oPCExiting, FALSE);
         }
        else if (sGetMessage != "" && iSingleUse <= 1)
        {

            object oPCGroup = GetFirstObjectInShape(SHAPE_SPHERE,8.0f, GetLocation(oPCExiting));

            while (GetIsObjectValid(oPCGroup))
            {

                if (GetIsPC(oPCGroup))
                {
                    FloatingTextStringOnCreature(sGetMessage, oPCExiting, FALSE);
                }
         oPCGroup = GetNextObjectInShape(SHAPE_SPHERE,8.0f, GetLocation(oPCExiting));
        SetLocalInt(OBJECT_SELF,"iSingleUseExit",iSingleUse * 2);
            }
        }

        if (sGetScript != "" && iSingleUse <= 1)
        {


            ExecuteScript(sGetScript);
            SetLocalInt(OBJECT_SELF,"iSingleUseExit",iSingleUse * 2);

        }
    }
}
