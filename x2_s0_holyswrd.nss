//::///////////////////////////////////////////////
//:: Holy Sword
//:: X2_S0_HolySwrd
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Grants holy avenger properties.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 28, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller

#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
#include "loot_wep_type"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-07-07 by Georg Zoeller
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    object oTarget = GetAttemptedSpellTarget();
    int nDuration = GetCasterLevel(OBJECT_SELF) / 6;
    int nMetaMagic = GetMetaMagicFeat();
    object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    string sNewTag = "OH_2H_HOAV";
    string sOldTag = GetTag(oMyWeapon);
    int nAmmo = nDuration * 5;
    int nAttacks = nDuration * 4;

    if(nDuration < 1)
    {
        nDuration = 1;
    }

    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        float fDuration = RoundsToSeconds(nDuration);

        if (nDuration > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), RoundsToSeconds(nDuration));
            //Do something different for ranged weapons
            if(GetBaseItemType(oMyWeapon) == 6)
            {
                CreateItemOnObject("hoav_rf_bullets", OBJECT_SELF, nAmmo);
                object oAmmo = GetItemPossessedBy(OBJECT_SELF, "OH_GU_HOAV");
                ActionDoCommand(ActionEquipItem(oAmmo, INVENTORY_SLOT_BOLTS));
                DelayCommand(60.0, DestroyObject(oAmmo));
            }
            else if(GetBaseItemType(oMyWeapon) == 11)
            {
                CreateItemOnObject("hoav_hg_bullets", OBJECT_SELF, nAmmo);
                object oAmmo = GetItemPossessedBy(OBJECT_SELF, "OH_GU_HOAV");
                ActionDoCommand(ActionEquipItem(oAmmo, INVENTORY_SLOT_ARROWS));
                DelayCommand(60.0, DestroyObject(oAmmo));
            }
            else
            {
                SetTag(oMyWeapon, sNewTag);
                SetLocalInt(OBJECT_SELF, "HOLY_SWORD_ATTACKS", nAttacks);
                SetLocalString(OBJECT_SELF, "MAIN_WEP_TAG", sOldTag);
            }
            //SendMessageToPC(OBJECT_SELF, "Old Tag: " + sOldTag + " and New Tag: " + sNewTag);
        }
        TLVFXPillar(VFX_IMP_GOOD_HELP, GetLocation(GetSpellTargetObject()), 4, 0.0f, 6.0f);
        DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_SUPER_HEROISM),GetLocation(GetSpellTargetObject())));

        return;
    }
        else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }

}
