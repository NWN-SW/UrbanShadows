void main()
{
    object oFort = GetObjectByTag("TheEnd_WZ");
    SetEventScript(oFort, 4000, "fort_start_force");
}
