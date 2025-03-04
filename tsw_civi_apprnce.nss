void main()
{
    int nGender = GetGender(OBJECT_SELF);
    int nMale = 267 + Random(18);
    int nFemale = 255 + Random(12);
    if(nGender == GENDER_MALE)
    {
        SetCreatureAppearanceType(OBJECT_SELF, nMale);
    }
    else if(nGender == GENDER_FEMALE)
    {
        SetCreatureAppearanceType(OBJECT_SELF, nFemale);
    }

    //Send message to players
    object oPC = GetFirstPC();
    while(oPC != OBJECT_INVALID)
    {
        if(GetArea(oPC) == GetArea(OBJECT_SELF))
        {
            SendMessageToPC(oPC, "Your comms device alerts you, 'A civilian needs help in this area.'");
            AssignCommand(oPC, DelayCommand(1.0, PlaySound("found_thing_3")));
        }
        oPC = GetNextPC();
    }
}
