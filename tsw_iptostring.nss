string ItemPropertyToString(itemproperty ipItemProperty)
{
    int nIPType = GetItemPropertyType(ipItemProperty);
    string sName = GetStringByStrRef(StringToInt(Get2DAString("itempropdef", "GameStrRef", nIPType)));
    if(GetItemPropertySubType(ipItemProperty) != -1)//nosubtypes
    {
        string sSubTypeResRef = Get2DAString("itempropdef", "SubTypeResRef", nIPType);
        int nTlk = StringToInt(Get2DAString(sSubTypeResRef, "Name", GetItemPropertySubType(ipItemProperty)));
        if(nTlk > 0)
            sName += " " + GetStringByStrRef(nTlk);
    }
    if(GetItemPropertyParam1(ipItemProperty) != -1)
    {
        string sParamResRef = Get2DAString("iprp_paramtable", "TableResRef", GetItemPropertyParam1(ipItemProperty));
        if(Get2DAString("itempropdef", "SubTypeResRef", nIPType) != "" &&
           Get2DAString(Get2DAString("itempropdef", "SubTypeResRef", nIPType), "TableResRef", GetItemPropertyParam1(ipItemProperty)) != "")
            sParamResRef = Get2DAString(Get2DAString("itempropdef", "SubTypeResRef", nIPType), "TableResRef", GetItemPropertyParam1(ipItemProperty));
        int nTlk = StringToInt(Get2DAString(sParamResRef, "Name", GetItemPropertyParam1Value(ipItemProperty)));
        if(nTlk > 0)
            sName += " " + GetStringByStrRef(nTlk);
    }
    if(GetItemPropertyCostTable(ipItemProperty) != -1)
    {
        string sCostResRef = Get2DAString("iprp_costtable", "Name", GetItemPropertyCostTable(ipItemProperty));
        int nTlk = StringToInt(Get2DAString(sCostResRef, "Name", GetItemPropertyCostTableValue(ipItemProperty)));
        if(nTlk > 0)
            sName += " " + GetStringByStrRef(nTlk);
    }
    return sName;
}
