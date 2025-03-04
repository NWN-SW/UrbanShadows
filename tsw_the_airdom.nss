/////////////////////////////////////////////////
//Theurgist Air Domain by Alexander G.
/////////////////////////////////////////////////

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
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    string sTargets;
    int nFinalDamage;
    int nTargetCheck;
    object oMainTarget;
    string sElement;
    object oCaster = OBJECT_SELF;
    int nReduction;
    int nMetaMagic = GetMetaMagicFeat();
    //Set the lightning stream to start at the caster's hands
    effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_HAND);
    effect eVis  = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION);
    effect eVis2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDamage;
    effect ePara = EffectParalyze();
    object oTarget = GetSpellTargetObject();
    location lTarget = GetLocation(oTarget);
    object oNextTarget, oTarget2;
    float fDelay;
    int nCnt = 1;
    float fDuration = GetExtendSpell(6.0);
    float fArea = GetSpellArea(60.0);

    oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTarget2) && GetDistanceToObject(oTarget2) <= 30.0)
    {
        //Get first target in the lightning area by passing in the location of first target and the casters vector (position)
        oTarget = GetFirstObjectInShape(SHAPE_SPELLCYLINDER, fArea, lTarget, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
        while (GetIsObjectValid(oTarget))
        {
           //Exclude the caster from the damage effects
           if (oTarget != OBJECT_SELF && oTarget2 == oTarget)
           {
                if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
                {
                   //Fire cast spell at event for the specified target
                   SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                   //Make an SR check
                   if (oTarget != OBJECT_SELF)
                   {
                        //Start Custom Spell-Function Block
                            //Get damage
                            sTargets = "AOE";
                            nDamage = GetSeventhLevelDamage(oTarget, nCasterLevel, sTargets);
                            nDamage = nDamage / 2;

                            //Buff damage by Amplification elvel
                            nDamage = GetAmp(nDamage);

                            //Get the Alchemite resistance reduction
                            sElement = "Elec";
                            nReduction = GetFocusReduction(oCaster, sElement);

                            //Buff damage bonus on Alchemite
                            nDamage = GetFocusDmg(oCaster, nDamage, sElement);
                        //End Custom Spell-Function Block

                        //Adjust damage based on Alchemite and Saving Throw
                        nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
                        float fFinalDuration = GetReflexDuration(oTarget, nReduction, fDuration);

                        //Set damage effect
                        eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_ELECTRICAL);
                        if(nDamage > 0)
                        {
                            fDelay = GetSpellEffectDelay(GetLocation(oTarget), oTarget);
                            //Apply VFX impcat, damage effect and lightning effect
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePara,oTarget, fFinalDuration));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis2,oTarget));
                        }
                    }
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.0);
                    //Set the currect target as the holder of the lightning effect
                    oNextTarget = oTarget;
                    eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oNextTarget, BODY_NODE_CHEST);
                }
           }
           //Get the next object in the lightning cylinder
           oTarget = GetNextObjectInShape(SHAPE_SPELLCYLINDER, fArea, lTarget, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
        }
        nCnt++;
        oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCnt);
    }

    //Class mechanics
    string sSpellType = "Force";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Control", sTargets, nFinalDamage, oMainTarget);
}

