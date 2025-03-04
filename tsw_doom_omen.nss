//::///////////////////////////////////////////////
//Omen by Alexander G.
//:://////////////////////////////////////////////

#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    //Declare major variables
    int nLevel = GetCasterLevel(OBJECT_SELF);
    float fDuration = GetExtendSpell(120.0);
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    string sSummon;

    if(GetHasFeat(DOOM_PROPHECY_FIRE, OBJECT_SELF) && GetSpellId() == 949)
    {
        sSummon = "summ_fire_1";
    }
    else if(GetHasFeat(DOOM_PROPHECY_COLD, OBJECT_SELF) && GetSpellId() == 950)
    {
        sSummon = "summ_water_1";
    }
    else if(GetHasFeat(DOOM_PROPHECY_ELEC, OBJECT_SELF) && GetSpellId() == 951)
    {
        sSummon = "summ_air_1";
    }
    else
    {
        SendMessageToPC(OBJECT_SELF, "You can only cast spells aligned with your Prophecy element.");
        return;
    }

    //Summon the appropriate creature
    eSummon = EffectSummonCreature(sSummon, VFX_FNF_SUMMON_MONSTER_3);
    eSummon = ExtraordinaryEffect(eSummon);
    //Apply the summon visual and summon the undead.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), fDuration);

    //Make it have no hit box.
    effect eTouch = EffectCutsceneGhost();
    eTouch = SupernaturalEffect(eTouch);

    DelayCommand(1.5, SetLocalInt(GetAssociate(ASSOCIATE_TYPE_SUMMONED), "CLASS_MECH_SUMMON", 1));
    DelayCommand(1.5, SetLocalObject(GetAssociate(ASSOCIATE_TYPE_SUMMONED), "MY_SUMMON_MASTER", OBJECT_SELF));
    DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTouch, GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF)));

    //Class mechanics
    string sSpellType = "Invocation";
    DoClassMechanic(sSpellType, "Single", 0, OBJECT_SELF);
}
