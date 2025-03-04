#include "mr_hips_inc"
///////////////////////////////////////
//MadRabbit's HIPS Feat              //
//Created By : MadRabbit             //
//Created On : April 14, 2009        //
//Email : mad_rabbit_land@hotmail.com//
///////////////////////////////////////
//Pseudo heartbeat to check for when the shadowdancer is out of HIPS and then
//flags them for the delay
void HIPS_Heartbeat()
{
    //I don't know if this can happen, but making sure the target of the
    //script is valid so the script isnt running on people who have logged out
    if (!GetIsObjectValid(OBJECT_SELF)) return;

    //Only run the code on players who have the feat in order to keep from
    //applying delays on shifters who are not in kobold commando form
    if (GetHasFeat(1118)) {

        //Get the stealth mode of the target and whether or not they have been
        //flagged for a check
        int nStealth = GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH);
        int nCheck = GetLocalInt(OBJECT_SELF, "MR_HIPS_CHK");

        //If they are in Stealth mode and not flagged for a check, then
        //they have used the stealth mode button to enter stealth mode and
        //need to be flagged
        if (nStealth && !nCheck)
            SetLocalInt(OBJECT_SELF, "MR_HIPS_CHK", 1);

        //If they are no longer in stealth mode, are not flagged for a delay and
        //flagged as needing to be checked, then apply the delay to prohibit use of the
        //ability. If they are flagged for a delay and flagged for a check, then
        //they have somehow managed to leave HIPS, start the delay, enter stealth
        //while the delay is still running. Therefore, we shall wait until the
        //delay is over, and then enforce another delay.
        if (!nStealth && nCheck && !GetLocalInt(OBJECT_SELF, "MR_HIPS")) {

            //Convert the delay to a string and inform the player of how long until
            //they may use HIPS again
            string sDelay = IntToString(FloatToInt(HIPS_DELAY));
            SendMessageToPC(OBJECT_SELF, "You may not use Hide In Plain Sight for " + sDelay + " seconds");

            //Delete the flag for checking
            DeleteLocalInt(OBJECT_SELF, "MR_HIPS_CHK");

            //Flag them for delay
            SetLocalInt(OBJECT_SELF, "MR_HIPS", 1);

            //Delete the flag after the delay period has passed
            DelayCommand(HIPS_DELAY, DeleteLocalInt(OBJECT_SELF, "MR_HIPS"));
            DelayCommand(HIPS_DELAY, SendMessageToPC(OBJECT_SELF, "You may now use Hide In Plain Sight")); } }

    //Fire the heartbeat again in 1 seconds
    DelayCommand(1.0, HIPS_Heartbeat());
}

void main()
{
    HIPS_Heartbeat();
}

