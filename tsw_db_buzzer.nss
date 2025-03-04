
//:: ///////////////////////////////////////////////
//:: ScriptName: tsw_db_buzzer
//:: Author: FallenDabus
//::
//:: This script handles the database functionaltiy for the Buzzer Tablet App.
//:: (...)
//:: //////////////////////////////////////////////


//:: ///////////////////////////////////////////////
//::
//:: DATABASE INFORMATION
//:: Database Name: "tsw_buzzm"
//::
//:: Column01 Name: "tag"
//:: Column01 Type: INTEGER
//:: Column01 Use:  Tag == Message Number. This is used to select messages and keeps track of their order.
//::
//:: Column02 Name: "msg_img"
//:: Column02 Type: Text
//:: Column02 Use:  Icon Name a message was posted with.
//::
//:: Column03 Name: "msg_usr"
//:: Column03 Type: Text
//:: Column03 Use:  User Name a message was posted with.
//::
//:: Column04 Name: "msg_txt"
//:: Column04 Type: Text
//:: Column04 Use:  Text a message was posted with.
//::
//:: Column05 Name: "date_day"
//:: Column05 Type: INTEGER
//:: Column05 Use:  Day the message was posted.
//::
//:: Column06 Name: "date_month"
//:: Column06 Type: INTEGER
//:: Column06 Use:  Month the message was posted.
//::
//:: Column07 Name: "date_year"
//:: Column07 Type: INTEGER
//:: Column07 Use:  Year the message was posted.
//::
//:: Column08 Name: "edited"
//:: Column08 Type: INTEGER
//:: Column08 Use:  Currently Unused. 0 = unedited, 1 = edited.
//::
//:: Column09 Name: "banned"
//:: Column09 Type: INTEGER
//:: Column09 Use:  Currently Unused. 0 = visible, 1 = dm banned message.
//::
//:: Column10 Name: "pc_id"
//:: Column10 Type: Text
//:: Column10 Use:  Tracks the character that posted the message.
//::
//:: Column11 Name: "player_id"
//:: Column11 Type: Text
//:: Column11 Use:  Tracks the player that posted the message.
//::
//:: //////////////////////////////////////////////


void app_buzzer_test(object oPC)
{

    // INFORMATION ON sqlquery function's STRUCTURE
    //                   SQLPrepareQueryCampaign used as it persists across resets
    //sqlquery myquery = SQLPrepareQueryCampaign "DB_NAME",
    //                                                          "select
    //                                                                  "ENTRY_COLUMN"
    //                                                                                  from "DBTable"
    //                                                                                          where tag = @
    //                                                                                                      "ENTRY_COLUMN_TAG" ");

    //1. Declaring Query.
    sqlquery myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");

    //2. Binding Query "@tag" = @ColumnWithNameTag, "1" EntryWithValue1InTagColumn
    SqlBindInt (myquery, "@tag", 1);

    //3. Executing Query.
    while (SqlStep(myquery)) {
        SendMessageToPC(oPC, "Message Reads: " + SqlGetString(myquery, 0));
    }
}
