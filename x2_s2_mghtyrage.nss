//::///////////////////////////////////////////////
//:: Mighty Rage
//:: X2_S2_MghtyRage
//:://////////////////////////////////////////////
/*
The Barbarian erupts with energy, heals themselves, then knocksdown and damages enemies.
*/
//:://////////////////////////////////////////////
//:: Created By: Alexander Gates
//:: Created On: September 12, 2020
//:://////////////////////////////////////////////
#include "x2_i0_spells"
void main()
{
    if(GetHasFeatEffect(FEAT_BARBARIAN_RAGE))
    {
        //Declare major variables
        int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        //Determine the duration by getting the con modifier after being modified
        int nDamage = GetAbilityModifier(ABILITY_CONSTITUTION) * GetAbilityModifier(ABILITY_STRENGTH);
        int nHeal = nLevel * GetAbilityModifier(ABILITY_CONSTITUTION);
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
        effect eKnockdown = EffectKnockdown();
        effect eHeal = EffectHeal(nHeal);
        effect eBoom = EffectVisualEffect(VFX_IMP_TORNADO);
        effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
        effect eVis = EffectVisualEffect(VFX_IMP_HARM);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
        float fDelay;

        //Get the spell target location as opposed to the spell target.
        location lTarget = GetLocation(OBJECT_SELF);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, OBJECT_SELF, RoundsToSeconds(d3()));
        //Apply epicenter explosion on caster
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(OBJECT_SELF));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, OBJECT_SELF);
        //Declare the spell shape, size and the location.  Capture the first target object in the shape.
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        //Cycle through the targets within the spell shape until an invalid object is captured.
        while (GetIsObjectValid(oTarget))
        {
            // * spell should not affect the caster
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && (oTarget != OBJECT_SELF))
            {
                //Get the distance between the explosion and the target to calculate delay
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(OBJECT_SELF))/20;
                effect eTrip = EffectKnockdown();
                // * DO a strength check vs. Strength 20
                if (d20() + GetAbilityScore(oTarget, ABILITY_STRENGTH) <= 40 + d20())
                {
                    //Apply effects to the currently selected target.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTrip, oTarget, 6.0));
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                }
                else
                    FloatingTextStrRefOnCreature(2750, OBJECT_SELF, FALSE);
            }
           //Select the next target within the spell shape.
           oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
}
