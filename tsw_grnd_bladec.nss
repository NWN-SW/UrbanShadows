//::///////////////////////////////////////////////
//Blade Grenade OnHeartbeat by Alexander G.
//::///////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "spell_dmg_inc"

void main()
{

    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    object oPC = GetAreaOfEffectCreator();
    //Get the total martial class levels.
    int nClassTotal = GetLevelByClass(4, oPC) +
                    GetLevelByClass(33, oPC) +
                    GetLevelByClass(30, oPC) +
                    GetLevelByClass(0, oPC) +
                    GetLevelByClass(8, oPC) +
                    GetLevelByClass(27, oPC) +
                    GetLevelByClass(36, oPC) +
                    GetLevelByClass(37, oPC) +
                    GetLevelByClass(32, oPC) +
                    GetLevelByClass(7, oPC) +
                    GetLevelByClass(6, oPC) +
                    GetLevelByClass(5, oPC);
    int nDC = nClassTotal + 20;
    effect eDam;
    object oTarget;
    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_IMP_SPIKE_TRAP);
    effect eVis2 = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    float fDelay;
    //Capture the first target object in the shape.

    //--------------------------------------------------------------------------
    // GZ 2003-Oct-15
    // When the caster is no longer there, all functions calling
    // GetAreaOfEffectCreator will fail. Its better to remove the barrier then
    //--------------------------------------------------------------------------
    if (!GetIsObjectValid(GetAreaOfEffectCreator()))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }


    oTarget = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
    //Declare the spell shape, size and the location.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
        {
            fDelay = GetRandomDelay(0.5, 2.0);
            //Get Damage
            nDamage = 25 + Random(26) + nClassTotal;

            //Adjust the damage and DC
            nDamage = GetReflexDamage(oTarget, nDC, nDamage);
            nDamage = nDamage / 2;

            // Apply effects to the currently selected target.
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING);
            if(nDamage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget)));
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
    }
}

