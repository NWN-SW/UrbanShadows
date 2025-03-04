//::///////////////////////////////////////////////
//:: Acid Fog by Alexander G.
//:://////////////////////////////////////////////


#include "x2_inc_spellhook"
#include "tsw_class_func"
#include "spell_dmg_inc"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGACID);
    location lTarget = GetSpellTargetLocation();
    float fDuration = GetExtendSpell(36.0);
    effect eImpact = EffectVisualEffect(257);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);

    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, fDuration);

    DoClassMechanic("Earth", "AOE", 30, OBJECT_SELF, OBJECT_SELF, CLASS_TYPE_GEOMANCER);
}
