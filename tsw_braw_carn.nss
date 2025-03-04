#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "inc_timer"

void main()
{
    float fDuration = GetExtendSpell(18.0);
    int nCheck = GetLocalInt(OBJECT_SELF, "BRAWLER_CARNAGE");
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

    eVis = EffectVisualEffect(961);
    eBoom = EffectVisualEffect(1080);
    sElement = "Slash";
    nDamageType = DAMAGE_TYPE_SLASHING;

    SetLocalInt(OBJECT_SELF, "BRAWLER_CARNAGE", 1);
    DelayCommand(fDuration, DeleteLocalInt(OBJECT_SELF, "BRAWLER_CARNAGE"));

    //Apply VFX
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, OBJECT_SELF);

    //Base damage roll for class mechanics
    object oTarget;
    object oMainTarget = GetAttemptedAttackTarget();
    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        int nDamage = GetNinthLevelDamage(oTarget, 5, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    //End Custom Spell-Function Block

    //Class mechanics
    string sSpellType = "Assault";
    DoMartialMechanic(sSpellType, sTargets, nDamage, oMainTarget);
}

