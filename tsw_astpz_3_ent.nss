void main()
{
    //Track players in area with sword parts.
    object oPC = GetEnteringObject();

    //Don't check items if it's not a PC
    if(!GetIsPC(oPC))
    {
        effect eSignal = EffectVisualEffect(VFX_IMP_PDK_WRATH);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSignal, oPC);
        ExecuteScript("tsw_astpz_3n_ent");
        return;
    }
    else
    {
        object oBlade = GetItemPossessedBy(oPC, "ObsidianBlade");
        object oHandle = GetItemPossessedBy(oPC, "ObsidianHandle");
        string sCountName = "ALTAR_PC_COUNTER";
        string sVFXToggle = "ALTER_VFX_TOGGLE";
        string sRitual = "ASTORIA_RITUAL_AREA";
        int nCounter = GetLocalInt(OBJECT_SELF, sCountName);
        int nToggle = GetLocalInt(OBJECT_SELF, sVFXToggle);

        if(oPC != OBJECT_INVALID && oBlade != OBJECT_INVALID && oHandle != OBJECT_INVALID)
        {
            nCounter = nCounter + 1;
            SetLocalInt(OBJECT_SELF, sCountName, nCounter);
            SetLocalInt(oPC, sRitual, 1);

            //VFX handling
            if(nToggle != 1)
            {
                //Get waypoints and their locations.
                location lWP1 = GetLocation(GetObjectByTag("WP_VFX_AstAltar_1"));
                location lWP2 = GetLocation(GetObjectByTag("WP_VFX_AstAltar_2"));
                location lWP3 = GetLocation(GetObjectByTag("WP_VFX_AstAltar_3"));
                location lWP4 = GetLocation(GetObjectByTag("WP_VFX_AstAltar_4"));
                location lWP5 = GetLocation(GetObjectByTag("WP_VFX_AstAltar_5"));
                location lWP6 = GetLocation(GetObjectByTag("WP_VFX_AstAltar_6"));
                location lWP7 = GetLocation(GetObjectByTag("WP_VFX_AstAltar_7"));
                location lWP8 = GetLocation(GetObjectByTag("WP_VFX_AstAltar_8"));

                CreateObject(OBJECT_TYPE_PLACEABLE, "rituallightyel", lWP1);
                CreateObject(OBJECT_TYPE_PLACEABLE, "rituallightyel", lWP2);
                CreateObject(OBJECT_TYPE_PLACEABLE, "rituallightyel", lWP3);
                CreateObject(OBJECT_TYPE_PLACEABLE, "rituallightyel", lWP4);
                CreateObject(OBJECT_TYPE_PLACEABLE, "rituallightyel", lWP5);
                CreateObject(OBJECT_TYPE_PLACEABLE, "rituallightyel", lWP6);
                CreateObject(OBJECT_TYPE_PLACEABLE, "rituallightyel", lWP7);
                CreateObject(OBJECT_TYPE_PLACEABLE, "rituallightyel", lWP8);

                object oSphere = GetObjectByTag("AstSphereGlow");
                SetObjectVisualTransform(oSphere, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 3.65);
                SetLocalInt(OBJECT_SELF, sVFXToggle, 1);
            }

        }
    }
}
