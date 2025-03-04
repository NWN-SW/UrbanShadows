//::///////////////////////////////////////////////
//:: Vampiric Touch by Alexander G.
//:://////////////////////////////////////////////

#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

void main()
{

    //--------------------------------------------------------------------------
    /*  Spellcast Hook Code
       Added 2003-06-20 by Georg
       If you want to make changes to all spells,
       check x2_inc_spellhook.nss to find out more
    */
    //--------------------------------------------------------------------------

    if (!X2PreSpellCastCode())
    {
        return;
    }
    //--------------------------------------------------------------------------
    // End of Spell Cast Hook
    //--------------------------------------------------------------------------


    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    //Roll damage for each target
    nDamage = GetThirdLevelDamage(oTarget, nCasterLevel, nMetaMagic, "Single");

    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
    string sElement = "Nega";
    object oCaster = OBJECT_SELF;
    int nDC = GetSpellSaveDC();
    int nBonusDC = GetFocusDC(oCaster, sElement);
    nDC = nDC + nBonusDC;
    nDamage = GetFocusDmg(oCaster, nDamage, sElement);
    nDamage = GetFortDamage(oTarget, nDC, nDamage);
    int nDuration = d4(2);

    //Debug Line
    //string sDC = IntToString(nDC);
    //string sDmg = IntToString(nDamage);
    //SendMessageToPC(oCaster, "Your final DC is: " + sDC + " and your final damage is: " + sDmg);

    //--------------------------------------------------------------------------
    //Limit damage to max hp + 10
    //--------------------------------------------------------------------------
    int nMax = GetCurrentHitPoints(oTarget) + 10;
    if(nMax < nDamage)
    {
        nDamage = nMax;
    }

    effect eHeal = EffectTemporaryHitpoints(nDamage);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHeal, eDur);

    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        if(!GetIsReactionTypeFriendly(oTarget) &&
            GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD &&
            GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT &&
            !GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget))
        {
            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_VAMPIRIC_TOUCH, FALSE));
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_VAMPIRIC_TOUCH, TRUE));
            // GZ: * GetSpellCastItem() == OBJECT_INVALID is used to prevent feedback from showing up when used as OnHitCastSpell property
            if (TouchAttackMelee(oTarget,GetSpellCastItem() == OBJECT_INVALID)>0)
            {
                if(MyResistSpell(OBJECT_SELF, oTarget) == 0)
                 {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, OBJECT_SELF);
                    RemoveTempHitPoints();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, TurnsToSeconds(nDuration));
                 }
            }
        }
    }
}
