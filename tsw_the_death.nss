//::///////////////////////////////////////////////
//Theurgist Death wall by Alexander G.
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

const int AOE_PER_WALLDEATH = 53;

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
    effect eAOE = EffectAreaOfEffect(AOE_PER_WALLDEATH);
    location lTarget = GetSpellTargetLocation();
    float fDuration = GetExtendSpell(24.0);

    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, fDuration);

    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, "AOE", 40, OBJECT_SELF, OBJECT_SELF, CLASS_TYPE_THEURGIST);
}

