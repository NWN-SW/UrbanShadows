//::///////////////////////////////////////////////
//:: Captis by Alexander G.
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

    effect eVis = EffectVisualEffect(VFX_COM_HIT_FIRE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eBeam = EffectBeam(VFX_BEAM_CHAIN, OBJECT_SELF, BODY_NODE_CHEST, FALSE, 2.0);
    effect eKD3 = EffectKnockdown();
        if (! GetIsPC(oCaster))
    {
        fSize = 1.5*fSize;
    }

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
    effect eExplode = EffectVisualEffect(280, FALSE, 1.5, [0.0,0.0,0.6]);
    while(nVFXCounter < 4)
    {
        lVFX = GetNewRandomLocation(GetLocation(OBJECT_SELF), fSize);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX);
        lVFX = GetNewRandomLocation(GetLocation(OBJECT_SELF), fSize);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX);
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
                nDamage = GetSeventhLevelDamage(oTarget, 0, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Fire";
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
                effect eFire = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);
                DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, 1.5);

                //Assign target to jump to
                SetLocalObject(oTarget, "CHAMP_JUMP_TARGET", OBJECT_SELF);

                //Do jump script
                DelayCommand(0.65, ExecuteScript("tsw_cham_jump", oTarget));

                if(GetDistanceBetween(oCaster, oTarget) >= 5.0f)
                {
                    DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKD3, oTarget,0.99f));
                }

            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    DoMartialMechanic("Assault", sTargets, nTotalDamage, oMainTarget);
    DoClassMechanic("Control", sTargets, nTotalDamage, oMainTarget);
}


