//::///////////////////////////////////////////////
//:: Improved Grenade weapons script
//:: x2_s3_bomb
//:://////////////////////////////////////////////
//New Grenade scripts by Alexander G.
//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "tsw_get_martial"

void main()
{
    int nSpell = GetSpellId();
    string sGrenUsed = "GRENADES_USED";
    object oPC = OBJECT_SELF;
    location lTarget = GetSpellTargetLocation();

    //Check how many grenades the person has used today.
    int nUsed = GetLocalInt(oPC, sGrenUsed);

    //Get the total martial class levels.
    int nClassTotal = GetMartialLevel(oPC);
    //Total grenade uses allowed per day.
    int nUses =  nClassTotal / 5;

    //Compare current uses vs allowed daily.
    if(nUsed >= nUses)
    {
        SendMessageToPC(oPC, "You have used all your daily grenades. Rest to replenish your supply.");
        return;
    }


    //Acid Grenade
    if(nSpell == 745)
    {
         nUsed = nUsed + 1;
         SetLocalInt(oPC, sGrenUsed, nUsed);
         int nDamage = 35 + Random(36) + nClassTotal * 2;
         DoGrenade(nDamage, nDamage, VFX_IMP_ACID_L, VFX_FNF_GAS_EXPLOSION_ACID, DAMAGE_TYPE_ACID, RADIUS_SIZE_HUGE, OBJECT_TYPE_CREATURE);
    }
    //Frag Grenade
    else if(nSpell == 744)
    {
         nUsed = nUsed + 1;
         SetLocalInt(oPC, sGrenUsed, nUsed);
         int nDamage = 35 + Random(36) + nClassTotal * 2;
         DoGrenade(nDamage, nDamage, VFX_IMP_FLAME_M, VFX_FNF_FIREBALL,DAMAGE_TYPE_FIRE,RADIUS_SIZE_HUGE, OBJECT_TYPE_CREATURE);
    }
    //Blade Grenade
    else if(nSpell == 471)
    {
        nUsed = nUsed + 1;
        SetLocalInt(oPC, sGrenUsed, nUsed);
        effect eBladeArea = EffectAreaOfEffect(AOE_PER_STONEHOLD, "tsw_grnd_bladea", "tsw_grnd_bladec", "tsw_grnd_bladeb");
        effect eCaltrops = EffectVisualEffect(VFX_DUR_CALTROPS);
        DoGrenade(5, 25, VFX_COM_BLOOD_REG_RED, VFX_IMP_SPIKE_TRAP, DAMAGE_TYPE_PIERCING, RADIUS_SIZE_HUGE, OBJECT_TYPE_CREATURE);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eBladeArea, GetSpellTargetLocation(), RoundsToSeconds(5));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eCaltrops, GetSpellTargetLocation());
    }
    //Thunder Grenade
    else if(nSpell == 468)
    {
        nUsed = nUsed + 1;
        SetLocalInt(oPC, sGrenUsed, nUsed);
        int nDamage = 10 + Random(11) + nClassTotal * 2;
        effect eStun = EffectStunned();
        DoGrenade(5, nDamage, VFX_IMP_SONIC, VFX_FNF_ELECTRIC_EXPLOSION, DAMAGE_TYPE_ELECTRICAL, RADIUS_SIZE_HUGE, OBJECT_TYPE_CREATURE);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        while(oTarget != OBJECT_INVALID)
        {
            if(GetIsEnemy(oTarget, oPC))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, 6.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    //Cryo Grenade
    else if(nSpell == 465)
    {
        nUsed = nUsed + 1;
        SetLocalInt(oPC, sGrenUsed, nUsed);
        int nDamage = d10(2);
        DoGrenade(nDamage, nDamage, VFX_IMP_FROST_L, VFX_FNF_LOS_NORMAL_30, DAMAGE_TYPE_COLD, RADIUS_SIZE_HUGE, OBJECT_TYPE_CREATURE);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        effect eParalyze = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
        effect eHold = EffectParalyze();
        effect eLink = EffectLinkEffects(eHold, eParalyze);
        while(oTarget != OBJECT_INVALID)
        {
            if(GetIsEnemy(oTarget, oPC))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 12.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
        }
    }

    //Send message to PC about remaining grenade uses
    int sCount = nUses - nUsed;
    string sAmount = IntToString(sCount);
    SendMessageToPC(oPC, "You have " + sAmount + " grenades left.");
}
