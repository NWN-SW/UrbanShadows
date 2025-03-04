//::///////////////////////////////////////////////
//:: Incendiary Grenade onHeartbeat by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "spell_dmg_inc"

void main()
{

    //Declare major variables
    int nDamage;
    int nCasterLvl = GetCasterLevel(GetAreaOfEffectCreator());
    object oCaster = GetAreaOfEffectCreator();
    effect eDam;
    object oTarget;
    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
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

    //Mao <3

    oTarget = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
    //Declare the spell shape, size and the location.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
        {
            fDelay = GetRandomDelay(0.5, 2.0);
            //Make SR check, and appropriate saving throw(s).
            if(!MyResistSpell(GetAreaOfEffectCreator(), oTarget, fDelay))
            {
                SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_INCENDIARY_CLOUD));
                //Start Custom Spell-Function Block
                    //Get damage
                    string sTargets = "AOE";
                    nDamage = GetFourthLevelDamage(oTarget, nCasterLvl, sTargets);

                    //Buff damage by Amplification elvel
                    nDamage = GetAmp(nDamage);

                    //Get the Alchemite resistance reduction
                    string sElement = "Fire";
                    int nReduction = GetFocusReduction(oCaster, sElement);

                    //Buff damage bonus on Alchemite
                    nDamage = GetFocusDmg(oCaster, nDamage, sElement);
                //End Custom Spell-Function Block

                //Adjust damage based on Alchemite and Saving Throw
                int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
                nFinalDamage = nFinalDamage / 3;
                // Apply effects to the currently selected target.
                eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
    }
}
