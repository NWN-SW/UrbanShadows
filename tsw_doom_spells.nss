#include "spell_dmg_inc"

//FORETELLING
void DoDoomAOE(object oCaster)
{
    int nCheck = GetLocalInt(oCaster, "DOOMSEER_FORETELLING");
    if(nCheck != 1)
    {
        return;
    }

    //Effect variables
    effect eVis;
    effect eBoom;
    effect eDamage;
    string sElement;
    int nDamageType;
    float fDelay;

    if(GetHasFeat(DOOM_PROPHECY_FIRE, oCaster))
    {
        eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
        eBoom = EffectVisualEffect(VFX_IMP_HEAD_FIRE);
        sElement = "Fire";
        nDamageType = DAMAGE_TYPE_FIRE;
    }
    else if(GetHasFeat(DOOM_PROPHECY_COLD, oCaster))
    {
        eVis = EffectVisualEffect(VFX_IMP_FROST_S);
        eBoom = EffectVisualEffect(VFX_IMP_HEAD_COLD);
        sElement = "Cold";
        nDamageType = DAMAGE_TYPE_COLD;
    }
    else if(GetHasFeat(DOOM_PROPHECY_ELEC, oCaster))
    {
        eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
        eBoom = EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY);
        sElement = "Elec";
        nDamageType = DAMAGE_TYPE_ELECTRICAL;
    }

    //Loop through targets in shape
    object oAttackee = GetAttackTarget(oCaster);
    float fSize = GetSpellArea(6.0);
    int nDamage;
    int nFinalDamage;
    string sTargets;
    int nTargetCheck;
    object oMainTarget;
    int nReduction;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oAttackee), TRUE, OBJECT_TYPE_CREATURE);

    //Do personal VFX
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, oCaster);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (GetIsReactionTypeHostile(oTarget, oCaster))
        {
            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetFifthLevelDamage(oTarget, 10, sTargets);
                nDamage = nDamage / 5;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIREBALL));

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Set the damage effect
            eDamage = EffectDamage(nFinalDamage, nDamageType);
            if(nFinalDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                fDelay = fDelay + 0.1;
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oAttackee), TRUE, OBJECT_TYPE_CREATURE);
    }
}

