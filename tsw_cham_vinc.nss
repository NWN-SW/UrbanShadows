//::///////////////////////////////////////////////
//:: Vincere by Alexander G.
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

     if ( GetLocalObject(OBJECT_SELF,"oChampionsBanner") == OBJECT_INVALID)
     {
    //Declare major variables, including the Area of Effect object.
    effect eAOE = EffectAreaOfEffect(71);
    //Capture the spell target location so that the AoE object can be created.
    location lTarget = GetSpellTargetLocation();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;

    //Custom duration
    int nDuration = 5;
    float fDuration = RoundsToSeconds(nDuration);
    fDuration = GetExtendSpell(fDuration);
    effect eImpact = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, "championflag1", lTarget, FALSE, GetName(oCaster) + "_FLAG");
    DelayCommand(fDuration, DestroyObject(oPlaceable));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    //Create the object at the location so that the objects scripts will start working.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, fDuration);

    //Change banner size
    SetObjectVisualTransform(oPlaceable, OBJECT_VISUAL_TRANSFORM_SCALE, 2.0, OBJECT_VISUAL_TRANSFORM_LERP_LINEAR, 1.0);

    //Class mechanics
    DoClassMechanic("Occult", "AOE", 100, oCaster);
    DoClassMechanic("Force", "AOE", 100, oCaster);
    SetLocalObject(OBJECT_SELF,"oChampionsBanner",oPlaceable);
    SetLocalObject(oPlaceable,"oBannersChampion",OBJECT_SELF);
    DelayCommand(fDuration+0.5f, DeleteLocalObject(OBJECT_SELF,"oChampionsBanner"));

    }

    else
    {
        FloatingTextStringOnCreature("You must retrieve your banner from the battlefield before you can plant it once more.",OBJECT_SELF,FALSE);
    }
}
