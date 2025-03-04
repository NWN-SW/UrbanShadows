//::///////////////////////////////////////////////
//:: Name: pals_main
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     This script automatically divides loot for
     the party.  Gold is evenly split and given
     to the players. Regular items are randomly
     distributed. Plot items go to the person who
     picked them up.
*/
//:://////////////////////////////////////////////
//:: Created By: Tom 'Magi' Smallwood (tomsmallwood@yahoo.com)
//:: Created On: August 2002
//:: Version 1.0
//:://////////////////////////////////////////////

#include "utl_i_sqlplayer"

void AutoSplitItem(object oItem, object oPC);
void AutoSplitGold(object oContainer, object oPC);
void MarkInv(object oContainer, int iStatus);
string GetUnidentifedDescription(object oItem);

//

string GetUnidentifiedDescriptin(object oItem)
//return the base type of an item
//this is used if the item is unidentified
{
  string sType;
  int iItemType = GetBaseItemType(oItem);
  switch(iItemType)
  {
    case BASE_ITEM_AMULET        : sType = "Amulet"; break;
    case BASE_ITEM_ARMOR         : sType = "Armor";  break;
    case BASE_ITEM_ARROW         : sType = "Arrows"; break;
    case BASE_ITEM_BASTARDSWORD  : sType = "Bastard Sword"; break;
    case BASE_ITEM_BATTLEAXE     : sType = "Battleaxe"; break;
    case BASE_ITEM_BELT          : sType = "Belt"; break;
    case BASE_ITEM_BOLT          : sType = "Bolts"; break;
    case BASE_ITEM_BOOK          : sType = "Book"; break;
    case BASE_ITEM_BOOTS         : sType = "Boots"; break;
    case BASE_ITEM_BRACER        : sType = "Bracer"; break;
    case BASE_ITEM_BULLET        : sType = "Bullets"; break;
    case BASE_ITEM_CBLUDGWEAPON  : sType = "Bludgeoning weapon"; break;
    case BASE_ITEM_CLOAK         : sType = "Cloak"; break;
    case BASE_ITEM_CLUB          : sType = "Club"; break;
    case BASE_ITEM_CPIERCWEAPON  : sType = "Creature Piercing Weapon"; break;
    case BASE_ITEM_CSLASHWEAPON  : sType = "Creature Slashing Weapon"; break;
    case BASE_ITEM_CSLSHPRCWEAP  : sType = "Creature Slashing and Piercing Weapon"; break;
    case BASE_ITEM_DAGGER        : sType = "Dagger"; break;
    case BASE_ITEM_DART          : sType = "Dart"; break;
    case BASE_ITEM_DIREMACE      : sType = "Dire Mace"; break;
    case BASE_ITEM_DOUBLEAXE     : sType = "Double Axe"; break;
    case BASE_ITEM_GEM           : sType = "Gem"; break;
    case BASE_ITEM_GLOVES        : sType = "Gloves"; break;
    case BASE_ITEM_GOLD          : sType = "Gold"; break;
    case BASE_ITEM_GREATAXE      : sType = "Greataxe"; break;
    case BASE_ITEM_GREATSWORD    : sType = "Greatsword"; break;
    case BASE_ITEM_HALBERD       : sType = "Halberd"; break;
    case BASE_ITEM_HANDAXE       : sType = "Handaxe"; break;
    case BASE_ITEM_HEALERSKIT    : sType = "Healer's Kit"; break;
    case BASE_ITEM_HEAVYCROSSBOW : sType = "Heavy Crossbow"; break;
    case BASE_ITEM_HEAVYFLAIL    : sType = "Heavy Flail"; break;
    case BASE_ITEM_HELMET        : sType = "Helmet"; break;
    case BASE_ITEM_INVALID       : sType = "Invalid Object"; break;
    case BASE_ITEM_KAMA          : sType = "Kama"; break;
    case BASE_ITEM_KATANA        : sType = "Katana"; break;
    case BASE_ITEM_KEY           : sType = "Key"; break;
    case BASE_ITEM_KUKRI         : sType = "Kukri"; break;
    case BASE_ITEM_LARGEBOX      : sType = "Large Box"; break;
    case BASE_ITEM_LARGESHIELD   : sType = "Large Shield"; break;
    case BASE_ITEM_LIGHTCROSSBOW : sType = "Light Crossbow"; break;
    case BASE_ITEM_LIGHTFLAIL    : sType = "Light Flail"; break;
    case BASE_ITEM_LIGHTHAMMER   : sType = "Light Hammer"; break;
    case BASE_ITEM_LIGHTMACE     : sType = "Light Mace"; break;
    case BASE_ITEM_LONGBOW       : sType = "Longbow"; break;
    case BASE_ITEM_LONGSWORD     : sType = "Longsword"; break;
    case BASE_ITEM_MAGICROD      : sType = "Magic Rod"; break;
    case BASE_ITEM_MAGICSTAFF    : sType = "Magic Staff"; break;
    case BASE_ITEM_MAGICWAND     : sType = "Magic Wand"; break;
    case BASE_ITEM_MISCLARGE     : sType = "Miscellaneous item"; break;
    case BASE_ITEM_MISCMEDIUM    : sType = "Miscellaneous item"; break;
    case BASE_ITEM_MISCSMALL     : sType = "Miscellaneous item"; break;
    case BASE_ITEM_MISCTALL      : sType = "Miscellaneous item"; break;
    case BASE_ITEM_MISCTHIN      : sType = "Miscellaneous item"; break;
    case BASE_ITEM_MISCWIDE      : sType = "Miscellaneous item"; break;
    case BASE_ITEM_MORNINGSTAR   : sType = "Morningstar"; break;
    case BASE_ITEM_POTIONS       : sType = "Potion"; break;
    case BASE_ITEM_QUARTERSTAFF  : sType = "Quarterstaff"; break;
    case BASE_ITEM_RAPIER        : sType = "Rapier"; break;
    case BASE_ITEM_RING          : sType = "Ring"; break;
    case BASE_ITEM_SCIMITAR      : sType = "Scimitar"; break;
    case BASE_ITEM_SCROLL        : sType = "Magical Scroll"; break;
    case BASE_ITEM_SCYTHE        : sType = "Scythe"; break;
    case BASE_ITEM_SHORTBOW      : sType = "Shortbow"; break;
    case BASE_ITEM_SHORTSPEAR    : sType = "Short Spear"; break;
    case BASE_ITEM_SHORTSWORD    : sType = "Short Sword"; break;
    case BASE_ITEM_SHURIKEN      : sType = "Shuriken"; break;
    case BASE_ITEM_SICKLE        : sType = "Sickle"; break;
    case BASE_ITEM_SLING         : sType = "Sling"; break;
    case BASE_ITEM_SMALLSHIELD   : sType = "Small Shield"; break;
    case BASE_ITEM_SPELLSCROLL   : sType = "Magical Scroll"; break;
    case BASE_ITEM_THIEVESTOOLS  : sType = "Thieves' Tools"; break;
    case BASE_ITEM_THROWINGAXE   : sType = "Throwing Axe"; break;
    case BASE_ITEM_TORCH         : sType = "Torch"; break;
    case BASE_ITEM_TOWERSHIELD   : sType = "Tower Shield"; break;
    case BASE_ITEM_TRAPKIT       : sType = "Trap Kit"; break;
    case BASE_ITEM_TWOBLADEDSWORD: sType = "Two-bladed Sword"; break;
    case BASE_ITEM_WARHAMMER     : sType = "Warhammer"; break;
    default                      : sType = "Object"; break;
  }
  return sType;
}

