#include "spell_dmg_inc"
#include "tsw_class_func"
#include "inc_timer"

void main()
{
    float fDuration = GetExtendSpell(18.0);
    int nCheck = GetLocalInt(OBJECT_SELF, "DOOMSEER_PROPHECY");
    if(nCheck == 1)
    {
        SendMessageToPC(OBJECT_SELF, "Spell already in effect.");
        return;
    }

    //Leave if  ranged weapon
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

    if(GetHasFeat(DOOM_PROPHECY_FIRE, OBJECT_SELF) && GetSpellId() == 955)
    {
        eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
        eBoom = EffectVisualEffect(VFX_FNF_FIRESTORM);
        sElement = "Fire";
        nDamageType = DAMAGE_TYPE_FIRE;
    }
    else if(GetHasFeat(DOOM_PROPHECY_COLD, OBJECT_SELF) && GetSpellId() == 956)
    {
        eVis = EffectVisualEffect(VFX_IMP_FROST_S);
        eBoom = EffectVisualEffect(VFX_FNF_ICESTORM);
        sElement = "Cold";
        nDamageType = DAMAGE_TYPE_COLD;
    }
    else if(GetHasFeat(DOOM_PROPHECY_ELEC, OBJECT_SELF) && GetSpellId() == 957)
    {
        eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
        eBoom = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION);
        sElement = "Elec";
        nDamageType = DAMAGE_TYPE_ELECTRICAL;
    }
    else
    {
        SendMessageToPC(OBJECT_SELF, "You can only cast spells aligned with your Prophecy element.");
        return;
    }

    SetLocalInt(OBJECT_SELF, "DOOMSEER_PROPHECY", 1);
    DelayCommand(fDuration, DeleteLocalInt(OBJECT_SELF, "DOOMSEER_PROPHECY"));

    //Apply VFX
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, GetLocation(OBJECT_SELF));

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
    string sSpellType = "Force";
    DoClassMechanic(sSpellType, sTargets, nDamage, oMainTarget);
}
