//Anima Light by Alexander G.

#include "utl_i_sqlplayer"

void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    int nColour = SQLocalsPlayer_GetInt(oPC, "PC_LIGHT_COLOUR");

    if(GetTag(oItem) != "AnimaLight")
    {
        return;
    }

    if(GetTag(GetArea(oPC)) != "TheEnd_WZ" && GetTag(GetArea(oPC)) != "OE_ItRests")
    {

        //Declare major variables
        int nColour = SQLocalsPlayer_GetInt(oPC, "PC_LIGHT_COLOUR");

        if(nColour == 0)
        {
            nColour == VFX_DUR_LIGHT_WHITE_10;
        }

        effect eVis = EffectVisualEffect(nColour);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eVis, eDur);

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, TurnsToSeconds(10));
    }
    else
    {
        SendMessageToPC(oPC, "Your light spell fades in this place. Something is smothering it.");
    }
}
