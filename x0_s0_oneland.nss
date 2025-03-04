//::///////////////////////////////////////////////
//:: One with the Land
//:: x0_s0_oneland.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
 bonus +3: animal empathy, move silently, search, hide
 Duration: 1 hour/level
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: July 19, 2002
//:://////////////////////////////////////////////
//:: Last Update By: Andrew Nobbs May 01, 2003
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
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

//This spell has been changed to teleport the player to Agartha.

    //Declare major variables
    object oWP = GetWaypointByTag("tp_recall");
    object oCaster = OBJECT_SELF;
    location lWP = GetLocation(oWP);
    location lPC = GetLocation(oCaster);
    effect ePortal = EffectVisualEffect(VFX_IMP_POLYMORPH);
    string sArea = GetTag(GetArea(OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lPC, TRUE, OBJECT_TYPE_CREATURE);
    object oLeader = GetFactionLeader(oCaster);
    object oCompareLeader;

    //Area compare
    if(sArea != "Hell_1" && sArea != "TheEnd_WZ")
    {
        //Cycle through the targets within the spell shape until an invalid object is captured.
        while (GetIsObjectValid(oTarget))
        {
            if(GetIsPC(oTarget))
            {
                oCompareLeader = GetFactionLeader(oTarget);
                if (oCompareLeader == oLeader)
                {
                    //Unsummon pets
                    DestroyObject(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oTarget));
                    //VFX
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePortal, oTarget);
                    //Teleport
                    DelayCommand(1.0, AssignCommand(oTarget, ActionJumpToObject(oWP)));
                    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, lWP);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lPC, TRUE, OBJECT_TYPE_CREATURE);
        }
        //Class mechanics
        string sSpellType = "Buff";
        DoClassMechanic(sSpellType, "AOE", 0, OBJECT_SELF);
    }
    else
    {
        SendMessageToPC(OBJECT_SELF, "Your fizzles. It doesn't seem to work in this place.");
    }
}

/* OLD SPELL
    //Declare major variables
    object oTarget = OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    int nMetaMagic = GetMetaMagicFeat();

    effect eSkillAnimal = EffectSkillIncrease(SKILL_ANIMAL_EMPATHY, 4);
    effect eHide = EffectSkillIncrease(SKILL_HIDE, 4);
    effect eMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 4);
    effect eSearch = EffectSkillIncrease(SKILL_SET_TRAP, 4);

    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eSkillAnimal, eMove);
    eLink = EffectLinkEffects(eLink, eHide);
    eLink = EffectLinkEffects(eLink, eSearch);

    eLink = EffectLinkEffects(eLink, eDur);

    int nDuration = GetCasterLevel(OBJECT_SELF); // * Duration 1 hour/level
     if (nMetaMagic == METAMAGIC_EXTEND)    //Duration is +100%
    {
         nDuration = nDuration * 2;
    }

    //Fire spell cast at event for target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 420, FALSE));
    //Apply VFX impact and bonus effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));

}

*/



