#include "inc_loot_rolls"

void OnUseGenerateItem(object oPC, int iTier)
{
    //Create random item

        string sToken = "loottokent" + IntToString(iTier);

      object oFreeLoot = CreateItemOnObject(sToken, oPC, 1);

}



void main()
{

   effect eVFXChest = EffectVisualEffect(VFX_IMP_KNOCK);
   ApplyEffectToObject(0, eVFXChest,OBJECT_SELF);
   object oPlayer = GetLastUsedBy();

   OnUseGenerateItem(oPlayer, Random(4)+1);



}
