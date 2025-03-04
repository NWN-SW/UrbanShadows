//Rallying Cry by Alexander G.

#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
	effect eVis2 = EffectVisualEffect(623,FALSE,0.33f);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF);
	if ( GetHasSpellEffect(GetSpellId(),OBJECT_SELF))
	{
		FloatingTextStringOnCreature("Not enough time has passed since your last Rallying cry. It had no impact on morale.",OBJECT_SELF);
		
		return;
	}
	
    
    float fDuration = GetExtendSpell(60.0);
    float fSize = GetSpellArea(10.0);
    int nTargetCheck;
    object oMainTarget;
    object oFake;

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        int nDamage = GetFourthLevelDamage(oFake, 0, sTargets);



        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Soni";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    //End Custom Spell-Function Block

    //Shield Amount
	int iRegenBasedMissingHP =  (GetMaxHitPoints() - GetCurrentHitPoints())/50;
    effect eHP = EffectTemporaryHitpoints(nDamage);
	effect eVis= EffectVisualEffect(1075);
	
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (!GetIsReactionTypeHostile(oTarget, OBJECT_SELF))
        {
            
            effect eLinkRegen =EffectRegenerate(3+iRegenBasedMissingHP,6.0f);
			eLinkRegen = EffectLinkEffects(EffectDamageResistance(7,7+iRegenBasedMissingHP),eLinkRegen);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLinkRegen, oTarget, fDuration/2);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    }

    //Play Sound
    PlaySoundByStrRef(16778130, FALSE);

    //Class mechanics
    DoMartialMechanic("Tactic", sTargets, nDamage, oMainTarget);
    DoClassMechanic("Buff", sTargets, nDamage, oMainTarget);
}
