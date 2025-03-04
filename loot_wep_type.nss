#include "x2_inc_itemprop"
#include "tsw_iptostring"

string LootWeaponType(object oWep)
{
    int nRand = Random(10);
    int nWepType = GetBaseItemType(oWep);
    string sTag = "OH_CLEAVE_WEP";
    string sName = GetName(oWep);

    //Return if ranged weapon.
    if(GetWeaponRanged(oWep))
    {
        return sName;
    }

/* OLD
    //DEBUGGING
    object oPC = GetFirstPC();

    //Remove existing OnHit
    itemproperty ipCleaner = GetFirstItemProperty(oWep);
    while(GetIsItemPropertyValid(ipCleaner))
    {
        string sProperty = ItemPropertyToString(ipCleaner);
        SendMessageToPC(oPC, "Found property: " + sProperty + ". Cleaning.");
        DelayCommand(1.0, RemoveItemProperty(oWep, ipCleaner));
        ipCleaner = GetNextItemProperty(oWep);
    }

*/
    switch(nRand)
    {
        case 0:
            SetLocalInt(oWep, "WEAPON_CLEAVE_TYPE", DAMAGE_TYPE_FIRE);
            SetTag(oWep, sTag);
            sName = "Fiery " + sName;
            SetDescription(oWep, "This weapon has been imbued with fire, and causes area damage when striking enemies. The damage scales with your Strength and Dexterity modifier.", TRUE);
            //IPSafeAddItemProperty(oWep, ipOnHit, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            //IPSafeAddItemProperty(oWep, ipWeight, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            return sName;
            break;
        case 1:
            SetLocalInt(oWep, "WEAPON_CLEAVE_TYPE", DAMAGE_TYPE_COLD);
            SetTag(oWep, sTag);
            sName = "Chilled " + sName;
            SetDescription(oWep, "This weapon has been imbued with frost, and causes area damage when striking enemies. The damage scales with your Strength and Dexterity modifier.", TRUE);
            //IPSafeAddItemProperty(oWep, ipOnHit, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            //IPSafeAddItemProperty(oWep, ipWeight, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            return sName;
            break;
        case 2:
            SetLocalInt(oWep, "WEAPON_CLEAVE_TYPE", DAMAGE_TYPE_ELECTRICAL);
            SetTag(oWep, sTag);
            sName = "Shocking " + sName;
            SetDescription(oWep, "This weapon has been imbued with lightning, and causes area damage when striking enemies. The damage scales with your Strength and Dexterity modifier.", TRUE);
            //IPSafeAddItemProperty(oWep, ipOnHit, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            //IPSafeAddItemProperty(oWep, ipWeight, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            return sName;
            break;
        case 3:
            SetLocalInt(oWep, "WEAPON_CLEAVE_TYPE", DAMAGE_TYPE_ACID);
            SetTag(oWep, sTag);
            sName = "Corrosive " + sName;
            SetDescription(oWep, "This weapon has been imbued with acid, and causes area damage when striking enemies. The damage scales with your Strength and Dexterity modifier.", TRUE);
            //IPSafeAddItemProperty(oWep, ipOnHit, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            //IPSafeAddItemProperty(oWep, ipWeight, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            return sName;
            break;
        case 4:
            SetLocalInt(oWep, "WEAPON_CLEAVE_TYPE", DAMAGE_TYPE_NEGATIVE);
            SetTag(oWep, sTag);
            sName = "Deathly " + sName;
            SetDescription(oWep, "This weapon has been imbued with deathly energy, and causes area damage when striking enemies. The damage scales with your Strength and Dexterity modifier.", TRUE);
            //IPSafeAddItemProperty(oWep, ipOnHit, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            //IPSafeAddItemProperty(oWep, ipWeight, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            return sName;
            break;
        case 5:
            SetLocalInt(oWep, "WEAPON_CLEAVE_TYPE", DAMAGE_TYPE_DIVINE);
            SetTag(oWep, sTag);
            sName = "Holy " + sName;
            SetDescription(oWep, "This weapon has been imbued with holy energy, and causes area damage when striking enemies. The damage scales with your Strength and Dexterity modifier.", TRUE);
            //IPSafeAddItemProperty(oWep, ipOnHit, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            //IPSafeAddItemProperty(oWep, ipWeight, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            return sName;
            break;
        case 6:
            SetLocalInt(oWep, "WEAPON_CLEAVE_TYPE", DAMAGE_TYPE_SONIC);
            SetTag(oWep, sTag);
            sName = "Shattering " + sName;
            SetDescription(oWep, "This weapon has been imbued with sonic energy, and causes area damage when striking enemies. The damage scales with your Strength and Dexterity modifier.", TRUE);
            //IPSafeAddItemProperty(oWep, ipOnHit, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            //IPSafeAddItemProperty(oWep, ipWeight, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            return sName;
            break;
        case 7:
            SetLocalInt(oWep, "WEAPON_CLEAVE_TYPE", DAMAGE_TYPE_SLASHING);
            SetTag(oWep, sTag);
            sName = "Evicerating " + sName;
            SetDescription(oWep, "This weapon causes bonus slashing damage in an area when striking enemies. The damage scales with your Strength and Dexterity modifier.", TRUE);
            //IPSafeAddItemProperty(oWep, ipOnHit, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            //IPSafeAddItemProperty(oWep, ipWeight, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            return sName;
            break;
        case 8:
            SetLocalInt(oWep, "WEAPON_CLEAVE_TYPE", DAMAGE_TYPE_PIERCING);
            SetTag(oWep, sTag);
            sName = "Perforating " + sName;
            SetDescription(oWep, "This weapon causes bonus piercing damage in an area when striking enemies. The damage scales with your Strength and Dexterity modifier.", TRUE);
            //IPSafeAddItemProperty(oWep, ipOnHit, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            //IPSafeAddItemProperty(oWep, ipWeight, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            return sName;
            break;
        case 9:
            SetLocalInt(oWep, "WEAPON_CLEAVE_TYPE", DAMAGE_TYPE_BLUDGEONING);
            SetTag(oWep, sTag);
            sName = "Crushing " + sName;
            SetDescription(oWep, "This weapon causes bonus bludgeoning damage in an area when striking enemies. The damage scales with your Strength and Dexterity modifier.", TRUE);
            //IPSafeAddItemProperty(oWep, ipOnHit, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            //IPSafeAddItemProperty(oWep, ipWeight, 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            return sName;
            break;
    }
    return "BROKEN";
}
