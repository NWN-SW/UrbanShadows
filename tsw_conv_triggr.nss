void TriggerConv(object oPC, string sConvTrigger)
{

    BeginConversation(sConvTrigger, oPC);
}

void main()
{

    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) && GetIsObjectValid(oPC))
    {
     AssignCommand(oPC, TriggerConv(oPC,"tsw_conv_trigger"));
    }
}
