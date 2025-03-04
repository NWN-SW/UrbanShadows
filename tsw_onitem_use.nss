void main()
{
    //ID
    ExecuteScript("pc_idcard");
    //Dice Bag script
    ExecuteScript("rb_activate_item", OBJECT_SELF);
    //DM tool
    ExecuteScript("dm_wand_wngbye", OBJECT_SELF);
    //PC Med Kit
    ExecuteScript("pc_med_kit", OBJECT_SELF);
    //PC Recall
    ExecuteScript("pc_recall", OBJECT_SELF);
    //Main script
    ExecuteScript("x2_mod_def_act", OBJECT_SELF);
    //Parker Middle School Puzzle Step 1
    ExecuteScript("tsw_pmspz_check1", OBJECT_SELF);
    //Astoria puzzle sword
    ExecuteScript("tsw_astpz_4", OBJECT_SELF);
    //DM Kill Wand
    ExecuteScript("tsw_killwand");
    //Spell Mantle Kit
    ExecuteScript("pc_mantlekit");
    //Test Missiles
    ExecuteScript("tsw_tch_missiles");
    //Summon Command
    ExecuteScript("tsw_command_summ");
    //Trash Wand
    ExecuteScript("tsw_witchit_wand");
    //Lore Reputation Device
    ExecuteScript("tsw_lore_rep");
    //Emergency Beacon
    ExecuteScript("pc_emergency_bcn");
    //Anima Infusion
    ExecuteScript("pc_anima_potion");
    //Summon Field Agent
    ExecuteScript("tsw_fac_summon");
    //Summon Party Item
    ExecuteScript("tsw_reinforce_fc");
    //Anima Light
    ExecuteScript("tsw_anima_light");

    //Gnome stick
    ExecuteScript("tsw_gnmpz_boom");
    //Fey Wine
    ExecuteScript("tsw_feywine");

    //Tablets
    //ExecuteScript("tsw_onitem_tablet");

}
