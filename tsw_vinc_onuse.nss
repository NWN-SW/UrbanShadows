void main()
{

 object oPCUsedBy = GetLastUsedBy();

 if (oPCUsedBy == GetLocalObject(OBJECT_SELF,"oBannersChampion") && GetLocalInt(OBJECT_SELF,"iBannerCount") > 2)
 {

    DeleteLocalObject(oPCUsedBy,"oChampionsBanner");
    DestroyObject(OBJECT_SELF);
 }
}
