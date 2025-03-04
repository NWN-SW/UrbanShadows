//Necrotic Burst by Alexander G.

#include "X0_I0_SPELLS"
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

    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);

    //We already know the damage. It's stored on the creature.
    int nDamage = GetLocalInt(OBJECT_SELF, "SEAL_DEST_DAMAGE");

    float fDelay;
    float fSize = GetSpellArea(6.0);
    effect eVis = EffectVisualEffect(VFX_IMP_STARBURST_RED);
    effect eExplode = EffectVisualEffect(VFX_IMP_DESTRUCTION);
    effect eDam;
    string sTargets;
    string sElement = "Nega";
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetLocation(oCaster);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplode, OBJECT_SELF);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeFriendly(oTarget))
        {
            //Set the damage effect
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
       fDelay = fDelay + 0.1;
    }
}

