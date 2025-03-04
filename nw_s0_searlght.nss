//::///////////////////////////////////////////////
//:: Searing Light by Alexander G.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
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

   //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;
    effect eBeam = EffectBeam(VFX_BEAM_HOLY, oCaster, BODY_NODE_HAND, FALSE, 1.0);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetFirstLevelDamage(oTarget, nCasterLevel, sTargets);
        nDamage = nDamage - 25;

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Holy";
        int nReduction = GetFocusReduction(oCaster, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(oCaster, nDamage, sElement);
    //End Custom Spell-Function Block


    effect eVis = EffectVisualEffect(VFX_COM_HIT_DIVINE);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        //Adjust damage based on Alchemite and Saving Throw
        nDamage = GetReflexDamage(oTarget, nReduction, nDamage);

        effect eBad = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
        //Apply the VFX impact and damage effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBad, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, 1.5);
    }
}

