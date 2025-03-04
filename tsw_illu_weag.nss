//Reworked Fireball by Alexander G.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void RunImpact(object oTarget, object oCaster, int nDamage, int nSpell);

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
    float fDuration = GetExtendSpell(18.0);
    float fSize = GetSpellArea(10.0);
    effect eExplode = EffectVisualEffect(1070);
    effect eVis = EffectVisualEffect(1079);
    effect eBeam = EffectBeam(VFX_BEAM_SILENT_ODD, oCaster, BODY_NODE_CHEST);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eSilence = EffectSilence();
    effect eBoom = EffectVisualEffect(1098);
    eDur = ExtraordinaryEffect(eDur);
    effect eDam;
    string sTargets;
    string sElement = "Magi";
    int nSpell = GetSpellId();
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    object oMainTarget;
    int nTargetCheck = 0;
    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    effect eBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBump, lTarget);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lTarget);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF && !GetHasSpellEffect(nSpell,oTarget))
        {
            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, sTargets);
                nDamage = nDamage / 2;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Magi";
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = 2.0 + GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetWillDamage(oTarget, nReduction, nDamage);
            int nDOTDamage = nFinalDamage / 2;

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Set the damage effect
            eDam = EffectDamage(nDOTDamage, DAMAGE_TYPE_MAGICAL);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, 1.5));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSilence, oTarget, fDuration));
                DelayCommand(6.0f, RunImpact(oTarget, OBJECT_SELF, nDOTDamage, nSpell));
            }
        }
        else if(oTarget != OBJECT_SELF && GetHasSpellEffect(nSpell, oTarget))
        {
            FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Control", sTargets, nFinalDamage, oMainTarget);
}

//DoT Function
void RunImpact(object oTarget, object oCaster, int nDamage, int nSpell)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if(GZGetDelayedSpellEffectsExpired(nSpell, oTarget, oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
        //----------------------------------------------------------------------
        // Calculate Damage
        //----------------------------------------------------------------------
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
        effect eVis = EffectVisualEffect(292);
        eDam = EffectLinkEffects(eVis, eDam);
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eDam, oTarget);
        DelayCommand(6.0f,RunImpact(oTarget, oCaster, nDamage, nSpell));
    }
}

