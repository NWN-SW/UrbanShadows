//::///////////////////////////////////////////////
//:: Great Thunderclap by Alexander G.
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "spell_dmg_inc"
#include "x2_inc_spellhook"
#include "tsw_class_func"

void main()
{

    /*
      Spellcast Hook Code
      Added 2003-07-07 by Georg Zoeller
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // End of Spell Cast Hook

    int nDamage = 0;
    object oCaster = OBJECT_SELF;
    int nDC = GetSpellSaveDC();
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
    effect eVis  = EffectVisualEffect(VFX_IMP_SONIC);
    effect eVis2 = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
    effect eVis3 = EffectVisualEffect(VFX_IMP_STUN);
    effect eStun = EffectStunned();
    effect eDebuff = EffectAttackDecrease(2);
    effect eShake = EffectVisualEffect(356);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";

        //Get the Alchemite resistance reduction
        string sElement = "Soni";
        int nReduction = GetFocusReduction(oCaster, sElement);
    //End Custom Spell-Function Block

    //Get adjusted duration
    float fDuration = GetExtendSpell(6.0);
    float fDuration2 = GetExtendSpell(30.0);

    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, OBJECT_SELF, 2.0f);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            float fFinalDuration = GetReflexDuration(oTarget, nReduction, fDuration);
            float fFinalDuration2 = GetReflexDuration(oTarget, nReduction, fDuration2);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fFinalDuration));
            DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDebuff, oTarget, fFinalDuration2));
            DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fFinalDuration2));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis3, oTarget));
        }

       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    DoClassMechanic("Control", "AOE", 0, oMainTarget);
    DoClassMechanic("Debuff", "AOE", 0, oMainTarget);
}

