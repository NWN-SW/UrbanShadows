//Firing Line by Alexander G

#include "tsw_class_func"
#include "spell_dmg_inc"

const int VFX_MOB_COM_HEAL = 49;

void main()
{
    //Leave if not ranged weapon
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    int nType = GetBaseItemType(oWep);
    if(!GetWeaponRanged(oWep))
    {
        SendMessageToPC(OBJECT_SELF, "Requires a ranged weapon.");
        return;
    }


    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_FNF_LOS_NORMAL_10);
    object oTarget = OBJECT_SELF;
    int nCount = 0;

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Set and apply Attack/Damage buffs
    effect eAttack = EffectAttackDecrease(5, ATTACK_BONUS_ONHAND);
    effect eDamage = EffectDamageIncrease(5, DAMAGE_TYPE_PIERCING);
    effect eLink = EffectLinkEffects(eAttack, eDamage);
    //Make the effect supernatural
    eLink = SupernaturalEffect(eLink);
    //Add a tag to the effect for removal later
    eLink = TagEffect(eLink, "Marksman_Firing_Line");

    //Remove all existing auras
    effect eEffect = GetFirstEffect(OBJECT_SELF);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectTag(eEffect) == "Marksman_Firing_Line")
        {
            RemoveEffect(OBJECT_SELF, eEffect);
            nCount = 1;
            SendMessageToPC(OBJECT_SELF, "You disable your stance.");
            break;
        }
        eEffect = GetNextEffect(OBJECT_SELF);
    }

    if(nCount != 1)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(60));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }

    if(nCount != 1)
    {
        //Class mechanics
        string sSpellType = "Tactic";
        DoMartialMechanic(sSpellType, "Single", 0, OBJECT_SELF);
    }
}
