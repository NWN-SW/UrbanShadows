#include "tsw_class_consts"
#include "spell_dmg_inc"
#include "inc_timer"

//Get Weapon Sound for ranged weapons
int GetWeaponSound(object oCaster)
{
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCaster);
    int nType = GetBaseItemType(oWep);
    int nResRef;

    if(nType == 6 || nType == 7)
    {
        nResRef = 16778122;
    }
    else if (nType == 11)
    {
        nResRef = 16778123;
    }
    else if (nType == 61)
    {
        nResRef = 16778124;
    }

    return nResRef;
}

//Attack nearest enemy to prevent flat footed
void AttackNearest(float fArea, object oCaster)
{
    object oMainTarget = GetAttackTarget(oCaster);
    int nAction = GetCurrentAction(oCaster);
    if(oMainTarget == OBJECT_INVALID && nAction != ACTION_MOVETOPOINT)
    {
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fArea, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
        while(GetIsObjectValid(oTarget))
        {
            if(GetIsReactionTypeHostile(oTarget) && oTarget != OBJECT_SELF)
            {
                ActionAttack(oTarget);
                break;
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fArea, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
        }
    }
    ActionAttack(oMainTarget);
}

void DoClassMechanic(string sSpellType, string sTargets, int nDamage, object oTarget, object oCaster = OBJECT_SELF, int nClass = 1, int nSpecial = 0)
{
    //ANIMA cost of spells. Some spells call this function twice in a row.
    //We'll add a brief cooldown to prevent double feedback and cost.
    int nResourceCD = GetLocalInt(oCaster, "ANIMA_USE_COOLDOWN");
    int nAnima;
    if(nResourceCD != 1 && nSpecial == 0)
    {
        nAnima = UseAnima(oCaster, GetSpellId());
        SetLocalInt(oCaster, "ANIMA_USE_COOLDOWN", 1);
        //Some classes use both class tags. We'll set the cooldown for both.
        SetLocalInt(oCaster, "STAM_USE_COOLDOWN", 1);
    }

    //AOEs cannot use GetLastSpellCastClass when calling this function. This is a workaround.
    int nClass1;
    int nClass2;
    int nClass3;
    if(nClass == 1)
    {
        nClass1 = GetClassByPosition(1, oCaster);
        nClass2 = GetClassByPosition(2, oCaster);
        nClass3 = GetClassByPosition(3, oCaster);
    }
    //int nLevel = GetLevelByClass(nClass, oCaster);

    //Check if this is an NPC caster. Since they all use the same class, we can manually say what mechanics to use.
    string sClass = GetLocalString(oCaster, "NPC_CLASS_MECHANIC");

    //string sLevel = IntToString(nLevel);
    //SendMessageToPC(oCaster, "Your level is: " + sLevel);

    //Random delay between 1 and 2 seconds
    float fBase = 8.0;
    int nRandom = 4 + Random(5);
    float fRandom = IntToFloat(nRandom);
    float fDelay = fBase / fRandom;

    //Get location of primary target for AOEs
    location lLoc = GetLocation(oTarget);

    //Custom spell size
    float fSize = GetSpellArea(10.0, 0);

////PYROMANCER////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_PYROMANCER ||
        nClass2 == CLASS_TYPE_PYROMANCER ||
        nClass3 == CLASS_TYPE_PYROMANCER ||
        sClass == "Pyromancer") &&
        (sSpellType == "Fire" || sSpellType == "Force" || sSpellType == "Electric" || sSpellType == "Earth"))
    {
        //Get Pyro ability tracker
        int nPyroLocal = GetLocalInt(oCaster, "PYROMANCER_LOCAL");

        //Debug Message
        //SendMessageToPC(oCaster, "Local variable set on you.");

        //Effects
        effect eFire = EffectVisualEffect(494);
        effect eDamage;
        effect eAura;
        effect eLink;
        effect eVis = EffectVisualEffect(1071);

        //Determine level of class and efficacy of mechanic. Also get the stage of the mechanic.
        if(nPyroLocal >= 3)
        {
            if(GetHasFeat(PYRO_WILD_CONFLAGRATION, oCaster))
            {
                eDamage = EffectDamage(nDamage / 2, DAMAGE_TYPE_FIRE);
                eLink = EffectLinkEffects(eFire, eDamage);
            }
            else if(GetHasFeat(PYRO_CONFLAGRATION, oCaster))
            {
                eDamage = EffectDamage(nDamage / 4, DAMAGE_TYPE_FIRE);
                eLink = EffectLinkEffects(eFire, eDamage);
            }

            //If single target, do bonus damage to primary.
            if(sTargets == "Single")
            {
                if(GetIsReactionTypeHostile(oTarget))
                {
                    DelayCommand(1.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
                }
            }
            //If AoE, do damage to all enemies in range of the closest enemy
            else if(sTargets == "AOE" || sTargets == "AoE")
            {
                object oEnemies = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);

                //Debug Line
                //SendMessageToPC(oCaster, "Attempting to fire AOE script.");

                while(oEnemies != OBJECT_INVALID)
                {
                    //SendMessageToPC(oCaster, "We're inside the While loop.");
                    if(GetIsReactionTypeHostile(oEnemies, oCaster))
                    {
                        //SendMessageToPC(oCaster, "We're inside the If section.");
                        DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oEnemies));
                    }
                    oEnemies = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);
                }
            }
            SetLocalInt(oCaster, "PYROMANCER_LOCAL", 0);
        }
        else
        {
            nPyroLocal = nPyroLocal + 1;
            eAura = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
            if(nPyroLocal >= 3)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, oCaster);
                DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, oCaster));
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, oCaster));
                DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, oCaster));
                DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCaster));
                SendMessageToPC(oCaster, "Conflagration ready!");
            }
            SetLocalInt(oCaster, "PYROMANCER_LOCAL", nPyroLocal);
        }
    }

