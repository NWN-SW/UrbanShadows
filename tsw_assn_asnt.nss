//::///////////////////////////////////////////////
//:: Assassination by Alexander G.
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

    // Calculate the duration
    float fDuration = GetExtendSpell(6.0);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetNinthLevelDamage(oTarget, 0, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Pierce";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

    //End Custom Spell-Function Block

    effect eVis = EffectVisualEffect(VFX_COM_CHUNK_RED_BALLISTA);
    effect eVis2 = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL);
    effect eStun = EffectStunned();

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        //Adjust damage based on Alchemite and Saving Throw
        nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
        fDuration = GetReflexDuration(oTarget, nReduction, fDuration);

        effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_PIERCING);
        if(nFinalDamage > 0)
        {
            //Apply the VFX impact and effects
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF);
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fDuration));
        }

        //Teleport to Enemy
        location lJump = GetNewRandomLocation(GetLocation(oTarget), 1.0);
        DelayCommand(0.75, JumpToLocation(lJump));

        //Sound Effects
        DelayCommand(0.75, PlaySoundByStrRef(16778116, FALSE));

        //Attack Nearest Enemy
        DelayCommand(0.8, AttackNearest(3.0, OBJECT_SELF));
    }

    //Class mechanics
    DoMartialMechanic("Assault", sTargets, nFinalDamage, oTarget);
    DoMartialMechanic("Guile", sTargets, nFinalDamage, oTarget);
}

