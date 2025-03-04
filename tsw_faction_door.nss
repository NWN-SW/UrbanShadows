#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    string sFaction = GetFaction(oPC);
    string sDoor = GetLocalString(OBJECT_SELF, "MAIN_FACTION_DOOR");
    object oWP;
    location lWP;

    if(sFaction == "Templar" && sDoor == "Templar")
    {
        oWP = GetWaypointByTag("Templar_Entrance");
        lWP = GetLocation(oWP);
        AssignCommand(oPC, ActionJumpToObject(oWP));
    }
    else if(sFaction == "Dragon" && sDoor == "Dragon")
    {
        oWP = GetWaypointByTag("Dragon_Entrance");
        lWP = GetLocation(oWP);
        AssignCommand(oPC, ActionJumpToObject(oWP));
    }
    else if(sFaction == "Illuminati" && sDoor == "Illuminati")
    {
        oWP = GetWaypointByTag("Illuminati_Entrance");
        lWP = GetLocation(oWP);
        AssignCommand(oPC, ActionJumpToObject(oWP));
    }

    else if (sDoor == "EgyptOasis")
    {
        oWP = GetWaypointByTag("EgpO_Entry");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

      else if (sDoor == "EdinGlaistig")
    {
        oWP = GetWaypointByTag("EdinSelkieIn");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

      else if (sDoor == "EdinSelkie")
    {
        oWP = GetWaypointByTag("EdinGlaistigIn");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

  else if (sDoor == "EdinSewersA")
    {
        oWP = GetWaypointByTag("EdinSewersAIn");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

  else if (sDoor == "EdinSewersB")
    {
        oWP = GetWaypointByTag("EdinSewersBIn");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

  else if (sDoor == "GlaistigSewers1")
    {
        oWP = GetWaypointByTag("GlaistigSewers1In");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

  else if (sDoor == "GlaistigSewers2")
    {
        oWP = GetWaypointByTag("GlaistigSewers2In");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

  else if (sDoor == "GlaistigSewers3")
    {
        oWP = GetWaypointByTag("GlaistigSewers3In");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "GlaistigSewers1L")
    {
        oWP = GetWaypointByTag("GlaistigSewers1LIn");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "GlaistigSewers2L")
    {
        oWP = GetWaypointByTag("GlaistigSewers2LIn");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "GlaistigSewers3L")
    {
        oWP = GetWaypointByTag("GlaistigSewers3LIn");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }


 else if (sDoor == "ast_sewer_s_hosb")
    {
        oWP = GetWaypointByTag("ast_sewer_s_hosbwp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_hosb_sewer_s")
    {
        oWP = GetWaypointByTag("ast_hosb_sewer_swp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }


 else if (sDoor == "ast_ssewer1_scity1")
    {
        oWP = GetWaypointByTag("ast_ssewer1_scity1_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_scity1_ssewer1")
    {
        oWP = GetWaypointByTag("ast_scity1_ssewer1_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_ssewer2_scity2")
    {
        oWP = GetWaypointByTag("ast_ssewer2_scity2_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_scity2_ssewer2")
    {
        oWP = GetWaypointByTag("ast_scity2_ssewer2_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_ssewer3_scity3")
    {
        oWP = GetWaypointByTag("ast_ssewer3_scity3_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_scity3_ssewer3")
    {
        oWP = GetWaypointByTag("ast_scity3_ssewer3_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_ssewer4_scity4")
    {
        oWP = GetWaypointByTag("ast_ssewer4_scity4_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_scity4_ssewer4")
    {
        oWP = GetWaypointByTag("ast_scity4_ssewer4_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_ssewer5_scity5")
    {
        oWP = GetWaypointByTag("ast_ssewer5_scity5_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_scity5_ssewer5")
    {
        oWP = GetWaypointByTag("ast_scity5_ssewer5_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }




 else if (sDoor == "ast_nsewer_ncity1")
    {
        oWP = GetWaypointByTag("ast_nsewer_ncity1_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_ncity_nsewer1")
    {
        oWP = GetWaypointByTag("ast_ncity_nsewer1_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_nsewer_ncity2")
    {
        oWP = GetWaypointByTag("ast_nsewer_ncity2_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_ncity_nsewer2")
    {
        oWP = GetWaypointByTag("ast_ncity_nsewer2_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_nsewer_ncity3")
    {
        oWP = GetWaypointByTag("ast_nsewer_ncity3_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

 else if (sDoor == "ast_ncity_nsewer3")
    {
        oWP = GetWaypointByTag("ast_ncity_nsewer3_wp");
        lWP = GetLocation(oWP);
        AssignCommand (oPC, ActionJumpToObject(oWP));
    }

}
