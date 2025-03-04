#include "tsw_get_rndmloc"
#include "spell_dmg_inc"
#include "X0_I0_SPELLS"
#include "tsw_random_debuf"

const int VFX_IMP_MIRV_FIREBALL = 822;

void main()
{
    string sTitle = GetLocalString(OBJECT_SELF, "BOSS_TITLE");
    string sRarity = GetLocalString(OBJECT_SELF, "BOSS_RARITY");
    int nBuffed = GetLocalInt(OBJECT_SELF, "BOSS_BUFFED");

    if(nBuffed == 1)
    {
        ExecuteScript("nw_c2_default3", OBJECT_SELF);
        return;
    }
    //Bonus bludgeoning damage
    if(sTitle == "Hammer")
    {
        effect eDamage;
        effect eAttack;

        if(sRarity == "Common")
        {
            eDamage = EffectDamageIncrease(5, DAMAGE_TYPE_BLUDGEONING);
            eAttack = EffectAttackIncrease(2);
        }
        else if(sRarity == "Uncommon")
        {
            eDamage = EffectDamageIncrease(8, DAMAGE_TYPE_BLUDGEONING);
            eAttack = EffectAttackIncrease(2);
        }
        else if(sRarity == "Rare")
        {
            eDamage = EffectDamageIncrease(10, DAMAGE_TYPE_BLUDGEONING);
            eAttack = EffectAttackIncrease(6);
        }
        else if(sRarity == "Legendary")
        {
            eDamage = EffectDamageIncrease(20, DAMAGE_TYPE_BLUDGEONING);
            eAttack = EffectAttackIncrease(10);
        }
        eDamage = SupernaturalEffect(eDamage);
        eAttack = SupernaturalEffect(eAttack);
        effect eLink = EffectLinkEffects(eDamage, eAttack);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "BOSS_BUFFED", 1);
    }
    //Bonus slashing damage
    else if(sTitle == "Axe")
    {
        effect eDamage;
        effect eAttack;

        if(sRarity == "Common")
        {
            eDamage = EffectDamageIncrease(5, DAMAGE_TYPE_SLASHING);
            eAttack = EffectAttackIncrease(2);
        }
        else if(sRarity == "Uncommon")
        {
            eDamage = EffectDamageIncrease(8, DAMAGE_TYPE_SLASHING);
            eAttack = EffectAttackIncrease(2);
        }
        else if(sRarity == "Rare")
        {
            eDamage = EffectDamageIncrease(10, DAMAGE_TYPE_SLASHING);
            eAttack = EffectAttackIncrease(6);
        }
        else if(sRarity == "Legendary")
        {
            eDamage = EffectDamageIncrease(20, DAMAGE_TYPE_SLASHING);
            eAttack = EffectAttackIncrease(10);
        }
        eDamage = SupernaturalEffect(eDamage);
        eAttack = SupernaturalEffect(eAttack);
        effect eLink = EffectLinkEffects(eDamage, eAttack);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "BOSS_BUFFED", 1);
    }
    else if(sTitle == "Sharp")
    {
        effect eDamage;
        effect eAttack;

        if(sRarity == "Common")
        {
            eDamage = EffectDamageIncrease(5, DAMAGE_TYPE_PIERCING);
            eAttack = EffectAttackIncrease(2);
        }
        else if(sRarity == "Uncommon")
        {
            eDamage = EffectDamageIncrease(8, DAMAGE_TYPE_PIERCING);
            eAttack = EffectAttackIncrease(2);
        }
        else if(sRarity == "Rare")
        {
            eDamage = EffectDamageIncrease(10, DAMAGE_TYPE_PIERCING);
            eAttack = EffectAttackIncrease(6);
        }
        else if(sRarity == "Legendary")
        {
            eDamage = EffectDamageIncrease(20, DAMAGE_TYPE_PIERCING);
            eAttack = EffectAttackIncrease(10);
        }
        eDamage = SupernaturalEffect(eDamage);
        eAttack = SupernaturalEffect(eAttack);
        effect eLink = EffectLinkEffects(eDamage, eAttack);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "BOSS_BUFFED", 1);
    }
    //Random AOE of spikes
    else if(sTitle == "Jagged")
    {
        effect eBlood = EffectVisualEffect(VFX_COM_CHUNK_RED_MEDIUM);
        effect eSpikes = EffectVisualEffect(VFX_IMP_SPIKE_TRAP);
        effect eExplosion = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL);
        effect eDam;
        effect eLink = EffectLinkEffects(eBlood, eSpikes);
        int nRandom = 4 + Random(6);
        float fDistance = IntToFloat(nRandom);
        location lLoc = GetNewRandomLocation(GetLocation(OBJECT_SELF), fDistance);
        int nDamage;
        int nDC;

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplosion, lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpikes, lLoc);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc, TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 10 + d10(1);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 20 + d10(2);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Rare")
            {
                nDamage = 30 + d10(3);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 40 + d10(4);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }

            if (GetIsReactionTypeHostile(oTarget))
            {
                nDamage = GetFortDamage(oTarget, nDC, nDamage);
                //Set Damage
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING);
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Swinging blades do damage and reduce AC by 4 for 12 seconds
    else if(sTitle == "Flayer")
    {
        effect eBlood = EffectVisualEffect(VFX_COM_CHUNK_RED_MEDIUM);
        effect eSpikes = EffectVisualEffect(VFX_FNF_SWINGING_BLADE);
        effect eDam;
        effect eAC = EffectACDecrease(2);
        effect eLink = EffectLinkEffects(eBlood, eSpikes);
        int nDamage;
        int nDC;

        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 5 + d10(2);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 10 + d10(3);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Rare")
            {
                nDamage = 15 + d10(4);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 20 + d10(5);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }

            if (GetIsReactionTypeHostile(oTarget))
            {
                nDamage = GetReflexDamage(oTarget, nDC, nDamage);
                //Set Damage
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING);
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oTarget, 18.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses slasing damage. Lowers slash resist by 20%
    else if(sTitle == "Slasher")
    {
        effect eBlood = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
        effect eSpikes = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
        effect eDam;
        effect eEffect = EffectDamageImmunityDecrease(DAMAGE_TYPE_SLASHING, 10);
        effect eLink = EffectLinkEffects(eBlood, eSpikes);
        int nDamage;
        int nDC;

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpikes, GetLocation(OBJECT_SELF));
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 5 + d10(2);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 10 + d10(3);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Rare")
            {
                nDamage = 15 + d10(4);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 20 + d10(5);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }

            if (GetIsReactionTypeHostile(oTarget))
            {
                nDamage = GetReflexDamage(oTarget, nDC, nDamage);
                //Set Damage
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING);
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 12.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Line damage at a random target
    else if(sTitle == "Impaler")
    {
        effect eBlood = EffectVisualEffect(VFX_COM_CHUNK_RED_MEDIUM);
        effect eFlame = EffectVisualEffect(VFX_IMP_FLAME_M);
        effect eDam;
        effect eLink = EffectLinkEffects(eBlood, eFlame);
        int nDamage;
        int nDC;
        //Set the lightning stream to start at the caster's hands
        effect eLightning = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_HAND);

        object oMain = GetLastAttacker();
        if(GetDistanceToObject(oMain) > 15.0 && GetArea(OBJECT_SELF) != GetArea(oMain))
        {
            return;
        }
        location lTarget = GetLocation(oMain);
        object oNextTarget, oTarget2;
        float fDelay;
        int nCnt = 1;

        oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCnt);
        while(GetIsObjectValid(oTarget2) && GetDistanceToObject(oTarget2) <= 30.0)
        {
            //Get first target in the lightning area by passing in the location of first target and the casters vector (position)
            object oTarget = GetFirstObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
            while (GetIsObjectValid(oTarget))
            {
               //Exclude the caster from the damage effects
               if (oTarget != OBJECT_SELF && oTarget2 == oTarget)
               {
                    if (GetIsReactionTypeHostile(oTarget))
                    {
                       //Fire cast spell at event for the specified target
                       SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LIGHTNING_BOLT));
                        if(sRarity == "Common")
                        {
                            nDamage = 10 + d10(2);
                            nDamage = GetReflexDamage(oTarget, 0, nDamage);
                        }
                        else if(sRarity == "Uncommon")
                        {
                            nDamage = 15 + d10(3);
                            nDamage = GetReflexDamage(oTarget, 0, nDamage);
                        }
                        else if(sRarity == "Rare")
                        {
                            nDamage = 20 + d10(4);
                            nDamage = GetReflexDamage(oTarget, 0, nDamage);
                        }
                        else if(sRarity == "Legendary")
                        {
                            nDamage = 25 + d10(5);
                            nDamage = GetReflexDamage(oTarget, 0, nDamage);
                        }

                        //Set damage effect
                        effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                        if(nDamage > 0)
                        {
                            fDelay = GetSpellEffectDelay(GetLocation(oTarget), oTarget);
                            //Apply VFX impcat, damage effect and lightning effect
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget));
                        }
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.0);
                        //Set the currect target as the holder of the lightning effect
                        oNextTarget = oTarget;
                        eLightning = EffectBeam(VFX_BEAM_FIRE, oNextTarget, BODY_NODE_CHEST);
                    }
               }
               //Get the next object in the lightning cylinder
               oTarget = GetNextObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
            }
            nCnt++;
            oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCnt);
        }
    }
    //Pulses physical damage reduction
    else if(sTitle == "Slayer")
    {
        effect eAura = EffectVisualEffect(VFX_DUR_AURA_PULSE_GREY_BLACK);
        effect eDebuff = EffectVisualEffect(VFX_IMP_DOOM);
        effect eDam;
        effect eEffect = EffectDamageImmunityDecrease(DAMAGE_TYPE_SLASHING, 25);
        effect eEffect1 = EffectDamageImmunityDecrease(DAMAGE_TYPE_PIERCING, 25);
        effect eEffect2 = EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING, 25);
        effect eLink = EffectLinkEffects(eEffect, eEffect1);
        eLink = EffectLinkEffects(eLink, eEffect2);
        int nDamage;
        float fDuration;
        int nDC;

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, 7.0);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                fDuration = GetFortDuration(oTarget, 0, 12.0);
            }
            else if(sRarity == "Uncommon")
            {
                fDuration = GetFortDuration(oTarget, 0, 13.0);
            }
            else if(sRarity == "Rare")
            {
                fDuration = GetFortDuration(oTarget, 0, 14.0);
            }
            else if(sRarity == "Legendary")
            {
                fDuration = GetFortDuration(oTarget, 0, 16.0);
            }

            if (GetIsReactionTypeHostile(oTarget))
            {
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses REFLEX reduction.
    else if(sTitle == "Mauler")
    {
        effect eAura = EffectVisualEffect(VFX_DUR_AURA_GREEN_LIGHT);
        effect eDebuff = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        effect eDam;
        effect eEffect;
        int nDamage;
        int nDC;
        float fDuration;

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, 7.0);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                fDuration = GetFortDuration(oTarget, 0, 6.0);
                eEffect = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, 5);
            }
            else if(sRarity == "Uncommon")
            {
                fDuration = GetFortDuration(oTarget, 0, 7.0);
                eEffect = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, 10);
            }
            else if(sRarity == "Rare")
            {
                fDuration = GetFortDuration(oTarget, 0, 8.0);
                eEffect = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, 15);
            }
            else if(sRarity == "Legendary")
            {
                fDuration = GetFortDuration(oTarget, 0, 9.0);
                eEffect = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, 20);
            }

            if (GetIsReactionTypeHostile(oTarget))
            {
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses FORT reduction.
    else if(sTitle == "Destroyer")
    {
        effect eAura = EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_ORANGE);
        effect eDebuff = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        effect eDam;
        effect eEffect;
        int nDamage;
        int nDC;
        float fDuration;

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, 7.0);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                fDuration = GetFortDuration(oTarget, 0, 6.0);
                eEffect = EffectSavingThrowDecrease(SAVING_THROW_FORT, 5);
            }
            else if(sRarity == "Uncommon")
            {
                fDuration = GetFortDuration(oTarget, 0, 7.0);
                eEffect = EffectSavingThrowDecrease(SAVING_THROW_FORT, 10);
            }
            else if(sRarity == "Rare")
            {
                fDuration = GetFortDuration(oTarget, 0, 8.0);
                eEffect = EffectSavingThrowDecrease(SAVING_THROW_FORT, 15);
            }
            else if(sRarity == "Legendary")
            {
                fDuration = GetFortDuration(oTarget, 0, 9.0);
                eEffect = EffectSavingThrowDecrease(SAVING_THROW_FORT, 20);
            }

            if (GetIsReactionTypeHostile(oTarget))
            {
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Bonus speed and magic damage
    if(sTitle == "Quick")
    {
        effect eDamage;
        effect eAttack;

        if(sRarity == "Common")
        {
            eDamage = EffectDamageIncrease(5, DAMAGE_TYPE_MAGICAL);
            eAttack = EffectMovementSpeedIncrease(99);
        }
        else if(sRarity == "Uncommon")
        {
            eDamage = EffectDamageIncrease(8, DAMAGE_TYPE_MAGICAL);
            eAttack = EffectMovementSpeedIncrease(99);
        }
        else if(sRarity == "Rare")
        {
            eDamage = EffectDamageIncrease(10, DAMAGE_TYPE_MAGICAL);
            eAttack = EffectMovementSpeedIncrease(99);
        }
        else if(sRarity == "Legendary")
        {
            eDamage = EffectDamageIncrease(20, DAMAGE_TYPE_MAGICAL);
            eAttack = EffectMovementSpeedIncrease(99);
        }
        eDamage = SupernaturalEffect(eDamage);
        eAttack = SupernaturalEffect(eAttack);
        effect eLink = EffectLinkEffects(eDamage, eAttack);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "BOSS_BUFFED", 1);
    }
    //Random effects applied to enemies every around
    if(sTitle == "Witch")
    {
        effect eAura = EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE);
        int nDC;
        float fDuration;
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);

        int nRounds = GetLocalInt(OBJECT_SELF, "BOSS_ROUND_COUNTER");
        if(nRounds == 0)
        {
            nRounds = nRounds + 1;
            SetLocalInt(OBJECT_SELF, "BOSS_ROUND_COUNTER", nRounds);
        }
        else if(nRounds >= 2)
        {
            SetLocalInt(OBJECT_SELF, "BOSS_ROUND_COUNTER", 0);

            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            while(oTarget != OBJECT_INVALID)
            {
                if(GetIsReactionTypeHostile(oTarget))
                {
                    if(sRarity == "Common")
                    {
                        fDuration = GetFortDuration(oTarget, 0, 3.0);
                    }
                    else if(sRarity == "Uncommon")
                    {
                        fDuration = GetFortDuration(oTarget, 0, 4.0);
                    }
                    else if(sRarity == "Rare")
                    {
                        fDuration = GetFortDuration(oTarget, 0, 5.0);
                    }
                    else if(sRarity == "Legendary")
                    {
                        fDuration = GetFortDuration(oTarget, 0, 6.0);
                    }
                    ApplyRandomEffect(oTarget, sRarity, fDuration);
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            }
        }
    }
    //Pulses Confusion.
    else if(sTitle == "Mad")
    {
        effect eDebuff = EffectVisualEffect(VFX_IMP_MIRV);
        effect eEffect = EffectConfused();
        effect eConfuse = EffectVisualEffect(VFX_IMP_CONFUSION_S);
        float fDist = 0.0;
        float fDelay = 0.0;
        float fDelay2, fTime;
        effect eDam;
        int nDamage;
        int nDC;
        float fDuration;

        int nRounds = GetLocalInt(OBJECT_SELF, "BOSS_ROUND_COUNTER");
        if(nRounds == 0)
        {
            nRounds = nRounds + 1;
            SetLocalInt(OBJECT_SELF, "BOSS_ROUND_COUNTER", nRounds);
        }
        else if(nRounds >= 2)
        {
            SetLocalInt(OBJECT_SELF, "BOSS_ROUND_COUNTER", 0);

            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            while(oTarget != OBJECT_INVALID)
            {
                if(sRarity == "Common")
                {
                    fDuration = GetWillDuration(oTarget, 0, 3.0);
                }
                else if(sRarity == "Uncommon")
                {
                    fDuration = GetWillDuration(oTarget, 0, 4.0);
                }
                else if(sRarity == "Rare")
                {
                    fDuration = GetWillDuration(oTarget, 0, 5.0);
                }
                else if(sRarity == "Legendary")
                {
                    fDuration = GetWillDuration(oTarget, 0, 6.0);
                }

                if (GetIsReactionTypeHostile(oTarget))
                {
                    // * recalculate appropriate distances
                    fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
                    fDelay = fDist/(3.0 * log(fDist) + 2.0);

                    fTime = fDelay;
                    fDelay2 += 0.1;
                    fTime += fDelay2;

                    //Apply impact VFX and damage
                    DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget));
                    DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration));
                    DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConfuse, oTarget));
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            }
        }
    }
    //50% Concealment
    if(sTitle == "Wraith")
    {
        effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_MIND);
        effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
        effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eCover = EffectConcealment(50);
        effect eLink = EffectLinkEffects(eDur, eCover);
        eLink = EffectLinkEffects(eLink, eVis);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, OBJECT_SELF, 12.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "BOSS_BUFFED", 1);
    }
    //25% Concealment
    if(sTitle == "Shade")
    {
        effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_MIND);
        effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
        effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eCover = EffectConcealment(25);
        effect eLink = EffectLinkEffects(eDur, eCover);
        eLink = EffectLinkEffects(eLink, eVis);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, OBJECT_SELF, 12.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "BOSS_BUFFED", 1);
    }
    //Dark chain damage
    if(sTitle == "Dead")
    {
        effect eBlood = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
        effect eFlame = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);
        effect eDam;
        effect eLink = EffectLinkEffects(eBlood, eFlame);
        int nDamage;
        int nDC;
        //Set the lightning stream to start at the caster's hands
        effect eLightning = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND);

        object oMain = GetLastAttacker();
        if(GetDistanceToObject(oMain) > 15.0 && GetArea(OBJECT_SELF) != GetArea(oMain))
        {
            return;
        }
        location lTarget = GetLocation(oMain);
        object oNextTarget, oTarget2;
        float fDelay;
        int nCnt = 1;

        oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCnt);
        while(GetIsObjectValid(oTarget2) && GetDistanceToObject(oTarget2) <= 30.0)
        {
            //Get first target in the lightning area by passing in the location of first target and the casters vector (position)
            object oTarget = GetFirstObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
            while (GetIsObjectValid(oTarget))
            {
               //Exclude the caster from the damage effects
               if (oTarget != OBJECT_SELF && oTarget2 == oTarget)
               {
                    if (GetIsReactionTypeHostile(oTarget))
                    {
                       //Fire cast spell at event for the specified target
                       SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LIGHTNING_BOLT));
                        if(sRarity == "Common")
                        {
                            nDamage = 10 + d10(2);
                            nDamage = GetWillDamage(oTarget, 0, nDamage);
                        }
                        else if(sRarity == "Uncommon")
                        {
                            nDamage = 15 + d10(3);
                            nDamage = GetWillDamage(oTarget, 0, nDamage);
                        }
                        else if(sRarity == "Rare")
                        {
                            nDamage = 20 + d10(4);
                            nDamage = GetWillDamage(oTarget, 0, nDamage);
                        }
                        else if(sRarity == "Legendary")
                        {
                            nDamage = 25 + d10(5);
                            nDamage = GetWillDamage(oTarget, 0, nDamage);
                        }

                        //Set damage effect
                        effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                        if(nDamage > 0)
                        {
                            fDelay = GetSpellEffectDelay(GetLocation(oTarget), oTarget);
                            //Apply VFX impcat, damage effect and lightning effect
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget));
                        }
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.0);
                        //Set the currect target as the holder of the lightning effect
                        oNextTarget = oTarget;
                        eLightning = EffectBeam(VFX_BEAM_EVIL, oNextTarget, BODY_NODE_CHEST);
                    }
               }
               //Get the next object in the lightning cylinder
               oTarget = GetNextObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
            }
            nCnt++;
            oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCnt);
        }
    }
    //Pulses negative energy damage.
    else if(sTitle == "Unholy")
    {
        effect eAura = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_RED);
        effect eDebuff = EffectVisualEffect(VFX_IMP_HARM);
        effect eDam;
        effect eEffect;
        int nDamage;
        int nDC;

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, 7.0);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 5 + d10(2);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 10 + d10(3);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Rare")
            {
                nDamage = 15 + d10(4);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 20 + d10(5);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }

            if(GetIsReactionTypeHostile(oTarget))
            {
                eEffect = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses sonic damage and slows.
    else if(sTitle == "Howler")
    {
        effect eAura = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
        effect eDebuff = EffectVisualEffect(VFX_IMP_SONIC);
        effect eSlow = EffectMovementSpeedDecrease(50);
        effect eDam;
        effect eEffect;
        int nDamage;
        int nDC;

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 10 + d10(2);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 15 + d10(3);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Rare")
            {
                nDamage = 20 + d10(4);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 25 + d10(5);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }

            if(GetIsReactionTypeHostile(oTarget))
            {
                eEffect = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, 2.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses fear
    else if(sTitle == "Grim")
    {
        effect eAura = EffectVisualEffect(VFX_FNF_HOWL_MIND);
        effect eDebuff = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
        effect eFear = EffectFrightened();
        int nDC;
        float fDuration;
        int nCD = GetLocalInt(OBJECT_SELF, "BOSS_MOD_CD");
        nCD = nCD + 1;

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                fDuration = GetWillDuration(oTarget, 0, 3.0);
            }
            else if(sRarity == "Uncommon")
            {
                fDuration = GetWillDuration(oTarget, 0, 4.0);
            }
            else if(sRarity == "Rare")
            {
                fDuration = GetWillDuration(oTarget, 0, 5.0);
            }
            else if(sRarity == "Legendary")
            {
                fDuration = GetWillDuration(oTarget, 0, 6.0);
            }

            if (GetIsReactionTypeHostile(oTarget) && nCD >= 3)
            {
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oTarget, fDuration);
                SetLocalInt(OBJECT_SELF, "BOSS_MOD_CD", 0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
        SetLocalInt(OBJECT_SELF, "BOSS_MOD_CD", nCD);
    }
    //Pulses Blindness
    else if(sTitle == "Dark")
    {
        effect eAura = EffectVisualEffect(VFX_FNF_PWKILL);
        effect eDebuff = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
        effect eBlind = EffectBlindness();
        int nDC;
        float fDuration;

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                fDuration = GetWillDuration(oTarget, 0, 1.0);
            }
            else if(sRarity == "Uncommon")
            {
                fDuration = GetWillDuration(oTarget, 0, 2.0);
            }
            else if(sRarity == "Rare")
            {
                fDuration = GetWillDuration(oTarget, 0, 3.0);
            }
            else if(sRarity == "Legendary")
            {
                fDuration = GetWillDuration(oTarget, 0, 4.0);
            }

            if (GetIsReactionTypeHostile(oTarget) && !FortitudeSave(oTarget, nDC))
            {
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, fDuration);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Drops acid clouds
    else if(sTitle == "Tainted")
    {
        //Declare major variables including Area of Effect Object
        effect eAOE = EffectAreaOfEffect(AOE_PER_FOGACID);
        location lTarget = GetLocation(OBJECT_SELF);
        int nDuration;
        effect eImpact = EffectVisualEffect(257);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
        if(sRarity == "Common")
        {
            nDuration = 2;
        }
        else if(sRarity == "Uncommon")
        {
            nDuration = 3;
        }
        else if(sRarity == "Rare")
        {
            nDuration = 4;
        }
        else if(sRarity == "Legendary")
        {
            nDuration = 4;
        }
        //Create an instance of the AOE Object using the Apply Effect function
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
    }
    //Rapid fire acid arrows.
    else if(sTitle == "Unclean")
    {
        effect eDebuff = EffectVisualEffect(245);
        effect eEffect = EffectDamageImmunityDecrease(DAMAGE_TYPE_ACID, 15);
        effect eConfuse = EffectVisualEffect(VFX_IMP_HEAD_ACID);
        float fDist = 0.0;
        float fDelay = 0.0;
        float fDelay2, fTime;
        effect eDam;
        int nDamage;
        int nDC;

        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 5 + d10(2);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 10 + d10(3);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Rare")
            {
                nDamage = 20 + d10(4);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 30 + d10(5);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }


            if(GetIsReactionTypeHostile(oTarget))
            {
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
                // * recalculate appropriate distances
                fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
                fDelay = (fDist/25.0);

                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 7.0));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConfuse, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses life draining
    else if(sTitle == "Hungry")
    {
        effect eAura = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_RED);
        effect eDebuff = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
        effect eHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
        effect eGain;
        effect eDam;
        effect eEffect;
        int nDamage;
        int nDC;

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, 7.0);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 5 + d10(1);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 10 + d10(2);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Rare")
            {
                nDamage = 15 + d10(3);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 20 + d10(4);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }

            if(GetIsReactionTypeHostile(oTarget))
            {
                eEffect = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                eGain = EffectHeal(nDamage);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eGain, OBJECT_SELF);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Chain cold damage and slow
    else if(sTitle == "Cold")
    {
        //Declare major variables
        int nCasterLevel = 25;
        //Limit caster level
        // June 2/04 - Bugfix: Cap the level BEFORE the damage calculation, not after. Doh.
        int nDamage;
        int nDamStrike;
        int nNumAffected = 0;
        int nDC;
        //Declare lightning effect connected the casters hands
        effect eLightning = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND);
        effect eVis  = EffectVisualEffect(VFX_IMP_FROST_L);
        effect eDamage;
        object oFirstTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);

        object oHolder;
        object oTarget;
        location lSpellLocation;
        //Enter Metamagic conditions
        //Roll damage for each target
        if(sRarity == "Common")
        {
            nDamage = 5 + d10(2);
            nDamage = GetReflexDamage(oTarget, 0, nDamage);
        }
        else if(sRarity == "Uncommon")
        {
            nDamage = 10 + d10(3);
            nDamage = GetReflexDamage(oTarget, 0, nDamage);
        }
        else if(sRarity == "Rare")
        {
            nDamage = 15 + d10(4);
            nDamage = GetReflexDamage(oTarget, 0, nDamage);
        }
        else if(sRarity == "Legendary")
        {
            nDamage = 20 + d10(5);
            nDamage = GetReflexDamage(oTarget, 0, nDamage);
        }

        //Damage the initial target
        if (spellsIsTarget(oFirstTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oFirstTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CHAIN_LIGHTNING));
            //Make an SR Check
            if (!MyResistSpell(OBJECT_SELF, oFirstTarget))
            {
                //Adjust damage via Reflex Save or Evasion or Improved Evasion
                //nDamStrike = GetReflexAdjustedDamage(nDamage, oFirstTarget, nDC, SAVING_THROW_TYPE_ELECTRICITY);
                //Set the damage effect for the first target
                eDamage = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
                //Apply damage to the first target and the VFX impact.
                if(nDamage > 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oFirstTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oFirstTarget);
                }
            }
        }
        //Apply the lightning stream effect to the first target, connecting it with the caster
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oFirstTarget,0.5);


        //Reinitialize the lightning effect so that it travels from the first target to the next target
        eLightning = EffectBeam(VFX_BEAM_COLD, oFirstTarget, BODY_NODE_CHEST);


        float fDelay = 0.2;
        int nCnt = 0;


        // *
        // * Secondary Targets
        // *


        //Get the first target in the spell shape
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
        while (GetIsObjectValid(oTarget) && nCnt < nCasterLevel)
        {
            //Make sure the caster's faction is not hit and the first target is not hit
            if (oTarget != oFirstTarget && spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
            {
                //Connect the new lightning stream to the older target and the new target
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,0.5));

                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CHAIN_LIGHTNING));
                //Do an SR check
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    //Adjust damage via Reflex Save or Evasion or Improved Evasion
                    int nNewDamage;
                            //Roll damage for each target
                    if(sRarity == "Common")
                    {
                        nDamage = 5 + d10(2);
                        nNewDamage = GetReflexDamage(oTarget, 0, nDamage);
                    }
                    else if(sRarity == "Uncommon")
                    {
                        nDamage = 10 + d10(3);
                        nNewDamage = GetReflexDamage(oTarget, 0, nDamage);
                    }
                    else if(sRarity == "Rare")
                    {
                        nDamage = 15 + d10(4);
                        nNewDamage = GetReflexDamage(oTarget, 0, nDamage);
                    }
                    else if(sRarity == "Legendary")
                    {
                        nDamage = 20 + d10(5);
                        nNewDamage = GetReflexDamage(oTarget, 0, nDamage);
                    }
                    //Apply the damage and VFX impact to the current target
                    eDamage = EffectDamage(nNewDamage, DAMAGE_TYPE_COLD);
                    if(nDamage > 0) //Damage > 0)
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                    }
                }
                oHolder = oTarget;

                //change the currect holder of the lightning stream to the current target
                if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
                {
                eLightning = EffectBeam(VFX_BEAM_COLD, oHolder, BODY_NODE_CHEST);
                }
                else
                {
                    // * April 2003 trying to make sure beams originate correctly
                    effect eNewLightning = EffectBeam(VFX_BEAM_COLD, oHolder, BODY_NODE_CHEST);
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
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
          }
    }
    //Pulses Wail of the Banshee at 75% and 25% HP
    else if(sTitle == "Wailer")
    {
        effect eAura = EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES);
        effect eDebuff = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
        effect eGain;
        effect eDam;
        effect eEffect;
        int nDamage;
        int nDC;
        float fDelay = GetRandomDelay(3.0, 4.0);
        int nMax = GetMaxHitPoints(OBJECT_SELF);
        int nTop = nMax / 4;
        int nBottom = nTop * 3;
        nBottom = nMax - nBottom;
        nTop = nMax - nTop;
        int nCurrent = GetCurrentHitPoints(OBJECT_SELF);
        int nTopCheck = GetLocalInt(OBJECT_SELF, "FIRST_SKILL_DONE");
        int nBottomCheck = GetLocalInt(OBJECT_SELF, "SECOND_SKILL_DONE");

        if(nCurrent <= nTop && nTopCheck != 1)
        {
            SetLocalInt(OBJECT_SELF, "FIRST_SKILL_DONE", 1);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eAura, GetLocation(OBJECT_SELF));
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            while(oTarget != OBJECT_INVALID)
            {
                if(sRarity == "Common")
                {
                    nDamage = 50 + d10(3);
                }
                else if(sRarity == "Uncommon")
                {
                    nDamage = 70 + d10(4);
                }
                else if(sRarity == "Rare")
                {
                    nDamage = 90 + d10(5);
                }
                else if(sRarity == "Legendary")
                {
                    nDamage = 100 + d10(6);
                }

                if (GetIsReactionTypeHostile(oTarget))
                {
                    eEffect = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                    //Apply impact VFX and damage
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            }
        }
        else if(nCurrent <= nBottom && nBottomCheck != 1)
        {
            SetLocalInt(OBJECT_SELF, "SECOND_SKILL_DONE", 1);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eAura, GetLocation(OBJECT_SELF));
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            while(oTarget != OBJECT_INVALID)
            {
                if(sRarity == "Common")
                {
                    nDamage = 10 + d10(3);
                }
                else if(sRarity == "Uncommon")
                {
                    nDamage = 20 + d10(4);
                }
                else if(sRarity == "Rare")
                {
                    nDamage = 30 + d10(5);
                }
                else if(sRarity == "Legendary")
                {
                    nDamage = 40 + d10(6);
                }

                if (GetIsReactionTypeHostile(oTarget))
                {
                    eEffect = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                    //Apply impact VFX and damage
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            }
        }
    }
    //Pulses damage that increases every round
    else if(sTitle == "Ravager")
    {
        effect eAura = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
        effect eVis = EffectVisualEffect(VFX_IMP_NIGHTMARE_HEAD_HIT);
        effect eDamage;
        effect eDam;
        int nDamage;
        int nCounter = GetLocalInt(OBJECT_SELF, "RAVAGER_COUNTER");

        //Ensure max so the boss doesn't get stupid
        if(nCounter > 50)
        {
            nCounter = 50;
        }

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 4 * nCounter;
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 6 * nCounter;
            }
            else if(sRarity == "Rare")
            {
                nDamage = 8 * nCounter;
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 10 * nCounter;
            }

            if(GetIsReactionTypeHostile(oTarget))
            {
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
        nCounter = nCounter + 1;
        SetLocalInt(OBJECT_SELF, "RAVAGER_COUNTER", nCounter);
    }
    //Pulses elemental debuff
    else if(sTitle == "Corruptor")
    {
        effect eAura = EffectVisualEffect(VFX_DUR_AURA_PULSE_GREEN_BLACK);
        effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);
        int nAmount = 50;

        //Elemental Effects
        effect eFire = EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, nAmount);
        effect eCold = EffectDamageImmunityDecrease(DAMAGE_TYPE_COLD, nAmount);
        effect eElec = EffectDamageImmunityDecrease(DAMAGE_TYPE_ELECTRICAL, nAmount);
        effect eAcid = EffectDamageImmunityDecrease(DAMAGE_TYPE_ACID, nAmount);
        effect eNega = EffectDamageImmunityDecrease(DAMAGE_TYPE_NEGATIVE, nAmount);
        effect eMagi = EffectDamageImmunityDecrease(DAMAGE_TYPE_MAGICAL, nAmount);
        effect eSoni = EffectDamageImmunityDecrease(DAMAGE_TYPE_SONIC, nAmount);
        effect ePosi = EffectDamageImmunityDecrease(DAMAGE_TYPE_POSITIVE, nAmount);
        effect eDivi = EffectDamageImmunityDecrease(DAMAGE_TYPE_DIVINE, nAmount);

        effect eLink = EffectLinkEffects(eFire, eCold);
        eLink = EffectLinkEffects(eLink, eElec);
        eLink = EffectLinkEffects(eLink, eAcid);
        eLink = EffectLinkEffects(eLink, eNega);
        eLink = EffectLinkEffects(eLink, eMagi);
        eLink = EffectLinkEffects(eLink, eSoni);
        eLink = EffectLinkEffects(eLink, ePosi);
        eLink = EffectLinkEffects(eLink, eDivi);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, 7.0);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(GetIsReactionTypeHostile(oTarget))
            {
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 6.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses STR and movespeed reduction.
    else if(sTitle == "Famished")
    {
        effect eAura = EffectVisualEffect(VFX_DUR_AURA_PULSE_YELLOW_BLACK);
        effect eDebuff = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        effect eDam;
        effect eEffect;
        int nDamage;
        int nDC;
        float fDuration;

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, 7.0);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                eEffect = EffectMovementSpeedDecrease(20);
                fDuration = GetWillDuration(oTarget, 0, 5.0);
            }
            else if(sRarity == "Uncommon")
            {
                fDuration = GetWillDuration(oTarget, 0, 5.0);
                eEffect = EffectMovementSpeedDecrease(30);
            }
            else if(sRarity == "Rare")
            {
                fDuration = GetWillDuration(oTarget, 0, 5.0);
                eEffect = EffectMovementSpeedDecrease(40);
            }
            else if(sRarity == "Legendary")
            {
                fDuration = GetWillDuration(oTarget, 0, 5.0);
                eEffect = EffectMovementSpeedDecrease(50);
            }

            if (GetIsReactionTypeHostile(oTarget) && !FortitudeSave(oTarget, nDC))
            {
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses physical damage that increases every round
    else if(sTitle == "Muncher")
    {
        effect eAura = EffectVisualEffect(VFX_IMP_PULSE_WIND);
        effect eVis = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
        effect eDamage;
        effect eDam;
        int nDamage;
        int nCounter = GetLocalInt(OBJECT_SELF, "RAVAGER_COUNTER");

        //Ensure max so the boss doesn't get stupid
        if(nCounter > 50)
        {
            nCounter = 50;
        }

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 4 * nCounter;
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 6 * nCounter;
            }
            else if(sRarity == "Rare")
            {
                nDamage = 8 * nCounter;
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 10 * nCounter;
            }

            if(GetIsReactionTypeHostile(oTarget))
            {
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING);
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
        nCounter = nCounter + 1;
        SetLocalInt(OBJECT_SELF, "RAVAGER_COUNTER", nCounter);
    }
    //Pulses life draining
    else if(sTitle == "Drained")
    {
        effect eAura = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_RED);
        effect eDebuff = EffectVisualEffect(VFX_IMP_HARM);
        effect eHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
        effect eGain;
        effect eDam;
        effect eEffect;
        int nDamage;
        int nDC;

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, 7.0);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 5 + d10(4);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 10 + d10(5);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Rare")
            {
                nDamage = 15 + d10(6);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 20 + d10(7);
                nDamage = GetFortDamage(oTarget, 0, nDamage);
            }

            if(GetIsReactionTypeHostile(oTarget))
            {
                eEffect = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                eGain = EffectHeal(nDamage);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDebuff, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eGain, OBJECT_SELF);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Crit immunity. Physical damage reduction.
    else if(sTitle == "Callous")
    {
        effect eImmunity = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
        effect eSlash = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 50);
        effect ePierce = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 50);
        effect eBludge = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 50);
        effect eLink = EffectLinkEffects(eSlash, ePierce);
        eLink = EffectLinkEffects(eLink, eBludge);
        eImmunity = SupernaturalEffect(eImmunity);
        eLink = SupernaturalEffect(eLink);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "BOSS_BUFFED", 1);
    }
    //Death Armour
    else if(sTitle == "Torturous")
    {
        effect eShield;
        effect eVis = EffectVisualEffect(VFX_DUR_DEATH_ARMOR);
        int nDamage;

        if(sRarity == "Common")
        {
            nDamage = 2;
        }
        else if(sRarity == "Uncommon")
        {
            nDamage = 4;
        }
        else if(sRarity == "Rare")
        {
            nDamage = 6;
        }
        else if(sRarity == "Legendary")
        {
            nDamage = 8;
        }

        eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d4, DAMAGE_TYPE_MAGICAL);
        eShield = SupernaturalEffect(eShield);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eShield, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "BOSS_BUFFED", 1);
    }
    //Pulses physical debuff
    else if(sTitle == "Painbringer")
    {
        effect eAura = EffectVisualEffect(VFX_DUR_AURA_PULSE_CYAN_BLACK);
        effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
        int nAmount = 50;

        //Elemental Effects
        effect eSlash = EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, nAmount);
        effect ePierce = EffectDamageImmunityDecrease(DAMAGE_TYPE_COLD, nAmount);
        effect eBludge = EffectDamageImmunityDecrease(DAMAGE_TYPE_ELECTRICAL, nAmount);

        effect eLink = EffectLinkEffects(eSlash, ePierce);
        eLink = EffectLinkEffects(eLink, eBludge);
        eLink = SupernaturalEffect(eLink);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, 7.0);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(GetIsReactionTypeHostile(oTarget))
            {
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 6.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Random AOE damage
    else if(sTitle == "Render")
    {
        effect eBlood = EffectVisualEffect(VFX_COM_HIT_SONIC);
        effect eSpikes = EffectVisualEffect(VFX_IMP_SONIC);
        effect eExplosion = EffectVisualEffect(VFX_FNF_SOUND_BURST);
        effect eDam;
        effect eLink = EffectLinkEffects(eBlood, eSpikes);
        int nRandom = 4 + d12(1);
        float fDistance = IntToFloat(nRandom);
        location lLoc = GetNewRandomLocation(GetLocation(OBJECT_SELF), fDistance);
        int nDamage;
        int nDC;

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplosion, lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpikes, lLoc);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc, TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 20 + d10(2);
                nDamage = GetWillDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 30 + d10(3);
                nDamage = GetWillDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Rare")
            {
                nDamage = 40 + d10(4);
                nDamage = GetWillDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 50 + d10(5);
                nDamage = GetWillDamage(oTarget, 0, nDamage);
            }

            if (GetIsReactionTypeHostile(oTarget))
            {
                //Set Damage
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses healing to allies
    else if(sTitle == "Biggun")
    {
        effect eAura = EffectVisualEffect(VFX_FNF_MASS_HEAL);
        effect eHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
        effect eEffect;
        int nHeal;

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nHeal = 10 + d10(2);
            }
            else if(sRarity == "Uncommon")
            {
                nHeal = 20 + d10(3);
            }
            else if(sRarity == "Rare")
            {
                nHeal = 30 + d10(4);
            }
            else if(sRarity == "Legendary")
            {
                nHeal = 40 + d10(5);
            }

            if(!GetIsReactionTypeHostile(oTarget))
            {
                eEffect = EffectHeal(nHeal);
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Super tanky
    else if(sTitle == "Chonk")
    {
        int nHP = GetMaxHitPoints(OBJECT_SELF);
        nHP = nHP / 2;
        effect eHealth = EffectTemporaryHitpoints(nHP);
        effect eSlash = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 50);
        effect ePierce = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 50);
        effect eBludge = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 50);
        effect eLink = EffectLinkEffects(eSlash, ePierce);
        eLink = EffectLinkEffects(eLink, eBludge);
        eHealth = SupernaturalEffect(eHealth);
        eLink = SupernaturalEffect(eLink);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHealth, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "BOSS_BUFFED", 1);
        //Make creature bigger
        SetObjectVisualTransform(OBJECT_SELF, 10, 1.4);
    }
    //Lowers saves
    else if(sTitle == "Deathmonger")
    {
        effect eAura = EffectVisualEffect(VFX_DUR_AURA_CYAN);
        effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
        int nAmount;

        if(sRarity == "Common")
        {
            nAmount = 5;
        }
        else if(sRarity == "Uncommon")
        {
            nAmount = 10;
        }
        else if(sRarity == "Rare")
        {
            nAmount = 15;
        }
        else if(sRarity == "Legendary")
        {
            nAmount = 20;
        }

        //Reduce Save
        effect eSaves = EffectSavingThrowDecrease(SAVING_THROW_ALL, nAmount);
        eSaves = SupernaturalEffect(eSaves);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, 7.0);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(GetIsReactionTypeHostile(oTarget))
            {
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaves, oTarget, 6.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses Entangle
    else if(sTitle == "Hesitant")
    {
        effect eAura = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
        effect eVis = EffectVisualEffect(VFX_DUR_ENTANGLE);
        effect eEntangle = EffectMovementSpeedDecrease(99);
        int nDC;
        float fDuration;

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(GetIsReactionTypeHostile(oTarget))
            {
                if(sRarity == "Common")
                {
                    fDuration = GetFortDuration(oTarget, 0, 1.0);
                }
                else if(sRarity == "Uncommon")
                {
                    fDuration = GetFortDuration(oTarget, 0, 2.0);
                }
                else if(sRarity == "Rare")
                {
                    fDuration = GetFortDuration(oTarget, 0, 3.0);
                }
                else if(sRarity == "Legendary")
                {
                    fDuration = GetFortDuration(oTarget, 0, 4.0);
                }
                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEntangle, oTarget, fDuration);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses Silent
    else if(sTitle == "Quiet")
    {
        effect eAura = EffectVisualEffect(VFX_FNF_BLINDDEAF);
        effect eVis = EffectVisualEffect(VFX_IMP_SILENCE);
        effect eSilence = EffectSilence();
        int nDC;
        float fDuration;

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, OBJECT_SELF);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(GetIsReactionTypeHostile(oTarget))
            {
                if(sRarity == "Common")
                {
                    fDuration = GetWillDuration(oTarget, 0, 6.0);
                }
                else if(sRarity == "Uncommon")
                {
                    fDuration = GetWillDuration(oTarget, 0, 7.0);
                }
                else if(sRarity == "Rare")
                {
                    fDuration = GetWillDuration(oTarget, 0, 8.0);
                }
                else if(sRarity == "Legendary")
                {
                    fDuration = GetWillDuration(oTarget, 0, 9.0);
                }

                //Apply impact VFX and damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSilence, oTarget, fDuration);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Pulses fire missiles.
    else if(sTitle == "Spicy")
    {
        effect eMissile = EffectVisualEffect(VFX_IMP_MIRV_FIREBALL);
        effect eFire = EffectVisualEffect(VFX_IMP_FLAME_M);
        float fDist = 0.0;
        float fDelay = 0.0;
        float fDelay2, fTime;
        effect eDam;
        int nDamage;
        int nDC;

        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(sRarity == "Common")
            {
                nDamage = 10 + d12(2);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Uncommon")
            {
                nDamage = 20 + d12(3);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Rare")
            {
                nDamage = 30 + d12(4);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }
            else if(sRarity == "Legendary")
            {
                nDamage = 40 + d12(5);
                nDamage = GetReflexDamage(oTarget, 0, nDamage);
            }

            if (GetIsReactionTypeHostile(oTarget))
            {
                // * recalculate appropriate distances
                fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
                fDelay = fDist/(3.0 * log(fDist) + 2.0);

                fTime = fDelay;
                fDelay2 += 0.1;
                fTime += fDelay2;
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                //Apply impact VFX and damage
                DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
                DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }


    ExecuteScript("nw_c2_default3", OBJECT_SELF);
}
