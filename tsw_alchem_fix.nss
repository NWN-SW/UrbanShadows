void main()
{
    //Global variables
    object oPC = GetLastUsedBy();
    if(oPC == OBJECT_INVALID)
    {
        oPC = OBJECT_SELF;
    }

    if(oPC != OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "The Alchemite fix has run. Please relog to apply the fix.");
    }

    //FIRE
    //Fire focus local variables.
    string sCommFireVar = "COMM_FOCUS_FIRE";
    string sUncoFireVar = "UNCO_FOCUS_FIRE";
    string sRareFireVar = "RARE_FOCUS_FIRE";
    string sLegeFireVar = "LEGE_FOCUS_FIRE";

    SetLocalInt(oPC, sCommFireVar, 0);
    SetLocalInt(oPC, sUncoFireVar, 0);
    SetLocalInt(oPC, sRareFireVar, 0);
    SetLocalInt(oPC, sLegeFireVar, 0);

    //COLD
    //Local variables.
    string sCommColdVar = "COMM_FOCUS_COLD";
    string sUncoColdVar = "UNCO_FOCUS_COLD";
    string sRareColdVar = "RARE_FOCUS_COLD";
    string sLegeColdVar = "LEGE_FOCUS_COLD";

    SetLocalInt(oPC, sCommColdVar, 0);
    SetLocalInt(oPC, sUncoColdVar, 0);
    SetLocalInt(oPC, sRareColdVar, 0);
    SetLocalInt(oPC, sLegeColdVar, 0);

    //ELEC
    //Local variables.
    string sCommElecVar = "COMM_FOCUS_ELEC";
    string sUncoElecVar = "UNCO_FOCUS_ELEC";
    string sRareElecVar = "RARE_FOCUS_ELEC";
    string sLegeElecVar = "LEGE_FOCUS_ELEC";

    SetLocalInt(oPC, sCommElecVar, 0);
    SetLocalInt(oPC, sUncoElecVar, 0);
    SetLocalInt(oPC, sRareElecVar, 0);
    SetLocalInt(oPC, sLegeElecVar, 0);

    //ACID
    //Local variables.
    string sCommAcidVar = "COMM_FOCUS_ACID";
    string sUncoAcidVar = "UNCO_FOCUS_ACID";
    string sRareAcidVar = "RARE_FOCUS_ACID";
    string sLegeAcidVar = "LEGE_FOCUS_ACID";

    SetLocalInt(oPC, sCommAcidVar, 0);
    SetLocalInt(oPC, sUncoAcidVar, 0);
    SetLocalInt(oPC, sRareAcidVar, 0);
    SetLocalInt(oPC, sLegeAcidVar, 0);

    //SONI
    //Local variables.
    string sCommSoniVar = "COMM_FOCUS_SONI";
    string sUncoSoniVar = "UNCO_FOCUS_SONI";
    string sRareSoniVar = "RARE_FOCUS_SONI";
    string sLegeSoniVar = "LEGE_FOCUS_SONI";

    SetLocalInt(oPC, sCommSoniVar, 0);
    SetLocalInt(oPC, sUncoSoniVar, 0);
    SetLocalInt(oPC, sRareSoniVar, 0);
    SetLocalInt(oPC, sLegeSoniVar, 0);

    //MAGI
    //Local variables.
    string sCommMagiVar = "COMM_FOCUS_MAGI";
    string sUncoMagiVar = "UNCO_FOCUS_MAGI";
    string sRareMagiVar = "RARE_FOCUS_MAGI";
    string sLegeMagiVar = "LEGE_FOCUS_MAGI";

    SetLocalInt(oPC, sCommMagiVar, 0);
    SetLocalInt(oPC, sUncoMagiVar, 0);
    SetLocalInt(oPC, sRareMagiVar, 0);
    SetLocalInt(oPC, sLegeMagiVar, 0);

    //HOLY
    //Local variables.
    string sCommHolyVar = "COMM_FOCUS_HOLY";
    string sUncoHolyVar = "UNCO_FOCUS_HOLY";
    string sRareHolyVar = "RARE_FOCUS_HOLY";
    string sLegeHolyVar = "LEGE_FOCUS_HOLY";

    SetLocalInt(oPC, sCommHolyVar, 0);
    SetLocalInt(oPC, sUncoHolyVar, 0);
    SetLocalInt(oPC, sRareHolyVar, 0);
    SetLocalInt(oPC, sLegeHolyVar, 0);

    //NEGA
    //Local variables.
    string sCommNegaVar = "COMM_FOCUS_NEGA";
    string sUncoNegaVar = "UNCO_FOCUS_NEGA";
    string sRareNegaVar = "RARE_FOCUS_NEGA";
    string sLegeNegaVar = "LEGE_FOCUS_NEGA";

    SetLocalInt(oPC, sCommNegaVar, 0);
    SetLocalInt(oPC, sUncoNegaVar, 0);
    SetLocalInt(oPC, sRareNegaVar, 0);
    SetLocalInt(oPC, sLegeNegaVar, 0);


    //Slash
    string sCommVar = "COMM_FOCUS_SLASH";
    string sUncoVar = "UNCO_FOCUS_SLASH";
    string sRareVar = "RARE_FOCUS_SLASH";
    string sLegeVar = "LEGE_FOCUS_SLASH";
    SetLocalInt(oPC, sCommVar, 0);
    SetLocalInt(oPC, sUncoVar, 0);
    SetLocalInt(oPC, sRareVar, 0);
    SetLocalInt(oPC, sLegeVar, 0);

    //Pierce
    sCommVar = "COMM_FOCUS_PIERCE";
    sUncoVar = "UNCO_FOCUS_PIERCE";
    sRareVar = "RARE_FOCUS_PIERCE";
    sLegeVar = "LEGE_FOCUS_PIERCE";
    SetLocalInt(oPC, sCommVar, 0);
    SetLocalInt(oPC, sUncoVar, 0);
    SetLocalInt(oPC, sRareVar, 0);
    SetLocalInt(oPC, sLegeVar, 0);


    //Bludge
    sCommVar = "COMM_FOCUS_BLUDGE";
    sUncoVar = "UNCO_FOCUS_BLUDGE";
    sRareVar = "RARE_FOCUS_BLUDGE";
    sLegeVar = "LEGE_FOCUS_BLUDGE";
    SetLocalInt(oPC, sCommVar, 0);
    SetLocalInt(oPC, sUncoVar, 0);
    SetLocalInt(oPC, sRareVar, 0);
    SetLocalInt(oPC, sLegeVar, 0);
}
