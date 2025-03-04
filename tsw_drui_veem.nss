//::///////////////////////////////////////////////
//:: Verdant Embrace by Alexander G.
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "utl_i_sqlplayer"
#include "tsw_class_func"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Get the spell target
    object oTarget = GetSpellTargetObject();
    //Check to make sure the target is dead first
    //Fire cast spell at event for the specified target
    if (GetIsObjectValid(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if(GetIsDead(oTarget))
        {
            //Declare major variables
            int nHealed = GetMaxHitPoints(oTarget);
            effect eRaise = EffectResurrection();
            effect eHeal = EffectHeal(nHealed / 2);
            effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
            effect eVis2 = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
            //Apply the heal, raise dead and VFX impact effect
            //Remove variables if dead
            if(GetIsDead(oTarget))
            {
                SQLocalsPlayer_DeleteInt(oTarget, "CURRENTLY_DEAD");

                //Blood Mage check
                int nRitual = GetLocalInt(oTarget, "I_AM_BLOODMAGE");
                if(nRitual >= 1)
                {
                    SetLocalInt(oTarget, "I_AM_BLOODMAGE", 1);
                }

                ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis2, GetLocation(oTarget));

                //Class mechanics
                string sSpellType = "Buff";
                DoClassMechanic(sSpellType, "Single", 0, oTarget);

                // Jasperre's additions...
                AssignCommand(oTarget, SpeakString("I AM ALIVE!", TALKVOLUME_SILENT_TALK));
                if(!GetIsPC(oTarget) && !GetIsDMPossessed(oTarget))
                {
                    // Default AI script
                    ExecuteScript("nw_c2_default3", oTarget);
                }
            }
        }
    }
}

