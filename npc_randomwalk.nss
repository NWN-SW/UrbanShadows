void main()
{
    string sMage = GetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND);
    if(sMage != "tsw_mage_chase")
    {
        ActionRandomWalk();
    }
    ExecuteScript("npc_ai_default", OBJECT_SELF);
    ExecuteScript("tsw_scale_npcs", OBJECT_SELF);
}
