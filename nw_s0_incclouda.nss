//::///////////////////////////////////////////////
//:: Incendiary Cloud onEnter by Alexander G.
//::///////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "spell_dmg_inc"

void main()
{

    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nCasterLvl = GetCasterLevel(GetAreaOfEffectCreator());
    effect eDam;
    object oTarget;
    object oCaster = GetAreaOfEffectCreator();
    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
   //effect eSpeed = EffectMovementSpeedDecrease(50);
    effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = eVis2; //EffectLinkEffects(eSpeed, eVis2);
    float fDelay;
    //Capture the first target object in the shape.
    oTarget = GetEnteringObject();
    //Declare the spell shape, size and the location.
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INCENDIARY_CLOUD));
        //Make SR check, and appropriate saving throw(s).
        if(!MyResistSpell(GetAreaOfEffectCreator(), oTarget, fDelay))
        {
            fDelay = GetRandomDelay(0.5, 2.0);
            //Start Custom Spell-Function Block
                //Get damage
                string sTargets = "AOE";
                nDamage = GetEighthLevelDamage(oTarget, nCasterLvl, sTargets);

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
       // ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeed, oTarget);
    }
}