////AEROMANCER////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_AEROMANCER ||
        nClass2 == CLASS_TYPE_AEROMANCER ||
        nClass3 == CLASS_TYPE_AEROMANCER ||
        sClass == "Aeromancer") &&
        (sSpellType == "Electric"|| sSpellType == "Force" || sSpellType == "Fire" || sSpellType == "Earth"))
    {
        //Get Aero ability tracker
        int nAeroLocal = GetLocalInt(oCaster, "AEROMANCER_LOCAL");

        //Custom spell size
        float fSize = GetSpellArea(15.0, 0);

        //Duration
        int nDuration = 2;
        float fDuration = RoundsToSeconds(nDuration);
        fDuration = GetExtendSpell(fDuration, 0, oCaster);

        //Location
        lLoc = GetLocation(oCaster);

        //Debug Message
        //SendMessageToPC(oCaster, "Local variable set on you.");

        //Effects
        effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oCaster, BODY_NODE_HAND);
        effect eElec = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
        effect eDamage;
        effect eReflex = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, 5);
        effect eAC = EffectACIncrease(2);
        effect eAura = EffectVisualEffect(VFX_DUR_GHOST_SMOKE_2);
        effect eLink;
        effect eBuffLinks;

        //Damage
        int nNewDamage;

        //Loop check.
        int nCounter = 0;

        //Determine level of class and efficacy of mechanic. Also get the stage of the mechanic.
        if(nAeroLocal >= 1 && GetHasFeat(AERO_STRIKE_TWICE, oCaster))
        {
            if(GetHasFeat(AERO_RIDETHELIGHTNING, oCaster))
            {
                nNewDamage = 5 + (nDamage / 10);
                if(nNewDamage < 1)
                {
                    nNewDamage = 1;
                }
                eDamage = EffectDamage(nNewDamage, DAMAGE_TYPE_ELECTRICAL);
                eBuffLinks = EffectLinkEffects(eAC, eReflex);
                eBuffLinks = EffectLinkEffects(eBuffLinks, eAura);
            }
            else if(GetHasFeat(AERO_STRIKE_TWICE, oCaster))
            {
                nNewDamage = 5 + (nDamage / 20);
                if(nNewDamage < 1)
                {
                    nNewDamage = 1;
                }
                eDamage = EffectDamage(nNewDamage, DAMAGE_TYPE_ELECTRICAL);
            }

            object oEnemies = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);

            while(oEnemies != OBJECT_INVALID && nCounter == 0)
            {
                //SendMessageToPC(oCaster, "We're inside the While loop.");
                if(GetIsReactionTypeHostile(oEnemies, oCaster))
                {
                    //SendMessageToPC(oCaster, "We're inside the If section.");
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightning, oEnemies, 1.0);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eElec, oEnemies);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oEnemies);
                    nCounter = 1;
                }
                oEnemies = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBuffLinks, oCaster, fDuration);
            SetLocalInt(oCaster, "AEROMANCER_LOCAL", 0);
        }
        else if(nAeroLocal == 0 && GetHasFeat(AERO_STRIKE_TWICE, oCaster))
        {
            nAeroLocal = nAeroLocal + 1;
            eAura = EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY);
            if(nAeroLocal >= 1)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, oCaster);
                DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, oCaster));
                SendMessageToPC(oCaster, "Strike Twice ready!");
            }
            SetLocalInt(oCaster, "AEROMANCER_LOCAL", nAeroLocal);
        }
    }

////GEOMANCER////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_GEOMANCER ||
        nClass2 == CLASS_TYPE_GEOMANCER ||
        nClass3 == CLASS_TYPE_GEOMANCER ||
        sClass == "Geomancer") &&
        sSpellType == "Control")
    {
        //Get Pyro ability tracker
        int nGeoLocal = GetLocalInt(oCaster, "GEOMANCER_LOCAL");

        //Debug Message
        //SendMessageToPC(oCaster, "Local variable set on you.");

        //Duration
        float fDuration = GetExtendSpell(12.0, 0, oCaster);
        float fDuration2 = GetExtendSpell(18.0, 0, oCaster);

        //Variables
        int nBonus = GetAbilityModifier(ABILITY_WISDOM, oCaster) * 5;
        int nFort;
        int nReflex;
        int nWill;

        //Effects
        effect eEarth = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
        effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ACID);
        effect eHealVis = EffectVisualEffect(864);
        effect eLowerFort;
        effect eLowerRef;
        effect eLowerWill;
        effect eHealth= eHealth = EffectHeal(nBonus);;
        effect eLink;
        effect eVisLink;

        //Determine level of class and efficacy of mechanic. Also get the stage of the mechanic.
        if(nGeoLocal >= 2 && GetHasFeat(GEOM_CORROSION, oCaster))
        {
            object oEnemies = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);

            //Debug Line
            //SendMessageToPC(oCaster, "Attempting to fire AOE script.");

            while(oEnemies != OBJECT_INVALID)
            {
                //SendMessageToPC(oCaster, "We're inside the While loop.");
                if(GetIsReactionTypeHostile(oEnemies, oCaster))
                {
                    //Get 10% of their saves.
                    nFort = GetFortitudeSavingThrow(oEnemies);
                    nReflex = GetReflexSavingThrow(oEnemies);
                    nWill = GetWillSavingThrow(oEnemies);
                    nFort = 1 + (nFort / 10);
                    nReflex = 1 + (nReflex / 10);
                    nWill = 1 + (nWill / 10);

                    //Create debuffs
                    eLowerFort = EffectSavingThrowDecrease(SAVING_THROW_FORT, nFort);
                    eLowerRef = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, nReflex);
                    eLowerWill = EffectSavingThrowDecrease(SAVING_THROW_WILL, nWill);

                    eVisLink = EffectLinkEffects(eEarth, eVis);
                    eLink = EffectLinkEffects(eLink, eLowerFort);
                    eLink = EffectLinkEffects(eLink, eLowerRef);
                    eLink = EffectLinkEffects(eLink, eLowerWill);

                    //SendMessageToPC(oCaster, "We're inside the If section.");
                    nRandom = 4 + Random(5);
                    fRandom = IntToFloat(nRandom);
                    fDelay = fBase / fRandom;
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisLink, oEnemies));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oEnemies, fDuration));
                }
                oEnemies = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);
            }
            SetLocalInt(oCaster, "GEOMANCER_LOCAL", 0);
            if(GetHasFeat(GEOM_CALCIFY, oCaster))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oCaster);
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealth, oCaster));
            }
        }
        else
        {
            nGeoLocal = nGeoLocal + 1;
            if(nGeoLocal == 2)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eEarth, oCaster);
                DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCaster));
                SendMessageToPC(oCaster, "Corrosion ready!");
            }
            SetLocalInt(oCaster, "GEOMANCER_LOCAL", nGeoLocal);
        }
    }

