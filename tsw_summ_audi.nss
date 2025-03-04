//Aura Disruption by Alexander G.

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
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nDamage;
    int nFinalDamage;
    float fDelay;
    float fSize = GetSpellArea(20.0);
    effect eImpact = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_MIND);
    effect eMissile = EffectVisualEffect(1113);
    effect eDam;
    string sTargets;
    string sElement = "Magi";
    object oMainTarget;
    int nTargetCheck = 0;

    //Get the location of our summon
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    location lTarget = GetLocation(oSummon);

    //Beam effect
    effect eBeam = EffectBeam(VFX_BEAM_ODD, oSummon, BODY_NODE_CHEST, FALSE, 4.0);

    if(oSummon == OBJECT_INVALID)
    {
        SendMessageToPC(OBJECT_SELF, "You must have an active summon to use this ability.");
        return;
    }

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget) && nTargetCheck != 1)
    {
        if(GetIsReactionTypeHostile(oTarget) && nTargetCheck != 1)
        {
            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "Single";
                nDamage = GetFifthLevelDamage(oTarget, nCasterLvl, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            float fDist = GetDistanceBetween(oSummon, oTarget);
            float fDelay = fDist/(3.0 * log(fDist) + 2.0);
            float fDelay2, fTime;

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetWillDamage(oTarget, nReduction, nDamage);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_MAGICAL);
            if(nDamage > 0)
            {
                //Set local variables on summon to use their own VFX
                SetLocalInt(oSummon, "MY_TEMPORARY_EFFECT", 1113);
                SetLocalObject(oSummon, "MY_TEMPORARY_TARGET", oTarget);
                // Apply effects to the currently selected target.
                ExecuteScript("tsw_3rdparty_vis", oSummon);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(oTarget)));
            }
        }
       //Select the next target within the spell shape.
       if(nTargetCheck == 0)
       {
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
       }
    }

    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Force", sTargets, nFinalDamage, oMainTarget);
}

