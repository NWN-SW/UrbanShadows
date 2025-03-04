//::///////////////////////////////////////////////
//:: Tempest by Alexander G.
//::///////////////////////////////////////////////

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
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nFinalDamage;
    float fDelay;
    float fSize = GetSpellArea(15.0);
    effect eExplode = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION);
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eDam;
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect ePara = EffectStunned();
    effect eStun = EffectVisualEffect(VFX_IMP_STUN);
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, OBJECT_SELF);

    //Apply epicenter explosion on caster
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(OBJECT_SELF));


    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    if(!spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
    {
        while(!spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
        {
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        }
    }

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Elec";
        int nReduction = GetFocusReduction(oCaster, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(oCaster, nDamage, sElement);

        //Track the first valid target for class mechanics
        object oMainTarget;
        int nTargetCheck = 0;
    //End Custom Spell-Function Block

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EARTHQUAKE));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = 3.0;

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            float fDuration = GetWillDuration(oTarget, nReduction, 8.0);

            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_ELECTRICAL);
            // * caster can't be affected by the spell
            if( (nDamage > 0) && (oTarget != oCaster))
            {
                //Paralysis effect
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oTarget, fDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fDuration);

                //Slowly lift target into air
                SetObjectVisualTransform(oTarget, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 2.0, OBJECT_VISUAL_TRANSFORM_LERP_LINEAR, 3.0);

                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplode, oTarget));

                //Undolift
                DelayCommand(fDelay, ExecuteScript("tsw_reset_height", oTarget));
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    string sSpellType = "Electric";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
}





