//::///////////////////////////////////////////////
//:: Light by Alexander G
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "utl_i_sqlplayer"

void main()
{

   // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run
    // this spell.
    if (!X2PreSpellCastCode())
    {
        return;
    }

    if(GetTag(GetArea(OBJECT_SELF)) != "TheEnd_WZ" && GetTag(GetArea(OBJECT_SELF)) != "OE_ItRests")
    {

        //Declare major variables
        object oTarget = GetSpellTargetObject();

        int nDuration;
        int nMetaMagic;

        int nColour = SQLocalsPlayer_GetInt(OBJECT_SELF, "PC_LIGHT_COLOUR");

        if(nColour == 0)
        {
            nColour == VFX_DUR_LIGHT_WHITE_10;
        }

        effect eVis = EffectVisualEffect(nColour);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eVis, eDur);

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LIGHT, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(10));
    }
    else
    {
        SendMessageToPC(OBJECT_SELF, "Your light spell fades in this place. Something is smothering it.");
    }

}

/*
#include "x2_inc_spellhook"
//:://////////////////////////////////////////////
//:: Created By: Zephyo :)
//:: Created On: Feb 9, 2022
//:://////////////////////////////////////////////
//:: This function returns a shorthand of a character's alignment value.
//:://////////////////////////////////////////////
int AssignShortAlignment(int input)
{
    if (input == 2 || input == 4)
    {
        return 2;
    }

    if (input == 3 || input == 5)
    {
        return 0;
    }

    else
    {
        return 1;
    }
}


void main()
{

   // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run
    // this spell.
    if (!X2PreSpellCastCode())
    {
        return;
    }

    //Declare major variables
    object oTarget = GetSpellTargetObject();

    int nDuration;
    int nMetaMagic;

    int eCheck;         // This integer holds the simplified ethical alignment (Law/Chaos)
    int mCheck;         // This integer holds the simplified moral alighnment  (Good/Evil)

    // Handle spell cast on item....
    if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM && ! CIGetIsCraftFeatBaseItem(oTarget))
    {
        // Do not allow casting on not equippable items
        if (!IPGetIsItemEquipable(oTarget))
        {
         // Item must be equipable...
             FloatingTextStrRefOnCreature(83326,OBJECT_SELF);
            return;
        }

        itemproperty ip = ItemPropertyLight (IP_CONST_LIGHTBRIGHTNESS_NORMAL, IP_CONST_LIGHTCOLOR_WHITE);

        if (GetItemHasItemProperty(oTarget, ITEM_PROPERTY_LIGHT))
        {
            IPRemoveMatchingItemProperties(oTarget,ITEM_PROPERTY_LIGHT,DURATION_TYPE_TEMPORARY);
        }

        nDuration = GetCasterLevel(OBJECT_SELF);
        nMetaMagic = GetMetaMagicFeat();
        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration * 2; //Duration is +100%
        }

        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oTarget,HoursToSeconds(nDuration));
    }
    else
    {

        eCheck = AssignShortAlignment(GetAlignmentLawChaos(OBJECT_SELF));
        // 0 = Chaos, 1 = Neutral, 2 = Law

        mCheck = AssignShortAlignment(GetAlignmentGoodEvil(OBJECT_SELF));
        // 0 = Evil, 1 = Neutral, 2 = Good

        effect eVis;

        switch (eCheck)
            {
            case 0: if (mCheck > 0)         // Chaotic characters that are not evil...
                    {
                        eVis = EffectVisualEffect(VFX_DUR_LIGHT_PURPLE_20);
                    }                       // ...have a purple light..
                    else
                    {
                        eVis = EffectVisualEffect(VFX_DUR_LIGHT_RED_20);
                    }                       // ...while evil charactershave a red light.
                    break;

            case 1: if (mCheck != 1)        // Neutral characters that aren't true neutral...
                    {
                        eVis = EffectVisualEffect(VFX_DUR_LIGHT_BLUE_20);
                    }                       // ...will cast a blue light...
                    else
                    {
                        eVis = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20);
                    }                       // ...while true neutral characters have a yellow light.
                    break;

            case 2: if (mCheck < 2)         // Lawful characters that are not good...
                    {
                        eVis = EffectVisualEffect(VFX_DUR_LIGHT_ORANGE_20);
                    }                       // ...have an orange light...
                    else
                    {
                        eVis = EffectVisualEffect(VFX_DUR_LIGHT_WHITE_20);
                    }                       // ...while good characters have a white light.
                    break;
            }

        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eVis, eDur);

        nDuration = GetCasterLevel(OBJECT_SELF);
        nMetaMagic = GetMetaMagicFeat();
        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2; //Duration is +100%
        }
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LIGHT, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    }

}
*/
