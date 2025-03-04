//::///////////////////////////////////////////////
//:: Undeath to Death
//:: X2_S0_Undeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

  This spell slays 1d4 HD worth of undead creatures
  per caster level (maximum 20d4). Creatures with
  the fewest HD are affected first;

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On:  August 13,2003
//:://////////////////////////////////////////////


#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_toollib"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

void DoUndeadToDeath(object oCreature, int nDamage)
{
    SignalEvent(oCreature, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    SetLocalInt(oCreature,"X2_EBLIGHT_I_AM_DEAD", TRUE);

   float fDelay = GetRandomDelay(0.2f,0.4f);
   if (!MyResistSpell(OBJECT_SELF, oCreature, fDelay))
   {
        //effect eDeath = EffectDamage(GetCurrentHitPoints(oCreature),DAMAGE_TYPE_DIVINE,DAMAGE_POWER_ENERGY);
        effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_DIVINE,DAMAGE_POWER_ENERGY);
        effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
        //DelayCommand(fDelay+0.5f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oCreature));
        DelayCommand(fDelay + 0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oCreature));
        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oCreature));
        DelayCommand(0.6f,DeleteLocalInt(oCreature,"X2_EBLIGHT_I_AM_DEAD"));
    }
}

void main()
{

/*
  Spellcast Hook Code
  Added 2003-07-07 by Georg Zoeller
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();


// End of Spell Cast Hook

    // Impact VFX
    location lLoc = GetSpellTargetLocation();

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_STRIKE_HOLY),lLoc);
    TLVFXPillar(VFX_FNF_LOS_HOLY_20, lLoc,3,0.0f);


     // build list with affected creatures

     // calculation
     int nLevel = GetCasterLevel(OBJECT_SELF);
     // calculate number of hitdice affected
     int nLow = 9999;
     object oLow;
     //int nHDLeft = nLevel *d4();
     int nHDLeft = 99999;


    int nCurHD;
    object oFirst = GetFirstObjectInShape(SHAPE_SPHERE, 10.0f,lLoc );

    //Roll damage for each target
    int nDamage = GetSixthLevelDamage(oFirst, nLevel, nMetaMagic, "AOE");

     // Only start loop if there is a creature in the area of effect
     if  (GetIsObjectValid(oFirst))
     {
        object oTarget = oFirst;
        while (GetIsObjectValid(oTarget) && nHDLeft >0)
        {
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {
                nCurHD = GetHitDice(oTarget);
                if (nCurHD <= nHDLeft )
                {
                    if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
                    {
                        // ignore creatures already affected
                        if (GetLocalInt(oTarget,"X2_EBLIGHT_I_AM_DEAD") == 0 && !GetPlotFlag(oTarget) && !GetIsDead(oTarget))
                        {
                            //Roll damage for each target
                            nDamage = GetSixthLevelDamage(oTarget, nLevel, nMetaMagic, "AOE");

                            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                            string sElement = "Nega";
                            int nDC = GetSpellSaveDC();
                            int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
                            nDC = nDC + nBonusDC;
                            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
                            nDamage = GetWillDamage(oTarget, nDC, nDamage);

                            // store the creature with the lowest HD
                            if (GetHitDice(oTarget) <= nLow)
                            {
                                nLow = GetHitDice(oTarget);
                                oLow = oTarget;
                            }
                        }
                    }
                }
            }

            // Get next target
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 10.0f ,lLoc);

            // End of cycle, time to kill the lowest creature
            if (!GetIsObjectValid(oTarget))
            {
                // we have a valid lowest creature we can affect with the remaining HD
                if (GetIsObjectValid(oLow) && nHDLeft >= nLow)
                {
                    DoUndeadToDeath(oLow, nDamage);
                    // decrement remaining HD
                    nHDLeft -= nLow;
                    // restart the loop
                    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 10.0f, GetSpellTargetLocation());
                }
                // reset counters
                oLow = OBJECT_INVALID;
                nLow = 9999;
            }
        }
    }
 }
