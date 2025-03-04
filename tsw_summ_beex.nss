//Aura Disruption by Alexander G.

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
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nHeal;
    float fDelay;
    float fSize = GetSpellArea(20.0);
    effect eImpact = EffectVisualEffect(1079);
    effect eVis = EffectVisualEffect(940);
    effect eSound = EffectVisualEffect(943);
    effect eMissile = EffectVisualEffect(1113);
    effect eDamage;
    string sTargets;
    string sElement = "Magi";
    object oMainTarget;
    int nTargetCheck = 0;

    //Get the location of our summon
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    location lTarget = GetLocation(oSummon);

    if(oSummon == OBJECT_INVALID)
    {
        SendMessageToPC(OBJECT_SELF, "You must have an active summon to use this ability.");
        return;
    }

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeHostile(oTarget) && oTarget != oSummon)
        {
            //Get 20% of the summon's max health
            nHeal = GetMaxHitPoints(oSummon) / 5;
            nHeal = GetFocusDmg(OBJECT_SELF, nHeal, sElement);
            effect eHeal = EffectHeal(nHeal);

            eDamage = EffectDamage(nHeal, DAMAGE_TYPE_POSITIVE);


            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            //Get the distance between the explosion and the target to calculate delay
            float fDist = GetDistanceBetween(oSummon, oTarget);
            float fDelay = fDist/(3.0 * log(fDist) + 2.0);
            float fDelay2, fTime;

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            if(nHeal > 0)
            {
                //Set local variables on summon to use their own VFX
                SetLocalInt(oSummon, "MY_TEMPORARY_EFFECT", 1113);
                SetLocalObject(oSummon, "MY_TEMPORARY_TARGET", oTarget);
                // Apply effects to the currently selected target.
                ExecuteScript("tsw_3rdparty_vis", oSummon);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSound, oTarget));
                DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget)));
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Damage pet
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSummon);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oSummon);

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, sTargets, nHeal, oMainTarget);
}

