void main()
{
    object oSound = GetNearestObjectByTag("Horror_Moans_1", OBJECT_SELF);
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC))
    {
        SoundObjectPlay(oSound);
    }
}
