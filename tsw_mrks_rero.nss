//::///////////////////////////////////////////////
//:: Rebounder Rounds by Alexander G.
//:://////////////////////////////////////////////

#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{

    //Leave if not ranged weapon
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    int nType = GetBaseItemType(oWep);
    if(!GetWeaponRanged(oWep))
    {
        SendMessageToPC(OBJECT_SELF, "Requires a ranged weapon.");
        return;
    }


    //Declare major variables
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    //Limit caster level
    int nDamage;;
    int nDamStrike;
    int nNumAffected = 0;
    int nFinalDamage;
    effect eVis  = EffectVisualEffect(VFX_COM_SPARKS_PARRY);
    effect eVis2 = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);
    effect eDamage;
    object oFirstTarget = GetSpellTargetObject();
    object oHolder;
    object oTarget;
    location lSpellLocation;
    float fSize = GetSpellArea(10.0);

    //Get Marksman crit
    int nCrit = GetLocalInt(OBJECT_SELF, "MARKSMAN_CRIT");

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        nDamage = GetSixthLevelDamage(oFirstTarget, nCasterLevel, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "PIerce";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
        if(nCrit == 1)
        {
            nDamage = nDamage + (nDamage / 2);
            DeleteLocalInt(OBJECT_SELF, "MARKSMAN_CRIT");
        }

        //Track the first valid target for class mechanics
        object oMainTarget;
        int nTargetCheck = 0;
    //End Custom Spell-Function Block

    //Damage the initial target
    if (spellsIsTarget(oFirstTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oFirstTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        //Adjust damage based on Alchemite and Saving Throw
        nFinalDamage = GetReflexDamage(oFirstTarget, nReduction, nDamage);

        //Set the damage effect for the first target
        eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_PIERCING);
        //Apply damage to the first target and the VFX impact.
        if(nDamage > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oFirstTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oFirstTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oFirstTarget);
            AssignCommand(oFirstTarget, DelayCommand(0.0, PlaySoundByStrRef(16778126, FALSE)));
        }
    }

    //Reinitialize the effect so that it travels from the first target to the next target
    float fDelay = 0.2;
    int nCnt = 0;

    // *
    // * Secondary Targets
    // *

    //Get the first target in the spell shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);

    while (GetIsObjectValid(oTarget) && nCnt < 15)
    {
        //Make sure the caster's faction is not hit and the first target is not hit
        if (oTarget != oFirstTarget && spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Apply the damage and VFX impact to the current target
            eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_PIERCING);
            if(nDamage > 0) //Damage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                AssignCommand(oTarget, DelayCommand(fDelay, PlaySoundByStrRef(16778126, FALSE)));
            }
            oHolder = oTarget;

            fDelay = fDelay + 0.2;
        }
        //Count the number of targets that have been hit.
        if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            nCnt++;
        }

        // April 2003: Setting the new origin for the beam
       // oFirstTarget = oTarget;

        //Get the next target in the shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
      }
    //Class mechanics
    DoMartialMechanic("Assault", sTargets, nFinalDamage, oMainTarget);

    //Play weapon shot sounds
    int nSound = GetWeaponSound(OBJECT_SELF);
    PlaySoundByStrRef(nSound, FALSE);

 }

