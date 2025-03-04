//Blade Thirst by Alexander G.
#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = GetCasterLevel(OBJECT_SELF) / 3;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF) / 3;
    int nMetaMagic = GetMetaMagicFeat();
    float fDuration = IntToFloat(nDuration);
    fDuration = fDuration * 65;

    //Limit nCasterLvl to 5, so it max out at +5 enhancement to the weapon.
    if(nCasterLvl > 5)
    {
        nCasterLvl = 5;
    }

    itemproperty iAttack = ItemPropertyAttackBonus(nCasterLvl);
    itemproperty iDamage = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID, nCasterLvl);
    itemproperty iVamp = ItemPropertyVampiricRegeneration(nCasterLvl);



     object oMyWeapon   =  GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }

    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        if (nDuration > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            IPSafeAddItemProperty(oMyWeapon,iAttack, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
            IPSafeAddItemProperty(oMyWeapon,iDamage, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
            IPSafeAddItemProperty(oMyWeapon,iVamp, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        }
        return;
    }
        else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }
}
