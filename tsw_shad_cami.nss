//::///////////////////////////////////////////////
//:: Camisado by Alexander G.
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
    float fSize = GetSpellArea(10.0);
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
    effect eImpact = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
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

    //Apply the acid explosions
    float fDelay2;
    float fFinalDuration;
    location lVFX;
    int nVFXCounter;
    effect eExplode = EffectVisualEffect(VFX_DUR_DARKNESS);
    while(nVFXCounter < 10)
    {
        lVFX = GetNewRandomLocation(GetLocation(OBJECT_SELF), fSize);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eExplode, lVFX, 3.0));
        fDelay2 = fDelay2 + 0.1;
        nVFXCounter = nVFXCounter + 1;
    }

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
                nDamage = GetNinthLevelDamage(oTarget, nCasterLevel, sTargets);
                nDamage = nDamage / 3;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Cold";
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
            nFinalDamage = GetWillDamage(oTarget, nReduction, nDamage);

            //Bonus damage if target has Blindness
            effect eEffect = GetFirstEffect(OBJECT_SELF);
            while(GetIsEffectValid(eEffect))
            {
                if(GetEffectType(eEffect) == EFFECT_TYPE_BLINDNESS)
                {
                    nFinalDamage = nFinalDamage + (nFinalDamage / 2);
                    break;
                }
                eEffect = GetNextEffect(OBJECT_SELF);
            }

            if(nDamage > 0)
            {
                  // Apply effects to the currently selected target.  For this spell we have used
                  //both Divine and Fire damage.
                  effect eFire = EffectDamage(nFinalDamage, DAMAGE_TYPE_COLD);
                  DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                  DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                  DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                  DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    DoMartialMechanic("Guile", sTargets, nTotalDamage, oMainTarget);
    DoMartialMechanic("Assault", sTargets, nTotalDamage, oMainTarget);
}


