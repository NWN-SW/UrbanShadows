void main()
{
    //Track players in area with sword parts.
    object oPC = GetExitingObject();

    //Don't check items if it's not a PC
    if(!GetIsPC(oPC))
    {
        ExecuteScript("tsw_astpz_3n_ext");
        return;
    }
    else
    {
        object oBlade = GetItemPossessedBy(oPC, "ObsidianBlade");
        object oHandle = GetItemPossessedBy(oPC, "ObsidianHandle");
        object oSword = GetItemPossessedBy(oPC, "ObsidianSword");
        string sCountName = "ALTAR_PC_COUNTER";
        string sVFXToggle = "ALTER_VFX_TOGGLE";
        string sRitual = "ASTORIA_RITUAL_AREA";
        int nCounter = GetLocalInt(OBJECT_SELF, sCountName);
        int nToggle = GetLocalInt(OBJECT_SELF, sVFXToggle);
        int Check1;
        int Check2;

        //Check if they are a PC and have both parts of the broken blade.
        if(oPC != OBJECT_INVALID && oBlade != OBJECT_INVALID && oHandle != OBJECT_INVALID)
        {
            Check1 = 1;
        }
        //Check if they are a PC and have the completed sword.
        if(oPC != OBJECT_INVALID && oSword != OBJECT_INVALID)
        {
            Check2 = 1;
        }

        if(Check1 == 1 || Check2 == 1)
        {
            nCounter = nCounter - 1;
            SetLocalInt(OBJECT_SELF, sCountName, nCounter);
            nCounter = GetLocalInt(OBJECT_SELF, sCountName);
            SetLocalInt(oPC, sRitual, 0);

            //VFX handling
            if(nCounter < 1)
            {
                //Get waypoints by tag
                int nLoop = 8;
                int nStep = 0;
                object oLightshaft;

                while(nStep < nLoop)
                {
                    oLightshaft = GetObjectByTag("YellowLightshaftRitual", nStep);
                    DestroyObject(oLightshaft);
                    nStep = nStep + 1;
                }

                object oSphere = GetObjectByTag("AstSphereGlow");
                SetObjectVisualTransform(oSphere, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, -9.0);
                SetLocalInt(OBJECT_SELF, sVFXToggle, 0);
            }

        }
    }
}
