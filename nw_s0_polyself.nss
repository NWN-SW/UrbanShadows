//Transformation by Alexander G.

#include "x2_inc_spellhook"

void main()
{

    object oPC = OBJECT_SELF;
    int nCheck;
    if(GetIsPC(oPC))
    {
        int nCheck = GetLocalInt(oPC, "HAS_TENSERS");
        if(nCheck == 1)
        {
            SendMessageToPC(oPC, "Tensers Transformation and Polymorph Self cannot be active at the same time.");
            return;
        }
    }
  //----------------------------------------------------------------------------
  // GZ, Nov 3, 2003
  // There is a serious problems with creatures turning into unstoppable killer
  // machines when affected by tensors transformation. NPC AI can't handle that
  // spell anyway, so I added this code to disable the use of Tensors by any
  // NPC.
  //----------------------------------------------------------------------------
  if (!GetIsPC(OBJECT_SELF))
  {
      WriteTimestampedLogEntry(GetName(OBJECT_SELF) + "[" + GetTag (OBJECT_SELF) +"] tried to cast Tensors Transformation. Bad! Remove that spell from the creature");
      return;
  }

  /*
    Spellcast Hook Code
      Added 2003-06-23 by GeorgZ
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more
    */

    if (!X2PreSpellCastCode())
    {
        return;
    }

    // End of Spell Cast Hook


    //Declare major variables
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nHP, nCnt, nDuration;
    nDuration = GetCasterLevel(OBJECT_SELF);
    //Determine bonus HP
    for(nCnt; nCnt <= nLevel; nCnt++)
    {
        nHP += d6();
    }

    int nMeta = GetMetaMagicFeat();
    //Metamagic
    if(nMeta == METAMAGIC_MAXIMIZE)
    {
        nHP = nLevel * 6;
    }
    else if(nMeta == METAMAGIC_EMPOWER)
    {
        nHP = nHP + (nHP/2);
    }
    else if(nMeta == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    //Declare effects
    effect eAttack = EffectAttackIncrease(nLevel/4);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_FORT, 2);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    //effect ePoly = EffectPolymorph(28);
    effect eSwing = EffectModifyAttacks(2);
    //Bonus Stats
    effect eSTR = EffectAbilityIncrease(0, 4);
    effect eDEX = EffectAbilityIncrease(1, 4);
    effect eCON = EffectAbilityIncrease(2, 2);

    //Link effects
    effect eLink = EffectLinkEffects(eAttack, eSTR);
    eLink = EffectLinkEffects(eLink, eDEX);
    eLink = EffectLinkEffects(eLink, eCON);

    eLink = EffectLinkEffects(eLink, eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eSwing);

    effect eHP = EffectTemporaryHitpoints(nHP);

    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVis1 = EffectVisualEffect(VFX_DUR_GHOST_SMOKE_2);
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_POLYMORPH_SELF, FALSE));

    ClearAllActions(); // prevents an exploit
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis1, OBJECT_SELF, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, OBJECT_SELF, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
    SetLocalInt(OBJECT_SELF, "HAS_POLYMORPHSELF", 1);
    DelayCommand(RoundsToSeconds(nDuration), DeleteLocalInt(OBJECT_SELF, "HAS_POLYMORPHSELF"));
    /*
    //Change Appearance
    int nApp = GetAppearanceType(OBJECT_SELF);
    SetCreatureAppearanceType(OBJECT_SELF, 1938);
    DelayCommand(RoundsToSeconds(nDuration), SetCreatureAppearanceType(OBJECT_SELF, nApp));
    SetLocalInt(OBJECT_SELF, "HAS_POLYMORPHSELF", 1);
    DelayCommand(RoundsToSeconds(nDuration), DeleteLocalInt(OBJECT_SELF, "HAS_POLYMORPHSELF"));
    */

}
