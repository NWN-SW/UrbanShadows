//Custom Shadow Finger of Death spell for Greater Shadow Conjuration

#include "x0_I0_SPELLS"
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


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE);

    if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE,OBJECT_SELF))
    {
        //GZ: I still signal this event for scripting purposes, even if a placeable
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW));
         if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            //Make SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
               {
                    //Roll damage for each target
                    nDamage = GetFifthLevelDamage(oTarget, nCasterLvl, nMetaMagic, "Single");

                    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                    int nDC = GetSpellSaveDC();
                    string sElement = "Magi";
                    int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
                    nDC = nDC + nBonusDC;
                    nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
                    nDamage = GetFortDamage(OBJECT_SELF, nDC, nDamage);
                    nDamage = nDamage + 10;
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
                }
        }
    }
}
