#include "spell_dmg_inc"

void DoStamAnimDmg(int iDamage, object oPCTarget)
{
    effect eDamage;
    eDamage = EffectDamage(iDamage, DAMAGE_TYPE_POSITIVE);
    ApplyEffectToObject(0,eDamage,oPCTarget);
}


void main()
{
    effect eFilthualFX = EffectVisualEffect(VFX_DUR_TENTACLE,FALSE,1.5f);

    if (GetLocalInt(OBJECT_SELF,"iTentacleFilth") != 0)
    {
        int iPullChance = Random(100);

        object oNearestTentacle = GetNearestObjectByTag("tentaclefilth", OBJECT_SELF);

    if (iPullChance >=61 && GetIsObjectValid(oNearestTentacle))
    {
        int iNearestPCCounter = 1;
        object oNearestPC =  GetNearestObject(OBJECT_TYPE_CREATURE,oNearestTentacle,iNearestPCCounter);

        while (!GetIsEnemy(oNearestPC) && GetIsObjectValid(oNearestPC))
        {
          iNearestPCCounter +=1;
          oNearestPC =  GetNearestObject(OBJECT_TYPE_CREATURE,oNearestTentacle,iNearestPCCounter);
        }

     float fDistanceBetweenTentaclePC = GetDistanceBetween(oNearestPC, oNearestTentacle);
     if (fDistanceBetweenTentaclePC <= 22.0f)
     {

        string sTentacledMessage;
        vector vPlayerPulledToPos = GetPosition(oNearestTentacle)+Vector(IntToFloat(Random(5)),IntToFloat(Random(5)),0f);
        float fTentacleFacing = GetFacing(oNearestTentacle);
        location lTentaclePullToLoc = Location(GetArea(OBJECT_SELF), vPlayerPulledToPos, fTentacleFacing);
        int iMissOrNot = FALSE;
        effect eKnocked = EffectKnockdown();
        float fKnocked = 1.0f;
        float fKnockedDelay = 0.50f;


        if (iPullChance>=85)
        {
            fKnocked = 3.0f;
            fKnockedDelay = 2.0f;
            DelayCommand(1.5f,AssignCommand(oNearestPC, JumpToLocation(lTentaclePullToLoc)));

          sTentacledMessage = "The nearest overgrowth sent forth a whip-like tentacle of filth, successfully snatching you off the ground to its position ";
        }
        else
        {
             iMissOrNot = TRUE;
            sTentacledMessage = "The nearest overgrowth sent forth a whip-like tentacle of filth in an attempt to abduct you, barely missing.";
        }
         effect eBeamFilth = EffectLinkEffects(EffectVisualEffect(VFX_DUR_TENTACLE,iMissOrNot,1.5f),EffectBeam(485,oNearestTentacle,BODY_NODE_CHEST,iMissOrNot));
         DelayCommand(fKnockedDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnocked,oNearestPC,fKnocked));
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamFilth,oNearestPC,3.0f);
         SendMessageToPC(oNearestPC,sTentacledMessage);

     }
    }
    }

    object oPCinFilth = GetFirstInPersistentObject(OBJECT_SELF);
    int nAnima = GetLocalInt(oPCinFilth, "PC_ANIMA_CURRENT");
    int nStamina = GetLocalInt(oPCinFilth, "PC_STAMINA_CURRENT");
    int iFilthDamage = 0;


    while (GetIsObjectValid(oPCinFilth))
    {
        if (GetIsEnemy(oPCinFilth))
        {
            if (GetLocalInt(oPCinFilth,"I_AM_BLOODMAGE") || !GetIsPC(oPCinFilth))
            {
                    iFilthDamage = 15;
                    DoStamAnimDmg(iFilthDamage, oPCinFilth);

            }
            else
            {
                if ( nAnima >=5)
                {
                    SetLocalInt(oPCinFilth, "PC_ANIMA_CURRENT", nAnima-5);
                }
                else
                {
                    iFilthDamage = abs(nAnima -5);
                    SetLocalInt(oPCinFilth, "PC_ANIMA_CURRENT", 0);
                }
                if ( nStamina >=5 )
                {
                    SetLocalInt(oPCinFilth, "PC_STAMINA_CURRENT", nStamina-5);
                }
                else
                {
                    iFilthDamage += abs(nStamina -5);
                    SetLocalInt(oPCinFilth, "PC_STAMINA_CURRENT", 0);
                }
        }

    if (iFilthDamage >0)
    {
        DoStamAnimDmg(iFilthDamage, oPCinFilth);
    }

    UpdateBinds(oPCinFilth);
    ApplyEffectToObject(1, eFilthualFX, oPCinFilth,3.0f);
    if (Random(4) == 1)
    {
        SendMessageToPC(oPCinFilth,"The filth shifts around and sways in an attempt to submerge you.");
    }
    }
    oPCinFilth = GetNextInPersistentObject(OBJECT_SELF);

    }

}
