#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "inc_timer"

//Brawler Carnage by Alexander G.
void DoBrawlerCarnage(object oCaster)
{
    int nCheck = GetLocalInt(oCaster, "BRAWLER_CARNAGE");
    if(nCheck != 1)
    {
        return;
    }

    //Effect variables
    effect eVis;
    effect eBoom;
    effect eDamage;
    string sElement;
    int nDamageType;
    float fDelay;

    eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);
    effect eVis2 = EffectVisualEffect(961);
    eBoom = EffectVisualEffect(1080);
    sElement = "Slash";
    nDamageType = DAMAGE_TYPE_SLASHING;

    //Loop through targets in shape
    object oAttackee = GetAttackTarget(oCaster);
    float fSize = GetSpellArea(6.0);
    int nDamage;
    int nFinalDamage;
    string sTargets;
    int nTargetCheck;
    object oMainTarget;
    int nReduction;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oAttackee), TRUE, OBJECT_TYPE_CREATURE);

    //Do personal VFX
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, oCaster);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (GetIsReactionTypeHostile(oTarget, oCaster))
        {
            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetNinthLevelDamage(oTarget, 0, sTargets);
                nDamage = nDamage / 5;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Set the damage effect
            eDamage = EffectDamage(nFinalDamage, nDamageType);
            if(nFinalDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                fDelay = fDelay + 0.1;
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oAttackee), TRUE, OBJECT_TYPE_CREATURE);
    }

    //Sound Effects
    PlaySoundByStrRef(16778118, FALSE);
    DelayCommand(0.1, PlaySoundByStrRef(16778118, FALSE));
}
