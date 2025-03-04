//::///////////////////////////////////////////////
//:: Storm of Vengeance by Alexander G.
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

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
    effect eAOE = EffectAreaOfEffect(AOE_PER_STORM);
    effect eVis = EffectVisualEffect(VFX_FNF_STORM);
    location lTarget = GetSpellTargetLocation();
    int nDuration = 6;
    float fDuration = RoundsToSeconds(nDuration);
    fDuration = GetExtendSpell(fDuration);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, fDuration);
    object oField = CreateObject(OBJECT_TYPE_PLACEABLE, "tempest_field", lTarget);
    SetObjectVisualTransform(oField, OBJECT_VISUAL_TRANSFORM_SCALE, 2.0, OBJECT_VISUAL_TRANSFORM_LERP_LINEAR, 3.0);
    DestroyObject(oField, fDuration);

    //Class mechanics
    string sSpellType = "Force";
    object oEnemy = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while(oEnemy != OBJECT_INVALID)
    {
        if(GetIsReactionTypeHostile(oEnemy, OBJECT_SELF))
        {
            break;
        }
        oEnemy = GetNextObjectInShape(SHAPE_SPHERE, 20.0, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
    DoClassMechanic(sSpellType, "AOE", 60, oEnemy, OBJECT_SELF);
}


