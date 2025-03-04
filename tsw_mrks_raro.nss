//::///////////////////////////////////////////////
//:: Ravager Round by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"

void RunImpact(object oTarget, object oCaster, int nDamage, int nSpell);

void main()
{

    //Leave if not ranged weapon
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    int nType = GetBaseItemType(oWep);
    if(!GetWeaponRanged(oWep))
    {
        SendMessageToPC(OBJECT_SELF, "Requires a ranged weapon.");
        return;
    }


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    eDur = ExtraordinaryEffect(eDur);
    int nSpell = GetSpellId();
    int nFinalDamage;
    int nTotalDamage;

    // Calculate the duration
    float fDuration = GetExtendSpell(18.0);

    //Get Marksman crit
    int nCrit = GetLocalInt(OBJECT_SELF, "MARKSMAN_CRIT");

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
        if(nCrit == 1)
        {
            nDamage = nDamage + (nDamage / 2);
            DeleteLocalInt(OBJECT_SELF, "MARKSMAN_CRIT");
        }

    //End Custom Spell-Function Block

    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);
    effect eVis2 = EffectVisualEffect(VFX_COM_CHUNK_RED_BALLISTA);

    if(!GetIsReactionTypeFriendly(oTarget) && !GetHasSpellEffect(nSpell,oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        //Adjust damage based on Alchemite and Saving Throw
        nFinalDamage = GetFortDamage(oTarget, nReduction, nDamage);
        int nDOTDamage = nFinalDamage / 2;

        effect eDam = EffectDamage(nDOTDamage, DAMAGE_TYPE_SLASHING);
        if(nDamage > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            DelayCommand(6.0f, RunImpact(oTarget, OBJECT_SELF, nDOTDamage, nSpell));
        }
    }
    else if(!GetIsReactionTypeFriendly(oTarget) && GetHasSpellEffect(nSpell, oTarget))
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
    }
    //Class mechanics
    string sSpellType = "Assault";
    DoMartialMechanic(sSpellType, sTargets, nFinalDamage, oTarget);

    //Play weapon shot sounds
    int nSound = GetWeaponSound(OBJECT_SELF);
    PlaySoundByStrRef(nSound, FALSE);
}

//DoT Function
void RunImpact(object oTarget, object oCaster, int nDamage, int nSpell)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if(GZGetDelayedSpellEffectsExpired(nSpell, oTarget, oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
        //----------------------------------------------------------------------
        // Calculate Damage
        //----------------------------------------------------------------------
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING);
        effect eVis = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
        effect eVis2 = EffectVisualEffect(961);
        eDam = EffectLinkEffects(eVis, eDam);
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eVis2, oTarget);
        AssignCommand(oTarget, DelayCommand(0.1, PlaySoundByStrRef(16778129, FALSE)));
        DelayCommand(6.0f,RunImpact(oTarget, oCaster, nDamage, nSpell));
    }
}
