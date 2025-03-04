//::///////////////////////////////////////////////
//:: Triple Slash by Alexander G.
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
    float fSize = GetSpellArea(5.0);
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);
    effect eImpact = EffectVisualEffect(460);
    effect eDur = EffectDamageDecrease(4);
    eDur = ExtraordinaryEffect(eDur);
    string sTargets;
    string sElement;
    int nTotalDamage;
    int nReduction;
    int nSpell = GetSpellId();
    //Apply Fire and Forget Visual in the area;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(OBJECT_SELF));

    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    //Get Slayer Stacks
    int nStacks = GetLocalInt(OBJECT_SELF, "SLAYER_CLASS_STACKS");

    // Calculate the duration
    float fBase = 18 + (IntToFloat(nStacks) * 6.0);
    float fDuration = GetExtendSpell(fBase);


    //VFX Explosions
    float fDelay2;
    float fFinalDuration;
    location lVFX;
    int nVFXCounter;
    /**
    effect eExplode = EffectVisualEffect(961, FALSE, 1.5, [0.0,0.0,0.6]);
    while(nVFXCounter < 5)
    {
        lVFX = GetNewRandomLocation(GetLocation(OBJECT_SELF), fSize);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX);
        nVFXCounter = nVFXCounter + 1;
    }
    */

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
                nDamage = GetFirstLevelDamage(oTarget, nCasterLevel, sTargets);
                if(nStacks > 0)
                {
                    nDamage = nDamage * (nStacks + 1);
                }

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
            nFinalDamage = 3 + (nFinalDamage / 3);

            //Adjust duration
            fFinalDuration = GetReflexDuration(oTarget, nReduction, fDuration);

            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.  For this spell we have used
                //both Divine and Fire damage.
                effect eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_SLASHING);

                //Hit One
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

                //Hit Two
                DelayCommand(0.15, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
                DelayCommand(0.15, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));

                //Hit Three
                DelayCommand(0.30, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
                DelayCommand(0.30, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));

                if(nStacks >= 1)
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fFinalDuration);
                }
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    DoMartialMechanic("Assault", sTargets, nTotalDamage, oMainTarget);
    DoMartialMechanic("Debuff", sTargets, nTotalDamage, oMainTarget);

    //Reset Slayer stacks
    SetLocalInt(OBJECT_SELF, "SLAYER_CLASS_STACKS", 0);

    //Sound Effects
    PlaySoundByStrRef(16778118, FALSE);
    DelayCommand(0.15, PlaySoundByStrRef(16778118, FALSE));
    DelayCommand(0.30, PlaySoundByStrRef(16778118, FALSE));
}


