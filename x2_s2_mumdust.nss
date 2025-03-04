#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    //Custom Mummy Dust spell by Alexander G.

        if (!X2PreSpellCastCode())
        {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
            return;
        }


    //Declare major variables
    int nLevel = GetCasterLevel(OBJECT_SELF);
    float fDuration = GetExtendSpell(30.0);
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    //Summon the appropriate creature
    eSummon = EffectSummonCreature("summ_dust_1", 496);
    eSummon = ExtraordinaryEffect(eSummon);
    //Apply the summon visual and summon the undead.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), fDuration);

    DelayCommand(2.0, SetLocalInt(GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF), "CLASS_MECH_SUMMON", 1));
    DelayCommand(1.5, SetSummonModel(OBJECT_SELF, GetAssociate(ASSOCIATE_TYPE_SUMMONED), GetSpellId()));

    //Class mechanics
    string sSpellType = "Invocation";
    DoClassMechanic(sSpellType, "Single", 0, OBJECT_SELF);
}


