//Champion Confirma by Alexander G.

#include "spell_dmg_inc"
#include "tsw_class_func"
#include "inc_timer"

void main()
{
    float fDuration = GetExtendSpell(18.0);
    int nCheck = GetLocalInt(OBJECT_SELF, "CHAMPION_CONFIRMA");
    if(nCheck == 1)
    {
        SendMessageToPC(OBJECT_SELF, "Spell already in effect.");
        return;
    }

    //Leave if ranged weapon
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    int nType = GetBaseItemType(oWep);
    if(GetWeaponRanged(oWep))
    {
        SendMessageToPC(OBJECT_SELF, "Requires a melee weapon.");
        return;
    }

    //Effect variables
    effect eVis;
    effect eBoom;
    effect eDamage;
    string sElement;
    int nDamageType;

    eVis = EffectVisualEffect(VFX_IMP_HEALING_L);
    eBoom = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    sElement = "Holy";
    nDamageType = DAMAGE_TYPE_FIRE;

    SetLocalInt(OBJECT_SELF, "CHAMPION_CONFIRMA", 1);
    DelayCommand(fDuration, DeleteLocalInt(OBJECT_SELF, "CHAMPION_CONFIRMA"));

    //Apply VFX
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);

    //Base damage roll for class mechanics
    object oTarget;
    object oMainTarget = GetAttemptedAttackTarget();
    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        int nDamage = GetEighthLevelDamage(oTarget, 5, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    //End Custom Spell-Function Block

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, sTargets, nDamage, oMainTarget);
}
