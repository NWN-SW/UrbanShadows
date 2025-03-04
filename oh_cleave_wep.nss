#include "x2_inc_switches"
#include "spell_dmg_inc"
#include "tsw_assn_leth"
#include "tsw_doom_spells"
#include "tsw_cham_conmain"
#include "tsw_braw_carna"

string GetCleaveTypeString(int nType)
{
    string sType;
    if(nType == DAMAGE_TYPE_ACID)
    {
        sType = "Acid";
    }
    else if(nType == DAMAGE_TYPE_BLUDGEONING)
    {
        sType = "Bludge";
    }
    else if(nType == DAMAGE_TYPE_COLD)
    {
        sType = "Cold";
    }
    else if(nType == DAMAGE_TYPE_DIVINE)
    {
        sType = "Holy";
    }
    else if(nType == DAMAGE_TYPE_ELECTRICAL)
    {
        sType = "Elec";
    }
    else if(nType == DAMAGE_TYPE_FIRE)
    {
        sType = "Fire";
    }
    else if(nType == DAMAGE_TYPE_MAGICAL)
    {
        sType = "Magi";
    }
    else if(nType == DAMAGE_TYPE_NEGATIVE)
    {
        sType = "Nega";
    }
    else if(nType == DAMAGE_TYPE_PIERCING)
    {
        sType = "Pierce";
    }
    else if(nType == DAMAGE_TYPE_POSITIVE)
    {
        sType = "Holy";
    }
    else if(nType == DAMAGE_TYPE_SLASHING)
    {
        sType = "Slash";
    }
    else if(nType == DAMAGE_TYPE_SONIC)
    {
        sType = "Soni";
    }

    return sType;
}

int GetCleaveVFX(int nType)
{
    int nVFX;
    if(nType == DAMAGE_TYPE_ACID)
    {
        nVFX = VFX_COM_HIT_ACID;
    }
    else if(nType == DAMAGE_TYPE_BLUDGEONING)
    {
        nVFX = VFX_COM_BLOOD_REG_RED;
    }
    else if(nType == DAMAGE_TYPE_COLD)
    {
        nVFX = VFX_COM_HIT_FROST;
    }
    else if(nType == DAMAGE_TYPE_DIVINE)
    {
        nVFX = VFX_COM_HIT_DIVINE;
    }
    else if(nType == DAMAGE_TYPE_ELECTRICAL)
    {
        nVFX = VFX_COM_HIT_ELECTRICAL;
    }
    else if(nType == DAMAGE_TYPE_FIRE)
    {
        nVFX = VFX_COM_HIT_FIRE;
    }
    else if(nType == DAMAGE_TYPE_MAGICAL)
    {
        nVFX = VFX_IMP_MAGBLUE;
    }
    else if(nType == DAMAGE_TYPE_NEGATIVE)
    {
        nVFX = VFX_COM_HIT_NEGATIVE;
    }
    else if(nType == DAMAGE_TYPE_PIERCING)
    {
        nVFX = VFX_COM_BLOOD_REG_RED;
    }
    else if(nType == DAMAGE_TYPE_POSITIVE)
    {
        nVFX = VFX_COM_HIT_DIVINE;
    }
    else if(nType == DAMAGE_TYPE_SLASHING)
    {
        nVFX = VFX_COM_BLOOD_REG_RED;
    }
    else if(nType == DAMAGE_TYPE_SONIC)
    {
        nVFX = VFX_COM_HIT_SONIC;
    }

    return nVFX;
}


void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if(nEvent == X2_ITEM_EVENT_ONHITCAST)
    {
        //Get our attack target
        object oEnemy = GetAttackTarget(OBJECT_SELF);

        //Store a reference to the PC and his target location
        object oPC = OBJECT_SELF;
        location lLocation = GetLocation(oEnemy);

        //Do Assassin Lethality
        DoLethality(oEnemy);

        //Do Doomseer gubbins
        DoDoomAOE(oPC);
        DoDoomChain(oPC);
        DoDoomMissiles(oPC);

        //Do Champion gubbins
        DoChampHeal(oPC);

        //Brawler Cleave
        DoBrawlerCarnage(oPC);

        //Check if the item has a cleave type.
        object oItem = GetSpellCastItem();
        int nDamageType = GetLocalInt(oItem, "WEAPON_CLEAVE_TYPE");
        if(nDamageType == 0)
        {
            return;
        }

        //Determine cleave damage based on weapon type.
        string sItemType = GetLocalString(oItem, "BASE_ITEM_TYPE");
        int nDamage = 10;
        int nFinalDamage;
        if(sItemType == "1H_Weapon")
        {
            nDamage = 6;
        }

        int nVFX = GetCleaveVFX(nDamageType);

        //Adjust damage
        int nSTR = GetAbilityModifier(ABILITY_STRENGTH, oPC);
        int nDEX = GetAbilityModifier(ABILITY_DEXTERITY, oPC);
        nDamage = nDamage + nSTR + nDEX;
        float fRadius = 2.0f;

        //Get the Alchemite resistance reduction
        string sElement = GetCleaveTypeString(nDamageType);
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        // detect the first creature in line of sight in a small~medium sphere
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLocation, TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            // check if it's an enemy
            if(GetIsEnemy(oTarget, oPC))
            {
               // if so, prepare damage to be dished out
               nFinalDamage = GetMartialDamage(oTarget, nReduction, nDamage);
               //Adjust damage based on the tier of enemy and Alchemite

               effect eDamage = EffectDamage(nFinalDamage, nDamageType, DAMAGE_POWER_NORMAL);
               effect eVis = EffectVisualEffect(nVFX);
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
