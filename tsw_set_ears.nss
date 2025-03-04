#include "utl_i_sqlplayer"

void SetEars(int nEars, object oPC)
{
    //Gender
    int nGender = GetGender(oPC);
    //Ear model
    effect eEars = EffectVisualEffect(nEars);
    //Lower ears for females
    vector vHeight = Vector(0.0, 0.0, -0.075);
    if(nGender == 1)
    {
        eEars = EffectVisualEffect(nEars, FALSE, 1.0, vHeight);
    }
    //Check for and remove existing ears. Then return.
    //If no ears found, add new ones.
    int nCheck = SQLocalsPlayer_GetInt(oPC, "PC_HAS_EARS");
    string sName = "PC_EARS";

    if(nCheck == 1)
    {
        effect eEffect = GetFirstEffect(oPC);
        while(GetIsEffectValid(eEffect))
        {
            if(GetEffectTag(eEffect) == sName)
                RemoveEffect(oPC, eEffect);
            eEffect = GetNextEffect(oPC);
        }
        SQLocalsPlayer_SetInt(oPC, "PC_HAS_EARS", 0);
        return;
    }
    else
    {
        eEars = SupernaturalEffect(eEars);
        eEars = TagEffect(eEars, sName);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEars, oPC);
        SQLocalsPlayer_SetInt(oPC, "PC_HAS_EARS", 1);
    }
}
