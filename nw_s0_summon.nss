//::///////////////////////////////////////////////
//:: Summon Creature Series
//:: NW_S0_Summon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Carries out the summoning of the appropriate
    creature for the Summon Monster Series of spells
    1 to 9
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////

effect SetSummonEffect(int nSpellID);

#include "x2_inc_spellhook"
#include "sum_set_stats"
#include "sum_apply_stats"

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
    int nSpellID = GetSpellId();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = 24;
    if(nDuration == 1)
    {
        nDuration = 2;
    }
    effect eSummon = SetSummonEffect(nSpellID);

    //Make metamagic check for extend
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));

    //New Content - Alexander Gates: Edit Summons' stats
    //Check for animal domain.
    int nDomain1 = GetDomain(OBJECT_SELF, 1 , CLASS_TYPE_CLERIC);
    int nDomain2 = GetDomain(OBJECT_SELF, 2 , CLASS_TYPE_CLERIC);

    if(nDomain1 == 1 || nDomain2 == 1 || GetLevelByClass(CLASS_TYPE_DRUID))
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            DelayCommand(1.0, ApplySummonStats(1));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            DelayCommand(1.0, ApplySummonStats(2));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            DelayCommand(1.0, ApplySummonStats(3));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            DelayCommand(1.0, ApplySummonStats(4));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            DelayCommand(1.0, ApplySummonStats(5));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            DelayCommand(1.0, ApplySummonStats(6));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            DelayCommand(1.0, ApplySummonStats(7));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            DelayCommand(1.0, ApplySummonStats(8));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            DelayCommand(1.0, ApplySummonStats(9));
        }
    }
    else
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            DelayCommand(1.0, ApplySummonStats(0));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            DelayCommand(1.0, ApplySummonStats(1));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            DelayCommand(1.0, ApplySummonStats(2));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            DelayCommand(1.0, ApplySummonStats(3));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            DelayCommand(1.0, ApplySummonStats(4));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            DelayCommand(1.0, ApplySummonStats(5));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            DelayCommand(1.0, ApplySummonStats(6));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            DelayCommand(1.0, ApplySummonStats(7));
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            DelayCommand(1.0, ApplySummonStats(8));
        }
    }
}


effect SetSummonEffect(int nSpellID)
{
    int nFNF_Effect;
    int nRoll = d3();
    int nEleRoll = d4();
    string sSummon;

    if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_CONJURATION)) //WITH CONJURATION FOCUS
    {
        //New Summon Animal 1 to 8 Line
        if(nRoll == 1)
        {
            sSummon = "summ_wolf_2";
        }
        else if(nRoll == 2)
        {
            sSummon = "summ_bear_2";
        }
        else if(nRoll == 3)
        {
            sSummon = "summ_cat_2";
        }

        //Old Summon Code
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            //sSummon = "summ_wolf_1";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            //sSummon = "NW_S_WOLFDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            //sSummon = "NW_S_SPIDDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            //sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            //sSummon = "NW_S_diretiger";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nEleRoll)
            {
                case 1:
                    sSummon = "summ_air_1";
                    break;
                case 2:
                    sSummon = "summ_fire_1";
                    break;
                case 3:
                    sSummon = "summ_earth_1";
                    break;
                case 4:
                    sSummon = "summ_water_1";
                    break;
            }
        }
    }
    else  //WITOUT CONJURATION FOCUS
    {
        //New Summon Animal 1 to 8 Line
        if(nRoll == 1)
        {
            sSummon = "summ_wolf_1";
        }
        else if(nRoll == 2)
        {
            sSummon = "summ_bear_1";
        }
        else if(nRoll == 3)
        {
            sSummon = "summ_cat_1";
        }

        //Old Code
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            //sSummon = "summ_wolf_1";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            //sSummon = "NW_S_BOARDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            //sSummon = "NW_S_WOLFDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            //sSummon = "NW_S_SPIDDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            //sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            //sSummon = "NW_S_diretiger";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            /*
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRGREAT";
                break;

                case 2:
                    sSummon = "NW_S_WATERGREAT";
                break;

                case 3:
                    sSummon = "NW_S_FIREGREAT";
                break;
            }
            */
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nEleRoll)
            {
                case 1:
                    sSummon = "summ_air_2";
                    break;
                case 2:
                    sSummon = "summ_fire_002";
                    break;
                case 3:
                    sSummon = "summ_earth_2";
                    break;
                case 4:
                    sSummon = "summ_water_2";
                    break;
            }
        }
    }
    //effect eVis = EffectVisualEffect(nFNF_Effect);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;
}

