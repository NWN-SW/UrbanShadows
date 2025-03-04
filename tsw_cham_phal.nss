//Phalanx By Alexander G.

#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"

const int VFX_MOB_COM_RESIST = 50;

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eVis2 = EffectVisualEffect(1083);
    object oTarget = OBJECT_SELF;

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    int nAmount = GetHighestAbilityModifier(OBJECT_SELF) * 2;

    effect eFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, nAmount);
    effect eCold = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, nAmount);
    effect eElec = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, nAmount);
    effect eAcid = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, nAmount);
    effect eNega = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, nAmount);
    effect eMagi = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, nAmount);
    effect eSoni = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, nAmount);
    //effect ePosi = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, nAmount);
    effect eDivi = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, nAmount);
    effect eSlash = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, nAmount);
    effect ePierce = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, nAmount);
    effect eBludge = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, nAmount);

    effect eLink = EffectLinkEffects(eFire, eCold);
    eLink = EffectLinkEffects(eLink, eElec);
    eLink = EffectLinkEffects(eLink, eAcid);
    eLink = EffectLinkEffects(eLink, eNega);
    eLink = EffectLinkEffects(eLink, eMagi);
    eLink = EffectLinkEffects(eLink, eSoni);
    //eLink = EffectLinkEffects(eLink, ePosi);
    eLink = EffectLinkEffects(eLink, eDivi);
    eLink = EffectLinkEffects(eLink, eSlash);
    eLink = EffectLinkEffects(eLink, ePierce);
    eLink = EffectLinkEffects(eLink, eBludge);

    //Make the effect supernatural
    eLink = SupernaturalEffect(eLink);
    //Add a tag to the effect for removal later
    eLink = TagEffect(eLink, "CHAMPION_PHALANX_EFFECT");

    //Remove all existing auras
    effect eEffect = GetFirstEffect(OBJECT_SELF);
    int nCheck = 1;
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectTag(eEffect) == "CHAMPION_PHALANX_EFFECT")
        {
            RemoveEffect(OBJECT_SELF, eEffect);
            nCheck = 0;
            FloatingTextStringOnCreature("Phalanx disabled.", OBJECT_SELF);
            SetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE", 0);
        }
        eEffect = GetNextEffect(OBJECT_SELF);
    }

    if(nCheck == 1)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(60));
        SetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE", 1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        //Class mechanics
        DoMartialMechanic("Tactic", "AOE", 0, oTarget);
        string sSpellType = "Buff";
        DoClassMechanic(sSpellType, "AOE", 0, oTarget);

    }
}
