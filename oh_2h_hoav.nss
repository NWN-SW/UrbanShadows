//Custom Holy Avenger skill
#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if(nEvent == X2_ITEM_EVENT_ONHITCAST)
    {
        //Evalute the weapon that is calling the script
        object oItem = GetSpellCastItem();
        string sItemTag = GetTag(oItem);

        // if so, does it have a supported and valid damage type?
        string sItemTagDamageType = GetStringRight(sItemTag, 4);
        if(sItemTagDamageType != "HOAV")
        {
            SendMessageToPC(OBJECT_SELF, "Return HOAV");
            return;
        }

        //Check the number of attacks the player has left.
        string sOldTag;
        int nAttacks = GetLocalInt(OBJECT_SELF, "HOLY_SWORD_ATTACKS");

        if(nAttacks <= 0)
        {
            sOldTag = GetLocalString(OBJECT_SELF, "MAIN_WEP_TAG");
            DeleteLocalString(OBJECT_SELF, "MAIN_WEP_TAG");
            SetTag(oItem, sOldTag);
            return;
        }
        else
        {
            nAttacks = nAttacks - 1;
            SetLocalInt(OBJECT_SELF, "HOLY_SWORD_ATTACKS", nAttacks);
        }

        //Debug block
        //string sAmount = IntToString(nAttacks);
        //SendMessageToPC(OBJECT_SELF, "You have " + sAmount + " attacks left.");

        // if so, store a reference to the PC and his location
        object oPC = OBJECT_SELF;
        object oEnemy = GetAttackTarget(OBJECT_SELF);
        location lLocation = GetLocation(oEnemy);
        // roll for damage
        int nSTR = GetAbilityModifier(ABILITY_STRENGTH, oPC);
        int nRolledDamage = d10(4) + (nSTR * 2) + 10; //Assuming 12 STR Mod 27 to 54 damage.
        float fRadius = 7.0f;
        // detect the first creature in line of sight in a small~medium sphere
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLocation, TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            // check if it's an enemy
            if(GetIsEnemy(oTarget, oPC))
            {
                // if so, prepare damage to be dished out
               effect eDamage = EffectDamage(nRolledDamage, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL);
               effect eVis = EffectVisualEffect(VFX_COM_HIT_DIVINE);
               effect eVis2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
               effect eDaze = EffectDazed();
               effect eLink = EffectLinkEffects(eVis, eDamage);

                // apply it
               ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
               ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oPC);
               ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oTarget, 4.0f);
               //SendMessageToPC(oPC, "Attempting to fire.");
            }
            // check if there are more creatures in the defined radius, if so, loop over them with the same logic
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLocation, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    // this is to inform the module the script has ended
    SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
}
