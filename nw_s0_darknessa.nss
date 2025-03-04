//::///////////////////////////////////////////////
//:: Darkness: On Enter by Alexander G.
//:://////////////////////////////////////////////
#include "x0_i0_spells"

#include "x2_inc_spellhook"

void main()
{

    int nMetaMagic = GetMetaMagicFeat();
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    effect eDark = EffectBlindness();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eDark, eDur);
    effect eLink2 =  EffectLinkEffects(eInvis, eDur);
    object oTarget = GetEnteringObject();

    // * July 2003: If has darkness then do not put it on it again
    if (GetHasEffect(EFFECT_TYPE_DARKNESS, oTarget) == TRUE)
    {
        return;
    }

    //Apply custom variable for other abilities to track
    SetLocalInt(oTarget, "SHADOW_IN_DARKNESS", 1);

    if(GetIsObjectValid(oTarget) && oTarget != GetAreaOfEffectCreator())
    {
        if (GetIsReactionTypeHostile(oTarget, GetAreaOfEffectCreator()))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetEffectSpellId(eLink)));
        }
        else
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetEffectSpellId(eLink), FALSE));
        }
        // Creatures immune to the darkness spell are not affected.
        if (GetIsReactionTypeHostile(oTarget, GetAreaOfEffectCreator()))
        {
            //Remove all existing aura effects
            effect eEffect = GetFirstEffect(oTarget);
            int nCheck = 0;
            while(GetIsEffectValid(eEffect))
            {
                if(GetEffectType(eEffect) == EFFECT_TYPE_ULTRAVISION || GetEffectType(eEffect) == EFFECT_TYPE_TRUESEEING)
                {
                    nCheck = 1;
                }
                eEffect = GetNextEffect(oTarget);
            }
            //Fire cast spell at event for the specified target
            if(nCheck != 1)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
            }
        }
    }
    else if (oTarget == GetAreaOfEffectCreator())
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetEffectSpellId(eLink), FALSE));
        //Fire cast spell at event for the specified target
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink2, oTarget);
    }
}
