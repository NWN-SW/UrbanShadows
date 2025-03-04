#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    // Author: Stumble 13 Aug 2002  stumble@nznights.com
    //Edited by Alexander G.

    //Variables
    object oPC = GetLastUsedBy();
    int nCheck = SQLocalsPlayer_GetInt(oPC, "RUSSIA_PUZZLE_2");
    int nStarted = SQLocalsPlayer_GetInt(oPC, "RUSSIA_PUZZLE_1");
    int nAttempts = SQLocalsPlayer_GetInt(oPC, "RUSSIA_ATTEMPTS_1");

    //Sound objects
    object oBoiler = GetObjectByTag("N12_Boiler_Groan");
    object oPipes = GetObjectByTag("N12_Pipe_Groan");
    object oPumps = GetObjectByTag("N12_Pump");
    object oSteam = GetObjectByTag("N12_Steam");
    object oFail = GetObjectByTag("N12_Puzzle_Fail");

    //Return if the person has completed the puzzle.
    if(nCheck == 1)
    {
        return;
    }

    //Add journal entry if new click.
    if(nStarted != 1)
    {
        SQLocalsPlayer_SetInt(oPC, "RUSSIA_PUZZLE_1", 1);
        AddJournalQuestEntry("Russia_Puzzle", 1, oPC, FALSE);
    }

    // Event OnUsed: A lever has been used

    // Note that all levers must have a tag of the form: "LEVER_1", LEVER_2", etc

    // Put here the order in which the levers must be activated
    // Note that any order of any levers will work. For example:
    // "1234" or "1142" or "1122421" or "14" are all valid
    // ========================================================
    string sLeverSequence = "48716253";
    // ========================================================

    // The door we will open when the puzzle is solved
    object oDoor = GetObjectByTag ("N12_PUZZLE_DOOR");

    // The object where the "last lever used" is stored
    object oLeverStatus = GetObjectByTag ("N12_LEVER_1");

    // Get the count of the number of valid levers used so far (0 if none)
    int iLeverCount = GetLocalInt (oLeverStatus, "LEVER_COUNT");

    // Get the number of the lever being used right now
    int iThisLever = StringToInt (GetSubString (GetTag (OBJECT_SELF), 10, 1));

    // Get the number of the lever we expect to be used
    int iNextLeverExpected = StringToInt (GetSubString (sLeverSequence, iLeverCount, 1));

    //Set up feedback damage
    if(nAttempts < 1)
    {
        nAttempts = 1;
    }

    int nDamage;
    nDamage = nAttempts * 10;

    //Effects
    effect eGood = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eBad = EffectVisualEffect(VFX_COM_HIT_ELECTRICAL);
    effect eBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);

    // See if the lever used was what we expected
    if (iThisLever == iNextLeverExpected)
    {
        //Play the right sound based on object.
        if(iThisLever == 4 || iThisLever == 8 || iThisLever == 3 || iThisLever == 2)
        {
            SoundObjectPlay(oBoiler);
        }
        else if(iThisLever == 7 || iThisLever == 1)
        {
            SoundObjectPlay(oPumps);
        }
        else if(iThisLever == 6)
        {
            SoundObjectPlay(oPipes);
        }
        else
        {
            SoundObjectPlay(oSteam);
        }

        // We got the lever we expected. Increment the lever count
        iLeverCount++;
        //Play effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eGood, GetLastUsedBy());

        // Check if we have completed the puzzle
        if (iLeverCount >= GetStringLength (sLeverSequence))
        {
            // No more levers to use, puzzle is complete !!

            // Reset the lever count
            iLeverCount = 0;

            // Completion effects
            CreateItemOnObject("shoptokent4", oPC);
            CreateItemOnObject("shoptokent4", oPC);
            SQLocalsPlayer_SetInt(oPC, "RUSSIA_PUZZLE_2", 1);
            AddJournalQuestEntry("Russia_Puzzle", 2, oPC, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oPC);
            AddReputation(oPC, 16);
        }
    }
    else
    {
        // The lever used was *not* what we expected. So, reset the lever count
        iLeverCount = 0;
        //Play effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBad, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBump, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
        SendMessageToPC(oPC, "Vladmirova Reactor Startup Error: Improper System Activation Order. Applying Disciplinary Feedback.");
        nAttempts = nAttempts + 1;
        SQLocalsPlayer_SetInt(oPC, "RUSSIA_ATTEMPTS_1", nAttempts);
    }
    // Store the current lever count
    SetLocalInt (oLeverStatus, "LEVER_COUNT", iLeverCount);
}