//PROPHECY
void DoDoomChain(object oCaster)
{
    int nCheck = GetLocalInt(oCaster, "DOOMSEER_PROPHECY");
    if(nCheck != 1)
    {
        return;
    }

    //Effect variables
    effect eVis;
    effect eBoom;
    effect eLightning;
    effect eDamage;
    string sElement;
    int nBeamType;
    int nDamageType;

    if(GetHasFeat(DOOM_PROPHECY_FIRE, oCaster))
    {
        eLightning = EffectBeam(VFX_BEAM_FIRE, oCaster, BODY_NODE_CHEST, FALSE, 5.0);
        eBoom = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
        nBeamType = VFX_BEAM_FIRE;
        eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
        sElement = "Fire";
        nDamageType = DAMAGE_TYPE_FIRE;
    }
    else if(GetHasFeat(DOOM_PROPHECY_COLD, oCaster))
    {
        eLightning = EffectBeam(VFX_BEAM_COLD, oCaster, BODY_NODE_CHEST, FALSE, 5.0);
        eBoom = EffectVisualEffect(VFX_IMP_PULSE_COLD);
        nBeamType = VFX_BEAM_COLD;
        eVis = EffectVisualEffect(VFX_IMP_FROST_S);
        sElement = "Cold";
        nDamageType = DAMAGE_TYPE_COLD;
    }
    else if(GetHasFeat(DOOM_PROPHECY_ELEC, oCaster))
    {
        eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oCaster, BODY_NODE_CHEST);
        eBoom = EffectVisualEffect(VFX_IMP_PULSE_WIND);
        nBeamType = VFX_BEAM_LIGHTNING;
        eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
        sElement = "Elec";
        nDamageType = DAMAGE_TYPE_ELECTRICAL;
    }

    //Do personal VFX
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, GetLocation(oCaster));

    //Declare major variables
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    //Limit caster level
    // June 2/04 - Bugfix: Cap the level BEFORE the damage calculation, not after. Doh.
    int nDamage;;
    int nDamStrike;
    int nNumAffected = 0;
    int nFinalDamage;
    //Declare lightning effect connected the casters hands
    object oFirstTarget = GetAttemptedAttackTarget();
    object oHolder;
    object oTarget;
    location lSpellLocation;
    float fSize = GetSpellArea(10.0);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        nDamage = GetNinthLevelDamage(oFirstTarget, nCasterLevel, sTargets);
        nDamage = nDamage / 5;

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

        //Track the first valid target for class mechanics
        object oMainTarget;
        int nTargetCheck = 0;
    //End Custom Spell-Function Block

    //Damage the initial target
    if (GetIsReactionTypeHostile(oFirstTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oFirstTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        //Adjust damage based on Alchemite and Saving Throw
        nFinalDamage = GetReflexDamage(oFirstTarget, nReduction, nDamage);

        //Set the damage effect for the first target
        eDamage = EffectDamage(nFinalDamage, nDamageType);
        //Apply damage to the first target and the VFX impact.
        if(nDamage > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oFirstTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oFirstTarget);
        }
    }
    //Apply the lightning stream effect to the first target, connecting it with the caster
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightning, oFirstTarget, 0.5);

    //Reinitialize the lightning effect so that it travels from the first target to the next target
    if(GetHasFeat(DOOM_PROPHECY_FIRE, oCaster))
    {
        eLightning = EffectBeam(VFX_BEAM_FIRE, oFirstTarget, BODY_NODE_CHEST, FALSE, 5.0);
    }
    else if(GetHasFeat(DOOM_PROPHECY_COLD, oCaster))
    {
        eLightning = EffectBeam(VFX_BEAM_COLD, oFirstTarget, BODY_NODE_CHEST, FALSE, 5.0);
    }
    else if(GetHasFeat(DOOM_PROPHECY_ELEC, oCaster))
    {
        eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oFirstTarget, BODY_NODE_CHEST);
    }

    float fDelay = 0.2;
    int nCnt = 0;

    // *
    // * Secondary Targets
    // *

    //Get the first target in the spell shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);

    while (GetIsObjectValid(oTarget) && nCnt < 40)
    {
        //Make sure the caster's faction is not hit and the first target is not hit
        if (oTarget != oFirstTarget && GetIsReactionTypeHostile(oTarget) && oTarget != OBJECT_SELF)
        {
            //Connect the new lightning stream to the older target and the new target
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,0.5));

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Apply the damage and VFX impact to the current target
            eDamage = EffectDamage(nFinalDamage, nDamageType);
            if(nDamage > 0) //Damage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
            }
            oHolder = oTarget;

            //change the currect holder of the lightning stream to the current target
            if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
            {
                if(GetHasFeat(DOOM_PROPHECY_FIRE, oCaster))
                {
                    eLightning = EffectBeam(VFX_BEAM_FIRE, oHolder, BODY_NODE_CHEST, FALSE, 5.0);
                }
                else if(GetHasFeat(DOOM_PROPHECY_COLD, oCaster))
                {
                    eLightning = EffectBeam(VFX_BEAM_COLD, oHolder, BODY_NODE_CHEST, FALSE, 5.0);
                }
                else if(GetHasFeat(DOOM_PROPHECY_ELEC, oCaster))
                {
                    eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oHolder, BODY_NODE_CHEST);
                }
            }
            else
            {
                // * April 2003 trying to make sure beams originate correctly
                effect eNewLightning;
                if(GetHasFeat(DOOM_PROPHECY_FIRE, oCaster))
                {
                    eNewLightning = EffectBeam(VFX_BEAM_FIRE, oHolder, BODY_NODE_CHEST, FALSE, 5.0);
                }
                else if(GetHasFeat(DOOM_PROPHECY_COLD, oCaster))
                {
                    eNewLightning = EffectBeam(VFX_BEAM_COLD, oHolder, BODY_NODE_CHEST, FALSE, 5.0);
                }
                else if(GetHasFeat(DOOM_PROPHECY_ELEC, oCaster))
                {
                    eNewLightning = EffectBeam(VFX_BEAM_LIGHTNING, oHolder, BODY_NODE_CHEST);
                }

                if(GetIsEffectValid(eNewLightning))
                {
                    eLightning =  eNewLightning;
                }
            }

            fDelay = fDelay + 0.1f;
        }
        //Count the number of targets that have been hit.
        if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            nCnt++;
        }

        // April 2003: Setting the new origin for the beam
       // oFirstTarget = oTarget;

        //Get the next target in the shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
    }
}

