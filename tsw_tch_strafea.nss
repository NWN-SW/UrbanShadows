//::///////////////////////////////////////////////
//:: Autocannon Strafe onEnter by Alexander G.
//::///////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{

    //Declare major variables
    int nDamage;
    int nTargets;
    int nTotal;

    object oMainTarget;
    int nTargetCheck = 0;
    int nCasterLvl = GetCasterLevel(GetAreaOfEffectCreator());
    effect eDam;
    object oTarget;
    int nFinalDamage;
    object oCaster = GetAreaOfEffectCreator(OBJECT_SELF);

    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);
   //effect eSpeed = EffectMovementSpeedDecrease(50);
    effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = eVis2; //EffectLinkEffects(eSpeed, eVis2);
    float fDelay;
    //Capture the first target object in the shape.
    oTarget = GetEnteringObject();

    //Declare the spell shape, size and the location.
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        fDelay = GetRandomDelay(0.5, 2.0);
        //Start Custom Spell-Function Block
            //Get damage
            string sTargets = "AOE";
            nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, sTargets);

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            string sElement = "Fire";
            int nReduction = GetFocusReduction(oCaster, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            nDamage = nDamage * 2;
        //End Custom Spell-Function Block

        //Store main target and set check
        if(nTargetCheck == 0)
        {
            oMainTarget = oTarget;
            nTargetCheck = 1;
        }

        //Adjust damage based on Alchemite and Saving Throw
        nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
        // Apply effects to the currently selected target.
        eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);
        if(nDamage > 0)
        {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
    }

    //Get cooldown
    int nCheck = GetLocalInt(oCaster, "STRAFE_COOLDOWN");
    if(nCheck == 1)
    {
        //SendMessageToPC(oCaster, "Doing the thing.");
        DoMartialMechanic("Tactic", "AOE", nFinalDamage, OBJECT_SELF, oCaster);
        DoMartialMechanic("Assault", "AOE", nFinalDamage, OBJECT_SELF, oCaster);
        DeleteLocalInt(oCaster, "STRAFE_COOLDOWN");
    }
}
