void main()
{
    string sMessage = GetPCChatMessage();
    object oPC = GetPCChatSpeaker();
    if(sMessage == "*stance arcane")
    {
        SetPhenoType(54, oPC);
    }
    else if(sMessage == "*stance kensei")
    {
        SetPhenoType(50, oPC);
    }
    else if(sMessage == "*stance ninja")
    {
        SetPhenoType(51, oPC);
    }
    else if(sMessage == "*stance fencing")
    {
        SetPhenoType(53, oPC);
    }
    else if(sMessage == "*stance heavy")
    {
        SetPhenoType(52, oPC);
    }
    else if(sMessage == "*stance demonblade")
    {
        SetPhenoType(55, oPC);
    }
    else if(sMessage == "*stance warrior")
    {
        SetPhenoType(56, oPC);
    }
    else if(sMessage == "*stance tigerfang")
    {
        SetPhenoType(57, oPC);
    }
    else if(sMessage == "*stance sunfist")
    {
        SetPhenoType(58, oPC);
    }
    else if(sMessage == "*stance dragonpalm")
    {
        SetPhenoType(59, oPC);
    }
    else if(sMessage == "*stance bearclaw")
    {
        SetPhenoType(60, oPC);
    }
    else if(sMessage == "*stance big")
    {
        SetPhenoType(2, oPC);
    }
    else if(sMessage == "*stance normal")
    {
        SetPhenoType(0, oPC);
    }
}
