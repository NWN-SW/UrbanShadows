//::///////////////////////////////////////////////
//:: FileName tsw_ast_wepcheck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ObsidianBlade"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "ObsidianHandle"))
        return FALSE;

    return TRUE;
}
