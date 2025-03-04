void main()
{
    string sTag = GetTag(OBJECT_SELF);
    if(sTag == "SumD_GateDemon_2" || sTag == "SumD_GateDemon_1")
    {
        SetObjectVisualTransform(OBJECT_SELF, 10, 1.3);
    }

    if(sTag == "SumN_BindAngel_2" || sTag == "SumN_BindAngel_1")
    {
        SetObjectVisualTransform(OBJECT_SELF, 10, 1.2);
    }


    if(sTag == "SumN_Shades_2")
    {
        SetObjectVisualTransform(OBJECT_SELF, 10, 1.25);
    }

    if(sTag == "SumN_TCH_Gun")
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 0.10);
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 1.0);
    }

    if(sTag == "SumT_TCH_Drone")
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 0.10);
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 1.0);
    }

    if(sTag == "Illusionist_Greater_H")
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 0.5);
    }
}
