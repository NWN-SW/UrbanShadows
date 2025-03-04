//Custom Holy Avenger bullets
#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if(nEvent == X2_ITEM_EVENT_ONHITCAST)
    {
        // evaluate on the weapon that is calling the script; is it a on-hit two-hander? (defined by ON_2H)
        object oItem = GetSpellCastItem();
        string sItemTag = GetTag(oItem);
        string sItemTagOnHitGun = GetStringLeft(sItemTag, 5);
        if(sItemTagOnHitGun != "OH_GU")
        {
            SendMessageToPC(OBJECT_SELF, "Return OH_GU");
            return;
        }
        // if so, does it have a supported and valid damage type?
        string sItemTagDamageType = GetStringRight(sItemTag, 4);
        if(sItemTagDamageType != "HOAV")
        {
            SendMessageToPC(OBJECT_SELF, "Return HOAV");
            return;
        }

        // if so, store a reference to the PC and his location
        object oPC = OBJECT_SELF;
        object oHolder;
        object oEnemy = GetAttackTarget(OBJECT_SELF);
        location lLocation = GetLocation(oEnemy);

        // roll for damage
        int nDEX = GetAbilityModifier(ABILITY_DEXTERITY, oPC);
        int nRolledDamage = d10(3) + (nDEX * 2) + 5; //Assuming 12 STR Mod 27 to 54 damage.
        float fRadius = 10.0f;

        //Beam effect from main target
        effect eBeam = EffectBeam(VFX_BEAM_HOLY, oEnemy, BODY_NODE_HAND);

        //Other visual effects and damage
       effect eDamage = EffectDamage(nRolledDamage, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL);
       effect eVis = EffectVisualEffect(98);
       effect eVis2 = EffectVisualEffect(189);
       effect eSlow = EffectMovementSpeedDecrease(75);

        //Apply damage to the first target and the VFX impact.
        if(nRolledDamage > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oEnemy);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oEnemy);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oEnemy);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oEnemy, 6.0f);
        }

        //Set delay and counter fo chain
        float fDelay = 0.2;
        int nCnt = 0;

        // detect the first creature in line of sight in a small~medium sphere
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oEnemy), TRUE, OBJECT_TYPE_CREATURE);
        while (GetIsObjectValid(oTarget) && nCnt < 10)
        {
            //Make sure the caster's faction is not hit and the first target is not hit
            if (oTarget != oEnemy && GetIsReactionTypeHostile(oTarget) && oTarget != OBJECT_SELF)
            {
               //Connect the new lightning stream to the older target and the new target
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,0.5));

               // apply it
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, 6.0f));

               //Set holder
               oHolder = oTarget;

                //change the currect holder of the lightning stream to the current target
                if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
                {
                    eBeam = EffectBeam(VFX_BEAM_HOLY, oHolder, BODY_NODE_CHEST);
                }
                else
                {
                    // * April 2003 trying to make sure beams originate correctly
                    effect eNewBeam = EffectBeam(VFX_BEAM_HOLY, oHolder, BODY_NODE_CHEST);
                    if(GetIsEffectValid(eNewBeam))
                    {
                        eBeam =  eNewBeam;
                    }
                }

                fDelay = fDelay + 0.1f;
            }
            //Count the number of targets that have been hit.
            if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
            {
                nCnt++;
            }
            // check if there are more creatures in the defined radius, if so, loop over them with the same logic
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oEnemy), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    // this is to inform the module the script has ended
    SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
}
