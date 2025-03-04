void main()
{
    object oUsing = GetLastUsedBy();
    object oPC;

    if(GetIsPC(oUsing))
    {
        SendMessageToPC(oUsing, "The voices of many gently speak in your mind, 'Ashes denote that fire was. Respect the grayest pile. For the departed creature's sake, that hoevered here a while. Offer your flame. For knowledge to gain and yearn. From fire I will grow. From ashes...' the voices pause, as if expecting you to finish.");
    }
}
