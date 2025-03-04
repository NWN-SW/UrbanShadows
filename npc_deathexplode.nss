#include "spell_dmg_inc"

void main()
{
    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
    effect eVis = EffectVisualEffect(VFX_IMP_DESTRUCTION);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetLocation(OBJECT_SELF);
    //Limit Caster level for the purposes of damage
    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, lTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, OBJECT_SELF);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
       //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIREBALL));
        //Get the distance between the explosion and the target to calculate delay
        fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
        //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
        nDamage = GetReflexDamage(oTarget, 45, 200);
        //Set the damage effect
        eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
        if(nDamage > 0 && GetIsEnemy(oTarget))
        {
            // Apply effects to the currently selected target.
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}
