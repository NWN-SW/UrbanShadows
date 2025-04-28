int CountPatterns (string sPattern)
{

	// We want to find the amount of different words in the sPattern string.
	// As an example, sPattern could be "lamp,cake,toto".
	// So by finding two commas, we know it's actually that number +1 words existing

 return 0;

}

string ParsePattern (string sPattern)
{

	// Here we will want to split a string into substrings by using a comma as the separator
	// Store the first word found in a var, remove it from the original string.
	// Reassign that newly updated string to sPattern
	// Return the isolated word to the calling function

    return "string";

}

void main()
{

     int iCooldown = GetLocalInt(OBJECT_SELF,"iCooldown");

     if (iCooldown != 0)
     {
        SetLocalInt(OBJECT_SELF,"iCooldown",iCooldown-1);
        return;
     }
     else if (iCooldown == 0)
     {
      SetLocalInt(OBJECT_SELF,"iCooldown",10);
     }

    int iAreaStatus = GetLocalInt(OBJECT_SELF, "iAreaNightCycle");
    int iVarBool;

    if (GetIsNight() && iAreaStatus == 0)
    	{
      SetLocalInt(OBJECT_SELF, "iAreaNightCycle",1);
    		iVarBool = 1;

    	}
    	else if (GetIsDay() && iAreaStatus == 1)
    	{
      SetLocalInt(OBJECT_SELF, "iAreaNightCycle",0);
    		iVarBool = 0;

    	}
    else
    	{
    		return;
    	}

    object oFEligiblePlaceable = GetFirstObjectInArea(OBJECT_SELF, OBJECT_TYPE_PLACEABLE);
    string sPattern = GetLocalString(OBJECT_SELF, "sActivatePattern");
    while (oFEligiblePlaceable != OBJECT_INVALID)
    	{
        if (FindSubString(sPattern,GetName(oFEligiblePlaceable)) != -1)
        		{

        			DoPlaceableObjectAction(oFEligiblePlaceable, iVarBool);

        		}
        		oFEligiblePlaceable = GetNextObjectInArea(OBJECT_SELF, OBJECT_TYPE_PLACEABLE);
    	}
}
