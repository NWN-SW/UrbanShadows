//Turn Undead AOE damage pulse edit from Alexander G.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

void main()
{
    int nClericLevel = GetLevelByClass(CLASS_TYPE_CLERIC);
    int nPaladinLevel = GetLevelByClass(CLASS_TYPE_PALADIN);
    int nBlackguardlevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD);
    int nTotalLevel =  nClericLevel + nPaladinLevel + nBlackguardlevel;

    //Make a turning check roll, modify if have the Sun Domain
    int nChrMod = GetAbilityModifier(ABILITY_CHARISMA);

    //Determine Element
    string sElement = "Holy";
    if(nBlackguardlevel > nClericLevel || nBlackguardlevel > nPaladinLevel)
    {
        sElement = "Nega";
    }

    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    float nSize =  15.0;
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eDam;
    //effect eShake = EffectVisualEffect(356);
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, OBJECT_SELF, 2.0f);

    if(sElement == "Nega")
    {
        eExplode = EffectVisualEffect(VFX_FNF_PWKILL);
        eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    }

    //Apply epicenter explosion on caster
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(OBJECT_SELF));


    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            // Earthquake does not allow spell resistance
//            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {

                //Roll damage for each target
                nDamage = GetFourthLevelDamage(oTarget, nTotalLevel, nMetaMagic, "AoE");

                //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                int nDC = GetSpellSaveDC();
                int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
                nDC = nDC + nBonusDC;
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
                nDamage = GetReflexDamage(oTarget, nDC, nDamage);

                //Set the damage effect
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
                // * caster can't be affected by the spell
                if( (nDamage > 0) && (oTarget != oCaster))
                {

                    // Apply effects to the currently selected target.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}
