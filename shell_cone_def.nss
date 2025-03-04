#include "x2_inc_switches"
#include "spell_dmg_inc"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if(nEvent == X2_ITEM_EVENT_ONHITCAST)
    {
        //Check if the item has a cleave type.
        object oItem = GetSpellCastItem();
        int nDamageType = GetLocalInt(oItem, "WEAPON_CLEAVE_TYPE");
        if(nDamageType == 0)
        {
            return;
        }

        //Determine cleave damage.
        int nDamage = 4;
        int nFinalDamage;
        int nDEX = GetAbilityModifier(ABILITY_DEXTERITY, OBJECT_SELF);
        int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, OBJECT_SELF);
        nDamage = nDamage + nDEX + nCON + d4(1);

        int nVFX = VFX_COM_BLOOD_REG_RED;

        // if so, store a reference to the PC and his location
        object oPC = OBJECT_SELF;
        object oEnemy = GetAttackTarget(OBJECT_SELF);
        location lLocation = GetLocation(oEnemy);

        // detect the first creature in line of sight in a small~medium cone
        object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 15.0, lLocation, TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            // check if it's an enemy
            if(GetIsEnemy(oTarget, oPC))
            {
               effect eDamage = EffectDamage(nDamage, nDamageType, DAMAGE_POWER_NORMAL);
               effect eVis = EffectVisualEffect(nVFX);
               effect eLink = EffectLinkEffects(eVis, eDamage);
                // apply it
               ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
            }
            // check if there are more creatures in the defined radius, if so, loop over them with the same logic
            oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 15.0, lLocation, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    // this is to inform the module the script has ended
    SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
}