////MAVERICK////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_MAVERICK ||
        nClass2 == CLASS_TYPE_MAVERICK ||
        nClass3 == CLASS_TYPE_MAVERICK ||
        sClass == "Maverick") &&
        (sSpellType == "Fire" || sSpellType == "Force" || sSpellType == "Electric" || sSpellType == "Earth"))
    {
        object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCaster);
        int nType = GetBaseItemType(oWep);
        if(GetWeaponRanged(oWep) && GetHasFeat(MVRK_BULLSEYE, oCaster))
        {
            //Increment Maverick combo tracker
            int nMvrkLocal = GetLocalInt(oCaster, "MAVERICK_COMBO_LOCAL");
            nMvrkLocal = nMvrkLocal + 1;
            SetLocalInt(oCaster, "MAVERICK_COMBO_LOCAL", nMvrkLocal);

            if(nMvrkLocal >= 3)
            {
                //Effects
                int nBuff = 10;
                effect eAttack = EffectAttackIncrease(nBuff);
                eAttack = SupernaturalEffect(eAttack);
                eAttack = TagEffect(eAttack, "MAV_ATTACK_30918");
                effect eVis = EffectVisualEffect(1069);

                //Check if they have no existing buff
                int nBuffCheck = 0;

                //Remove existing attack buff and apply new one.
                effect eEffect = GetFirstEffect(oCaster);
                while(GetIsEffectValid(eEffect))
                {
                    if(GetEffectTag(eEffect) == "MAV_ATTACK_30918")
                    {
                        RemoveEffect(oCaster, eEffect);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttack, oCaster, 60.0);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oCaster, 60.0);
                        SetLocalInt(oCaster, "MAVERICK_COMBO_LOCAL", 0);
                        nBuffCheck = 1;
                        break;
                    }
                    eEffect = GetNextEffect(OBJECT_SELF);
                }

                //Apply buff if no replacement added
                if(nBuffCheck != 1)
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttack, oCaster, 60.0);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oCaster, 60.0);
                    SetLocalInt(oCaster, "MAVERICK_COMBO_LOCAL", 0);
                }

                //Apply stun to main target if they have right feat
                if(GetHasFeat(MVRK_CONCUSSIVE_TEMPO, oCaster))
                {
                    effect eStun = EffectStunned();
                    effect eVis2 = EffectVisualEffect(VFX_IMP_STUN);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, 8.0);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
                }
            }
        }
    }

////MYSTIC////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_MYSTIC ||
        nClass2 == CLASS_TYPE_MYSTIC ||
        nClass3 == CLASS_TYPE_MYSTIC ||
        sClass == "Mystic") &&
        (sSpellType == "Buff"))
    {
        int nMystic = GetLocalInt(oCaster, "MYSTIC_BUFF_COUNTER");
        nMystic = nMystic + 1;
        SetLocalInt(oCaster, "MYSTIC_BUFF_COUNTER", nMystic);
        int nAmount = GetHighestAbilityModifier(oCaster) * 10;
        effect eHeal = EffectHeal(nAmount);
        int nCounter = 5;
        if(GetHasFeat(MYST_AVATAR, oCaster))
        {
            nCounter = 3;
        }

        if(nMystic >= nCounter && GetHasFeat(MYST_EXEMPLAR, oCaster))
        {
            IncrementRemainingFeatUses(oCaster, MYST_ANNIHILATING_BOLT);
            SetLocalInt(oCaster, "MYSTIC_BUFF_COUNTER", 0);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oCaster);
        }
    }