void MarkInv(object oContainer, int iStatus)
{
  //this marks all items in a chest to be autosplit
  //It is called from the chest's OnOpen event
  //only items with a pals_owner of 1 get split
  //
  //posible values for pals_owner are:
  // 0 = (default) never owned, don't autosplit. Useually something that starts on the ground
  // 1 = treasure, autosplit (marked in this proceedure
  // 2 = dropped by a pc, don't autosplit

  object oItem=GetFirstItemInInventory(oContainer);
  while(oItem!=OBJECT_INVALID)
  {
    //note this does not check for equiped items, but is designed for chests anyway
    //all container gold is given when object is opened so destroy it here
    if(GetTag(oItem)=="NW_IT_GOLD001")
      DestroyObject(oItem);
    else
      SetLocalInt(oItem,"pals_owner",iStatus);
    oItem=GetNextItemInInventory(oContainer);
  }
}


void AutoSplitItem(object oItem, object oPC)
{
  //this procedure splits items when they are picked up
  //only items with a pals_owner variable set to 1 will be picked up

  object oNewObject;

  //Don't distribute the item unless it has a tag of 1 (no tag indicates already owned)
  if(GetLocalInt(oItem,"pals_owner")==1)
  {
    int iNumPlayers = 1;
    int iShare;
    object oNextFactionMember;
    object oFactionLead=GetFirstFactionMember(oPC);
    string sName;

    //if identifed, get the name, otherwise, get the unideintifed base type
    if (GetIdentified(oItem))
      sName=GetName(oItem);
    else
      sName="Unidentifed "+GetUnidentifiedDescriptin(oItem);//"Unidentifed";

    //count people in the party
    while(GetNextFactionMember(oPC)!=OBJECT_INVALID)
      iNumPlayers++;

    //pick a random loot winner
    int x=Random(iNumPlayers)+1;
    int y=1;
    object oWinner=GetFirstFactionMember(oPC);
    while(y!=x)
    {
      oWinner=GetNextFactionMember(oPC);
      y++;
    }

    //if it is a plot item, give it to the person who picked it up
    if(GetPlotFlag(oItem))
      oWinner=oPC;

    //Give the item to the winner, unless the person who picks it up wins.
    //don't destroy/create if it goes to the person who picked it up (saves on spam)
    if(oWinner!=oPC)
    {
      oNewObject=CreateItemOnObject(GetTag(oItem),oWinner);
      SetLocalInt(oNewObject,"pals_owner",2);
      DestroyObject(oItem);
    } else
    {
      SetLocalInt(oItem,"pals_owner",2);
    }

    //Send message to whole party about who got what
    object oParty=GetFirstFactionMember(oPC);
    while(oParty!=OBJECT_INVALID)
    {
      SendMessageToPC(oParty,"The party has aquired an item ["+sName+"] which goes to "+GetName(oWinner));
      oParty=GetNextFactionMember(oPC);
    }
    //if it is a plot item, let the DM know it was picked up
    if(GetPlotFlag(oItem))
      SendMessageToAllDMs(GetName(oWinner)+" picked up the plot item: "+GetName(oItem));
  }
}

