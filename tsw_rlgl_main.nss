// essentially, "field of vision"
const float FACING_STRICTNESS = 20.0;

const float FACING_STRAIGHT = 180.0;
const float DURATION = 1.0;
const string ITERATION_COUNT = "iteration_count";

// THIS IS THE VALUE YOU WANT TO TOUCH FOR DISTANCE BETWEEN PC AND CREATURE WHOSE SCRIPT THIS IS ON
const float SPECIAL_DISTANCE = 1.0;

//Get the nearest PC within 100m and attack them
void AttackNearestPC()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 500.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsPC(oTarget))
        {
            ActionAttack(oTarget);
            break;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 500.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
    }
}


int isInFacingZone(float diff)
{
    // creature looking at pc from north towards south
    if(diff <= FACING_STRAIGHT + FACING_STRICTNESS && diff >= FACING_STRAIGHT - FACING_STRICTNESS)
    {
        return 1;
    // creature looking at pc from south towards north
    }
    else if (diff <= -FACING_STRAIGHT + FACING_STRICTNESS && diff >= -FACING_STRAIGHT - FACING_STRICTNESS)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

int isFacing(float oTargetOrientation, float oSourceOrientation)
{
    float diff = oSourceOrientation - oTargetOrientation;
    return isInFacingZone(diff);
}

void applyParalysis()
{
    effect ePara = EffectCutsceneParalyze();
    ePara = TagEffect(ePara, "STARTSTOP_PARALYSIS");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePara, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "AM_PARALYZED", 1);
}

void removeParalysis()
{
    effect eEffect = GetFirstEffect(OBJECT_SELF);
    int found = 0;
    while (GetIsEffectValid(eEffect) && found == 0)
    {
        if(GetEffectTag(eEffect) == "STARTSTOP_PARALYSIS")
        {
          found = 1;
          RemoveEffect(OBJECT_SELF, eEffect);
          SetLocalInt(OBJECT_SELF, "AM_PARALYZED", 0);
        }
        eEffect = GetNextEffect(OBJECT_SELF);
    }
    AttackNearestPC();
}

int isInSameArea(object oTarget, object oSource=OBJECT_SELF)
{
    object oSourceArea = GetArea(oSource);
    object oTargetArea = GetArea(oTarget);
    if(oTargetArea == oSourceArea)
    {
        return 1;
    }
    return 0;
}

// iterate over each PC, then checkif they're in the area, if they can be seen and if they're hostile
int awaken()
{
    object oPC = GetFirstPC();
    int isAwake = 0;
    while(GetIsPC(oPC))
    {
        if(isInSameArea(oPC) && GetIsEnemy(oPC))
        {
            isAwake = 1;
        }
        oPC = GetNextPC();
    }
    return isAwake;
}

void main()
{
    int nIterationCount = GetLocalInt(OBJECT_SELF, ITERATION_COUNT);
    SetLocalInt(OBJECT_SELF, ITERATION_COUNT, nIterationCount + 1);
    int nParaCheck = GetLocalInt(OBJECT_SELF, "AM_PARALYZED");

    //Ensure creature is in combat. If not, do nothing.
    /*
    if(!GetIsInCombat(OBJECT_SELF))
    {
        return;
    }
    */

    int isAwake = awaken();
    if(!isAwake)
    {
        applyParalysis();
        //SendMessageToPC(oPC, "I am not awake.");
    }
    else
    {
        object oPC = GetFirstPC();
        //SendMessageToPC(oPC, IntToString(nIterationCount + 1));
        while(GetIsObjectValid(oPC))
        {
            if(GetIsEnemy(oPC) && GetArea(oPC) == GetArea(OBJECT_SELF) && GetObjectSeen(oPC))
            {
                float fCreatureOrientation = GetFacing(OBJECT_SELF);
                float fPCOrientation = GetFacing(oPC);
                int facing = isFacing(fPCOrientation, fCreatureOrientation);
                if(facing == 1)
                {
                    ClearAllActions();
                    applyParalysis();
                    SendMessageToPC(oPC, "I am paralyzed.");
                }
                else
                {
                    removeParalysis();
                    SendMessageToPC(oPC, "I am free!");
                }
            }

            float fDistanceFromPC = GetDistanceToObject(oPC);
            if(fDistanceFromPC <= SPECIAL_DISTANCE)
            {
            // THIS IS THE BLOCK YOU WANT TO TOUCH FOR DISTANCE BETWEEN PC AND CREATURE WHOSE SCRIPT THIS IS ON
            }
            oPC = GetNextPC();
        }
    }

    if(nIterationCount >= 5)
    {
        SetLocalInt(OBJECT_SELF, ITERATION_COUNT, 0);
        //return;
    }

    DelayCommand(DURATION, main());
}
