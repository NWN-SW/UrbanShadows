const int CLASS_TYPE_TECH = 43;

int GetMartialLevel(object oPC)
{
        //Get the total martial class levels.
    int nClassTotal = GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) +
                    GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oPC) +
                    GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) +
                    GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) +
                    GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC) +
                    GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPC) +
                    GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER, oPC) +
                    GetLevelByClass(CLASS_TYPE_FIGHTER, oPC) +
                    GetLevelByClass(CLASS_TYPE_HARPER, oPC) +
                    GetLevelByClass(CLASS_TYPE_MONK, oPC) +
                    GetLevelByClass(CLASS_TYPE_PALADIN, oPC) +
                    GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPC) +
                    GetLevelByClass(CLASS_TYPE_ROGUE, oPC) +
                    GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC) +
                    GetLevelByClass(CLASS_TYPE_SHIFTER, oPC) +
                    GetLevelByClass(CLASS_TYPE_WEAPON_MASTER, oPC) +
                    GetLevelByClass(CLASS_TYPE_TECH, oPC) +
                    GetLevelByClass(CLASS_TYPE_RANGER, oPC);

    return nClassTotal;
}
