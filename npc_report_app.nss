void main()
{
    int nApp = GetAppearanceType(OBJECT_SELF);
    string sApp = IntToString(nApp);
    SendMessageToAllDMs("I am: " + GetName(OBJECT_SELF) + " and my appearance is: " + sApp);
}
