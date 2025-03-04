#include "utl_i_sqlplayer"
#include "tsw_faction_func"
#include "nw_i0_tool"
//::///////////////////////////////////////////////
//:: FileName tsw_factoken_te2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: FallenDAbus
//:://////////////////////////////////////////////

//this can be removed once all the old characters have received their tokens,
//as the recruiters also give them on joining.

void main()
{
    string sFaction = GetFaction(GetPCSpeaker());

    //templar faction token
    if(sFaction == "Templar" && !HasItem(GetPCSpeaker(), "ftoken_templar"))
    {
        if (sFaction != "Illuminati" || sFaction != "Dragon")
        {
        CreateItemOnObject("ftoken_templar", GetPCSpeaker());
        }
    }

    //illuminati faction token
    if(sFaction == "Illuminati" && !HasItem(GetPCSpeaker(), "ftoken_illum"))
       {
           if (sFaction != "Templar" || sFaction != "Dragon")
           {
           CreateItemOnObject("ftoken_illum", GetPCSpeaker());
           }
       }


     //dragon faction token
     if(sFaction == "Dragon" && !HasItem(GetPCSpeaker(), "ftoken_dragon"))
     {
           if (sFaction != "Illuminati" || sFaction != "Templar")
           {
           CreateItemOnObject("ftoken_dragon", GetPCSpeaker());
           }
     }


}



