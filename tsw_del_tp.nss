#include "nwnx_admin"
#include "utl_i_sqlplayer"

void JumpToDelArea()
{

    JumpToObject(GetWaypointByTag("dreamspawn"));

}

void main()
{

    AssignCommand(OBJECT_SELF, JumpToDelArea());

    if (GetLocalInt(OBJECT_SELF,"iMarkedForDeath") !=1)
    {
        SetLocalInt(OBJECT_SELF,"iMarkedForDeath",1);
        SQLocalsPlayer_SetInt(OBJECT_SELF,"iMarkedForDeath",1);
        SetXP(OBJECT_SELF,1);
    }
}