////NECROMANCER////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_NECROMANCER ||
        nClass2 == CLASS_TYPE_NECROMANCER ||
        nClass3 == CLASS_TYPE_NECROMANCER ||
        sClass == "Necromancer") &&
        (sSpellType == "Occult"))
    {
        int nNecro = GetLocalInt(oCaster, "NECRO_SUMMON_COUNTER");
        nNecro = nNecro + 1;
        SetLocalInt(oCaster, "NECRO_SUMMON_COUNTER", nNecro);
        int nCounter = 5;
        int nAmount = 2;
        int nCheck = 0;
        string sTier;
        int nFocus = GetSummFocus(oCaster);
        effect eKillSumm = EffectDamage(9999);
        float fSummDur = GetExtendSpell(18.0, 0, oCaster);
        if(GetHasFeat(NECR_GRAVE_ARMY, oCaster))
        {
            nCounter = 4;
            nAmount = 4;
            fSummDur = GetExtendSpell(18.0, 0, oCaster);
        }

        if(nNecro == (nCounter - 1) && GetHasFeat(NECR_GRAVE_MARCH, oCaster))
        {
            effect eVis = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCaster);
            SendMessageToPC(oCaster, "Necromancer bonus ready!");
        }

        //Summon focustiers
        if(nFocus == 4)
        {
            sTier = "T4";
        }
        else if(nFocus == 3)
        {
            sTier = "T3";
        }
        else if(nFocus == 2)
        {
            sTier = "T2";
        }
        else if(nFocus == 1)
        {
            sTier = "T1";
        }

        if(nNecro >= nCounter && GetHasFeat(NECR_GRAVE_MARCH, oCaster))
        {
            while(nCheck < nAmount)
            {
                effect eSumVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
                object oSummon = CreateObject(OBJECT_TYPE_CREATURE, "necro_mech_sum", GetLocation(oCaster), FALSE, "NECRO_MECH_SUMM_" + sTier);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSumVis, GetLocation(oCaster));
                nCheck = nCheck + 1;
                DestroyObject(oSummon, fSummDur);
                DelayCommand(fSummDur, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSumVis, GetLocation(oSummon)));
                DelayCommand(1.5, SetLocalInt(oSummon, "NECRO_MECH_SUMMON", 1));
                DelayCommand(1.5, SetLocalObject(oSummon, "MY_SUMMON_MASTER", oCaster));
            }
            SetLocalInt(oCaster, "NECRO_SUMMON_COUNTER", 0);
        }
    }

////DOOMSEER////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_DOOMSEER ||
        nClass2 == CLASS_TYPE_DOOMSEER ||
        nClass3 == CLASS_TYPE_DOOMSEER ||
        sClass == "Doomseer") &&
        (sSpellType == "Fire" || sSpellType == "Force" || sSpellType == "Electric" || sSpellType == "Earth"))
    {

        //If they have Renewal, heal for stamina spent. Use the same cooldown as resource consumption.
        int nSpellID = GetSpellId();
        string sCost = Get2DAString("spells", "Innate", nSpellID);
        int nStamCost = StringToInt(sCost);
        effect eHeal = EffectHeal(nStamCost);
        effect eHealVis = EffectVisualEffect(VFX_IMP_HEAD_HEAL);
        effect eBonus = EffectAttackIncrease(5);
        if(GetHasFeat(DOOM_RENEWAL, oCaster) && nResourceCD != 1)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oCaster);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oCaster);
        }

        if(GetHasFeat(DOOM_RUINATION, oCaster))
        {
            int nDamage = GetHighestAbilityModifier(oCaster) * 2;
            effect eVis;
            int nDamageType;
            float fNewDelay;
            object oEnemies = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oCaster), TRUE, OBJECT_TYPE_CREATURE);

            //Apply attack buff
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBonus, oCaster, 18.0);

            //CHeck our element
            if(GetHasFeat(DOOM_PROPHECY_FIRE, oCaster))
            {
                eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
                nDamageType = DAMAGE_TYPE_FIRE;
            }
            else if(GetHasFeat(DOOM_PROPHECY_COLD, oCaster))
            {
                eVis = EffectVisualEffect(VFX_IMP_FROST_L);
                nDamageType = DAMAGE_TYPE_COLD;
            }
            else if(GetHasFeat(DOOM_PROPHECY_ELEC, oCaster))
            {
                eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
                nDamageType = DAMAGE_TYPE_ELECTRICAL;
            }

            //Debug Line
            //SendMessageToPC(oCaster, "Attempting to fire AOE script.");

            while(oEnemies != OBJECT_INVALID)
            {
                //SendMessageToPC(oCaster, "We're inside the While loop.");
                if(GetIsReactionTypeHostile(oEnemies, oCaster))
                {
                    //SendMessageToPC(oCaster, "We're inside the If section.");
                    effect eDamage = EffectDamage(nDamage, nDamageType);
                    DelayCommand(fNewDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oEnemies));
                    DelayCommand(fNewDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oEnemies));
                    fNewDelay = fNewDelay + 0.1;
                }
                oEnemies = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oCaster), TRUE, OBJECT_TYPE_CREATURE);
            }
        }
    }

