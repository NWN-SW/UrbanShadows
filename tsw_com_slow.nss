//Commander Slow Aura

#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"

const int VFX_MOB_COM_SLOW = 52;

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
    effect eVis2 = EffectVisualEffect(VFX_IMP_PDK_INSPIRE_COURAGE);
    effect eAura = EffectVisualEffect(276, FALSE, 2.5);
    object oTarget = OBJECT_SELF;
    int nCount = 0;

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Set and apply AOE object
    effect eAOE = EffectAreaOfEffect(VFX_MOB_COM_SLOW);
    eAOE = EffectLinkEffects(eAOE, eAura);
    //Make the effect supernatural
    eAOE = SupernaturalEffect(eAOE);
    //Add a tag to the effect for removal later
    eAOE = TagEffect(eAOE, "Commander_Slow");

    //Remove all existing auras
    effect eEffect = GetFirstEffect(OBJECT_SELF);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectTag(eEffect) == "Commander_Resist" || GetEffectTag(eEffect) == "Commander_Debuff" || GetEffectTag(eEffect) == "Commander_Heal")
        {
            RemoveEffect(OBJECT_SELF, eEffect);
        }

        if(GetEffectTag(eEffect) == "Commander_Slow")
        {
            RemoveEffect(OBJECT_SELF, eEffect);
            nCount = 1;
            SendMessageToPC(OBJECT_SELF, "You disable your aura.");
            DeleteLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE");
        }
        eEffect = GetNextEffect(OBJECT_SELF);
    }

    if(nCount != 1)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oTarget, TurnsToSeconds(60));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        //Class mechanics
        string sSpellType = "Tactic";
        DoMartialMechanic(sSpellType, "AOE", 0, oTarget);
    }
}
