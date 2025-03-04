#include "othwld_fog"

void main()
{
    int nSirenCount = 0;
    object oSiren = GetObjectByTag("OtherworldSiren", nSirenCount);
    SoundObjectPlay(oSiren);
    nSirenCount++;

    while(oSiren != OBJECT_INVALID)
    {
        oSiren = GetObjectByTag("OtherworldSiren", nSirenCount);
        SoundObjectPlay(oSiren);
        nSirenCount++;
    }

    //Reminders and music stop
    object oPC = GetFirstPC();
    object oArea = GetArea(oPC);
    string sWarning = "Otherworld event detected. Get indoors.";
    string sWarning2 = "Otherworld event imminent. 30 seconds to get indoors.";
    string sWarning3 = "Otherworld event imminent. 15 seconds to get indoors.";
    string sWarningA = "Otherworld event detected. Stay in a safe area until the all-clear is given.";
    string sWarningB = "Otherworld event incoming. Please remain here until the all-clear is given.";
    string sWarningC = "Otherworld event imminent. Please remain here until the all-clear is given.";

    //Change area fog. Shake camera.
    effect eShake = EffectVisualEffect(286);
    DelayCommand(5.0, OtherworldFog());

    //Make sure we only affect players in specific zones.
    string sSafezone = GetTag(oArea);
    string sPrefix = "OS_";
    string sPrefix2 = "OE_";
    string sCompare = GetStringLeft(sSafezone, 3);

    while(oPC != OBJECT_INVALID)
    {
        if(sPrefix != sCompare && sPrefix2 != sCompare)
        {
            MusicBackgroundStop(oArea);
            FloatingTextStringOnCreature(sWarning, oPC, FALSE);
            //Screen shake
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oPC);
            DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oPC));
            DelayCommand(3.0, FadeToBlack(oPC, FADE_SPEED_SLOWEST));
            DelayCommand(5.0, FadeFromBlack(oPC, FADE_SPEED_SLOWEST));
            //Repeat message
            DelayCommand(30.0, FloatingTextStringOnCreature(sWarning2, oPC, FALSE));
            DelayCommand(45.0, FloatingTextStringOnCreature(sWarning3, oPC, FALSE));
        }
        else
        {
            FloatingTextStringOnCreature(sWarningA, oPC, FALSE);
            //Repeat message
            DelayCommand(30.0, FloatingTextStringOnCreature(sWarningB, oPC, FALSE));
            DelayCommand(45.0, FloatingTextStringOnCreature(sWarningC, oPC, FALSE));
        }
        oPC = GetNextPC();
        oArea = GetArea(oPC);
        sSafezone = GetTag(oArea);
        sCompare = GetStringLeft(sSafezone, 3);
    }

    //Play VFX on captured players
    DelayCommand(57.0, ExecuteScript("othwld_vfx", OBJECT_SELF));

    //Teleport players not indoors to Otherworld
    DelayCommand(60.0, ExecuteScript("othwld_teleport", OBJECT_SELF));
}
