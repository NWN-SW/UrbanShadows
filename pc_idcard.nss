#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oitem = GetItemActivated();
    string tag = GetResRef(oitem);


    if(tag == "ftoken_dragon" || tag == "ftoken_illum" || tag == "ftoken_templar") {

        object oPC = GetItemActivator();
        string sName = GetName(oPC);
        string fact = GetFaction(oPC);
        int rank = GetRank(oPC);

         string message = sName + " flashes their ID with a deft flick of their fingers, revealing them to be a member of the " + fact + " and currently of rank " + IntToString(rank)+".";

         object oReceiver = GetFirstPC();
         while(oReceiver != OBJECT_INVALID) {

            if(GetDistanceBetween(oPC,oReceiver) <= 5.0)  {
              SendMessageToPC(oReceiver,message);
            }
            oReceiver = GetNextPC();
          }
    }

    return;


}
