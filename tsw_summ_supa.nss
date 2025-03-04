#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    //Pactsworn spell by Alexander G.

    //Check Cooldown
    if(!GetTimerEnded("SUMMONER_PACTSWORN_CD", OBJECT_SELF))
    {
        SendMessageToPC(OBJECT_SELF, "You must wait two minutes after summoning your Pactsworn before casting again.");
        return;
    }

    //Declare major variables
    int nLevel = GetCasterLevel(OBJECT_SELF);
    float fDuration = GetExtendSpell(300.0);
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    //Summon the appropriate creature
    eSummon = EffectSummonCreature("sum_pactsworn", VFX_FNF_SUMMONDRAGON);
    eSummon = ExtraordinaryEffect(eSummon);
    //Apply the summon visual and summon the undead.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), fDuration);

    //Set Cooldown
    SetTimer("SUMMONER_PACTSWORN_CD", 120, OBJECT_SELF);

    DelayCommand(2.0, SetLocalInt(GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF), "CLASS_MECH_SUMMON", 1));
    DelayCommand(1.5, SetSummonModel(OBJECT_SELF, GetAssociate(ASSOCIATE_TYPE_SUMMONED), GetSpellId()));

    //Class mechanics
    string sSpellType = "Invocation";
    DoClassMechanic(sSpellType, "Single", 0, OBJECT_SELF);
}


