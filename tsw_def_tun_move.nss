void main()
{
    string sResRef = GetResRef(OBJECT_SELF);
    if(sResRef == "def_tun_1" || sResRef == "def_tun_2" ||
       sResRef == "def_tun_3" || sResRef == "def_tun_4" ||
       sResRef == "def_tun_5" || sResRef == "def_tun_6" ||
       sResRef == "def_tun_7")
    {
        if(!GetIsInCombat(OBJECT_SELF) && GetCurrentAction(OBJECT_SELF) != ACTION_MOVETOPOINT)
        {
            object oWP = GetWaypointByTag("WP_Tunnel_Center");
            location lLoc = GetLocation(oWP);

            ClearAllActions();
            AssignCommand(OBJECT_SELF, ActionMoveToLocation(lLoc));
        }
    }
}
