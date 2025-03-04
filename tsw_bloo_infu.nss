//::///////////////////////////////////////////////
// Infusion by Alexander G.
//::///////////////////////////////////////////////

#include "nw_i0_spells"
#include "spell_dmg_inc"
#include "x2_inc_spellhook"
#include "tsw_class_func"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    object oTarget = GetSpellTargetObject();
    float fDuration = GetExtendSpell(30.0);
    int nAmount =  20;
    effect eVis = EffectVisualEffect(VFX_IMP_HARM);
    effect eDamage;
    int nSpell = GetSpellId();
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    eDamage = EffectDamage(nAmount, DAMAGE_TYPE_POSITIVE);
    effect eDur = EffectVisualEffect(1107);
    effect eHeal = EffectRegenerate(10, 5.0);

    //Apply the armor bonuses and the VFX impact
    if(!GetHasSpellEffect(nSpell, OBJECT_SELF))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, OBJECT_SELF, fDuration);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHeal, OBJECT_SELF, fDuration);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF);
        DoClassMechanic("Buff", "Single", 0, OBJECT_SELF);
    }
    else
    {
        SendMessageToPC(OBJECT_SELF, "You are already affected by Infusion.");
    }
}
