///////////////////////////////////////
//MadRabbit's HIPS Feat              //
//Created By : MadRabbit             //
//Created On : April 14, 2009        //
//Email : mad_rabbit_land@hotmail.com//
///////////////////////////////////////
//Include file for HIPS feat

//This is the delay in seconds before a shadowdancer may use HIPS after
//leaving stealth mode
const float HIPS_DELAY = 6.0f;



void HIPS_On_ClientEnter()
{
    object oPC = GetEnteringObject();

    if (GetLocalInt(oPC, "MR_HIPS"))
    {
        SetLocalInt(oPC, "MR_HIPS_CHK", 1);
        DeleteLocalInt(oPC, "MR_HIPS");
    }

    //Only execute the script on people who have the feat or shifters with
    //kobold commando form
    if (GetHasFeat(1118, oPC) || GetLevelByClass(CLASS_TYPE_SHIFTER, oPC) >= 7)
        ExecuteScript("mr_hips_chk", oPC);
}