////SHAMAN////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_SHAMAN ||
        nClass2 == CLASS_TYPE_SHAMAN ||
        nClass3 == CLASS_TYPE_SHAMAN ||
        sClass == "Shaman") &&
        sSpellType == "Invocation")
    {
        //Get Pyro ability tracker
        int nShamLocal = GetLocalInt(oCaster, "SHAMAN_LOCAL");

        //Caster location
        location lLocation = GetLocation(oCaster);

        //Debug Message
        //SendMessageToPC(oCaster, "Local variable set on you.");

        //Effects
        //Heal
        effect eHealVis = EffectVisualEffect(VFX_IMP_STARBURST_GREEN);
        int nHeal = GetHighestAbilityModifier(oCaster) * 5;
        effect eHeal = EffectHeal(nHeal);

        //Debuff and Buff
        effect eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, 5);
        effect eBadSaves = EffectSavingThrowDecrease(SAVING_THROW_ALL, 5);
        float fDuration = GetExtendSpell(30.0, 0, oCaster);

        //Damage
        effect eDamage = EffectDamage(nHeal, DAMAGE_TYPE_NEGATIVE);
        effect eLink;
        effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);

        //Determine level of class and efficacy of mechanic. Also get the stage of the mechanic.
        if(nShamLocal >= 1)
        {
            //HEAL SECTION
            if(GetHasFeat(SHAM_CHANT_OF_LIFE, oCaster))
            {
                object oAllies = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLocation, TRUE, OBJECT_TYPE_CREATURE);
                while(oAllies != OBJECT_INVALID)
                {
                    //SendMessageToPC(oCaster, "We're inside the While loop.");
                    if(!GetIsReactionTypeHostile(oAllies, oCaster))
                    {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oAllies);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oAllies);

                        //Chant of War good stuff
                        if(GetHasFeat(SHAM_CHANT_OF_WAR, oCaster))
                        {
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaves, oAllies, fDuration);
                        }
                    }
                    oAllies = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLocation, TRUE, OBJECT_TYPE_CREATURE);
                }
            }

            //HARMFUL SECTION
            object oEnemies = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLocation, TRUE, OBJECT_TYPE_CREATURE);

            while(oEnemies != OBJECT_INVALID)
            {
                //SendMessageToPC(oCaster, "We're inside the While loop.");
                if(GetIsReactionTypeHostile(oEnemies, oCaster))
                {
                    //SendMessageToPC(oCaster, "We're inside the If section.");
                    nRandom = 4 + Random(5);
                    fRandom = IntToFloat(nRandom);
                    fDelay = fBase / fRandom;

                    if(GetHasFeat(SHAM_CHANT_OF_WAR, oCaster))
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBadSaves, oEnemies, fDuration));
                    }

                    if(GetHasFeat(SHAM_CHANT_OF_DEATH, oCaster))
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oEnemies));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oEnemies));
                    }
                }
                oEnemies = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLocation, TRUE, OBJECT_TYPE_CREATURE);
            }
            SetLocalInt(oCaster, "SHAMAN_LOCAL", 0);
        }
        else
        {
            nShamLocal = nShamLocal + 1;
            SetLocalInt(oCaster, "SHAMAN_LOCAL", nShamLocal);
        }
    }

////CRYOMANCER////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_CRYOMANCER ||
        nClass2 == CLASS_TYPE_CRYOMANCER ||
        nClass3 == CLASS_TYPE_CRYOMANCER ||
        sClass == "Cryomancer") &&
        (sSpellType == "Control" || sSpellType == "Buff"))
    {

        if(GetHasFeat(CRYO_GLACIATE, oCaster))
        {
            int nStacks;
            float fCryoDuration = GetExtendSpell(8.0, 0, oCaster);
            effect eVis = EffectVisualEffect(1094);
            effect eSlow = EffectMovementSpeedDecrease(99);
            effect ePulse = EffectVisualEffect(VFX_IMP_PULSE_COLD);
            effect eImpact = EffectVisualEffect(VFX_IMP_FROST_S);

            //Pulse visual effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oCaster);

            //Get first target in area
            object oEnemies = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oCaster), TRUE, OBJECT_TYPE_CREATURE);

            //Debug Line
            //SendMessageToPC(oCaster, "Attempting to fire AOE script.");

            while(oEnemies != OBJECT_INVALID)
            {
                //SendMessageToPC(oCaster, "We're inside the While loop.");
                if(GetIsReactionTypeHostile(oEnemies, oCaster))
                {
                    //Check their Glaciate Stacks
                    nStacks = GetLocalInt(oEnemies, "CRYOMANCER_GLACIATE_STACK");
                    if(nStacks >= 3)
                    {
                        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oEnemies, fCryoDuration));
                        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oEnemies, fCryoDuration));
                        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oEnemies));
                        SetLocalInt(oEnemies, "CRYOMANCER_GLACIATE_STACK", 0);

                        //If they have Steal Warmth, heal for twice their highest modifier. Same cooldown as other resources.
                        int nAbility = GetHighestAbilityModifier(oCaster);
                        effect eHeal = EffectHeal(nAbility);
                        effect eHealVis = EffectVisualEffect(VFX_IMP_HEAD_HEAL);
                        if(GetHasFeat(CRYO_STEAL_WARMTH, oCaster) && nResourceCD != 1)
                        {
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oCaster);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oCaster);
                        }
                    }
                    else
                    {
                        nStacks = nStacks + 1;
                        SetLocalInt(oEnemies, "CRYOMANCER_GLACIATE_STACK", nStacks);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oEnemies);
                    }

                }
                oEnemies = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oCaster), TRUE, OBJECT_TYPE_CREATURE);
            }
        }
    }

