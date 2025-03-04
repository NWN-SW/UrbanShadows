//::///////////////////////////////////////////////
//:: Pressing Attack by Alexander G.
//:://////////////////////////////////////////////

#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{
    //Declare major variables
    int nDamage;
    int nFinalDamage;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;
    //Custom spell size
    float fSize = GetSpellArea(8.0);
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);
    effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_G);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    string sTargets;
    string sElement;
    int nTotalDamage;
    int nReduction;
    int nHeal;
    int nSpell = GetSpellId();
    //Apply Fire and Forget Visual in the area;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(OBJECT_SELF));

    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    //Apply the acid explosions
    float fDelay2;
    float fFinalDuration;
    location lVFX;
    int nVFXCounter;
    effect eExplode = EffectVisualEffect(VFX_IMP_MAGBLUE, FALSE, 1.5, [0.0,0.0,0.6]);
    while(nVFXCounter < 8)
    {
        lVFX = GetNewRandomLocation(GetSpellTargetLocation(), fSize);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
        nVFXCounter = nVFXCounter + 1;
        fDelay2 = fDelay2 + 0.1;
    }

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        //Do damage to enemies
        if (GetIsReactionTypeHostile(oTarget) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSixthLevelDamage(oTarget, nCasterLevel, sTargets);
                nDamage = nDamage / 2;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Soni";
                nReduction = GetFocusReduction(OBJECT_SELF, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            //End Custom Spell-Function Block

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
                SetLocalInt(OBJECT_SELF, "SPIRIT_WING_DMG", nFinalDamage);
            }

            //Double effect for Talonstrike
            int nCheck = GetLocalInt(OBJECT_SELF, "TALONSTRIKE_ACTIVE");
            if(nCheck > 0)
            {
                nFinalDamage = nFinalDamage * 2;
            }

            if(nDamage > 0)
            {
                  // Apply effects to the currently selected target.  For this spell we have used
                  //both Divine and Fire damage.
                  effect eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_SONIC);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }

        //Heal allies if balance
        if (!GetIsReactionTypeHostile(oTarget) && GetHasFeat(MAAR_PATH_OF_BALANCE))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell, FALSE));

            nHeal = GetLocalInt(OBJECT_SELF, "SPIRIT_WING_DMG");
            nHeal = nHeal / 4;

            //Double effect for Talonstrike
            int nCheck = GetLocalInt(OBJECT_SELF, "TALONSTRIKE_ACTIVE");
            if(nCheck > 0)
            {
                nHeal = nHeal * 2;
            }

            if(nDamage > 0)
            {
                  // Apply effects to the currently selected target.
                  effect eHeal = EffectHeal(nHeal);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), OBJECT_TYPE_CREATURE);
    }

    //Do the self heal for Ruin
    if(GetHasFeat(MAAR_PATH_OF_RUIN))
    {
        nHeal = GetLocalInt(OBJECT_SELF, "SPIRIT_WING_DMG");
        nHeal = nHeal / 2;

        //Double effect for Talonstrike
        int nCheck = GetLocalInt(OBJECT_SELF, "TALONSTRIKE_ACTIVE");
        if(nCheck > 0)
        {
            nHeal = nHeal * 2;
        }

        effect eHeal = EffectHeal(nHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
    }


    //Class mechanics
    DoMartialMechanic("Assault", sTargets, nTotalDamage, oMainTarget);
    DoClassMechanic("Buff", sTargets, nTotalDamage, oMainTarget);

    //Sound Effects
    PlaySoundByStrRef(16778128, FALSE);
    DelayCommand(0.2, PlaySoundByStrRef(16778128, FALSE));
    DelayCommand(0.4, PlaySoundByStrRef(16778128, FALSE));

    DeleteLocalInt(OBJECT_SELF, "TALONSTRIKE_ACTIVE");
    DeleteLocalInt(OBJECT_SELF, "SPIRIT_WING_DMG");
}


