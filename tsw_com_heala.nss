//////////////////////////////////////////////////
//Commander Heal Aura onHeartbeat
///////////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

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
    int nCon = GetAbilityModifier(ABILITY_CONSTITUTION, GetAreaOfEffectCreator());
    if(nCon < 1)
    {
        nCon = 1;
    }
    int nHeal = nCon;

    effect eVis = EffectVisualEffect(VFX_IMP_STARBURST_GREEN);
    effect eHeal = EffectHeal(nHeal);

    //Get the first target in the radius around the caster
    object oTarget = GetFirstInPersistentObject();

    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeFriendly(oTarget, GetAreaOfEffectCreator()) || GetFactionEqual(oTarget, GetAreaOfEffectCreator()))
        {
            //Increase heal by missing HP
            int nMax = GetMaxHitPoints(oTarget);
            int nCurrent = GetCurrentHitPoints(oTarget);

            //Do nothing if max HP is less than current HP
            if(nMax > nCurrent)
            {
                float fPercent = 1 - IntToFloat(nCurrent) / IntToFloat(nMax);
                float fBonus = IntToFloat(nHeal) * fPercent;
                nHeal = nHeal + FloatToInt(fBonus);
                int nBattleBrother = GetLocalInt(oTarget, "BATTLE_BROTHER");
                if(nBattleBrother == 1)
                {
                    nHeal = nHeal + (nHeal / 2);
                }
                string sTest = FloatToString(fPercent);
                //SendMessageToPC(oTarget, "Bonus " + sTest + "% healing!");
                eHeal = EffectHeal(nHeal);

                //Fire spell cast at event for target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                //Apply VFX impact and bonus effects
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
            }
        }
        //Get the next target in the specified area around the caster
        oTarget = GetNextInPersistentObject();
        //Reset heal amount
        nHeal = nCon;
        eHeal = EffectHeal(nHeal);
    }
    //Break stealth
    if(GetStealthMode(GetAreaOfEffectCreator()) == 1)
    {
        SetActionMode(GetAreaOfEffectCreator(), ACTION_MODE_STEALTH, FALSE);
    }
}