//VISION
void DoDoomMissiles(object oCaster)
{
    int nCheck = GetLocalInt(oCaster, "DOOMSEER_VISION");
    if(nCheck != 1)
    {
        return;
    }

    //Effect variables
    effect eVis;
    effect eBoom;
    effect eMissile;
    effect eDamage;
    string sElement;
    int nDamageType;

    if(GetHasFeat(DOOM_PROPHECY_FIRE, oCaster))
    {
        eMissile = EffectVisualEffect(1090);
        eBoom = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
        eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
        sElement = "Fire";
        nDamageType = DAMAGE_TYPE_FIRE;
    }
    else if(GetHasFeat(DOOM_PROPHECY_COLD, oCaster))
    {
        eMissile = EffectVisualEffect(1091);
        eBoom = EffectVisualEffect(VFX_IMP_PULSE_COLD);
        eVis = EffectVisualEffect(VFX_IMP_FROST_S);
        sElement = "Cold";
        nDamageType = DAMAGE_TYPE_COLD;
    }
    else if(GetHasFeat(DOOM_PROPHECY_ELEC, oCaster))
    {
        eMissile = EffectVisualEffect(503);
        eBoom = EffectVisualEffect(VFX_IMP_PULSE_WIND);
        eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
        sElement = "Elec";
        nDamageType = DAMAGE_TYPE_ELECTRICAL;
    }

    //Loop through targets in shape
    object oAttackee = GetAttackTarget(oCaster);
    float fSize = GetSpellArea(6.0);
    int nDamage;
    int nFinalDamage;
    string sTargets = "Single";
    int nTargetCheck;
    object oMainTarget;
    int nReduction;
    float fDelay;
    int nCount;
    int nMainCounter;
    int nMissiles = 20;
    int nMissilesPer;
    location lLoc = GetLocation(oAttackee);

    //Do personal VFX
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, GetLocation(oCaster));

    //How many targets are there?
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget) && nCount <= nMissiles)
    {
        if(GetIsReactionTypeHostile(oTarget, oCaster))
        {
            nCount = nCount + 1;
        }
        //Get the next target in the shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);
    }

    if(nCount > 20)
    {
        nCount =  20;
    }

    if(nCount > 1)
    {
        sTargets = "AOE";
    }

    //Do the actual missile loop this time
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget) && nMainCounter <= nCount)
    {
        if(GetIsReactionTypeHostile(oTarget, oCaster))
        {
            //Delay calculations
            float fDist = GetDistanceBetween(oCaster, oTarget);
            float fDelay = fDist/(3.0 * log(fDist) + 2.0);
            float fDelay2, fTime;

            fTime = fDelay;
            fDelay2 += 0.1;
            fTime += fDelay2;

            //Start Custom Spell-Function Block
                //Get damage
                nDamage = GetSeventhLevelDamage(oTarget, 5, sTargets);
                nDamage = nDamage / 5;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Set the damage effect
            effect eDam = EffectDamage(nFinalDamage, nDamageType);

            DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
            DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
        }
        nMainCounter = nMainCounter + 1;
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);
    }
}
