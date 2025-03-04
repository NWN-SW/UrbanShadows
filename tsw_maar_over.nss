//::///////////////////////////////////////////////
//:: Overpower by Alexander G.
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
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
    location lTarget = GetLocation(oTarget);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nNewDamage;
    float fDuration = GetExtendSpell(6.0);

    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eExplosion = EffectVisualEffect(965);
    effect eStun = EffectStunned();
    effect eDur = EffectVisualEffect(VFX_IMP_STUN);


    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetFourthLevelDamage(oTarget, nCasterLvl, sTargets);
        nNewDamage = nDamage / 3;
        if(GetHasFeat(MAAR_PATH_OF_BALANCE))
        {
            nNewDamage = nDamage / 6;
        }

        //Buff damage by Amplification elvel
        nNewDamage = GetAmp(nNewDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Bludge";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nNewDamage = GetFocusDmg(OBJECT_SELF, nNewDamage, sElement);

        //Adjust damage based on Alchemite and Saving Throw
        int nFinalDamage = GetReflexDamage(oTarget, nReduction, nNewDamage);
        fDuration = GetReflexDuration(oTarget, nReduction, fDuration);

        //Track the first valid target for class mechanics
        object oMainTarget;
        int nTargetCheck = 0;
    //End Custom Spell-Function Block

    //Double effect for Talonstrike
    int nCheck = GetLocalInt(OBJECT_SELF, "TALONSTRIKE_ACTIVE");
    if(nCheck > 0)
    {
        nFinalDamage = nFinalDamage * 2;
        fDuration = fDuration * 2.0;
    }

    //Debug Line
    //string sDC = IntToString(nDC);
    //string sDmg = IntToString(nDamage);
    //SendMessageToPC(oCaster, "Your final DC is: " + sDC + " and your final damage is: " + sDmg);

    //Class mechanics
    string sSpellType = "Assault";
    DoMartialMechanic(sSpellType, sTargets, nFinalDamage, oTarget);
    DoClassMechanic("Control", sTargets, nFinalDamage, oTarget);

    //Damage Effect
    effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_BLUDGEONING);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosion, oTarget);

    //Second hit
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosion, oTarget));

    //Third hit
    DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosion, oTarget));
    if(GetHasFeat(MAAR_PATH_OF_BALANCE))
    {
        DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fDuration));
        DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration));
    }

    DeleteLocalInt(OBJECT_SELF, "TALONSTRIKE_ACTIVE");
}
