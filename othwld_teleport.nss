        #include "othwld_fog_resto"
#include "inc_timer"

void main()
{
    object oPC = GetFirstPC();
    object oArea = GetArea(oPC);
    object oWP = GetObjectByTag("otherworld_in");
    object oFort = GetObjectByTag("TheEnd_WZ");
    effect eNature = EffectVisualEffect(29,FALSE,0.20f);
    effect eBlessed = EffectVisualEffect(VFX_DUR_PIXIEDUST,FALSE);
    effect eRegen = EffectRegenerate(20, 2.0);
    string sEnding = "The Otherworld event has passed. Gaia's blessing upon you.";
    string sFinish = "The Otherworld event has passed.";

    //Start the Otherworld wave countdown
    SetEventScript(oFort, 4000, "fort_countdown");

    //Make sure we only affect players in specific zones.
    string sSafezone = GetTag(oArea);
    string sPrefix = "OS_";
    string sPrefix2 = "OE_";
    string sCompare = GetStringLeft(sSafezone, 3);

    while(oPC != OBJECT_INVALID)
    {
        //Safety timer
        if(GetTimerEnded("OTHERWORLD_PROTECTION", oPC))
        {
            //Interior check
            int nInside = GetLocalInt(oPC, "I_AM_INSIDE_SAFE");

            if(sPrefix == sCompare)
            {
                FloatingTextStringOnCreature(sEnding, oPC, FALSE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eNature, oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlessed, oPC,3.0f);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oPC, 10.0);
            }
            else if(sPrefix2 == sCompare)
            {
                FloatingTextStringOnCreature(sFinish, oPC, FALSE);
            }
            else if(!GetIsAreaInterior(oArea) && sPrefix2 != sCompare && sPrefix != sCompare && nInside != 1)
            {
                if ( !GetIsObjectValid(oArea) || GetTag(oArea) == "" || GetTag(oArea) == " " || GetResRef(oArea) == "" || GetResRef(oArea)== " ")
                {
                    SendMessageToPC(oPC,"If you see this : You were saved from getting Otherworlded mid-loading screen, or I goofed severely. (Report this message either way)");
                    break;
                }
                ForceRest(oPC);
                AssignCommand(oPC, ClearAllActions(TRUE));
                AssignCommand(oPC, ActionJumpToObject(oWP));
            }
        }
        oPC = GetNextPC();
        oArea = GetArea(oPC);
        sSafezone = GetTag(oArea);
        sCompare = GetStringLeft(sSafezone, 3);
    }

    //Restart music in all areas
    oArea = GetFirstArea();
    while(oArea != OBJECT_INVALID)
    {
        MusicBackgroundPlay(oArea);
        oArea = GetNextArea();
    }

    //Turn off siren sfx
    int nSirenCount = 0;
    object oSiren = GetObjectByTag("OtherworldSiren", nSirenCount);
    SoundObjectStop(oSiren);
    nSirenCount++;

    while(oSiren != OBJECT_INVALID)
    {
        oSiren = GetObjectByTag("OtherworldSiren", nSirenCount);
        SoundObjectStop(oSiren);
        nSirenCount++;
    }

    //Restore the fog
    RestoreFog();
}