////SUMMONER////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_SUMMONER ||
        nClass2 == CLASS_TYPE_SUMMONER ||
        nClass3 == CLASS_TYPE_SUMMONER ||
        sClass == "Summoner") &&
        sSpellType == "Occult")
    {
        //Pet location
        object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
        location lLocation = GetLocation(oSummon);

        //Debug Message
        //SendMessageToPC(oCaster, "Local variable set on you.");

        //Effects
        effect eVis = EffectVisualEffect(VFX_IMP_STARBURST_GREEN);
        int nAmount = GetHighestAbilityModifier(oCaster);
        nAmount = nAmount;
        int nBonus = GetPureDamage(nAmount / 2);
        effect eHeal = EffectHeal(nAmount);

        //Damage Buff
        effect eDamage = EffectDamageIncrease(nBonus, DAMAGE_TYPE_MAGICAL);
        float fDuration = GetExtendSpell(12.0, 0, oCaster);
        float fSize = GetSpellArea(10.0);

        //Determine level of class and efficacy of mechanic. Also get the stage of the mechanic. {
        if(GetHasFeat(SUMM_ANCIENT_PACT, oCaster))
        {
            object oAllies = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLocation, TRUE, OBJECT_TYPE_CREATURE);
            while(oAllies != OBJECT_INVALID)
            {
                //SendMessageToPC(oCaster, "We're inside the While loop.");
                if(!GetIsReactionTypeHostile(oAllies, oCaster))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oAllies);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oAllies);

                    //Harmonious Alliance
                    if(GetHasFeat(SUMM_HARMONIOUS_ALLIANCE, oCaster))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage, oAllies, fDuration);
                    }
                }
                oAllies = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLocation, TRUE, OBJECT_TYPE_CREATURE);
            }
        }
    }

////DRUID////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_NEW_DRUID ||
        nClass2 == CLASS_TYPE_NEW_DRUID ||
        nClass3 == CLASS_TYPE_NEW_DRUID ||
        sClass == "Druid") &&
        (sSpellType == "Control"))
    {
        int nDruid = GetLocalInt(oCaster, "DRUID_SUMMON_COUNTER");
        nDruid = nDruid + 1;
        SetLocalInt(oCaster, "DRUID_SUMMON_COUNTER", nDruid);
        int nCounter = 3;
        int nAmount = 2;
        int nCheck = 0;
        string sTier;
        string sResRef1;
        string sResRef2;
        int nFocus = GetSummFocus(oCaster);
        effect eKillSumm = EffectDamage(9999);
        float fSummDur = GetExtendSpell(12.0, 0, oCaster);
        object oSumm1;
        object oSumm2;
        if(GetHasFeat(DRUI_SEEDS_OF_GAIA, oCaster))
        {
            if(d10(1) <= 5)
            {
                sResRef1 = "druid_cs";
            }
            else
            {
                sResRef1 = "druid_ws";
            }
        }

        if(GetHasFeat(DRUI_CHILDREN_OF_GAIA, oCaster))
        {
            if(d10(1) <= 5)
            {
                sResRef2 = "druid_ss";
            }
            else
            {
                sResRef2 = "druid_bs";
            }
        }

        if(nDruid == (nCounter - 1) && GetHasFeat(DRUI_SEEDS_OF_GAIA, oCaster))
        {
            effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCaster);
            SendMessageToPC(oCaster, "Druid bonus ready!");
        }

        //Summon focustiers
        if(nFocus == 4)
        {
            sTier = "T4";
        }
        else if(nFocus == 3)
        {
            sTier = "T3";
        }
        else if(nFocus == 2)
        {
            sTier = "T2";
        }
        else if(nFocus == 1)
        {
            sTier = "T1";
        }

        if(nDruid >= nCounter && GetHasFeat(DRUI_SEEDS_OF_GAIA, oCaster))
        {
            effect eSumVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);

            //Wolf and lion spirits
            oSumm1 = CreateObject(OBJECT_TYPE_CREATURE, sResRef1, GetLocation(oCaster), FALSE, "DRUID_MECH_SUM_" + sTier);

            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSumVis, GetLocation(oCaster));
            DestroyObject(oSumm1, fSummDur);
            DelayCommand(fSummDur, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSumVis, GetLocation(oSumm1)));
            DelayCommand(1.5, SetLocalInt(oSumm1, "DRUID_MECH_SUMMON", 1));
            DelayCommand(1.5, SetLocalObject(oSumm1, "MY_SUMMON_MASTER", oCaster));

            //Bear and stag spirits
            if(GetHasFeat(DRUI_CHILDREN_OF_GAIA, oCaster))
            {
                oSumm2 = CreateObject(OBJECT_TYPE_CREATURE, sResRef2, GetLocation(oCaster), FALSE, "DRUID_MECH_SUM_" + sTier);
            }

            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSumVis, GetLocation(oCaster));
            DestroyObject(oSumm2, fSummDur);
            DelayCommand(fSummDur, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSumVis, GetLocation(oSumm2)));
            DelayCommand(1.5, SetLocalInt(oSumm2, "DRUID_MECH_SUMMON", 1));
            DelayCommand(1.5, SetLocalObject(oSumm2, "MY_SUMMON_MASTER", oCaster));

            SetLocalInt(oCaster, "DRUID_SUMMON_COUNTER", 0);
        }
    }

