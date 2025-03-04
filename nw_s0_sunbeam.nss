//::///////////////////////////////////////////////
//:: Sunbeam by Alexander G.
//:://////////////////////////////////////////////


#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

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
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_COM_HIT_DIVINE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eStrike = EffectVisualEffect(VFX_FNF_SUNBEAM);
    effect eDam;

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    int nOrgDam;
    int nMax;
    float fDelay;
    object oMainTarget;
    int nTargetCheck = 0;
    string sTargets;
    int nReduction;
    string sElement;
    int nFinalDamage;
    float fArea = GetSpellArea(RADIUS_SIZE_COLOSSAL);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
    //Get the first target in the spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fArea, GetSpellTargetLocation());
    while(GetIsObjectValid(oTarget))
    {
        // Make a faction check
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            fDelay = GetRandomDelay(1.0, 2.0);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBEAM));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetEighthLevelDamage(oTarget, nCasterLevel, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Holy";
                int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            //End Custom Spell-Function Block

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Set damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_DIVINE);
            if(nDamage > 0)
            {
                //Apply the damage effect and VFX impact
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            }
        }
        //Get the next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fArea, GetSpellTargetLocation());
    }
    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
}
