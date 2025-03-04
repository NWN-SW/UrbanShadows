//::///////////////////////////////////////////////
//:: Name x2_def_percept
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Clearly not the default On Perception script
*/
//:://////////////////////////////////////////////
//:: Created By: RaccManiac
//:: Created On: January 2024 baby
//:://////////////////////////////////////////////


void DelaySpeak (string sSpeech)
{

    AssignCommand(OBJECT_SELF, SpeakString(sSpeech,0));

}

void main()
{
    int nVar = GetLocalInt(OBJECT_SELF, "iFirstSpot");
    SetLocalInt(OBJECT_SELF, "iFirstSpot",nVar+1);
    nVar = GetLocalInt(OBJECT_SELF, "iFirstSpot");
    int nCount;
    //effect eSummon = EffectSummonCreature("vilecrawler",VFX_FNF_GAS_EXPLOSION_EVIL);
    effect eVFX = EffectVisualEffect(258);
    location lMob = GetLocation(OBJECT_SELF);

      if(nVar == 1)
      {
      // Stanley summons dog. Niak!
      ClearAllActions();
      DelayCommand(1.0f, DelaySpeak("Ah... HAHA! More fresh meat!? JUST FOR ME?!"));

      object oTarget = GetLastPerceived();
      SetFacingPoint(GetPosition(oTarget));
      ClearAllActions();
      DelayCommand(4.0f, DelaySpeak("Fetch me their souls!"));
      ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lMob);
         for (nCount = 0; nCount <5; nCount++)
         {
           CreateObject(1, "ghost_t4mob001", lMob);
         }
      }

    //ExecuteScript("nw_c2_default2", OBJECT_SELF);
     DelayCommand(6.0f,ExecuteScript("j_ai_onpercieve", OBJECT_SELF));
}
