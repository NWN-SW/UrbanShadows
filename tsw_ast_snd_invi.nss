void main()
{
    object oPC = GetEnteringObject();
    object oSword = GetItemPossessedBy(oPC, "ObsidianSword");
    object oSound = GetObjectByTag("Cthulhu_Invite");
    int nSoundCheck = GetLocalInt(OBJECT_SELF, "SOUND_PLAYED");
    //Timestop effect
    location lTarget = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    effect eTime;
    object oTarget;
    int nDuration = 10;
    float fDuration = IntToFloat(nDuration);
    int nTh;

    if(oSword != OBJECT_INVALID && nSoundCheck != 1)
    {
        //Freeze everyone.
        eTime = EffectLinkEffects(EffectCutsceneParalyze(), EffectVisualEffect(VFX_DUR_PARALYZED));
        eTime = ExtraordinaryEffect(EffectLinkEffects(eTime, EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION)));

        oTarget = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nTh);
        while(GetIsObjectValid(oTarget))
        {
            if(oTarget != OBJECT_SELF && !GetIsDM(oTarget))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTime, oTarget, fDuration);
            }
            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));
            oTarget = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, ++nTh);
        }

        //Play sound
        SoundObjectPlay(oSound);
        SetLocalInt(OBJECT_SELF, "SOUND_PLAYED", 1);
    }
}
