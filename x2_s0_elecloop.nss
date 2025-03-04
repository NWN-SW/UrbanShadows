//::///////////////////////////////////////////////
//:: Electric Loop by Alexander G.
//:://////////////////////////////////////////////


#include "x2_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"


void main()
{

    //--------------------------------------------------------------------------
    // Spellcast Hook Code
    // Added 2003-06-20 by Georg
    // If you want to make changes to all spells, check x2_inc_spellhook.nss to
    // find out more
    //--------------------------------------------------------------------------
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook


    location lTarget    = GetSpellTargetLocation();
    effect   eStrike    = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    int      nMetaMagic = GetMetaMagicFeat();
    float    fDelay;
    effect   eBeam;
    int      nDamage;
    string   sTargets;
    string   sElement;
    int      nReduction;
    int      nPotential;
    effect   eDam;
    object   oLastValid;
    object   oCaster = OBJECT_SELF;
    float    fSize = GetSpellArea(3.0);
    effect   eStun = EffectLinkEffects(EffectVisualEffect(VFX_IMP_STUN),EffectStunned());

    //--------------------------------------------------------------------------
    // Get Caster Level
    //--------------------------------------------------------------------------
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);

    //--------------------------------------------------------------------------
    // Loop through all targets
    //--------------------------------------------------------------------------

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSecondLevelDamage(oTarget, nCasterLvl, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Elec";
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //------------------------------------------------------------------
            // Calculate delay until spell hits current target. If we are the
            // first target, the delay is the time until the spell hits us
            //------------------------------------------------------------------
            if (GetIsObjectValid(oLastValid))
            {
                   fDelay += 0.2f;
                   fDelay += GetDistanceBetweenLocations(GetLocation(oLastValid), GetLocation(oTarget))/20;
            }
            else
            {
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            }

            //------------------------------------------------------------------
            // If there was a previous target, draw a lightning beam between us
            // and iterate delay so it appears that the beam is jumping from
            // target to target
            //------------------------------------------------------------------
            if (GetIsObjectValid(oLastValid))
            {
                 eBeam = EffectBeam(VFX_BEAM_LIGHTNING, oLastValid, BODY_NODE_CHEST);
                 DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam,oTarget,1.5f));
            }

            //Adjust damage based on Alchemite and Saving Throw
            int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Stun Target for duration
            float fDuration = GetWillDuration(oTarget, nReduction, 6.0);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fDuration));

            if (nDamage >0)
            {
                eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_ELECTRICAL);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oTarget));
            }

            //------------------------------------------------------------------
            // Store Target to make it appear that the lightning bolt is jumping
            // from target to target
            //------------------------------------------------------------------
            oLastValid = oTarget;

        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE );
    }

    //Class mechanics
    string sSpellType = "Electric";
    DoClassMechanic(sSpellType, sTargets, nDamage, oTarget);

}


