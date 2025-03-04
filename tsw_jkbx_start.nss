void main()
{
  object oPC = GetLastUsedBy();
  AssignCommand(OBJECT_SELF, ActionStartConversation(oPC, "tsw_jukebox", FALSE, FALSE));
}
