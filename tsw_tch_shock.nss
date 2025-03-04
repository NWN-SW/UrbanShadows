//::///////////////////////////////////////////////
//Technician Electroboom by Alexander G.
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 21, 2001

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
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
    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nFinalDamage;
    int nFinalDamage2;
    float fSize = GetSpellArea(10.0);
    effect eDam;
    string sTargets;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    object oMainTarget;
    int nTargetCheck = 0;
    int nDamage;
    int nDamage2;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eBoom = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION, FALSE, 0.5);
    float fDelay;
    string sElement;
    //Apply Fire and Forget Visual in the area;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, GetLocation(OBJECT_SELF));
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                //Start Custom Spell-Function Block
                    //Get damage
                    sTargets = "AOE";
                    nDamage = GetFifthLevelDamage(oTarget, nCasterLevel, sTargets);

                    //Buff damage by Amplification elvel
                    nDamage = GetAmp(nDamage);

                    //Get the Alchemite resistance reduction
                    sElement = "Elec";
                    int nReduction = GetFocusReduction(oCaster, sElement);

                    //Buff damage bonus on Alchemite
                    nDamage = GetFocusDmg(oCaster, nDamage, sElement);
                    nDamage = nDamage / 2;
                //End Custom Spell-Function Block

                //Adjust damage based on Alchemite and Saving Throw
                nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
                nFinalDamage2 = nFinalDamage;

                //Store main target and set check
                if(nTargetCheck == 0)
                {
                    oMainTarget = oTarget;
                    nTargetCheck = 1;
                }

                if(nFinalDamage > 0)
                {
                    // Apply effects to the currently selected target.  For this spell we have used
                    //both Electric and Sonic
                    effect eStun = EffectStunned();
                    float fDuration = GetWillDuration(oTarget, nReduction, 8.0);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fDuration);
                    effect eElec = EffectDamage(nFinalDamage, DAMAGE_TYPE_ELECTRICAL);
                    effect eSoni = EffectDamage(nFinalDamage2, DAMAGE_TYPE_SONIC);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eElec, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSoni, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }

    DoMartialMechanic("Tactic", "AOE", nFinalDamage, oMainTarget);
}
