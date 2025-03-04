#include "NW_I0_GENERIC"
#include "nw_o2_coninclude"
#include "_incl_rndloc"
#include "i_battle"
#include "aww_inc_walkway"
void main()
{

object oPC = GetFirstPC();
object oArea = GetArea(oPC);
object oModule = GetModule();
int nHD = GetHitDice(OBJECT_SELF);
object oSpawner = GetNearestObjectByTag("spawner", GetFirstPC());
object oFacList;
string sName;
string sFaction;
int nIntensity = GetLocalInt(oPC, "nIntensity");
int nLimit = GetLocalInt(oSpawner, "nLimit") + nIntensity;
int nRandom;
int nRandPop = GetLocalInt(oArea, "nRandPop");
int nNewPop;
int nMaxDistance; //Maximum distance NPC will spawn.
int nMinDistance; //Minimum distance NPC will spawn.
location lLocation; //Location of an NPC spawn.

// Listen
SetListeningPatterns();
//Do the following only if we're in a battle mode.
//NOTE: Originally used built-in InBattle() function for this.
//However, this only checked battle status on spawn area.
//Always check battle status on PCs area.

//If this is a helicopter, raise it's Z height
if (GetTag(OBJECT_SELF) == "aa_heli_saracen")
    SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 5.0);

if (GetLocalInt(GetArea(oPC), "BattleStarted") == TRUE)
{

//Increment population count.
nNewPop = nHD + nRandPop;

//If the new value is higher than nLimit, immediately erase the creature.
if (nNewPop > nLimit)
    {
    DestroyObject(OBJECT_SELF);
    return;
    }

SetLocalInt(oArea, "nRandPop", nNewPop);

//Turn off looting.
SetLootable(OBJECT_SELF, FALSE);
SetIsDestroyable(TRUE, FALSE, FALSE);

////////////////DETERMINE STARTING EQUIPMENT//////////////////////////
//Get Faction
sFaction = GetLocalString(OBJECT_SELF, "sFaction");
oFacList = GetNearestObjectByTag(sFaction, oPC);

/*Check FacList Weapon Designation.
nRandomWeps = 0: Do nothing. Stick with creature's default starting gear.
nRandomWeps = 1; Select a starting weapon from the faction list.
nRandomWeps = 2; Select a completely random weapon.
                 Note that this can result in creatures getting weird gear,
                 like lightsabers, unless those items are deleted from the module.
*/
int nRandomWeps = GetLocalInt(oFacList, "nRandomWeps");

if (nRandomWeps == 1)
    {
    //Get weapon ResRef from FacList.
    int nWepLimit = GetLocalInt(oFacList, "nWepLimit");
    nRandom = Random(nWepLimit) + 1;
    string sWep = GetLocalString(oFacList, "nWep" + IntToString(nRandom));
    CreateItemOnObject(sWep, OBJECT_SELF);
    }

if (nRandomWeps == 2)
    {
    //Give this creature a random medeival weapon.
    nRandom = Random(3);

    if (nRandom == 0) CreateGenericSimple(OBJECT_SELF, oPC);

    if (nRandom == 1) CreateGenericExotic(OBJECT_SELF, oPC);

    if (nRandom == 2) CreateGenericMartial(OBJECT_SELF, oPC);
    }

////////////////DETERMINE STARTING LOCATION//////////////////////////
//We want to pick a random location that's somewhere around the player.
//The trick is, we need to find a spot that isn't inside a structure
//or too close to the PC. Having enemies spawn right next to the PC can
//cause an unfair challenge.

nMaxDistance = GetLocalInt(oSpawner, "nMaxDistance");
nMinDistance = GetLocalInt(oSpawner, "nMinDistance");

float fMinDistance = IntToFloat(nMinDistance);

lLocation = RndLoc(GetLocation(oPC), nMaxDistance, nMinDistance, BASE_SHAPE_CIRCLE);

float fPCDistance = GetDistanceBetweenLocations(lLocation, GetLocation(oPC));

//If this location is invalid, keep searching for a valid one.
while (GetAreaFromLocation(lLocation)==OBJECT_INVALID)
    {
    lLocation = RndLoc(GetLocation(oPC), nMaxDistance, nMinDistance, BASE_SHAPE_CIRCLE);
    fPCDistance = GetDistanceBetweenLocations(lLocation, GetLocation(oPC));
    }
//This means the NPCs can be spawned anywhere within set distance of the PC,
//but not on rooftops or otherwise in buildings.

//Now we at last send the chosen NPC to the chosen location.

DelayCommand(0.5, AssignCommand(OBJECT_SELF, ActionJumpToLocation(lLocation)));
DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectAppear(), OBJECT_SELF));

//DEBUG
//Display nRandPop
//string sRandPop = IntToString(nNewPop);
//SendMessageToPC(GetFirstPC(), GetName(OBJECT_SELF) +" spawned, nRandPop: " + sRandPop);
return;
}
aww_WalkWayPoints(FALSE, 0.5);
}
