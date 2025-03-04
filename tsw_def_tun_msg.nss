void main()
{
    object oPC = GetEnteringObject();

    if(!GetIsPC(oPC))
    {
        return;
    }

    DelayCommand(5.0, FloatingTextStringOnCreature("You are surrounded by countless undead. Stand your ground and eliminate all enemies you encounter. If you leave this area for any reason, you will be unable to return. Good hunting.", oPC, FALSE));
}
