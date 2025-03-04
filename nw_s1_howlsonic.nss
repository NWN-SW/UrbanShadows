//::///////////////////////////////////////////////
//:: Howl: Sonic
//:: NW_S1_HowlSonic
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A howl emanates from the creature which affects
    all within 10ft unless they make a save.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 14, 2000
//:://////////////////////////////////////////////


#include "NW_I0_SPELLS"
#include "spell_dmg_inc"
void main()
{
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eHowl;
    effect eImpact = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);

    int nAmount = 10;
    int nDamage;
    float fDelay;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsFriend(oTarget) && oTarget != OBJECT_SELF)
        {
            fDelay = GetDistanceToObject(oTarget)/20;
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HOWL_SONIC));
            nDamage = GetFortDamage(oTarget, 0, 40);

            //Make a saving throw check
            /*
            if(MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_SONIC, OBJECT_SELF, fDelay))
            {
                nDamage = nDamage / 2;
            }
            */
            //Set damage effect
            eHowl = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
            //Apply the VFX impact and effects
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}


