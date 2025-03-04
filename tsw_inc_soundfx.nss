// This function was intended a workaround for the awkwardness of waiting on action queues to play sounds - this
// was circumvented by making a dedicated sound player for each effect with no other actions to worry about.  This
// worked unreliably at best, and usually not at all.  Having autolooted placeable play sounds was similarly
// ineffective.  Re-assigning the sound player to the looting PC seems to work much better.  Reliability still seems
// to vary for other applications.
//
// oSoundPlayer - usually a PC.
// sSoundResRef - the resref of the sound fx you want to play (examples in dn_inc_soundfx)
//

/*
void PlaySoundFX( object oSoundPlayer, string sSoundResRef, float fDelay=0.0)
{
    AssignCommand( oSoundPlayer, DelayCommand( fDelay, PlaySound( sSoundResRef ) ) );
}
*/

void main()
{
    int nRandom = Random(2);
    if(nRandom == 0)
    {
        PlaySound("found_thing_1");
    }
    else if(nRandom == 1)
    {
        PlaySound("found_thing_2");
    }
}
