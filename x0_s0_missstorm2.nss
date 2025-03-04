//::///////////////////////////////////////////////
//:: Isaacs Greater Missile Storm
//:: x0_s0_MissStorm2
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
 Up to 20 missiles, each doing 3d6 damage to each
 target in area.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 31, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Alexander G.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    int nLevel = GetCasterLevel(OBJECT_SELF);
    DoMissileStorm(6, nLevel, SPELL_ISAACS_GREATER_MISSILE_STORM, VFX_IMP_MIRV, VFX_IMP_MAGBLUE, DAMAGE_TYPE_MAGICAL, FALSE, TRUE);
}




