//////////////////////////////////////////////////
//Vincere onHeartbeat by Alexander G.
///////////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

void main()
{

    /*
      Spellcast Hook Code
      Added 2003-06-23 by GeorgZ
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // End of Spell Cast Hook


    //Get the first target in the radius around the caster
    object oTarget = GetFirstInPersistentObject();
    //Get PC
    object oPC = GetAreaOfEffectCreator();

    //Get CON modifier
    int nCon = GetAbilityModifier(ABILITY_CONSTITUTION, GetAreaOfEffectCreator());

    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eVis2 = EffectVisualEffect(964);
    effect eDam;
    object oBannerSelf = GetLocalObject(oPC,"oChampionsBanner");
    int iBannerCounter = GetLocalInt(oBannerSelf,"iBannerCount");
    SetLocalInt(oBannerSelf,"iBannerCount", iBannerCounter+1);

    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeHostile(oTarget, GetAreaOfEffectCreator()) && LineOfSightObject(GetAreaOfEffectCreator(), oTarget))
        {
            //Start Custom Spell-Function Block
                //Get damage
                string sTargets = "AOE";
                int nDamage = GetSeventhLevelDamage(oTarget, nCon+1, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                string sElement = "Fire";
                int nReduction = GetFocusReduction(oPC, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oPC, nDamage, sElement);
                nDamage = (nDamage)/2 ;
            //End Custom Spell-Function Block

            int nFinalDamage = GetWillDamage(oTarget, nReduction, nDamage);
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        }
        //Get the next target in the specified area around the caster
        oTarget = GetNextInPersistentObject();
    }
    //Break stealth
    if(GetStealthMode(GetAreaOfEffectCreator()) == 1)
    {
        SetActionMode(GetAreaOfEffectCreator(), ACTION_MODE_STEALTH, FALSE);
    }

}

