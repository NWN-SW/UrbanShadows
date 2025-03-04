//::///////////////////////////////////////////////
//:: Iron Riddle by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"

void RunImpact(object oTarget, object oCaster, int nDamage, int nSpell);

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
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    eDur = ExtraordinaryEffect(eDur);
    int nSpell = GetSpellId();
    int nFinalDamage;
    int nTotalDamage;

    // Calculate the duration
    float fDuration = GetExtendSpell(18.0);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetSeventhLevelDamage(oTarget, 0, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Slash";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

    //End Custom Spell-Function Block

    effect eVis = EffectVisualEffect(1078);
    effect eVis2 = EffectVisualEffect(961);

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

    //Sound Effects
    PlaySoundByStrRef(16778117, FALSE);
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
        effect eVis = EffectVisualEffect(VFX_IMP_STARBURST_RED);
        eDam = EffectLinkEffects(eVis, eDam);
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eDam, oTarget);
        DelayCommand(6.0f,RunImpact(oTarget, oCaster, nDamage, nSpell));
    }
}
