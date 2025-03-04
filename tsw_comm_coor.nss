//Coordination by Alexander G.

#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(548);
    float fDuration = GetExtendSpell(18.0);
    string sTargets;
    int nDamage;
    string sElement;
    int nReduction;

    //Debuffs
    effect eFire = EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, 10);
    effect eCold = EffectDamageImmunityDecrease(DAMAGE_TYPE_COLD, 10);
    effect eElec = EffectDamageImmunityDecrease(DAMAGE_TYPE_ELECTRICAL, 10);
    effect eSoni = EffectDamageImmunityDecrease(DAMAGE_TYPE_ACID, 10);
    effect eAcid = EffectDamageImmunityDecrease(DAMAGE_TYPE_SONIC, 10);
    effect eMagic = EffectDamageImmunityDecrease(DAMAGE_TYPE_MAGICAL, 10);
    effect eNega = EffectDamageImmunityDecrease(DAMAGE_TYPE_NEGATIVE, 10);
    effect eHoly = EffectDamageImmunityDecrease(DAMAGE_TYPE_DIVINE, 10);
    effect eSlash = EffectDamageImmunityDecrease(DAMAGE_TYPE_SLASHING, 10);
    effect ePierce = EffectDamageImmunityDecrease(DAMAGE_TYPE_PIERCING, 10);
    effect eBludge = EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING, 10);

    effect eLink = EffectLinkEffects(eFire, eCold);
    eLink = EffectLinkEffects(eLink, eElec);
    eLink = EffectLinkEffects(eLink, eSoni);
    eLink = EffectLinkEffects(eLink, eAcid);
    eLink = EffectLinkEffects(eLink, eMagic);
    eLink = EffectLinkEffects(eLink, eNega);
    eLink = EffectLinkEffects(eLink, eHoly);
    eLink = EffectLinkEffects(eLink, eSlash);
    eLink = EffectLinkEffects(eLink, ePierce);
    eLink = EffectLinkEffects(eLink, eBludge);

    if(GetIsReactionTypeHostile(oTarget))
    {
        //Start Custom Spell-Function Block
            //Get damage
            sTargets = "AOE";
            nDamage = GetFirstLevelDamage(oTarget, 0, sTargets);

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            sElement = "Soni";
            nReduction = GetFocusReduction(OBJECT_SELF, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
        //End Custom Spell-Function Block

        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);

        fDuration = GetWillDuration(oTarget, nReduction, fDuration);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fDuration);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
        AssignCommand(oTarget, DelayCommand(0.25, PlaySoundByStrRef(16778132, FALSE)));

        //Class mechanics
        DoMartialMechanic("Tactic", "Single", nDamage, oTarget);
        DoMartialMechanic("Debuff", "Single", nDamage, oTarget);
    }
}
