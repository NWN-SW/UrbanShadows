//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2.
//:: NPC: Ana Catagena
//:: Location: Egypt
//:://////////////////////////////////////////////

//:: Check if character has gathered all the evidence during stage 2 and are now stage 3. If they are, they get a phonecall when they enter this trigger.
//:: Script requires that the invisible phone placable is near trigger.
//:: Script requires conversation file.

#include "nw_i0_tool"
#include "utl_i_sqlplayer"


void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
    {
        return;
    }

    int nCheck = SQLocalsPlayer_GetInt(oPC, "Q_FOTERRA2");
    string sAreaTag = GetTag(GetArea(OBJECT_SELF));

    if(nCheck == 3 && (sAreaTag == "OS_Egypt2ScorpionCave")) {
        string sConvo = "conv_q_foterra_1";
        //object oPhone = GetObjectByTag("CellPh_CoV2", 0);

        // Start the appropriate conversation between the target placable object and the player character.
        AssignCommand(oPC, ActionStartConversation(oPC, sConvo, TRUE, FALSE));
    }
}
