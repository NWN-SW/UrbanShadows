//::///////////////////////////////////////////////
//:: Arterial Spray by Alexander G.
//:://////////////////////////////////////////////

#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{
    //Declare major variables
    int nDamage;
    int nFinalDamage;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;
    //Custom spell size
    float fSize = GetSpellArea(6.0);
    effect eVis = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
    effect eImpact = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    effect eHarm;
    string sTargets;
    string sElement;
    int nTotalDamage;
    int nReduction;
    int nSpell = GetSpellId();

    /*
    //Do self damage
    int nMax = GetMaxHitPoints(OBJECT_SELF);
    int nHarm = nMax / 20;
    eHarm = EffectDamage(nHarm, DAMAGE_TYPE_POSITIVE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHarm, OBJECT_SELF);
    */

    //Apply Fire and Forget Visual in the area;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(OBJECT_SELF));

    //Apply the acid explosions
    float fDelay2;
    location lVFX;
    int nVFXCounter;
    effect eExplode = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED, FALSE, 1.5, [0.0,0.0,0.6]);
    while(nVFXCounter < 6)
    {
        fDelay2 = fDelay2 + 0.1;
        lVFX = GetNewRandomLocation(GetLocation(OBJECT_SELF), fSize);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
        lVFX = GetNewRandomLocation(GetLocation(OBJECT_SELF), fSize);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
        nVFXCounter = nVFXCounter + 1;
    }

    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (GetIsReactionTypeHostile(oTarget) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSixthLevelDamage(oTarget, nCasterLevel, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Slash";
                nReduction = GetFocusReduction(OBJECT_SELF, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            //End Custom Spell-Function Block

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            if(nDamage > 0)
            {
                  // Apply effects to the currently selected target.  For this spell we have used
                  //both Divine and Fire damage.
                  effect eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_SLASHING);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    DoMartialMechanic("Assault", sTargets, nTotalDamage, oMainTarget);

    //Sound Effects
    PlaySoundByStrRef(16778134, FALSE);
    DelayCommand(0.3, PlaySoundByStrRef(16778134, FALSE));
    DelayCommand(0.6, PlaySoundByStrRef(16778134, FALSE));
}


