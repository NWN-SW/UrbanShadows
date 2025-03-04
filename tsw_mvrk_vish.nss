//::///////////////////////////////////////////////
//:: Vicious Shackle by Alexander G.
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
    // June 2/04 - Bugfix: Cap the level BEFORE the damage calculation, not after. Doh.
    int nDamage;;
    int nDamStrike;
    int nNumAffected = 0;
    int nFinalDamage;
    //Declare lightning effect connected the casters hands
    effect eLightning = EffectBeam(VFX_BEAM_SILENT_COLD, OBJECT_SELF, BODY_NODE_HAND);
    effect eVis  = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect ePara = EffectParalyze();
    effect eDamage;
    object oFirstTarget = GetSpellTargetObject();
    object oHolder;
    object oTarget;
    location lSpellLocation;
    float fSize = GetSpellArea(10.0);
    float fDuration = GetExtendSpell(8.0);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        nDamage = GetNinthLevelDamage(oFirstTarget, nCasterLevel, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Soni";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
        nDamage = nDamage / 2;

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
        eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_SONIC);
        //Apply damage to the first target and the VFX impact.
        if(nDamage > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oFirstTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oFirstTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oFirstTarget, fDuration);
        }
    }
    //Apply the lightning stream effect to the first target, connecting it with the caster
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightning, oFirstTarget, 0.5);

    //Reinitialize the lightning effect so that it travels from the first target to the next target
    eLightning = EffectBeam(VFX_BEAM_SILENT_COLD, oFirstTarget, BODY_NODE_CHEST);

    float fDelay = 0.2;
    int nCnt = 0;

    // *
    // * Secondary Targets
    // *

    //Get the first target in the spell shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);

    while (GetIsObjectValid(oTarget) && nCnt < 10)
    {
        //Make sure the caster's faction is not hit and the first target is not hit
        if (oTarget != oFirstTarget && spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            //Connect the new lightning stream to the older target and the new target
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightning, oTarget, 0.5));

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
            eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_SONIC);
            if(nDamage > 0) //Damage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oTarget, fDuration));
            }
            oHolder = oTarget;

            //change the currect holder of the lightning stream to the current target
            if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
            {
                eLightning = EffectBeam(VFX_BEAM_SILENT_COLD, oHolder, BODY_NODE_CHEST);
            }
            else
            {
                // * April 2003 trying to make sure beams originate correctly
                effect eNewLightning = EffectBeam(VFX_BEAM_SILENT_COLD, oHolder, BODY_NODE_CHEST);
                if(GetIsEffectValid(eNewLightning))
                {
                    eLightning =  eNewLightning;
                }
            }

            fDelay = fDelay + 0.1f;
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
    DoClassMechanic("Force", sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Control", sTargets, nFinalDamage, oMainTarget);
    DoMartialMechanic("Control", sTargets, nFinalDamage, oMainTarget);

    //Play weapon shot sounds
    int nSound = GetWeaponSound(OBJECT_SELF);
    int nCount = 0;
    float fShotDelay = 0.1;
    float fIncrement = 0.1;
    PlaySoundByStrRef(nSound, FALSE);
    while(nCount <= 5)
    {
        DelayCommand(fShotDelay, PlaySoundByStrRef(nSound, FALSE));
        nCount = nCount + 1;
        fShotDelay = fShotDelay + fIncrement;
    }
 }

