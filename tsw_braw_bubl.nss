//::///////////////////////////////////////////////
//:: Burning Blood by Alexander Gates
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "tsw_class_func"
#include "spell_dmg_inc"

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
    object oTarget = OBJECT_SELF;
    effect eParal = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
    effect eEntangle = EffectImmunity(IMMUNITY_TYPE_ENTANGLE);
    effect eSlow = EffectImmunity(IMMUNITY_TYPE_SLOW);
    effect eMove = EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
    effect eVis = EffectVisualEffect(1088);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_BLACK);

    //Check if we already have effect
    int nCheck = GetLocalInt(OBJECT_SELF, "BRAWLER_BURNING_BLOOD");
    if(nCheck != 0)
    {
        SendMessageToPC(OBJECT_SELF, "Ability already in effect.");
        return;
    }

    //Duration
    float fDuration = GetExtendSpell(15.0);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    SetLocalInt(OBJECT_SELF, "BRAWLER_BURNING_BLOOD" , 1);
    DelayCommand(fDuration, DeleteLocalInt(OBJECT_SELF, "BRAWLER_BURNING_BLOOD"));

    //Search for and remove the above negative effects
    effect eLook = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eLook))
    {
        if(GetEffectType(eLook) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eLook) == EFFECT_TYPE_ENTANGLE ||
            GetEffectType(eLook) == EFFECT_TYPE_SLOW ||
            GetEffectType(eLook) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eLook) == EFFECT_TYPE_STUNNED ||
            GetEffectType(eLook) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
        {
            RemoveEffect(oTarget, eLook);
        }
        eLook = GetNextEffect(oTarget);
    }

    //Heal
    effect eHeal = EffectRegenerate(4, 1.0);

    //Apply Linked Effect
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur2, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHeal, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    //Class mechanics
    DoMartialMechanic("Tactic", "Single", 0, OBJECT_SELF);
    DoMartialMechanic("Buff", "Single", 0, OBJECT_SELF);
}

