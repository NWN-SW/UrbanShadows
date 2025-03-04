void main()
{
    object oDoor = GetFirstObjectInArea(OBJECT_SELF);
    int nCheck = GetLocalInt(OBJECT_SELF, "PLACEABLE_PORTS_DONE");
    if(nCheck != 1)
    {
        while(oDoor != OBJECT_INVALID)
        {
            if(GetObjectType(oDoor) == OBJECT_TYPE_DOOR)
            {
                SetPortraitResRef(oDoor, "po_PLC_C10_");
            }
            if(GetObjectType(oDoor) == OBJECT_TYPE_PLACEABLE)
            {
                SetPortraitResRef(oDoor, "");
            }
            oDoor = GetNextObjectInArea(OBJECT_SELF);
        }
        SetLocalInt(OBJECT_SELF, "PLACEABLE_PORTS_DONE", 1);
    }
}
