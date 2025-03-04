void main()
{
    string sTag = GetTag(OBJECT_SELF);

    int nAction = GetCurrentAction(OBJECT_SELF);
    if(nAction == ACTION_SIT)
    {
        return;
    }

    if(sTag == "Arawn")
    {
        ActionSit( GetNearestObjectByTag("Arawn_Chair"));
    }
    else if(sTag == "PubPatron1")
    {
        ActionSit( GetNearestObjectByTag("Pub_Chair_Mal"));
    }
    else if(sTag == "PubPatron2")
    {
        ActionSit( GetNearestObjectByTag("Pub_Chair_Fem"));
    }
    else if(sTag == "DragonRecruiter")
    {
        ActionSit( GetNearestObjectByTag("Dragon_Chair"));
    }
    else if(sTag == "TemplarRecruiter")
    {
        ActionSit( GetNearestObjectByTag("Templar_Chair"));
    }
    else if(sTag == "IlluminatiRecruiter")
    {
        ActionSit( GetNearestObjectByTag("Illuminati_Chair"));
    }
    else if(sTag == "CitizenM")
    {
        ActionSit( GetNearestObjectByTag("Citizen_ChairM"));
    }
    else if(sTag == "CitizenF")
    {
        ActionSit( GetNearestObjectByTag("Citizen_ChairF"));
    }
    else if(sTag == "CitizenM1")
    {
        ActionSit( GetNearestObjectByTag("Citizen_ChairM1"));
    }
    else if(sTag == "CitizenF1")
    {
        ActionSit( GetNearestObjectByTag("Citizen_ChairF1"));
    }
}
