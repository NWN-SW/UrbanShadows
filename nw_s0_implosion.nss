//::///////////////////////////////////////////////
//:: Implosion
//:: NW_S0_Implosion.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All persons within a 5ft radius of the spell must
    save at +3 DC or die.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 13, 2001
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
    object oTarget;
    effect eDeath = EffectDeath(TRUE);
    eDeath = SupernaturalEffect(eDeath);
    effect eImplode = EffectVisualEffect(VFX_FNF_IMPLOSION);
    float fDelay;

    //New Variables
    int nLevel = GetLevelByClass(2, OBJECT_SELF);
    int nDamage;
    int nCount = 0;
    int nMetaMagic = GetMetaMagicFeat();
    location lTarget = GetSpellTargetLocation();
    float fTargetDistance;
    effect eVis = EffectVisualEffect(89);

    //Apply the implose effect
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImplode, GetSpellTargetLocation());
    //Get the first target in the shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_IMPLOSION));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Roll damage for each target
            nDamage = GetNinthLevelDamage(oTarget, nLevel, nMetaMagic, "AoE");

            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            string sElement = "Nega";
            int nDC = GetSpellSaveDC();
            //Get bonus DC based on any spell foci
            int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
            nDC = nDC + nBonusDC;
            //Buff damage if spell foci present
            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            nDamage = GetFortDamage(oTarget, nDC, nDamage);

            //New Effects
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
            eDam = SupernaturalEffect(eDam);

            eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}

/* OLD IMPLOSION CODE
    lTarget = GetLocation(oTarget);
    fTargetDistance = GetDistanceBetweenLocations(GetSpellTargetLocation(), lTarget);
    while (GetIsObjectValid(oTarget) && nCount < 20)
    {
        if (oTarget != OBJECT_SELF && spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && fTargetDistance <= 3.33)
        {
           //Fire cast spell at event for the specified target
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_IMPLOSION));
           fDelay = GetRandomDelay(0.4, 1.2);
           //Make SR check
           if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
           {
                //Make Fort save
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay))
                {
                    //Apply death effect and the VFX impact
                    //DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                }
                else
                {
                    nDamage = nDamage / 2;
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                    eDam = SupernaturalEffect(eDam);
                }   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
           }
       }
       //Get next target in the shape
       //oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation(), FALSE, 1);
       nCount++;
       oTarget = GetNearestObjectToLocation(OBJECT_TYPE_CREATURE, GetSpellTargetLocation(), nCount);
    } */
