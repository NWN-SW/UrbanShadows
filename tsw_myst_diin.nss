//::///////////////////////////////////////////////
//:: Divine Intervention by Alexander G.
//:://////////////////////////////////////////////

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
    int nDamage;
    int nFinalDamage;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;
    //Custom spell size
    float fSize = GetSpellArea(15.0);
    float fDuration = GetExtendSpell(60.0);
    effect eVis = EffectVisualEffect(949);
    effect eSound = EffectVisualEffect(953);
    effect eFireStorm = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, 10);
    float fDelay;
    string sTargets;
    string sElement;
    int nReduction;
    object oFake;
    //Apply Fire and Forget Visual in the area;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));

    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (!GetIsReactionTypeHostile(oTarget))
        {
            fDelay = GetRandomDelay(0.25, 1.0);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetNinthLevelDamage(oFake, nCasterLevel, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Holy";
                nReduction = GetFocusReduction(OBJECT_SELF, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            //End Custom Spell-Function Block

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            if(nDamage > 0)
            {
                  // Apply effects to the currently selected target.  For this spell we have used
                  //both Divine and Fire damage.
                  effect eHeal = EffectHeal(nDamage);
                  effect eRaise = EffectResurrection();
                  //Remove variables if dead
                  if(GetIsDead(oTarget))
                  {
                      SQLocalsPlayer_DeleteInt(oTarget, "CURRENTLY_DEAD");

                      //Blood Mage check
                      int nRitual = GetLocalInt(oTarget, "I_AM_BLOODMAGE");
                      if(nRitual >= 1)
                      {
                          SetLocalInt(oTarget, "I_AM_BLOODMAGE", 1);
                      }
                      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget));
                  }
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSound, oTarget));
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaves, oTarget, fDuration));

                // Jasperre's additions...
                AssignCommand(oTarget, SpeakString("I AM ALIVE!", TALKVOLUME_SILENT_TALK));
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
}
