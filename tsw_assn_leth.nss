#include "tsw_class_consts"
#include "spell_dmg_inc"

void DoLethality(object oTarget)
{
    //AOEs cannot use GetLastSpellCastClass when calling this function. This is a workaround.
    int nClass1;
    int nClass2;
    int nClass3;
    nClass1 = GetClassByPosition(1, OBJECT_SELF);
    nClass2 = GetClassByPosition(2, OBJECT_SELF);
    nClass3 = GetClassByPosition(3, OBJECT_SELF);

    if(nClass1 == CLASS_TYPE_NEW_ASSIN ||
        nClass2 == CLASS_TYPE_NEW_ASSIN ||
        nClass3 == CLASS_TYPE_NEW_ASSIN)
    {

        //Get Assassin combo tracker
        int nAssnLocal = GetLocalInt(OBJECT_SELF, "ASSASSIN_COMBO_LOCAL");

        //How many hits per exceution? Hits - 1.
        int nMax = 9;

        //Get target's last received hit
        int nLastHit = GetLocalInt(oTarget, "LAST_DAMAGE_RECEIVED");

        if(GetHasFeat(ASSN_VIRULENT)&& nAssnLocal >= nMax)
        {
            //Declare the spell shape, size and the location.  Capture the first target object in the shape.
            object oPrimeTarget = GetFirstObjectInShape(SHAPE_SPHERE, 6.0, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);

            //Effects and Variables
            effect eVis = EffectVisualEffect(VFX_COM_HIT_ACID);
            int nAbility = GetHighestAbilityModifier(OBJECT_SELF);
            int nHeal = nAbility;
            int nBigDead = nLastHit * 3;
            effect eHeal = EffectHeal(nHeal);
            effect eAura = EffectVisualEffect(1084);


            //Cycle through the targets within the spell shape until an invalid object is captured.
            while(GetIsObjectValid(oPrimeTarget))
            {
                if (GetIsReactionTypeHostile(oPrimeTarget) && oPrimeTarget != OBJECT_SELF)
                {
                    if(nBigDead > 0)
                    {
                        // Apply effects to the currently selected target.  For this spell we have used
                        //both Divine and Fire damage.
                        effect eDam = EffectDamage(nBigDead, DAMAGE_TYPE_ACID);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPrimeTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPrimeTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);
                        //ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, OBJECT_SELF);
                    }
                }
                //Select the next target within the spell shape.
                oPrimeTarget = GetNextObjectInShape(SHAPE_SPHERE, 6.0, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
            }
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
            FloatingTextStringOnCreature("Lethality Bonus Damage!", OBJECT_SELF, TRUE);
            //Sound Effects
            PlaySoundByStrRef(16778120, FALSE);

            //Reset variable
            SetLocalInt(OBJECT_SELF, "ASSASSIN_COMBO_LOCAL", 0);
        }
        else if(GetHasFeat(ASSN_LETHALITY) && nAssnLocal >= nMax && !GetHasFeat(ASSN_VIRULENT))
        {
            int nAbility = GetHighestAbilityModifier(OBJECT_SELF);
            int nHeal = nAbility;
            int nBigDead = nLastHit * 3;
            effect eHeal = EffectHeal(nHeal);
            effect eAura = EffectVisualEffect(1084);
            effect eKill = EffectDamage(nBigDead, DAMAGE_TYPE_PIERCING);
            effect eVis = EffectVisualEffect(VFX_COM_CHUNK_RED_MEDIUM);
            effect eHealVis = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);
            //ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, OBJECT_SELF);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
            FloatingTextStringOnCreature("Lethality Bonus Damage!", OBJECT_SELF, TRUE);

            //Sound Effects
            PlaySoundByStrRef(16778120, FALSE);

            //Reset variable
            SetLocalInt(OBJECT_SELF, "ASSASSIN_COMBO_LOCAL", 0);
        }
        else
        {
            nAssnLocal = nAssnLocal + 1;
            SetLocalInt(OBJECT_SELF, "ASSASSIN_COMBO_LOCAL", nAssnLocal);
        }
    }
}
