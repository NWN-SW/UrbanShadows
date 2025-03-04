#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    string sTag = GetTag(oItem);
    string sPCName = GetName(oPC);

    //Check the item being used.
    if(sTag != "ObsidianSword")
    {
        return;
    }

    //Get the nearest trigger area and check if the player is inside.
    object oTrigger = GetNearestObjectByTag("Ast_Puz4_Trig", oPC);
    int nInside = GetLocalInt(oPC, "AST_PUZZLE4_IN");

    if(nInside != 1)
    {
        SendMessageToPC(oPC, "You are not near a Paintite crystal.");
        return;
    }

    //Check if player has already destroyed the nearest crystal.
    string sDone = GetLocalString(oTrigger, sPCName);

    if(sDone != "")
    {
        SendMessageToPC(oPC, "You have already destroyed this Painite crystal.");
        return;
    }
    else
    {
        object oSound = GetNearestObjectByTag("Ast_Crystal_Break", oPC);
        effect eFeedback = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFeedback, GetLocation(oPC));
        SoundObjectPlay(oSound);
        SetLocalString(oTrigger, sPCName, sPCName);
        int nCount = SQLocalsPlayer_GetInt(oPC, "AST_PUZZLE_4_COUNT");
        nCount = nCount + 1;
        SQLocalsPlayer_SetInt(oPC, "AST_PUZZLE_4_COUNT", nCount);

        //Send a message
        string sMessage = IntToString(nCount);
        SendMessageToPC(oPC, "You have destroyed " + sMessage + " crystals.");
    }

    int nCount = SQLocalsPlayer_GetInt(oPC, "AST_PUZZLE_4_COUNT");
    if(nCount >= 8)
    {
        SQLocalsPlayer_SetInt(oPC, "ASTORIA_PUZZLE_5", 1);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        object oScream = GetObjectByTag("Ast_Scream");
        SoundObjectPlay(oScream);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, GetLocation(oPC));
        AddJournalQuestEntry("Astoria_Puzzle", 5, oPC, FALSE);
    }
}
