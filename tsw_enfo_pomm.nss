//::///////////////////////////////////////////////
//:: Pommel Strike by Alexander G.
//:://////////////////////////////////////////////

#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nSpell = GetSpellId();
    int nFinalDamage;

    // Calculate the duration
    float fDuration = GetExtendSpell(12.0);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetSixthLevelDamage(oTarget, 0, sTargets);
        nDamage = nDamage / 2;

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Bludge";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

    //End Custom Spell-Function Block

    effect eVis = EffectVisualEffect(VFX_IMP_STUN);
    effect eVis2 = EffectVisualEffect(239);
    effect eStun = EffectStunned();

    if(!GetIsReactionTypeFriendly(oTarget) && !GetHasSpellEffect(nSpell,oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        //Adjust damage based on Alchemite and Saving Throw
        nFinalDamage = GetFortDamage(oTarget, nReduction, nDamage);
        fDuration = GetFortDuration(oTarget, nReduction, fDuration);

        effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_BLUDGEONING);
        if(nDamage > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fDuration);
        }
    }
    else if(!GetIsReactionTypeFriendly(oTarget) && GetHasSpellEffect(nSpell, oTarget))
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
    }
    //Class mechanics
    string sSpellType = "Control";
    DoMartialMechanic(sSpellType, sTargets, nFinalDamage, oTarget);
}

