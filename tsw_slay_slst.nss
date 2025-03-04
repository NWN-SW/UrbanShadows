//::///////////////////////////////////////////////
//:: Slaying Strike by Alexander G.
//:://////////////////////////////////////////////

#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nSpell = GetSpellId();
    int nFinalDamage;

    //Get Slayer Stacks
    int nStacks = GetLocalInt(OBJECT_SELF, "SLAYER_CLASS_STACKS");

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetSixthLevelDamage(oTarget, 0, sTargets);

        //Crit chance block
        int nRandom = d10(1);
        int nRange = 1 + nStacks;
        if(nRandom <= nRange)
        {
            nDamage = nDamage * 2;
        }

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Slash";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

    //End Custom Spell-Function Block

    effect eVis = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
    effect eVis2 = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        //Adjust damage based on Alchemite and Saving Throw
        nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

        effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_SLASHING);
        if(nFinalDamage > 0)
        {
            //Apply the VFX impact and effects
            DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF);
            DelayCommand(0.15, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
            DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
        }

        //Sound Effects
        DelayCommand(0.2, PlaySoundByStrRef(16778131, FALSE));
    }

    //Class mechanics
    DoMartialMechanic("Assault", sTargets, nFinalDamage, oTarget);

    //Reset Slayer stacks
    SetLocalInt(OBJECT_SELF, "SLAYER_CLASS_STACKS", 0);
}