////SHADOW////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_SHADOW ||
        nClass2 == CLASS_TYPE_SHADOW ||
        nClass3 == CLASS_TYPE_SHADOW ||
        sClass == "Shadow") &&
        sSpellType == "Control")
    {

        //Variables
        int nBonus = GetHighestAbilityModifier(oCaster)+3*GetHighestAlchemiteTier("Cold",oCaster);

        //Effects
        effect eCold = EffectVisualEffect(VFX_IMP_PULSE_COLD);
        effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
        effect eDamage = EffectDamage(nBonus, DAMAGE_TYPE_COLD);

        //Remove blindness from caster
        effect eEffect = GetFirstEffect(oCaster);
        while(GetIsEffectValid(eEffect))
        {
            if(GetEffectType(eEffect) == EFFECT_TYPE_BLINDNESS)
            {
                RemoveEffect(oCaster, eEffect);
            }
            eEffect = GetNextEffect(oCaster);
        }

        //Determine level of class and efficacy of mechanic. Also get the stage of the mechanic.
        if(GetHasFeat(SHAD_BITING_SHADOWS, oCaster))
        {
            object oEnemies = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);

            //Debug Line
            //SendMessageToPC(oCaster, "Attempting to fire AOE script.");

            while(oEnemies != OBJECT_INVALID)
            {
                //SendMessageToPC(oCaster, "We're inside the While loop.");
                if(GetIsReactionTypeHostile(oEnemies, oCaster))
                {
                    //SendMessageToPC(oCaster, "We're inside the If section.");
                    nRandom = 4 + Random(5);
                    fRandom = IntToFloat(nRandom);
                    fDelay = fBase / fRandom;
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oEnemies));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oEnemies));
                }
                oEnemies = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);
            }

            if(GetHasFeat(SHAD_VEILWALK, oCaster))
            {
                effect eConceal = EffectConcealment(40+(GetHighestAlchemiteTier("Magi",oCaster)*5));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConceal, oCaster, 12.0);
            }
        }
    }

    //All spells will make the player automatically target the closest enemy in melee.
    int nEngage = SQLocalsPlayer_GetInt(oCaster, "AUTO_ENGAGE_SETTING");
    if(nEngage == 0)
    {
        AttackNearest(4.0, oCaster);
    }
}

/////////MARTIAL CLASS MECHANICS///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DoMartialMechanic(string sType, string sTargets, int nDamage, object oTarget, object oCaster = OBJECT_SELF, int nClass = 1, int nSpecial = 1)
{
    //Stamina cost of spells. Some spells call this function twice in a row.
    //We'll add a brief cooldown to prevent double feedback and cost.
    int nResourceCD = GetLocalInt(oCaster, "STAM_USE_COOLDOWN");
    int nStam;
    if(nResourceCD != 1 && nSpecial == 1)
    {
        nStam = UseStamina(oCaster, GetSpellId());
        //Stamina cooldown
        SetLocalInt(oCaster, "STAM_USE_COOLDOWN", 1);
        //Some classes use both class tags. We'll set the cooldown for both.
        SetLocalInt(oCaster, "ANIMA_USE_COOLDOWN", 1);
    }

    //If they have Second Wind, heal for stamina spent. Use the same cooldown as resource consumption.
    int nSpellID = GetSpellId();
    string sCost = Get2DAString("spells", "Innate", nSpellID);
    int nStamCost = StringToInt(sCost);
    effect eHeal = EffectHeal(nStamCost);
    if(GetHasFeat(FEAT_SECONDWIND, oCaster) && nResourceCD != 1)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oCaster);
    }

    //AOEs cannot use GetLastSpellCastClass when calling this function. This is a workaround.
    int nClass1;
    int nClass2;
    int nClass3;
    if(nClass == 1)
    {
        nClass1 = GetClassByPosition(1, oCaster);
        nClass2 = GetClassByPosition(2, oCaster);
        nClass3 = GetClassByPosition(3, oCaster);
    }
    int nLevel = GetLevelByClass(nClass, oCaster);

    //Check if this is an NPC caster. Since they all use the same class, we can manually say what mechanics to use.
    string sClass = GetLocalString(oCaster, "NPC_CLASS_MECHANIC");

    string sLevel = IntToString(nLevel);
    //SendMessageToPC(oCaster, "Your level is: " + sLevel);

    //Random delay between 1 and 2 seconds
    float fBase = 8.0;
    int nRandom = 4 + Random(5);
    float fRandom = IntToFloat(nRandom);
    float fDelay = fBase / fRandom;

    //Get location of primary target for AOEs
    location lLoc = GetLocation(oTarget);

    //Custom spell size
    float fSize = GetSpellArea(10.0, 0);

////ENFORCER////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_ENFORCER ||
        nClass2 == CLASS_TYPE_ENFORCER ||
        nClass3 == CLASS_TYPE_ENFORCER ||
        sClass == "Enforcer") &&
        (sType == "Assault"))
    {
        //Get Enforcer ability tracker
        int nEnfoLocal = GetLocalInt(oCaster, "ENFORCER_LOCAL");

        //Debug Message
        //SendMessageToPC(oCaster, "Local variable set on you.");

        //Effects
        effect eBoom = EffectVisualEffect(VFX_COM_SPARKS_PARRY);
        effect eDamage;
        effect eAura;
        effect eLink;
        effect eHeal;
        effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_S);
        effect eVis = EffectVisualEffect(VFX_COM_BLOOD_REG_RED);

        //Determine level of class and efficacy of mechanic. Also get the stage of the mechanic.
        if(nEnfoLocal >= 3 && GetHasFeat(ENFO_MOMENTUM, oCaster))
        {
            eDamage = EffectDamage(nDamage / 4, DAMAGE_TYPE_SLASHING);
            eLink = EffectLinkEffects(eBoom, eDamage);
            eLink = EffectLinkEffects(eLink, eVis);

            //If single target, do bonus damage to primary.
            if(sTargets == "Single")
            {
                if(GetIsReactionTypeHostile(oTarget))
                {
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
                }
            }
            //If AoE, do damage to all enemies in range of the closest enemy
            else if(sTargets == "AOE" || sTargets == "AoE")
            {
                object oEnemies = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);

                //Debug Line
                //SendMessageToPC(oCaster, "Attempting to fire AOE script.");

                while(oEnemies != OBJECT_INVALID)
                {
                    //SendMessageToPC(oCaster, "We're inside the While loop.");
                    if(GetIsReactionTypeHostile(oEnemies, oCaster))
                    {
                        //SendMessageToPC(oCaster, "We're inside the If section.");
                        nRandom = 4 + Random(5);
                        fRandom = IntToFloat(nRandom);
                        fDelay = fBase / fRandom;
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oEnemies));
                    }
                    oEnemies = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLoc, TRUE, OBJECT_TYPE_CREATURE);
                }
            }
            SetLocalInt(oCaster, "ENFORCER_LOCAL", 0);
            if(GetHasFeat(ENFO_BATTLERUSH, oCaster))
            {
                eHeal = EffectHeal(nDamage / 4);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oCaster);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oCaster);
            }
        }
        else
        {
            nEnfoLocal = nEnfoLocal + 1;
            eAura = EffectVisualEffect(1088);
            if(nEnfoLocal >= 3)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eAura, oCaster);
                SendMessageToPC(oCaster, "Momentum ready!");
            }
            SetLocalInt(oCaster, "ENFORCER_LOCAL", nEnfoLocal);
        }
    }

