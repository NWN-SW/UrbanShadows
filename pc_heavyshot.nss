//Custom feat Heavy Shot by Alexander G.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_get_martial"

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
    if(!GetWeaponRanged(GetItemInSlot(4, OBJECT_SELF)))
    {
        SendMessageToPC(OBJECT_SELF, "This ability only works with ranged weapons.");
        return;
    }

    //Declare major variables
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oPC = OBJECT_SELF;
    int nDamage;
    int nMetaMagic = GetMetaMagicFeat();
    //Set the lightning stream to start at the caster's hands
    //effect eLightning = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND);
    effect eVis  = EffectVisualEffect(VFX_COM_CHUNK_RED_BALLISTA);
    effect eDamage;
    object oTarget = GetSpellTargetObject();
    location lTarget = GetLocation(oTarget);
    object oNextTarget, oTarget2;
    float fDelay;
    int nCnt = 1;

    //Get the total martial class levels.
    int nClassTotal = GetMartialLevel(oPC);

    oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTarget2) && GetDistanceToObject(oTarget2) <= 30.0)
    {
        //Get first target in the lightning area by passing in the location of first target and the casters vector (position)
        oTarget = GetFirstObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
        while (GetIsObjectValid(oTarget))
        {
           //Exclude the caster from the damage effects
           if (oTarget != OBJECT_SELF && oTarget2 == oTarget)
           {
                if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
                {
                   //Fire cast spell at event for the specified target
                   SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

                    //Roll damage for each target
                    nDamage = nClassTotal * GetAbilityModifier(1, oPC);

                    //Set damage effect
                    eDamage = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING);
                    if(nDamage > 0)
                    {
                        fDelay = GetSpellEffectDelay(GetLocation(oTarget), oTarget);
                        //Apply VFX impcat, damage effect and lightning effect
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                    }

                    //ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.0);
                    //Set the currect target as the holder of the lightning effect
                    oNextTarget = oTarget;
                    //eLightning = EffectBeam(VFX_BEAM_EVIL, oNextTarget, BODY_NODE_CHEST);
                }
           }
           //Get the next object in the lightning cylinder
           oTarget = GetNextObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
        }
        nCnt++;
        oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCnt);
    }
}

