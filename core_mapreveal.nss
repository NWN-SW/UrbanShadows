//Put this script OnEnter. Will reveal map on entering area. -Smirk
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

ExploreAreaForPlayer(GetArea(oPC), oPC);

}

