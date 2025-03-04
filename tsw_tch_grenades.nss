//::///////////////////////////////////////////////
//:: Technomancer Grenades
//:://////////////////////////////////////////////
//New Grenade scripts by Alexander G.
//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

const int CLASS_TYPE_TECH = 43;

void main()
{
    int nSpell = GetSpellId();
	int iTechClassLevels = GetLevelByClass(CLASS_TYPE_TECH,OBJECT_SELF);
    int nDamage;
    int nTotal;
    int nTargets = 0;
    int nVFXCounter = 0;
    float fSize = GetSpellArea(7.0);
    effect eSlow = EffectMovementSpeedDecrease(75);
    float fDelay2;
    location lVFX;
    effect eExplode = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
    object oPC = OBJECT_SELF;
    location lTarget = GetSpellTargetLocation();

    if(nSpell == 857)
    {
        effect eVis = EffectVisualEffect(VFX_IMP_TORNADO);

        //Damage section of the grenade
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE);

        //Apply the acid explosions
        while(nVFXCounter < 11)
        {
            fDelay2 = fDelay2 + 0.1;
            lVFX = GetNewRandomLocation(lTarget, fSize);
            DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
            nVFXCounter = nVFXCounter + 1;
        }
		
		//Start Custom Spell-Function Block
		//Get damage
		string sTargets = "AOE";


		//Get the Alchemite resistance reduction
		string sElement = "Acid";
		int nReduction = GetFocusReduction(oPC, sElement);



        while(oTarget != OBJECT_INVALID)
        {
		
		//Buff damage bonus on Alchemite
		nDamage = GetThirdLevelDamage(oTarget, 10, sTargets);

		//Buff damage by Amplification elvel
		

                //End Custom Spell-Function Block
				 if(GetIsEnemy(oTarget))
            {
           
                nDamage = GetReflexDamage(oTarget, nReduction, nDamage)/2;
                 nDamage = GetAmp(nDamage);
				int nFinalDamage = GetFocusDmg(oPC, nDamage, sElement);
                //Increment total damage dealt
                if(nTotal < nFinalDamage)
                {
                    nTotal = nFinalDamage;
                }
                //Increment total number of targets
                nTargets = nTargets + 1;
                effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_ACID);
                effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
                float fDuration = GetExtendSpell(18.0);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                if(!GetHasSpellEffect(GetSpellId(), oTarget))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, fDuration);
                }
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
			else if(!GetIsEnemy(oTarget))
            {
				nDamage = GetAmp(nDamage/2);
				int nFinalDamage = GetFocusDmg(oPC, nDamage, sElement);
                effect eHeal = EffectHeal(nFinalDamage);
                
				eVis = EffectVisualEffect(VFX_IMP_TORNADO);
				if (!GetHasSpellEffect(857,oTarget))
				{
					effect eBoostSave = EffectSavingThrowIncrease(SAVING_THROW_ALL,iTechClassLevels/2);
					eBoostSave = EffectLinkEffects(EffectTemporaryHitpoints(iTechClassLevels*4),eBoostSave);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBoostSave, oTarget,18.0f);
				}
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
				
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE);			
        }

        //Damage section of the grenade
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE);

    }
    else if(nSpell == 856)
    {
        effect eFireArea = EffectAreaOfEffect(AOE_PER_FOGFIRE, "tsw_grnd_incena", "tsw_grnd_incenc", "tsw_grnd_incenb");
        effect eCaltrops = EffectVisualEffect(494);
        float fDuration = GetExtendSpell(36.0);
        DoGrenade(d10(1), d10(4), VFX_IMP_FLAME_M, VFX_IMP_FLAME_M, DAMAGE_TYPE_FIRE, fSize, OBJECT_TYPE_CREATURE);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eFireArea, GetSpellTargetLocation(), fDuration);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eCaltrops, GetSpellTargetLocation());
    }

    //Class mechanics
    string sSpellType = "Tactic";
    DoMartialMechanic(sSpellType, "AOE", 0, oPC);
}
