//::///////////////////////////////////////////////
//Technician cluster mines by Alexander G.
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "tsw_class_func"
#include "spell_dmg_inc"

const int VFX_PER_MINE = 47;

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
    effect eAOE = EffectAreaOfEffect(VFX_PER_MINE);
    location lTarget = GetSpellTargetLocation();

    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, TurnsToSeconds(3));
    int nStam = UseStamina(OBJECT_SELF, GetSpellId());
}


