//::///////////////////////////////////////////////
//:: Name x2_def_ondamage
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDamaged script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    //ExecuteScript("nw_c2_default6", OBJECT_SELF);
    ExecuteScript("j_ai_ondamaged", OBJECT_SELF);

    //Store last damage received
    int nDamaged = GetTotalDamageDealt();
    SetLocalInt(OBJECT_SELF, "LAST_DAMAGE_RECEIVED", nDamaged);
}
