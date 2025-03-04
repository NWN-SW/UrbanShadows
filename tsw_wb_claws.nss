#include "x2_inc_switches"

void main() {
    int nEvent = GetUserDefinedItemEventNumber();
    if(nEvent == X2_ITEM_EVENT_ONHITCAST){
        // evaluate on the weapon that is calling the script; is it a on-hit two-hander? (defined by ON_2H)
        object oItem = GetSpellCastItem();
        string sItemTag = GetTag(oItem);
        if(sItemTag != "tsw_wb_claws") {
            return;
        }

        // if so, store a reference to the PC and his location
        object oPC = OBJECT_SELF;
        object oEnemy = GetAttackTarget(OBJECT_SELF);
        location lLocation = GetLocation(oEnemy);
        // roll for damage
        int nSTR = GetAbilityModifier(ABILITY_STRENGTH, oPC);
        int nRolledDamage;
        int nAcidDamage;
        effect eAcid;
        float fRadius = 2.0f;
        // detect the first creature in line of sight in a small~medium sphere
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLocation, TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {

            nRolledDamage = d10(2) + nSTR;
            //Add bonus damage for the Use Poison feat
            nAcidDamage = nRolledDamage / 2;
            // check if it's an enemy
            if(GetIsEnemy(oTarget, oPC) && oTarget != oEnemy) {
                // if so, prepare damage to be dished out
               effect eAcid = EffectDamage(nAcidDamage, DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);
               effect eDamage = EffectDamage(nRolledDamage, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_NORMAL);
               effect eVis = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
               effect eLink = EffectLinkEffects(eVis, eDamage);
                // apply it
               ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
               //Apply acid if Use Poison feat
               if(GetHasFeat(FEAT_USE_POISON, OBJECT_SELF))
               {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget);
               }
            }
            // check if there are more creatures in the defined radius, if so, loop over them with the same logic
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLocation, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    // this is to inform the module the script has ended
    SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
}
