//::///////////////////////////////////////////////
//:: Fulminare by Alexander G.
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
    int nCasterLvl = 5;
    float fSize = GetSpellArea(6.0);
    float fDuration = GetExtendSpell(6.0);

    effect eVis = EffectVisualEffect(VFX_COM_HIT_DIVINE);
    effect eExplosion = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
    effect eBlind = EffectBlindness();
    effect eDur = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetFirstLevelDamage(oTarget, nCasterLvl, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Holy";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

        //Adjust damage based on Alchemite and Saving Throw
        int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
        nFinalDamage = nFinalDamage / 4;

        //Track the first valid target for class mechanics
        object oMainTarget;
        int nTargetCheck = 0;
    //End Custom Spell-Function Block

    //Debug Line
    //string sDC = IntToString(nDC);
    //string sDmg = IntToString(nDamage);
    //SendMessageToPC(oCaster, "Your final DC is: " + sDC + " and your final damage is: " + sDmg);

    //Class mechanics
    string sSpellType = "Assault";
    DoMartialMechanic(sSpellType, sTargets, nDamage, oTarget);
    DoClassMechanic("Control", sTargets, nDamage, oTarget);

    //Damage Effect
    effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_DIVINE);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);

    //Second hit
    DelayCommand(0.33, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    DelayCommand(0.33, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));


    //Pulse Visual
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosion, oTarget));


    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeHostile(oTarget, OBJECT_SELF))
        {
            // Apply effects to the currently selected target.
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, fDuration));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration));

            //Third hit
            DelayCommand(0.66, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(0.66, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}
