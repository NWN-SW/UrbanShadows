//::///////////////////////////////////////////////
//:: Wall of Wind by Alexander G.
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


    //Declare Area of Effect object using the appropriate constant
    effect eAOE = EffectAreaOfEffect(AOE_PER_WALLWIND);
    //Get the location where the wall is to be placed.
    location lTarget = GetSpellTargetLocation();
    int nDuration = 6;
    float fDuration = RoundsToSeconds(nDuration);
    fDuration = GetExtendSpell(fDuration);

    if(nDuration == 0)
    {
        nDuration = 1;
    }

    //Create the Area of Effect Object declared above.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, fDuration);

    //Class mechanics
    string sSpellType = "Control";
    string sTargets = "AOE";
    DoClassMechanic(sSpellType, sTargets, 60, OBJECT_SELF);
}
