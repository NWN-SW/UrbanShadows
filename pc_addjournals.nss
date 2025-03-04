#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetEnteringObject();

    //Edinburgh - Fey Estate Quest, Pednant Quest
    int nFEY_EST_03 = SQLocalsPlayer_GetInt(oPC, "Q_FEYEST03");

    if(nFEY_EST_03 == 1)
        AddJournalQuestEntry("Q_FeyEst03", 1, oPC, FALSE);


    //Edinburgh - Fey Estate Quest, Questions Quest
    int nFEY_EST_02 = SQLocalsPlayer_GetInt(oPC, "Q_FEYEST02");

    if(nFEY_EST_03 == 1)
        AddJournalQuestEntry("Q_FeyEst02", 1, oPC, FALSE);


    //Edinburgh - Fey Estate Quest, Questgiver Sommerset, Goal Kill Handmaiden
    int nFEY_EST_01 = SQLocalsPlayer_GetInt(oPC, "Q_FEYEST01");

    if(nFEY_EST_01 == 1)
        AddJournalQuestEntry("Q_FeyEst01", 1, oPC, FALSE);
    else if(nFEY_EST_01 == 2)
        AddJournalQuestEntry("Q_FeyEst01", 2, oPC, FALSE);
    else if(nFEY_EST_01 == 3)
        AddJournalQuestEntry("Q_FeyEst01", 3, oPC, FALSE);
    else if(nFEY_EST_01 == 4)
        AddJournalQuestEntry("Q_FeyEst01", 4, oPC, FALSE);
    else if(nFEY_EST_01 == 5)
        AddJournalQuestEntry("Q_FeyEst01", 5, oPC, FALSE);
    else if(nFEY_EST_01 == 6)
        AddJournalQuestEntry("Q_FeyEst01", 6, oPC, FALSE);
    else if(nFEY_EST_01 == 7)
        AddJournalQuestEntry("Q_FeyEst01", 7, oPC, FALSE);
    else if(nFEY_EST_01 == 8)
        AddJournalQuestEntry("Q_FeyEst01", 8, oPC, FALSE);
    else if(nFEY_EST_01 == 9)
        AddJournalQuestEntry("Q_FeyEst01", 9, oPC, FALSE);
    else if(nFEY_EST_01 == 10)
        AddJournalQuestEntry("Q_FeyEst01", 10, oPC, FALSE);
    else if(nFEY_EST_01 == 11)
        AddJournalQuestEntry("Q_FeyEst01", 11, oPC, FALSE);
    else if(nFEY_EST_01 == 12)
        AddJournalQuestEntry("Q_FeyEst01", 12, oPC, FALSE);
    else if(nFEY_EST_01 == 13)
        AddJournalQuestEntry("Q_FeyEst01", 13, oPC, FALSE);
    else if(nFEY_EST_01 == 14)
        AddJournalQuestEntry("Q_FeyEst01", 14, oPC, FALSE);

    //Egypt - Missing Bee Quest
    int nMBEES = SQLocalsPlayer_GetInt(oPC, "Q_MBEES");

    if(nMBEES == 1)
        AddJournalQuestEntry("Q_MBees", 1, oPC, FALSE);
    else if(nMBEES == 2)
        AddJournalQuestEntry("Q_MBees", 2, oPC, FALSE);
    else if(nMBEES == 3)
        AddJournalQuestEntry("Q_MBees", 3, oPC, FALSE);
    else if(nMBEES == 4)
        AddJournalQuestEntry("Q_MBees", 4, oPC, FALSE);
    else if(nMBEES == 5)
        AddJournalQuestEntry("Q_MBees", 5, oPC, FALSE);
    else if(nMBEES == 6)
        AddJournalQuestEntry("Q_MBees", 6, oPC, FALSE);
    else if(nMBEES == 7)
        AddJournalQuestEntry("Q_MBees", 7, oPC, FALSE);

    //Egypt - Terra Tech Quest
    int nTT02 = SQLocalsPlayer_GetInt(oPC, "Q_FOTERRA2");

    if(nTT02 == 1)
        AddJournalQuestEntry("Q_FOTerra2", 1, oPC, FALSE);
    else if(nTT02 == 2)
        AddJournalQuestEntry("Q_FOTerra2", 2, oPC, FALSE);
    else if(nTT02 == 3)
        AddJournalQuestEntry("Q_FOTerra2", 3, oPC, FALSE);
    else if(nTT02 == 4)
        AddJournalQuestEntry("Q_FOTerra2", 4, oPC, FALSE);
    else if(nTT02 == 5)
        AddJournalQuestEntry("Q_FOTerra2", 5, oPC, FALSE);
    else if(nTT02 == 6)
        AddJournalQuestEntry("Q_FOTerra2", 6, oPC, FALSE);

    //Egypt - Dr. Khan Intro Quest
    int nTT01 = SQLocalsPlayer_GetInt(oPC, "Q_FOTERRA1");

    if(nTT01 == 1)
        AddJournalQuestEntry("Q_FOTerra1", 1, oPC, FALSE);
    else if(nTT01 == 2)
        AddJournalQuestEntry("Q_FOTerra1", 2, oPC, FALSE);


    //Edinburgh - Tunu Bargian Quest
    int nTunu01 = SQLocalsPlayer_GetInt(oPC, "THEBARGAIN");

    if(nTunu01 == 1)
        AddJournalQuestEntry("TheBargain", 1, oPC, FALSE);
    else if(nTunu01 == 2)
        AddJournalQuestEntry("TheBargain", 2, oPC, FALSE);

    //Edinburgh - Tunu F-Word Quest
    int nTunu02 = SQLocalsPlayer_GetInt(oPC, "TUNUFWORD");

    if(nTunu02 == 1)
        AddJournalQuestEntry("TunuFWord", 1, oPC, FALSE);
    else if(nTunu02 == 2)
        AddJournalQuestEntry("TunuFWord", 2, oPC, FALSE);



    //Minnesota Puzzles
    int nMN1 = SQLocalsPlayer_GetInt(oPC, "MINNESOTA_PUZZLE_1");
    int nMN2 = SQLocalsPlayer_GetInt(oPC, "MINNESOTA_PUZZLE_2");
    int nMN3 = SQLocalsPlayer_GetInt(oPC, "MINNESOTA_PUZZLE_3");
    int nMN4 = SQLocalsPlayer_GetInt(oPC, "MINNESOTA_PUZZLE_4");
    int nMN5 = SQLocalsPlayer_GetInt(oPC, "MINNESOTA_PUZZLE_5");
    int nMN6 = SQLocalsPlayer_GetInt(oPC, "MINNESOTA_PUZZLE_6");
    RemoveJournalQuestEntry("Minnesota_Puzzle", oPC, FALSE);

    if(nMN1 == 1 && nMN2 == 1 && nMN3 == 1 && nMN4 == 1 && nMN5 == 1 && nMN6 == 1)
    {
        AddJournalQuestEntry("Minnesota_Puzzle", 6, oPC, FALSE);
    }
    else if(nMN1 == 1 && nMN2 == 1 && nMN3 == 1 && nMN4 == 1 && nMN5 == 1 && nMN6 != 1)
    {
        AddJournalQuestEntry("Minnesota_Puzzle", 5, oPC, FALSE);
    }
    else if(nMN1 == 1 && nMN2 == 1 && nMN3 == 1 && nMN4 == 1 && nMN5 != 1 && nMN6 != 1)
    {
        AddJournalQuestEntry("Minnesota_Puzzle", 4, oPC, FALSE);
    }
    else if(nMN1 == 1 && nMN2 == 1 && nMN3 == 1 && nMN4 != 1 && nMN5 != 1 && nMN6 != 1)
    {
        AddJournalQuestEntry("Minnesota_Puzzle", 3, oPC, FALSE);
    }
    else if(nMN1 == 1 && nMN2 == 1 && nMN3 != 1 && nMN4 != 1 && nMN5 != 1 && nMN6 != 1)
    {
        AddJournalQuestEntry("Minnesota_Puzzle", 2, oPC, FALSE);
    }
    else if(nMN1 == 1 && nMN2 != 1 && nMN3 != 1 && nMN4 != 1 && nMN5 != 1 && nMN6 != 1)
    {
        AddJournalQuestEntry("Minnesota_Puzzle", 1, oPC, FALSE);
    }

    //Egypt Puzzles
    int nEG1 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_1");
    int nEG2 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_2");
    int nEG3 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_3");
    int nEG4 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_4");
    RemoveJournalQuestEntry("Egypt_Puzzle", oPC, FALSE);

    if(nEG1 == 1 && nEG2 == 1 && nEG3 == 1 && nEG4 == 1)
    {
        AddJournalQuestEntry("Egypt_Puzzle", 4, oPC, FALSE);
    }
    else if(nEG1 == 1 && nEG2 == 1 && nEG3 == 1 && nEG4 != 1)
    {
        AddJournalQuestEntry("Egypt_Puzzle", 3, oPC, FALSE);
    }
    else if(nEG1 == 1 && nEG2 == 1 && nEG3 != 1 && nEG4 != 1)
    {
        AddJournalQuestEntry("Egypt_Puzzle", 2, oPC, FALSE);
    }
    else if(nEG1 == 1 && nEG2 != 1 && nEG3 != 1 && nEG4 != 1)
    {
        AddJournalQuestEntry("Egypt_Puzzle", 1, oPC, FALSE);
    }

    //Parker Puzzles
    int nPMS1 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_1");
    int nPMS2 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_2");
    int nPMS3 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_3");
    int nPMS4 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_4");
    int nPMS5 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_5");
    int nPMS6 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_6");
    RemoveJournalQuestEntry("Parker_Puzzle", oPC, FALSE);

    if(nPMS1 == 1 && nPMS2 == 1 && nPMS3 == 1 && nPMS4 == 1 && nPMS5 == 1 && nPMS6 == 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 6, oPC, FALSE);
    }
    else if(nPMS1 == 1 && nPMS2 == 1 && nPMS3 == 1 && nPMS4 == 1 && nPMS5 == 1 && nPMS6 != 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 5, oPC, FALSE);
    }
    else if(nPMS1 == 1 && nPMS2 == 1 && nPMS3 == 1 && nPMS4 == 1 && nPMS5 != 1 && nPMS6 != 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 4, oPC, FALSE);
    }
    else if(nPMS1 == 1 && nPMS2 == 1 && nPMS3 == 1 && nPMS4 != 1 && nPMS5 != 1 && nPMS6 != 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 3, oPC, FALSE);
    }
    else if(nPMS1 == 1 && nPMS2 == 1 && nPMS3 != 1 && nPMS4 != 1 && nPMS5 != 1 && nPMS6 != 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 2, oPC, FALSE);
    }
    else if(nPMS1 == 1 && nPMS2 != 1 && nPMS3 != 1 && nPMS4 != 1 && nPMS5 != 1 && nPMS6 != 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 1, oPC, FALSE);
    }

    //Astoria Puzzles
    int nAST1 = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_1");
    int nAST2 = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_2");
    int nAST3 = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_3");
    int nAST4 = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_4");
    int nAST5 = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_5");
    int nAST6 = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_6");
    RemoveJournalQuestEntry("Astoria_Puzzle", oPC, FALSE);

    if(nAST1 == 1 && nAST2 == 1 && nAST3 == 1 && nAST4 == 1 && nAST5 == 1 && nAST6 == 1)
    {
        AddJournalQuestEntry("Astoria_Puzzle", 6, oPC, FALSE);
    }
    else if(nAST1 == 1 && nAST2 == 1 && nAST3 == 1 && nAST4 == 1 && nAST5 == 1 && nAST6 != 1)
    {
        AddJournalQuestEntry("Astoria_Puzzle", 5, oPC, FALSE);
    }
    else if(nAST1 == 1 && nAST2 == 1 && nAST3 == 1 && nAST4 == 1 && nAST5 != 1 && nAST6 != 1)
    {
        AddJournalQuestEntry("Astoria_Puzzle", 4, oPC, FALSE);
    }
    else if(nAST1 == 1 && nAST2 == 1 && nAST3 == 1 && nAST4 != 1 && nAST5 != 1 && nAST6 != 1)
    {
        AddJournalQuestEntry("Astoria_Puzzle", 3, oPC, FALSE);
    }
    else if(nAST1 == 1 && nAST2 == 1 && nAST3 != 1 && nAST4 != 1 && nAST5 != 1 && nAST6 != 1)
    {
        AddJournalQuestEntry("Astoria_Puzzle", 2, oPC, FALSE);
    }
    else if(nAST1 == 1 && nAST2 != 1 && nAST3 != 1 && nAST4 != 1 && nAST5 != 1 && nAST6 != 1)
    {
        AddJournalQuestEntry("Astoria_Puzzle", 1, oPC, FALSE);
    }

    //Russia Puzzle
    int nRU1 = SQLocalsPlayer_GetInt(oPC, "RUSSIA_PUZZLE_1");
    int nRU2 = SQLocalsPlayer_GetInt(oPC, "RUSSIA_PUZZLE_2");
    RemoveJournalQuestEntry("Russia_Puzzle", oPC, FALSE);

    if(nRU1 == 1 && nRU2 == 1)
    {
        AddJournalQuestEntry("Russia_Puzzle", 2, oPC, FALSE);
    }
    else if(nRU1 == 1 && nRU2 != 1)
    {
        AddJournalQuestEntry("Russia_Puzzle", 1, oPC, FALSE);
    }

    //Wendigo Puzzle
    int nWN1 = SQLocalsPlayer_GetInt(oPC, "CANNIBAL_PUZZLE");
    RemoveJournalQuestEntry("Cannibal_Puzzle", oPC, FALSE);
    if(nWN1 == 1)
    {
        AddJournalQuestEntry("Cannibal_Puzzle", 1, oPC, FALSE);
    }
    else if(nWN1 == 2)
    {
        AddJournalQuestEntry("Cannibal_Puzzle", 2, oPC, FALSE);
    }
    else if(nWN1 == 3)
    {
        AddJournalQuestEntry("Cannibal_Puzzle", 3, oPC, FALSE);
    }
    else if(nWN1 == 4)
    {
        AddJournalQuestEntry("Cannibal_Puzzle", 4, oPC, FALSE);
    }
    else if(nWN1 == 5)
    {
        AddJournalQuestEntry("Cannibal_Puzzle", 5, oPC, FALSE);
    }
    else if(nWN1 == 6)
    {
        AddJournalQuestEntry("Cannibal_Puzzle", 6, oPC, FALSE);
    }
    else if(nWN1 == 7)
    {
        AddJournalQuestEntry("Cannibal_Puzzle", 7, oPC, FALSE);
    }
    else if(nWN1 == 8)
    {
        AddJournalQuestEntry("Cannibal_Puzzle", 8, oPC, FALSE);
    }


    //Hardcore characters
    int nHardcore = SQLocalsPlayer_GetInt(oPC, "AM_HARDCORE");
    RemoveJournalQuestEntry("Hardcore_Journal", oPC, FALSE);

    if(nHardcore == 1)
    {
        AddJournalQuestEntry("Hardcore_Journal", 1, oPC, FALSE);
    }

    //Noobie quest
    int nNoobie = SQLocalsPlayer_GetInt(oPC, "NOOBIE_QUEST");
    RemoveJournalQuestEntry("Noobie_Quest", oPC, FALSE);

    if(nNoobie >= 1)
    {
        AddJournalQuestEntry("Noobie_Quest", nNoobie, oPC, FALSE);
    }

    //Faction Quest
    int nFaction = SQLocalsPlayer_GetInt(oPC, "FACTION_QUEST_1");
    RemoveJournalQuestEntry("Faction_Quest_1", oPC, FALSE);

    if(nFaction >= 1)
    {
        AddJournalQuestEntry("Faction_Quest_1", nFaction, oPC, FALSE);
    }

    //Prologue Quest
    int nIntro = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    RemoveJournalQuestEntry("Prologue_Quest", oPC, FALSE);
    if(nIntro >= 1)
    {
        AddJournalQuestEntry("Prologue_Quest", nIntro, oPC, FALSE);
    }

    //Gnome Quest
    int nGnome = SQLocalsPlayer_GetInt(oPC, "GNOME_QUEST");
    RemoveJournalQuestEntry("Gnome_Quest", oPC, FALSE);
    if(nGnome >= 1)
    {
        AddJournalQuestEntry("Gnome_Quest", nGnome, oPC, FALSE);
    }
}
