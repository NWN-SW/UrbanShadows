#include "pals_main"

void main()
{
    object oChest;
    string sTag = GetTag(OBJECT_SELF);
    string sToken;
    int nLoop = 0;

    //Determine the correct chest
    if(sTag == "Hobenzog")
    {
        oChest = GetObjectByTag("boss_chest_kh");
        sToken = "loottokenkhz";
    }
    else if(sTag == "Bremkaos")
    {
        oChest = GetObjectByTag("boss_chest_fa");
        sToken = "loottokenfal";
    }
    else if(sTag == "TheRegent")
    {
        oChest = GetObjectByTag("boss_chest_un");
        sToken = "loottokenund";
    }
    else if(sTag == "Doubt")
    {
        oChest = GetObjectByTag("boss_chest_de");
        sToken = "loottokendem";
    }

    CreateItemOnObject(sToken, oChest, 1);

    //Create special effect on chest
    effect eBoom = EffectVisualEffect(VFX_FNF_BLINDDEAF);
    location lSpot = GetLocation(oChest);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lSpot);
    AutoSplitGold(OBJECT_SELF,GetLastKiller());
}
