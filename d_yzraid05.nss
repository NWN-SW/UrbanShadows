void animate(object oArcade) {
    int id = GetLocalInt(oArcade, "id");
    SetLocalInt(oArcade, "id", id + 1);
    string res = "d_yzraid" + IntToString(id % 4); // 9 is however many you have, 0..8 in this case
    ReplaceObjectTexture(oArcade, "d_yzraid05", res);
    DelayCommand(1.9f, animate(oArcade));
}

void main() {
    animate(OBJECT_SELF);
    SetEventScript(OBJECT_SELF, EVENT_SCRIPT_PLACEABLE_ON_HEARTBEAT, "");
}
