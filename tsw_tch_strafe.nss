//::///////////////////////////////////////////////
//Technomancer Strafe by Alexander G.
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

const int AOE_PER_STRAFE = 48;

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare Area of Effect object using the appropriate constant
    effect eAOE = EffectAreaOfEffect(AOE_PER_STRAFE);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eSmoke = EffectVisualEffect(VFX_IMP_AURA_NEGATIVE_ENERGY);
    //Get the location where the wall is to be placed.
    location lTarget = GetSpellTargetLocation();

    //Create the Area of Effect Object declared above.
    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, lTarget));
    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, 3.0));
    PlaySound("tsw_tch_strafe_1");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lTarget);
    DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lTarget));
    DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lTarget));
    DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lTarget));
    DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lTarget));
    DelayCommand(2.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lTarget));

    SetLocalInt(OBJECT_SELF, "STRAFE_COOLDOWN", 1);
    int nStam = UseStamina(OBJECT_SELF, GetSpellId());
}
