#include "x3_inc_string"

void main()
{
    //Prefixes
    string sPrefix1 = "He Who";
    string sPrefix2 = "She Who";
    string sPrefix3 = "It That";
    string sPrefix4 = "He That";
    string sPrefix5 = "She That";

    //Suffixes
    string sSuffix1 = "Craves";
    string sSuffix2 = "Desires";
    string sSuffix3 = "Feasts";
    string sSuffix4 = "Wounds";
    string sSuffix5 = "Grins";
    string sSuffix6 = "Maims";
    string sSuffix7 = "Wants";
    string sSuffix8 = "Needs";
    string sSuffix9 = "Rends";
    string sSuffix10 = "Screams";
    string sSuffix11 = "Consumes";
    string sSuffix12 = "Drowns The Light";
    string sSuffix13 = "Calls";
    string sSuffix14 = "Loathes";
    string sSuffix15 = "Wails";
    string sSuffix16 = "Covets Creation";
    string sSuffix17 = "Brings The Void";
    string sSuffix18 = "Wakes Them";
    string sSuffix19 = "Calls The Weak";
    string sSuffix20 = "Corrupts The Strong";
    string sSuffix21 = "Pierces The Mind";
    string sSuffix22 = "Crawls";
    string sSuffix23 = "Sings";
    string sSuffix24 = "Bends Perception";
    string sSuffix25 = "Weaves The Stars";
    string sSuffix26 = "Devours";
    string sSuffix27 = "Gathers";
    string sSuffix28 = "Decays";
    string sSuffix29 = "Breeds";
    string sSuffix30 = "Destroys";
    string sSuffix31 = "Obliterates";
    string sSuffix32 = "Annhiliates";
    string sSuffix33 = "Saves The Wicked";
    string sSuffix34 = "Protects The Wrong";
    string sSuffix35 = "Guards The Corrupt";
    string sSuffix36 = "Brings The Pain";
    string sSuffix37 = "Rends The Sky";
    string sSuffix38 = "Calls For Them";
    string sSuffix39 = "Makes Way";

    //Name Numbers
    int iPrefix = Random(5);
    int iSuffix = Random(39);

    //Name Picker - Prefix
    string sPrefixMain = "";
    switch (iPrefix)
    {
        case 0:
            sPrefixMain = sPrefix1;
            break;
        case 1:
            sPrefixMain = sPrefix2;
            break;
        case 2:
            sPrefixMain = sPrefix3;
            break;
        case 3:
            sPrefixMain = sPrefix4;
            break;
        case 4:
            sPrefixMain = sPrefix5;
            break;
    }

    //Name Picker - Suffix
    string sSuffixMain = "";
    switch (iSuffix)
    {
        case 0:
            sSuffixMain = sSuffix1;
            break;
        case 1:
            sSuffixMain = sSuffix2;
            break;
        case 2:
            sSuffixMain = sSuffix3;
            break;
        case 3:
            sSuffixMain = sSuffix4;
            break;
        case 4:
            sSuffixMain = sSuffix5 ;
            break;
        case 5:
            sSuffixMain = sSuffix6 ;
            break;
        case 6:
            sSuffixMain = sSuffix7;
            break;
        case 7:
            sSuffixMain = sSuffix8;
            break;
        case 8:
            sSuffixMain = sSuffix9;
            break;
        case 9:
            sSuffixMain = sSuffix10;
            break;
        case 10:
            sSuffixMain = sSuffix11;
            break;
        case 11:
            sSuffixMain = sSuffix12;
            break;
        case 12:
            sSuffixMain = sSuffix13;
            break;
        case 13:
            sSuffixMain = sSuffix14;
            break;
        case 14:
            sSuffixMain = sSuffix15;
            break;
        case 15:
            sSuffixMain = sSuffix16;
            break;
        case 16:
            sSuffixMain = sSuffix17;
            break;
        case 17:
            sSuffixMain = sSuffix18;
            break;
        case 18:
            sSuffixMain = sSuffix19;
            break;
        case 19:
            sSuffixMain = sSuffix20;
            break;
        case 20:
            sSuffixMain = sSuffix21;
            break;
        case 21:
            sSuffixMain = sSuffix22;
            break;
        case 22:
            sSuffixMain = sSuffix23;
            break;
        case 23:
            sSuffixMain = sSuffix24;
            break;
        case 24:
            sSuffixMain = sSuffix25;
            break;
        case 25:
            sSuffixMain = sSuffix26;
            break;
        case 26:
            sSuffixMain = sSuffix27;
            break;
        case 27:
            sSuffixMain = sSuffix28;
            break;
        case 28:
            sSuffixMain = sSuffix29;
            break;
        case 29:
            sSuffixMain = sSuffix30;
            break;
        case 30:
            sSuffixMain = sSuffix31;
            break;
        case 31:
            sSuffixMain = sSuffix32;
            break;
        case 32:
            sSuffixMain = sSuffix33;
            break;
        case 33:
            sSuffixMain = sSuffix34;
            break;
        case 34:
            sSuffixMain = sSuffix35;
            break;
        case 35:
            sSuffixMain = sSuffix36;
            break;
        case 36:
            sSuffixMain = sSuffix37;
            break;
        case 37:
            sSuffixMain = sSuffix38;
            break;
        case 38:
            sSuffixMain = sSuffix39;
            break;
    }

    int iLength = GetStringLength(sPrefixMain);
    string sFullName = sPrefixMain + " " + sSuffixMain;
    SetName(OBJECT_SELF, StringToRGBString(sFullName, STRING_COLOR_RED));
    //SetLocalString(OBJECT_SELF, "BOSS_TITLE", sTitleMain);
}
