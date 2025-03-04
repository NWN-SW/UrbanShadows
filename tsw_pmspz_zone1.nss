#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
    {
        return;
    }

    SetLocalInt(oPC, "PMS_P_1_IN", 1);
}
