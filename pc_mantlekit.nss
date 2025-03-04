#include "nw_i0_spells"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

const int CLASS_TYPE_TECHNICIAN = 43;

void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    //Check if it's the item we want.
    if(GetTag(oItem) != "PC_Mantle_Kit")
    {
        return;
    }
    int nAbsorb;
    effect eVis = EffectVisualEffect(VFX_DUR_SPELLTURNING);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    string sGrenUsed = "GRENADES_USED";

    //Check how many grenades the person has used today.
    int nUsed = GetLocalInt(oPC, sGrenUsed);

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
                    GetLevelByClass(31, oPC) +
                    GetLevelByClass(35, oPC) +
                    GetLevelByClass(43, oPC) +
                    GetLevelByClass(5, oPC);

    //Total grenade uses allowed per day.
    int nUses =  nClassTotal / 5;

    //Compare current uses vs allowed daily.
    if(nUsed >= nUses)
    {
        SendMessageToPC(oPC, "You have used all your daily devices. Rest to replenish your supply.");
        return;
    }

    //Link Effects
    nAbsorb = nClassTotal;
    effect eAbsorb = EffectSpellLevelAbsorption(9, nAbsorb);
    effect eLink = EffectLinkEffects(eVis, eAbsorb);
    eLink = EffectLinkEffects(eLink, eDur);
    //Fire cast spell at event for the specified target
    SignalEvent(oPC, EventSpellCastAt(oPC, SPELL_SPELL_MANTLE, FALSE));

    RemoveEffectsFromSpell(oPC, SPELL_SPELL_MANTLE);
    RemoveEffectsFromSpell(oPC, SPELL_LESSER_SPELL_MANTLE);
    RemoveEffectsFromSpell(oPC, SPELL_GREATER_SPELL_MANTLE);
    //Increment device uses
    nUsed = nUsed + 1;
    SetLocalInt(oPC, sGrenUsed, nUsed);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, RoundsToSeconds(nClassTotal));
}
