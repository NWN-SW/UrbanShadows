void main()
{
    //Global variables
    object oItem = GetModuleItemAcquired();
    object oPC = GetModuleItemAcquiredBy();
    string sTag = GetTag(oItem);
    string sElement = GetStringLeft(sTag, 10);

    //FIRE
    //Fire focus local variables.
    if(GetIsPC(oPC) && sElement == "Focus_Fire")
    {
        string sCommFireVar = "COMM_FOCUS_FIRE";
        string sUncoFireVar = "UNCO_FOCUS_FIRE";
        string sRareFireVar = "RARE_FOCUS_FIRE";
        string sLegeFireVar = "LEGE_FOCUS_FIRE";

        int nCommFireVar = GetLocalInt(oPC, sCommFireVar);
        int nUncoFireVar = GetLocalInt(oPC, sUncoFireVar);
        int nRareFireVar = GetLocalInt(oPC, sRareFireVar);
        int nLegeFireVar = GetLocalInt(oPC, sLegeFireVar);

        //Fire focus counting up when acquired.
        if(sTag == "Focus_Fire_Comm")
        {
            nCommFireVar = nCommFireVar + 1;
            SetLocalInt(oPC, sCommFireVar, nCommFireVar);
        }
        else if(sTag == "Focus_Fire_Unco")
        {
            nUncoFireVar = nUncoFireVar + 1;
            SetLocalInt(oPC, sUncoFireVar, nUncoFireVar);
        }
        else if(sTag == "Focus_Fire_Rare")
        {
            nRareFireVar = nRareFireVar + 1;
            SetLocalInt(oPC, sRareFireVar, nRareFireVar);
        }
        else if(sTag == "Focus_Fire_Lege")
        {
            nLegeFireVar = nLegeFireVar + 1;
            SetLocalInt(oPC, sLegeFireVar, nLegeFireVar);
        }
    }

    //COLD
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Focus_Cold")
    {
        string sCommColdVar = "COMM_FOCUS_COLD";
        string sUncoColdVar = "UNCO_FOCUS_COLD";
        string sRareColdVar = "RARE_FOCUS_COLD";
        string sLegeColdVar = "LEGE_FOCUS_COLD";

        int nCommColdVar = GetLocalInt(oPC, sCommColdVar);
        int nUncoColdVar = GetLocalInt(oPC, sUncoColdVar);
        int nRareColdVar = GetLocalInt(oPC, sRareColdVar);
        int nLegeColdVar = GetLocalInt(oPC, sLegeColdVar);

        //Counting up when focus acquired.
        if(sTag == "Focus_Cold_Comm")
        {
            nCommColdVar = nCommColdVar + 1;
            SetLocalInt(oPC, sCommColdVar, nCommColdVar);
        }
        else if(sTag == "Focus_Cold_Unco")
        {
            nUncoColdVar = nUncoColdVar + 1;
            SetLocalInt(oPC, sUncoColdVar, nUncoColdVar);
        }
        else if(sTag == "Focus_Cold_Rare")
        {
            nRareColdVar = nRareColdVar + 1;
            SetLocalInt(oPC, sRareColdVar, nRareColdVar);
        }
        else if(sTag == "Focus_Cold_Lege")
        {
            nLegeColdVar = nLegeColdVar + 1;
            SetLocalInt(oPC, sLegeColdVar, nLegeColdVar);
        }
    }

    //ELEC
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Focus_Elec")
    {
        string sCommElecVar = "COMM_FOCUS_ELEC";
        string sUncoElecVar = "UNCO_FOCUS_ELEC";
        string sRareElecVar = "RARE_FOCUS_ELEC";
        string sLegeElecVar = "LEGE_FOCUS_ELEC";

        int nCommElecVar = GetLocalInt(oPC, sCommElecVar);
        int nUncoElecVar = GetLocalInt(oPC, sUncoElecVar);
        int nRareElecVar = GetLocalInt(oPC, sRareElecVar);
        int nLegeElecVar = GetLocalInt(oPC, sLegeElecVar);

        //Counting up when focus acquired.
        if(sTag == "Focus_Elec_Comm")
        {
            nCommElecVar = nCommElecVar + 1;
            SetLocalInt(oPC, sCommElecVar, nCommElecVar);
        }
        else if(sTag == "Focus_Elec_Unco")
        {
            nUncoElecVar = nUncoElecVar + 1;
            SetLocalInt(oPC, sUncoElecVar, nUncoElecVar);
        }
        else if(sTag == "Focus_Elec_Rare")
        {
            nRareElecVar = nRareElecVar + 1;
            SetLocalInt(oPC, sRareElecVar, nRareElecVar);
        }
        else if(sTag == "Focus_Elec_Lege")
        {
            nLegeElecVar = nLegeElecVar + 1;
            SetLocalInt(oPC, sLegeElecVar, nLegeElecVar);
        }
    }

    //ACID
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Focus_Acid")
    {
        string sCommAcidVar = "COMM_FOCUS_ACID";
        string sUncoAcidVar = "UNCO_FOCUS_ACID";
        string sRareAcidVar = "RARE_FOCUS_ACID";
        string sLegeAcidVar = "LEGE_FOCUS_ACID";

        int nCommAcidVar = GetLocalInt(oPC, sCommAcidVar);
        int nUncoAcidVar = GetLocalInt(oPC, sUncoAcidVar);
        int nRareAcidVar = GetLocalInt(oPC, sRareAcidVar);
        int nLegeAcidVar = GetLocalInt(oPC, sLegeAcidVar);

        //Counting up when focus acquired.
        if(sTag == "Focus_Acid_Comm")
        {
            nCommAcidVar = nCommAcidVar + 1;
            SetLocalInt(oPC, sCommAcidVar, nCommAcidVar);
        }
        else if(sTag == "Focus_Acid_Unco")
        {
            nUncoAcidVar = nUncoAcidVar + 1;
            SetLocalInt(oPC, sUncoAcidVar, nUncoAcidVar);
        }
        else if(sTag == "Focus_Acid_Rare")
        {
            nRareAcidVar = nRareAcidVar + 1;
            SetLocalInt(oPC, sRareAcidVar, nRareAcidVar);
        }
        else if(sTag == "Focus_Acid_Lege")
        {
            nLegeAcidVar = nLegeAcidVar + 1;
            SetLocalInt(oPC, sLegeAcidVar, nLegeAcidVar);
        }
    }

    //SONI
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Focus_Soni")
    {
        string sCommSoniVar = "COMM_FOCUS_SONI";
        string sUncoSoniVar = "UNCO_FOCUS_SONI";
        string sRareSoniVar = "RARE_FOCUS_SONI";
        string sLegeSoniVar = "LEGE_FOCUS_SONI";

        int nCommSoniVar = GetLocalInt(oPC, sCommSoniVar);
        int nUncoSoniVar = GetLocalInt(oPC, sUncoSoniVar);
        int nRareSoniVar = GetLocalInt(oPC, sRareSoniVar);
        int nLegeSoniVar = GetLocalInt(oPC, sLegeSoniVar);

        //Counting up when focus acquired.
        if(sTag == "Focus_Soni_Comm")
        {
            nCommSoniVar = nCommSoniVar + 1;
            SetLocalInt(oPC, sCommSoniVar, nCommSoniVar);
        }
        else if(sTag == "Focus_Soni_Unco")
        {
            nUncoSoniVar = nUncoSoniVar + 1;
            SetLocalInt(oPC, sUncoSoniVar, nUncoSoniVar);
        }
        else if(sTag == "Focus_Soni_Rare")
        {
            nRareSoniVar = nRareSoniVar + 1;
            SetLocalInt(oPC, sRareSoniVar, nRareSoniVar);
        }
        else if(sTag == "Focus_Soni_Lege")
        {
            nLegeSoniVar = nLegeSoniVar + 1;
            SetLocalInt(oPC, sLegeSoniVar, nLegeSoniVar);
        }
    }

    //MAGI
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Focus_Magi")
    {
        string sCommMagiVar = "COMM_FOCUS_MAGI";
        string sUncoMagiVar = "UNCO_FOCUS_MAGI";
        string sRareMagiVar = "RARE_FOCUS_MAGI";
        string sLegeMagiVar = "LEGE_FOCUS_MAGI";

        int nCommMagiVar = GetLocalInt(oPC, sCommMagiVar);
        int nUncoMagiVar = GetLocalInt(oPC, sUncoMagiVar);
        int nRareMagiVar = GetLocalInt(oPC, sRareMagiVar);
        int nLegeMagiVar = GetLocalInt(oPC, sLegeMagiVar);

        //Counting up when focus acquired.
        if(sTag == "Focus_Magi_Comm")
        {
            nCommMagiVar = nCommMagiVar + 1;
            SetLocalInt(oPC, sCommMagiVar, nCommMagiVar);
        }
        else if(sTag == "Focus_Magi_Unco")
        {
            nUncoMagiVar = nUncoMagiVar + 1;
            SetLocalInt(oPC, sUncoMagiVar, nUncoMagiVar);
        }
        else if(sTag == "Focus_Magi_Rare")
        {
            nRareMagiVar = nRareMagiVar + 1;
            SetLocalInt(oPC, sRareMagiVar, nRareMagiVar);
        }
        else if(sTag == "Focus_Magi_Lege")
        {
            nLegeMagiVar = nLegeMagiVar + 1;
            SetLocalInt(oPC, sLegeMagiVar, nLegeMagiVar);
        }
    }

    //HOLY
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Focus_Holy")
    {
        string sCommHolyVar = "COMM_FOCUS_HOLY";
        string sUncoHolyVar = "UNCO_FOCUS_HOLY";
        string sRareHolyVar = "RARE_FOCUS_HOLY";
        string sLegeHolyVar = "LEGE_FOCUS_HOLY";

        int nCommHolyVar = GetLocalInt(oPC, sCommHolyVar);
        int nUncoHolyVar = GetLocalInt(oPC, sUncoHolyVar);
        int nRareHolyVar = GetLocalInt(oPC, sRareHolyVar);
        int nLegeHolyVar = GetLocalInt(oPC, sLegeHolyVar);

        //Counting up when focus acquired.
        if(sTag == "Focus_Holy_Comm")
        {
            nCommHolyVar = nCommHolyVar + 1;
            SetLocalInt(oPC, sCommHolyVar, nCommHolyVar);
        }
        else if(sTag == "Focus_Holy_Unco")
        {
            nUncoHolyVar = nUncoHolyVar + 1;
            SetLocalInt(oPC, sUncoHolyVar, nUncoHolyVar);
        }
        else if(sTag == "Focus_Holy_Rare")
        {
            nRareHolyVar = nRareHolyVar + 1;
            SetLocalInt(oPC, sRareHolyVar, nRareHolyVar);
        }
        else if(sTag == "Focus_Holy_Lege")
        {
            nLegeHolyVar = nLegeHolyVar + 1;
            SetLocalInt(oPC, sLegeHolyVar, nLegeHolyVar);
        }
    }

    //NEGA
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Focus_Nega")
    {
        string sCommNegaVar = "COMM_FOCUS_NEGA";
        string sUncoNegaVar = "UNCO_FOCUS_NEGA";
        string sRareNegaVar = "RARE_FOCUS_NEGA";
        string sLegeNegaVar = "LEGE_FOCUS_NEGA";

        int nCommNegaVar = GetLocalInt(oPC, sCommNegaVar);
        int nUncoNegaVar = GetLocalInt(oPC, sUncoNegaVar);
        int nRareNegaVar = GetLocalInt(oPC, sRareNegaVar);
        int nLegeNegaVar = GetLocalInt(oPC, sLegeNegaVar);

        //Counting up when focus acquired.
        if(sTag == "Focus_Nega_Comm")
        {
            nCommNegaVar = nCommNegaVar + 1;
            SetLocalInt(oPC, sCommNegaVar, nCommNegaVar);
        }
        else if(sTag == "Focus_Nega_Unco")
        {
            nUncoNegaVar = nUncoNegaVar + 1;
            SetLocalInt(oPC, sUncoNegaVar, nUncoNegaVar);
        }
        else if(sTag == "Focus_Nega_Rare")
        {
            nRareNegaVar = nRareNegaVar + 1;
            SetLocalInt(oPC, sRareNegaVar, nRareNegaVar);
        }
        else if(sTag == "Focus_Nega_Lege")
        {
            nLegeNegaVar = nLegeNegaVar + 1;
            SetLocalInt(oPC, sLegeNegaVar, nLegeNegaVar);
        }
    }

    //SLASH
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Foc_Slash_")
    {
        string sCommNegaVar = "COMM_FOCUS_SLASH";
        string sUncoNegaVar = "UNCO_FOCUS_SLASH";
        string sRareNegaVar = "RARE_FOCUS_SLASH";
        string sLegeNegaVar = "LEGE_FOCUS_SLASH";

        int nCommNegaVar = GetLocalInt(oPC, sCommNegaVar);
        int nUncoNegaVar = GetLocalInt(oPC, sUncoNegaVar);
        int nRareNegaVar = GetLocalInt(oPC, sRareNegaVar);
        int nLegeNegaVar = GetLocalInt(oPC, sLegeNegaVar);

        //Counting up when focus acquired.
        if(sTag == "Foc_Slash_Comm")
        {
            nCommNegaVar = nCommNegaVar + 1;
            SetLocalInt(oPC, sCommNegaVar, nCommNegaVar);
        }
        else if(sTag == "Foc_Slash_Unco")
        {
            nUncoNegaVar = nUncoNegaVar + 1;
            SetLocalInt(oPC, sUncoNegaVar, nUncoNegaVar);
        }
        else if(sTag == "Foc_Slash_Rare")
        {
            nRareNegaVar = nRareNegaVar + 1;
            SetLocalInt(oPC, sRareNegaVar, nRareNegaVar);
        }
        else if(sTag == "Foc_Slash_Lege")
        {
            nLegeNegaVar = nLegeNegaVar + 1;
            SetLocalInt(oPC, sLegeNegaVar, nLegeNegaVar);
        }
    }

    //PIERCE
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Foc_Pierce")
    {
        string sCommNegaVar = "COMM_FOCUS_PIERCE";
        string sUncoNegaVar = "UNCO_FOCUS_PIERCE";
        string sRareNegaVar = "RARE_FOCUS_PIERCE";
        string sLegeNegaVar = "LEGE_FOCUS_PIERCE";

        int nCommNegaVar = GetLocalInt(oPC, sCommNegaVar);
        int nUncoNegaVar = GetLocalInt(oPC, sUncoNegaVar);
        int nRareNegaVar = GetLocalInt(oPC, sRareNegaVar);
        int nLegeNegaVar = GetLocalInt(oPC, sLegeNegaVar);

        //Counting up when focus acquired.
        if(sTag == "Foc_Pierce_Comm")
        {
            nCommNegaVar = nCommNegaVar + 1;
            SetLocalInt(oPC, sCommNegaVar, nCommNegaVar);
        }
        else if(sTag == "Foc_Pierce_Unco")
        {
            nUncoNegaVar = nUncoNegaVar + 1;
            SetLocalInt(oPC, sUncoNegaVar, nUncoNegaVar);
        }
        else if(sTag == "Foc_Pierce_Rare")
        {
            nRareNegaVar = nRareNegaVar + 1;
            SetLocalInt(oPC, sRareNegaVar, nRareNegaVar);
        }
        else if(sTag == "Foc_Pierce_Lege")
        {
            nLegeNegaVar = nLegeNegaVar + 1;
            SetLocalInt(oPC, sLegeNegaVar, nLegeNegaVar);
        }
    }

    //BLUDGE
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Foc_Bludge")
    {
        string sCommNegaVar = "COMM_FOCUS_BLUDGE";
        string sUncoNegaVar = "UNCO_FOCUS_BLUDGE";
        string sRareNegaVar = "RARE_FOCUS_BLUDGE";
        string sLegeNegaVar = "LEGE_FOCUS_BLUDGE";

        int nCommNegaVar = GetLocalInt(oPC, sCommNegaVar);
        int nUncoNegaVar = GetLocalInt(oPC, sUncoNegaVar);
        int nRareNegaVar = GetLocalInt(oPC, sRareNegaVar);
        int nLegeNegaVar = GetLocalInt(oPC, sLegeNegaVar);

        //Counting up when focus acquired.
        if(sTag == "Foc_Bludge_Comm")
        {
            nCommNegaVar = nCommNegaVar + 1;
            SetLocalInt(oPC, sCommNegaVar, nCommNegaVar);
        }
        else if(sTag == "Foc_Bludge_Unco")
        {
            nUncoNegaVar = nUncoNegaVar + 1;
            SetLocalInt(oPC, sUncoNegaVar, nUncoNegaVar);
        }
        else if(sTag == "Foc_Bludge_Rare")
        {
            nRareNegaVar = nRareNegaVar + 1;
            SetLocalInt(oPC, sRareNegaVar, nRareNegaVar);
        }
        else if(sTag == "Foc_Bludge_Lege")
        {
            nLegeNegaVar = nLegeNegaVar + 1;
            SetLocalInt(oPC, sLegeNegaVar, nLegeNegaVar);
        }
    }

    //SUMMON
    //Local variables.
    if(GetIsPC(oPC) && sElement == "Focus_Summ")
    {
        string sCommNegaVar = "COMM_FOCUS_SUMM";
        string sUncoNegaVar = "UNCO_FOCUS_SUMM";
        string sRareNegaVar = "RARE_FOCUS_SUMM";
        string sLegeNegaVar = "LEGE_FOCUS_SUMM";

        int nCommNegaVar = GetLocalInt(oPC, sCommNegaVar);
        int nUncoNegaVar = GetLocalInt(oPC, sUncoNegaVar);
        int nRareNegaVar = GetLocalInt(oPC, sRareNegaVar);
        int nLegeNegaVar = GetLocalInt(oPC, sLegeNegaVar);

        //Counting up when focus acquired.
        if(sTag == "Focus_Summ_Comm")
        {
            nCommNegaVar = nCommNegaVar + 1;
            SetLocalInt(oPC, sCommNegaVar, nCommNegaVar);
        }
        else if(sTag == "Focus_Summ_Unco")
        {
            nUncoNegaVar = nUncoNegaVar + 1;
            SetLocalInt(oPC, sUncoNegaVar, nUncoNegaVar);
        }
        else if(sTag == "Focus_Summ_Rare")
        {
            nRareNegaVar = nRareNegaVar + 1;
            SetLocalInt(oPC, sRareNegaVar, nRareNegaVar);
        }
        else if(sTag == "Focus_Summ_Lege")
        {
            nLegeNegaVar = nLegeNegaVar + 1;
            SetLocalInt(oPC, sLegeNegaVar, nLegeNegaVar);
        }
    }
}