//Evenly distribute an amount of gold to all characters in oPC's party.
//Note that a few gold pieces may be created to make sure everyone gets an even share.
void AutoSplitGold(object oContainer, object oPC)
{
  //if there is no gold, don't split it
  if(GetGold(oContainer)==0) return;
  int iNumPlayers = 0;
  int iShare;

  //if pet or familiar kills the critter, assign to the master.
  if(!GetIsPC(oPC))
    oPC=GetMaster(oPC);

  //if the critter was not killed by a player, just drop the gold and don't distribute it
  if(!GetIsPC(oPC) || (oPC==OBJECT_INVALID))
    return; //not killed by a player;

  object oWinner=GetFirstFactionMember(oPC);
  int iGold=GetGold(oContainer);
  TakeGoldFromCreature(iGold,oContainer,TRUE);

  //if creatures possesess an item with the tag of NoGoldDrop, then don't drop gold on death
  if(GetItemPossessedBy(oContainer,"NoGoldDrop")!=OBJECT_INVALID)
    return;

  //count the players
  while(oWinner!=OBJECT_INVALID)
  {
    iNumPlayers++;
    oWinner=GetNextFactionMember(oPC);
  }

  if(iNumPlayers==0) iNumPlayers=1;//a divide by zero check
  iShare=FloatToInt(iGold/iNumPlayers+0.5);//calculate individule shares, round up

  //Hardcore character bonus.
  int nHardcore;

  if(iShare>0)
  {
    PlaySound("it_coins");
    oWinner=GetFirstFactionMember(oPC);
    while(oWinner!=OBJECT_INVALID)
    {
        SendMessageToPC(oWinner,"Your share of the party treasure is "+ IntToString(iShare) +" coins.");
        nHardcore = SQLocalsPlayer_GetInt(oWinner, "AM_HARDCORE");
        if(nHardcore == 1)
        {
            iShare = iShare * 3;
        }
        else
        {
            iShare= FloatToInt(iGold / iNumPlayers + 0.5);
        }
        GiveGoldToCreature(oWinner,iShare);
        oWinner=GetNextFactionMember(oPC);
    }
  }
}

