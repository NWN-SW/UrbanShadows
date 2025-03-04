//::///////////////////////////////////////////////
//Blade Grenade onEnter by Alexander G.

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
    effect eSpeed = EffectMovementSpeedDecrease(75);
    effect eVis2 = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    effect eLink = eVis2; //EffectLinkEffects(eSpeed, eVis2);
    float fDelay;
    //Capture the first target object in the shape.
    oTarget = GetEnteringObject();
    //Declare the spell shape, size and the location.
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GRENADE_CALTROPS));
        //Make SR check, and appropriate saving throw(s).
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

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpeed, oTarget, 6.0);
    }
}
