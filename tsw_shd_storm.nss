//Custom Shades AOE spell by Alexander G.

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
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nToAffect = nCasterLevel;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nLessDam;
    object oTarget;
    float fTargetDistance;
    float fDelay;
    location lTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
    effect eWail = EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);
    //Added Knockdown
    effect eTrip = EffectKnockdown();
    int nCnt = 1;

    //Apply the FNF VFX impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eWail, GetSpellTargetLocation());
    //Get the closet target from the spell target location
    oTarget = GetSpellTargetObject(); // direct target
    if (!GetIsObjectValid(oTarget))
    {
        oTarget = GetNearestObjectToLocation(OBJECT_TYPE_CREATURE, GetSpellTargetLocation(), nCnt);
    }
    //Get Damage
    nDamage = GetSixthLevelDamage(oTarget, nCasterLevel, nMetaMagic, "AOE");

    //Adjust the damage and DC
    string sElement = "Magi";
    int nDC = GetSpellSaveDC();
    int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
    nDC = nDC + nBonusDC;
    nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    nDamage = GetWillDamage(oTarget, nDC, nDamage);
    nDamage = nDamage + 12;

    while (nCnt <= nToAffect)
    {
        lTarget = GetLocation(oTarget);
        //Get the distance of the target from the center of the effect
        fDelay = GetRandomDelay(2.0, 3.0);//
        fTargetDistance = GetDistanceBetweenLocations(GetSpellTargetLocation(), lTarget);
        //Check that the current target is valid and closer than 10.0m
        if(GetIsObjectValid(oTarget) && fTargetDistance <= 10.0)
        {
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHADES_FIREBALL));
                //Make SR check
                if(!MyResistSpell(OBJECT_SELF, oTarget)) //, 0.1))
                {
                    //Make a fortitude save to avoid death
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS)) //, OBJECT_SELF, 3.0))
                    {
                        //Apply the delay VFX impact and death effect
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        //effect eDeath = EffectDeath();
                        //New Damage Calculation
                        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget)); // no delay
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTrip, oTarget, 6.0));
                    }
                    else
                    {
                        //Apply the delay VFX impact and death effect
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget)); // no delay
                    }
                }
            }
        }
        else
        {
            //Kick out of the loop
            nCnt = nToAffect;
        }
        //Increment the count of creatures targeted
        nCnt++;
        //Get the next closest target in the spell target location.
        oTarget = GetNearestObjectToLocation(OBJECT_TYPE_CREATURE, GetSpellTargetLocation(), nCnt);
    }
}
