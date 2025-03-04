//Lux Aete Cast by Alexander Gates

#include "tsw_class_func"
#include "spell_dmg_inc"
#include "tsw_get_rndmloc"

void DoLuxExplosion(location lTarget, object oCaster, float fSize)
{
    //Apply the VFX explosions
    float fDelay;
    int nVFXCounter;
    effect eImpact = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    location lVFX;
    while(nVFXCounter < 5)
    {
        lVFX = GetNewRandomLocation(lTarget, fSize);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lVFX);
        lVFX = GetNewRandomLocation(lTarget, fSize);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lVFX);
        nVFXCounter = nVFXCounter + 1;
        fDelay = fDelay + 0.1;
    }

    //Declare more variables
    string sTargets;
    int nDamage;
    int nFinalDamage;
    object oMainTarget;
    int nTargetCheck;
    string sElement;
    float fBetterDamage=1.40f;
    effect eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeHostile(oTarget, oCaster))
        {
            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetNinthLevelDamage(oTarget, GetCasterLevel(OBJECT_SELF), sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Holy";
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackDecrease(5),oTarget,6.0f);
                    fBetterDamage = 1.55f;
                }
                nDamage = FloatToInt(fBetterDamage * GetFocusDmg(oCaster, nDamage, sElement));
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Set the damage effect
            effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_DIVINE);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    DoClassMechanic("Occult", sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Force", sTargets, nFinalDamage, oMainTarget);
}

void main()
{
    //Declare variables
    location lTarget = GetSpellTargetLocation();
    effect eVis1 = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
    effect eVis2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_20,FALSE,0.80f);
    effect eVis3 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30,FALSE,0.70f);
    effect eImpact = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    float fSize = GetSpellArea(5.0);

    if (GetLocalInt(OBJECT_SELF, "iExcoriated") != 1)
    {

        SetLocalInt(OBJECT_SELF, "iExcoriated",1);

    //Play visual effects in the area until the spell explodes
    int nLoop = 0;
    float fDelay = 0.0;
    while(nLoop < 12)
    {

        DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis1, lTarget));

        if(nLoop > 4 && nLoop <= 8)
        {
            DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis2, lTarget));
        }
        else if(nLoop > 8 && nLoop <= 12)
        {
            DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis3, lTarget));
        }
        nLoop = nLoop + 1;
        fDelay = IntToFloat(nLoop);
    }

    DelayCommand(fDelay, DoLuxExplosion(lTarget, OBJECT_SELF, fSize));
    DelayCommand(fDelay, SetLocalInt(OBJECT_SELF, "iExcoriated",0));
    }
    else if (GetLocalInt(OBJECT_SELF, "iExcoriated") == 1)
    {

        FloatingTextStringOnCreature("Your prayers go unanswered - No more than one Excoriatus can be used at the same time",OBJECT_SELF,FALSE);

    }

}
