//:://////////////////////////////////////////////////
//:: X0_O0_RESPAWN
//:: Copyright (c) 2002 Floodgate Entertainment
//:://////////////////////////////////////////////////
/*
  Respawn handler for XP1.
 */
//:://////////////////////////////////////////////////
//:: Created By: Naomi Novik
//:: Created On: 10/10/2002
//:://////////////////////////////////////////////////

#include "nw_i0_plot"
#include "x0_i0_common"
#include "utl_i_sqlplayer"
#include "tsw_class_consts"

/**********************************************************************
 * CONSTANTS
 **********************************************************************/

/**********************************************************************
 * FUNCTION PROTOTYPES
 **********************************************************************/


/**********************************************************************
 * FUNCTION DEFINITIONS
 **********************************************************************/

// Raise & heal the player, clearing all negative effects
void Raise(object oPlayer)
{
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);

    ApplyEffectToObject(DURATION_TYPE_INSTANT,
                        EffectResurrection(),
                        oPlayer);

    ApplyEffectToObject(DURATION_TYPE_INSTANT,
                        EffectHeal(GetMaxHitPoints(oPlayer)),
                        oPlayer);

    // Remove negative effects
    RemoveEffects(oPlayer);

    //Fire cast spell at event for the specified target
    SignalEvent(oPlayer,
                EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPlayer);
}


// * Applies an XP and GP penalty
// * to the player respawning
void ApplyPenalty(object oDead)
{
    int nGoldToTake =    FloatToInt(0.1 * GetGold(oDead));
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
    DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oDead, FALSE));
}


//Punishes dead Hardcore characters for the peasants they are.
void ApplyHardcorePenalty(object oDead)
{
    object oItem = GetFirstItemInInventory(oDead);
    int nGoldToTake = GetGold(oDead);
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));

    while(oItem != OBJECT_INVALID)
    {
        if(oItem != GetItemInSlot(INVENTORY_SLOT_CARMOUR, oDead) && !GetPlotFlag(oItem) )
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oDead);
    }

    //Delete equipped items.
    int nSlot;
    for (nSlot = 0; nSlot < INVENTORY_SLOT_CWEAPON_L; nSlot++)
    {
        DestroyObject(GetItemInSlot(nSlot, oDead));
    }
    CreateItemOnObject("d_boots", oDead);
    GiveGoldToCreature(oDead, 5000);

    object oPC = GetFirstPC();
    string sName = GetName(oDead);
    string sMessage = sName + " has died and lost everything! The enemies of creation claim another.";
    while(oPC != OBJECT_INVALID)
    {
        FloatingTextStringOnCreature(sMessage, oPC);
        oPC = GetNextPC();
    }
}

//////////////////////////////////////////////////////////////////////////////

void DoPCRespawn(object oPC)
{
    object oRespawner = oPC;
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
    RemoveEffects(oRespawner);

/* Give Stats based on skin name
    object oItem = GetItemInSlot(17, oRespawner);//PC Skin
    string sName = GetName(oItem);
    effect eCONBuff = EffectAbilityIncrease(2, 8);
    if (sName == "pc_STR_skin")
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCONBuff, oRespawner);
    }
 */

    string sDestTag =  "tp_recall";
    string sArea = GetTag(GetArea(oRespawner));
    object oSpawnPoint = GetObjectByTag(sDestTag);

    //Get Hardcore Variable
    int nHardcore = SQLocalsPlayer_GetInt(oRespawner, "AM_HARDCORE");
    int nIntCheck = GetLocalInt(GetArea(oRespawner), "PENALTY_SAFE_AREA");

    if(sArea != "FortMyrkur_WZ" && nHardcore != 1 && sArea != "OS_training_place" && nIntCheck != 1)
    {
        ApplyPenalty(oRespawner);
    }

    //Requip boots
    object oBoots = GetItemInSlot(2, oRespawner);
    DelayCommand(10.0, ActionUnequipItem(oBoots));
    DelayCommand(10.0, ActionEquipItem(oBoots, 2));

    if(sArea != "OS_training_place")
    {
        if(nHardcore == 1  && nIntCheck != 1)
        {
            ApplyHardcorePenalty(oRespawner);
        }

        AssignCommand(oRespawner, JumpToLocation(GetLocation(oSpawnPoint)));
    }

    //Mystic bolt
    DelayCommand(0.2, DecrementRemainingFeatUses(oRespawner, 1250));
    DelayCommand(0.3, DecrementRemainingFeatUses(oRespawner, 1250));
    DelayCommand(0.4, DecrementRemainingFeatUses(oRespawner, 1250));
    DelayCommand(0.5, DecrementRemainingFeatUses(oRespawner, 1250));
    DelayCommand(0.6, DecrementRemainingFeatUses(oRespawner, 1250));

    //Clear Umbral Tether
    DeleteLocalInt(OBJECT_SELF, "SHADOW_MARK_SET");

    //Remove dead variable
    SQLocalsPlayer_DeleteInt(oRespawner, "CURRENTLY_DEAD");

    //Reset Bloodmage Ritual
    if(GetHasFeat(BLOO_BLOOD_RITUAL, oRespawner))
    {
        SetLocalInt(oRespawner, "I_AM_BLOODMAGE", 1);
    }
}

