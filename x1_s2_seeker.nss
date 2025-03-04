//::///////////////////////////////////////////////
//:: x1_s2_seeker
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Seeker Arrow
     - creates an arrow that automatically hits target.
     - normal arrow damage, based on base item type

     - Must have shortbow or longbow in hand.


     APRIL 2003
     - gave it double damage to balance for the fact
       that since its a spell you are losing
       all your other attack actions

     SEPTEMBER 2003 (GZ)
        Added damage penetration
        Added correct enchantment bonus


*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

void main()
{
    int nBonus = 0;
    nBonus = ArcaneArcherCalculateBonus() ;

    object oTarget = GetSpellTargetObject();
    int nLevel = GetLevelByClass(29, OBJECT_SELF);

    if (GetIsObjectValid(oTarget) == TRUE)
    {
        //Roll damage for each target
        string sElement = "Magi";
        int nMetaMagic;
        int nDamage = GetFifthLevelDamage(oTarget, nLevel, nMetaMagic, "Single");

        //Adjust the damage based on the Reflex Save, Evasion, and Improved Evasion.
        int nDC = GetSpellSaveDC();
        int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
        nDC = nDC + nBonusDC;
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

        if (nDamage > 0)
        {
            effect ePhysical = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING,IPGetDamagePowerConstantFromNumber(nBonus));
            effect eMagic = EffectDamage(nBonus, DAMAGE_TYPE_MAGICAL);
            effect eVis = EffectVisualEffect(VFX_FNF_SOUND_BURST);

          //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 601));

            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePhysical, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagic, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}
