void main()
{
    //If Brawler Target
    if(GetLocalInt(OBJECT_SELF, "BRAWLER_FRENZY_TARGET") == 1)
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 0.0, OBJECT_VISUAL_TRANSFORM_LERP_LINEAR, 0.25);
        DeleteLocalInt(OBJECT_SELF, "BRAWLER_FRENZY_TARGET");
    }
    else
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 0.0);
    }
}
