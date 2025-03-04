void main() {

object oPCEntering = GetEnteringObject();
string sGetMessage = GetLocalString(OBJECT_SELF,"sTriggerMessageEnter");

    if (GetIsPC(oPCEntering) && GetLocalInt(oPCEntering,sGetMessage) ==0)
    {
		 SetLocalInt(oPCEntering,sGetMessage,1);
		 DelayCommand(180.0f,DeleteLocalInt(oPCEntering,sGetMessage));
         int iSingleUse = GetLocalInt(OBJECT_SELF,"iSingleUseEnter");

         string sGetScript = GetLocalString(OBJECT_SELF,"sTriggerScriptEnter");
         if (sGetMessage != "" && iSingleUse == 0)
         {
            FloatingTextStringOnCreature(sGetMessage, oPCEntering, FALSE);
         }
        else if (sGetMessage != "" && iSingleUse <= 1)
        {

            object oPCGroup = GetFirstObjectInShape(SHAPE_SPHERE,8.0f, GetLocation(oPCEntering));

            while (GetIsObjectValid(oPCGroup))
            {

                if (GetIsPC(oPCGroup))
                {
                    FloatingTextStringOnCreature(sGetMessage, oPCEntering, FALSE);
                }
         oPCGroup = GetNextObjectInShape(SHAPE_SPHERE,8.0f, GetLocation(oPCEntering));
        SetLocalInt(OBJECT_SELF,"iSingleUseEnter",iSingleUse * 2);
            }
        }

        if (sGetScript != "" && iSingleUse <= 1)
        {

            ExecuteScript(sGetScript);
            SetLocalInt(OBJECT_SELF,"iSingleUseEnter",iSingleUse * 2);

        }
    }
}
