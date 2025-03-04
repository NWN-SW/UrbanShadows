void TwistedNatureOnDeathExplosion()
{
    int iForCount = 0;
    location lCreatureDiedHere = GetLocation(OBJECT_SELF);
    object oArea = GetArea(OBJECT_SELF);
    effect ePlantVFX = EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM,FALSE,1.5f);
    effect ePlantBoom = EffectVisualEffect(241,FALSE, 0.50f);
    effect eBlindFright = EffectLinkEffects(EffectBlindness(),EffectVisualEffect(44));
    eBlindFright = EffectLinkEffects(eBlindFright,EffectVisualEffect(46));
    SetLocalLocation(oArea,"lDiedHere",lCreatureDiedHere);
    SetCommandable(1,oArea);
    location lGetLocation = GetLocalLocation(oArea,"lDiedHere");
    for (iForCount =0; iForCount<3;iForCount++)
    {
        AssignCommand(GetArea(OBJECT_SELF),DelayCommand(iForCount*3.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePlantVFX,lGetLocation)));
    }

    AssignCommand(GetArea(OBJECT_SELF),DelayCommand(9.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePlantBoom,lGetLocation)));
    object oPCNext = GetFirstObjectInShape(SHAPE_SPHERE,5.0f ,lGetLocation,TRUE);
    while (GetIsObjectValid(oPCNext))
    {
       if (GetIsEnemy(oPCNext))
       {
            AssignCommand(GetArea(OBJECT_SELF),DelayCommand(11.0f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlindFright,oPCNext,6.0f)));
            AssignCommand(GetArea(OBJECT_SELF),DelayCommand(11.0f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectConfused(),oPCNext,13.0f)));
       }
        oPCNext = GetNextObjectInShape(SHAPE_SPHERE,5.0f ,lGetLocation,TRUE);
    }
}


void ZombieOnDeathBlast ()
{

    int iDamageDealt = GetLocalInt(OBJECT_SELF,"CREATURE_DEF_TIER");

    location lMobDying = GetLocation(OBJECT_SELF);
    object oPCNext = GetFirstObjectInShape(SHAPE_SPHERE,3.33f ,lMobDying,TRUE);

    effect eDamageDealt = EffectDamage(iDamageDealt*10,DAMAGE_TYPE_ACID);
    effect eDamageDealtVFX = EffectVisualEffect(VFX_IMP_POISON_L,FALSE,1.33f);
    effect eGutsVFX = EffectVisualEffect(121);
    ApplyEffectToObject (DURATION_TYPE_INSTANT,eGutsVFX,OBJECT_SELF);

     while (GetIsObjectValid(oPCNext))
    {
       DelayCommand(0.5f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamageDealt,oPCNext));
       DelayCommand(0.5f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamageDealtVFX,oPCNext));

       oPCNext = GetNextObjectInShape(SHAPE_SPHERE,3.33f ,lMobDying,TRUE);

    }
}


// Good idea, bad execution so far
// On death curse mechanism but currently the curse cannot go down. Would need a hearbeat check on some areas. Tombs and stuff
void MummyOnDeathCurse ()
{

    effect eDeathVFX = EffectVisualEffect(50);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeathVFX,OBJECT_SELF);

    object oKiller = GetLastKiller();

    int iTempCurse = GetLocalInt(oKiller, "iCursedAmount");
    if (iTempCurse + 5 <= 100)
    {
        SetLocalInt(oKiller,"iCursedAmount", iTempCurse+5);
    }

    else if (iTempCurse +5 > 100)
    {

     SetLocalInt(oKiller,"iCursedAmount", 100);
     int iDamageDealt =(iTempCurse+5) % 100;

     effect eDamage = EffectDamage(Random(11) + iDamageDealt, DAMAGE_TYPE_POSITIVE);
     ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oKiller);

    }

}



void main()
{
        int iOnDeathFuncParam = GetLocalInt(OBJECT_SELF,"iDeathFuncParam");

        switch (iOnDeathFuncParam){
        default:
        break;

        case 1:
        ZombieOnDeathBlast();
        break;

        case 2:
        TwistedNatureOnDeathExplosion();
        break;

        case 3:
        MummyOnDeathCurse();
        break;


        }
}




