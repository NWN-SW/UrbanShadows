//::///////////////////////////////////////////////
//:: Incendiary Cloud by Alexander G.
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


    //Declare major variables, including the Area of Effect object.
    effect eAOE = EffectAreaOfEffect(73);
    //Capture the spell target location so that the AoE object can be created.
    location lTarget = GetSpellTargetLocation();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;

    //Custom duration
    int nDuration = 6;
    float fDuration = RoundsToSeconds(nDuration);
    fDuration = GetExtendSpell(fDuration);
    effect eImpact = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    //Create the object at the location so that the objects scripts will start working.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, fDuration);

    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, "AOE", 40, OBJECT_SELF, oCaster, CLASS_TYPE_THEURGIST);
}

