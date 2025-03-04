//Apotheosis by Alexander G.

#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{
    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nDamage;
    int nFinalDamage;
    float fDelay;
    float fCharges;
    float fSize;
    effect ePillar = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    effect eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    effect eWord = EffectVisualEffect(859, FALSE, 0.5);
    effect eSound = EffectVisualEffect(860);
    effect eImplosion = EffectVisualEffect(1057);
    effect eDam;
    string sTargets;
    string sElement = "Holy";
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    object oMainTarget;
    int nTargetCheck = 0;
    effect eAC = EffectACDecrease(10);

    //Manage charges
    int nCharges = GetLocalInt(OBJECT_SELF, "THEURGIST_APOTH_CHARGES");

    if(nCharges > 0)
    {
        fCharges = IntToFloat(nCharges);
        fCharges = fCharges * 5.0;
        fSize = GetSpellArea(5.0) + fCharges;

        //Reset height
        DelayCommand(fDelay, ExecuteScript("tsw_reset_height", OBJECT_SELF));

        //Remove freeze effect
        effect eEffect = GetFirstEffect(OBJECT_SELF);
        while(GetIsEffectValid(eEffect))
        {
            if(GetEffectTag(eEffect) == "THEURGIST_CHARGING")
            {
                RemoveEffect(OBJECT_SELF, eEffect);
            }
            eEffect = GetNextEffect(OBJECT_SELF);
        }

        //Clear charges
        DeleteLocalInt(OBJECT_SELF, "THEURGIST_APOTH_CHARGES");
        DeleteLocalInt(OBJECT_SELF, "CHARGING_APOTH");

        //Special effect explosions
        float fDelay2;
        location lVFX;
        int nVFXCounter;
        effect eExplode = EffectVisualEffect(VFX_FNF_STRIKE_HOLY, FALSE, 1.5, [0.0,0.0,0.6]);
        while(nVFXCounter < (5 + nCharges))
        {
            fDelay2 = fDelay2 + 0.1;
            lVFX = GetNewRandomLocation(GetLocation(OBJECT_SELF), fSize);
            DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
            nVFXCounter = nVFXCounter + 1;
        }

        //Declare the spell shape, size and the location.  Capture the first target object in the shape.
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

        //Cycle through the targets within the spell shape until an invalid object is captured.
        while (GetIsObjectValid(oTarget))
        {
            if(GetIsReactionTypeHostile(oTarget))
            {
                //Start Custom Spell-Function Block
                    //Get damage
                    sTargets = "AOE";
                    nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, sTargets);
                    nDamage = nDamage + (50 * nCharges);

                    //Buff damage by Amplification elvel
                    nDamage = GetAmp(nDamage);

                    //Get the Alchemite resistance reduction
                    sElement = "Holy";
                    int nReduction = GetFocusReduction(oCaster, sElement);

                    //Buff damage bonus on Alchemite
                    nDamage = GetFocusDmg(oCaster, nDamage, sElement);
                //End Custom Spell-Function Block

                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

                //Adjust damage based on Alchemite and Saving Throw
                nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

                //Store main target and set check
                if(nTargetCheck == 0)
                {
                    oMainTarget = oTarget;
                    nTargetCheck = 1;
                }

                //Set the damage effect
                eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_DIVINE);
                if(nDamage > 0)
                {
                    // Apply effects to the currently selected target.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eWord, oTarget));
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
           //Select the next target within the spell shape.
           oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        }

        //Class mechanics
        string sSpellType = "Occult";
        DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);

    }
    else
    {
        AssignCommand(OBJECT_SELF, ClearAllActions());
        AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 120.0));
        effect eFreeze = EffectMovementSpeedDecrease(99);
        effect eHold = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
        effect eAura = EffectVisualEffect(1069);
        effect eScript = EffectRunScript("", "", "tsw_theu_apota", 2.0);
        effect eLink = EffectLinkEffects(eFreeze, eAura);
        eLink = EffectLinkEffects(eLink, eScript);
        eLink = EffectLinkEffects(eLink, eAC);
        eLink = EffectLinkEffects(eLink, eHold);

        //Add local variable
        SetLocalInt(OBJECT_SELF, "CHARGING_APOTH", 1);

        //Slowly lift target into air
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 3.0, OBJECT_VISUAL_TRANSFORM_LERP_LINEAR, 12.0);

        eFreeze = TagEffect(eLink, "THEURGIST_CHARGING");
        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, OBJECT_SELF, 120.0));
    }

}
