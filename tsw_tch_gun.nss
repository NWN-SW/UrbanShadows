//::///////////////////////////////////////////////
//Technician Gun Drone by Alexander G.
//:://////////////////////////////////////////////

#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    effect eSummon;
    float fDuration = GetExtendSpell(120.0);;

    eSummon = EffectSummonCreature("sum_tch_gun", VFX_FNF_SUMMON_MONSTER_1);

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), fDuration);

    //Make it have no hit box.
    effect nTouch = EffectCutsceneGhost();
    nTouch = SupernaturalEffect(nTouch);
    object oPet = GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF);
    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, nTouch, oPet));

    //Class mechanics
    string sSpellType = "Tactic";
    DoMartialMechanic(sSpellType, "Single", 0, OBJECT_SELF);
}
