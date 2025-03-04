//::///////////////////////////////////////////////
//Grave Magus by Alexander G.
//:://////////////////////////////////////////////

#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    effect eSummon;
    float fDuration = GetExtendSpell(120.0);;

    eSummon = EffectSummonCreature("necro_gravemagus", VFX_FNF_SUMMON_UNDEAD);

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), fDuration);

    //Make it have no hit box.
    effect nTouch = EffectCutsceneGhost();
    nTouch = SupernaturalEffect(nTouch);
    DelayCommand(1.5, SetLocalInt(GetAssociate(ASSOCIATE_TYPE_SUMMONED), "CLASS_MECH_SUMMON", 1));
    DelayCommand(1.5, SetLocalObject(GetAssociate(ASSOCIATE_TYPE_SUMMONED), "MY_SUMMON_MASTER", OBJECT_SELF));
    DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, nTouch, GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF)));

    //Class mechanics
    string sSpellType = "Invocation";
    DoClassMechanic(sSpellType, "Single", 0, OBJECT_SELF);
}
