//::///////////////////////////////////////////////
//:: Dragonfury by Alexander G.
//:://////////////////////////////////////////////


#include "X0_I0_SPELLS"
#include "x2_i0_spells"
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
    object oCaster = OBJECT_SELF;
    float fDelay;
    float fSize = GetSpellArea(20.0);
    effect eExplode = EffectVisualEffect(489);
    effect eVis = EffectVisualEffect(494);
    string sTargets;
    string sElement;
    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;
    effect eDam;
    int nReduction;
    location lTarget = GetSpellTargetLocation();

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeHostile(oTarget, oCaster))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetNinthLevelDamage(oTarget, 10, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Bludge";
                nReduction = GetFocusReduction(OBJECT_SELF, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            //End Custom Spell-Function Block

            fDelay = 5.15;

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Double effect for Talonstrike
            int nCheck = GetLocalInt(OBJECT_SELF, "TALONSTRIKE_ACTIVE");
            if(nCheck > 0)
            {
                nFinalDamage = nFinalDamage * 2;
            }

            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);

            if(nFinalDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
             }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    string sSpellType = "Assault";
    DelayCommand(fDelay, DoMartialMechanic(sSpellType, "AOE", nFinalDamage, oMainTarget, oCaster));

    DeleteLocalInt(OBJECT_SELF, "TALONSTRIKE_ACTIVE");
}

