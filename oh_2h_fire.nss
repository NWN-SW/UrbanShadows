#include "x2_inc_switches"

int getDamageType(string sInput) {
    if(GetStringLength(sInput) == 4) {
        if(sInput == "FIRE") {
            return DAMAGE_TYPE_FIRE;
        }
        if(sInput == "COLD") {
            return DAMAGE_TYPE_COLD;
        }
        if(sInput == "ACID") {
            return DAMAGE_TYPE_ACID;
        }
        if(sInput == "ELEC") {
            return DAMAGE_TYPE_ELECTRICAL;
        }
        if(sInput == "NEGA") {
            return DAMAGE_TYPE_NEGATIVE;
        }
        if(sInput == "SONI") {
            return DAMAGE_TYPE_SONIC;
        }
        if(sInput == "HOLY") {
            return DAMAGE_TYPE_POSITIVE;
        }
        return 0;
    } else {
        return 0;
    }
}

void main() {
    int nEvent = GetUserDefinedItemEventNumber();
    if(nEvent == X2_ITEM_EVENT_ONHITCAST){
        // evaluate on the weapon that is calling the script; is it a on-hit two-hander? (defined by ON_2H)
        object oItem = GetSpellCastItem();
        string sItemTag = GetTag(oItem);
        string sItemTagOnHitTwoHander = GetStringLeft(sItemTag, 5);
        if(sItemTagOnHitTwoHander != "OH_2H") {
            return;
        }
        // if so, does it have a supported and valid damage type?
        string sItemTagDamageType = GetStringRight(sItemTag, 4);
        int nDamageType = getDamageType(sItemTagDamageType);
        if(nDamageType == 0) {
            return;
        }

        // if so, store a reference to the PC and his location
        object oPC = OBJECT_SELF;
        object oEnemy = GetAttackTarget(OBJECT_SELF);
        location lLocation = GetLocation(oEnemy);
        // roll for damage
        int nSTR = GetAbilityModifier(ABILITY_STRENGTH, oPC);
        int nRolledDamage = d10(2) + (nSTR * 2); //Assuming 12 STR Mod 27 to 54 damage.
        float fRadius = 2.25f;
        // detect the first creature in line of sight in a small~medium sphere
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLocation, TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            // check if it's an enemy
            if(GetIsEnemy(oTarget, oPC) && oTarget != oEnemy)
            {
                // if so, prepare damage to be dished out
               effect eDamage = EffectDamage(nRolledDamage, nDamageType, DAMAGE_POWER_NORMAL);
               effect eVis = EffectVisualEffect(280);
               effect eLink = EffectLinkEffects(eVis, eDamage);
                // apply it
               ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
            }
            // check if there are more creatures in the defined radius, if so, loop over them with the same logic
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLocation, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    // this is to inform the module the script has ended
    SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
}
