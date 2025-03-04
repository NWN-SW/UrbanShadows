#include "utl_i_sqlplayer"

void main()
{
    //Get the altar and trigger
    object oAltar = GetObjectByTag("Fathomless_Altar");
    object oTrigger = GetObjectByTag("TSW_AstPz_Altar");
    object oWP = GetObjectByTag("WP_VFX_AstAltar_9");
    location lWP = GetLocation(oWP);
    //Check if the enemy is in the Astoria ritual area
    string sRitual = "ASTORIA_RITUAL_AREA";
    string sVFXToggle = "ALTER_VFX_TOGGLE";
    int nArea = GetLocalInt(OBJECT_SELF, sRitual);
    int nToggle = GetLocalInt(oTrigger, sVFXToggle);

    //VFX
    effect eFeedback = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION);

    //Local int names
    string sAltarCount = "ASTORIA_ALTAR_COUNT";
    int nCounter;

    if(nArea == 1 && nToggle == 1)
    {
        nCounter = GetLocalInt(oAltar, sAltarCount);
        if(nCounter < 12)
        {
            nCounter = nCounter + 1;
            SetLocalInt(oAltar, sAltarCount, nCounter);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFeedback, lWP);
        }
        else if(nCounter >= 12)
        {
            //Reset counter
            SetLocalInt(oAltar, sAltarCount, 0);
            //Do player stuff
            object oPC = GetFirstPC();
            object oBlade = GetItemPossessedBy(oPC, "ObsidianBlade");
            object oHandle = GetItemPossessedBy(oPC, "ObsidianHandle");
            effect eComplete = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL);
            effect eFlashy = EffectVisualEffect(VFX_FNF_SOUND_BURST);
            int nStep = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_4");
            while(oPC != OBJECT_INVALID)
            {
                if(GetArea(oPC) == GetArea(OBJECT_SELF) && oBlade != OBJECT_INVALID && oHandle != OBJECT_INVALID)
                {
                    //Destroy sword components, add finished sword.
                    DestroyObject(oBlade);
                    DestroyObject(oHandle);
                    if(nStep != 1)
                    {
                        CreateItemOnObject("obsidiansword", oPC);
                    }
                    AddJournalQuestEntry("Astoria_Puzzle", 4, oPC, FALSE);
                    SQLocalsPlayer_SetInt(oPC, "ASTORIA_PUZZLE_4", 1);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFlashy, oPC);
                }
                oPC = GetNextPC();
                oBlade = GetItemPossessedBy(oPC, "ObsidianBlade");
                oHandle = GetItemPossessedBy(oPC, "ObsidianHandle");
                nStep = GetLocalInt(oPC, "ASTORIA_PUZZLE_4");
            }
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eComplete, lWP);

            /*
            //Do cleanup.
            int iCount = 0;
            effect eDeath = EffectDeath();
            object oCreature = GetNearestCreatureToLocation(4, TRUE, lWP, iCount);
            nArea = GetLocalInt(oCreature, sRitual);
            while(oCreature != OBJECT_INVALID)
            {
                if(nArea == 1)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oCreature);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFeedback, oCreature);
                    iCount = iCount + 1;
                    oCreature = GetNearestCreatureToLocation(4, TRUE, lWP, iCount);
                    nArea = GetLocalInt(oCreature, sRitual);
                }
                else
                {
                    return;
                }
            }
            */
        }
    }
    ExecuteScript("x2_def_ondeath", OBJECT_SELF);
}