////VANGUARD////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_VANGUARD ||
        nClass2 == CLASS_TYPE_VANGUARD ||
        nClass3 == CLASS_TYPE_VANGUARD ||
        sClass == "Vanguard") &&
        (sType == "Tactic"))
    {
        if(GetHasFeat(VNGD_REPRISAL, oCaster))
        {
            //Start Custom Spell-Function Block
                //Get damage
                string sTarg = "AOE";
                object oEnemy;
                int nDam = GetSecondLevelDamage(oEnemy, 10, sTarg);

                //Buff damage by Amplification elvel
                nDam = GetAmp(nDam);

                //Get the Alchemite resistance reduction
                string sElement = "Bludge";
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDam = GetFocusDmg(oCaster, nDam, sElement);
            //End Custom Spell-Function Block
            effect eShield = EffectDamageShield(nDam, d6(1), DAMAGE_TYPE_BLUDGEONING);
            effect eVis = EffectVisualEffect(1083, FALSE, 1.5);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShield, oCaster, 18.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oCaster, 18.0);
        }

        if(GetHasFeat(VNGD_RALLYING_REPRISAL, oCaster))
        {
            effect eBonus = EffectSavingThrowIncrease(SAVING_THROW_ALL, 5);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBonus, oCaster, 18.0);
        }
    }

////ASSASSIN////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_NEW_ASSIN ||
        nClass2 == CLASS_TYPE_NEW_ASSIN ||
        nClass3 == CLASS_TYPE_NEW_ASSIN ||
        sClass == "Assassin") &&
        (sType == "Guile"))
    {
        //Increment Assassin combo tracker
        int nAssnLocal = GetLocalInt(oCaster, "ASSASSIN_COMBO_LOCAL");
        nAssnLocal = nAssnLocal + 1;
        SetLocalInt(oCaster, "ASSASSIN_COMBO_LOCAL", nAssnLocal);
    }

////TECHNICIAN////////////////////////////////////////////////////////////////////
    if((nClass1 == CLASS_TYPE_TECHNICIAN ||
        nClass2 == CLASS_TYPE_TECHNICIAN ||
        nClass3 == CLASS_TYPE_TECHNICIAN ||
        sClass == "Technician") &&
        (sType == "Tactic"))
    {
        //Increment Assassin combo tracker
        int nTechLocal = GetLocalInt(oCaster, "TECHNICIAN_COUNT_LOCAL");
        nTechLocal = nTechLocal + 1;
        SetLocalInt(oCaster, "TECHNICIAN_COUNT_LOCAL", nTechLocal);

        if(nTechLocal >= 3 && GetHasFeat(TECH_COORDINATION, oCaster))
        {
            //Reset counter
            SetLocalInt(oCaster, "TECHNICIAN_COUNT_LOCAL", 0);

            //Ability scores
            effect eSTR = EffectAbilityIncrease(0, 2);
            effect eDEX = EffectAbilityIncrease(1, 2);
            effect eCON = EffectAbilityIncrease(2, 2);
            effect eINT = EffectAbilityIncrease(3, 2);
            effect eWIS = EffectAbilityIncrease(4, 2);
            effect eCHA = EffectAbilityIncrease(5, 2);

            //AC Bonus
            effect eAC = EffectACIncrease(2);

            //Attack bonus
            effect eATK = EffectAttackIncrease(2);

            //Link Everything
            effect eLink = EffectLinkEffects(eSTR, eDEX);
            eLink = EffectLinkEffects(eLink, eCON);
            eLink = EffectLinkEffects(eLink, eINT);
            eLink = EffectLinkEffects(eLink, eWIS);
            eLink = EffectLinkEffects(eLink, eCHA);
            eLink = EffectLinkEffects(eLink, eAC);
            eLink = EffectLinkEffects(eLink, eATK);

            effect eVis = EffectVisualEffect(VFX_IMP_HEAD_SONIC);

            //Declare the spell shape, size and the location.  Capture the first target object in the shape.
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);

            //Cycle through the targets within the spell shape until an invalid object is captured.
            while (GetIsObjectValid(oTarget))
            {
                if (!GetIsReactionTypeHostile(oTarget, oCaster))
                {
                    float fDuration = GetExtendSpell(36.0, 0, oCaster);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            }
        }
    }

    //All spells will make the player automatically target the closest enemy in melee.
    int nEngage = SQLocalsPlayer_GetInt(oCaster, "AUTO_ENGAGE_SETTING");
    if(nEngage == 0)
    {
        AttackNearest(4.0, oCaster);
    }
}
