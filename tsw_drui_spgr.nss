//::///////////////////////////////////////////////
//:: Spirit Grove by Alexander G.
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
    effect eAOE = EffectAreaOfEffect(72);
    //Capture the spell target location so that the AoE object can be created.
    location lTarget = GetSpellTargetLocation();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;

    //Custom duration
    float fDuration = GetExtendSpell(30.0);
    effect eImpact = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
    effect eGlyph = EffectVisualEffect(VFX_DUR_GLYPH_OF_WARDING, FALSE, 3.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    //Create the object at the location so that the objects scripts will start working.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, fDuration);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eGlyph, lTarget, fDuration);

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, "AOE", 40, OBJECT_SELF, oCaster, CLASS_TYPE_DRUID);
}

