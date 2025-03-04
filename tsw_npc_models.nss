// creature OnSpawn event handler

// util function
int randomNumberInRange(int start, int end) {
  int diff = end - start;
  return Random(diff + 1) + start;
}

// constants and their associated model id generation functions
const string  EG_AshConvertM = "EG_AshConvertM";
const int EG_AshConvertM_START = 2056;
const int EG_AshConvertM_END = 2060;
int randomAshMModelId() {
  return randomNumberInRange(EG_AshConvertM_START, EG_AshConvertM_END);
}

const string  EG_AshConvertF = "EG_AshConvertF";
const int EG_AshConvertF_START = 2069;
const int EG_AshConvertF_END = 2071;
int randomAshFModelId() {
  return randomNumberInRange(EG_AshConvertF_START, EG_AshConvertF_END);
}

const string  AST_Drowned_Main = "AST_Drowned_Main";
const int AST_Drowned_Main_START_A = 2045;
const int AST_Drowned_Main_END_A = 2055;
const int AST_Drowned_Main_START_B = 2064;
const int AST_Drowned_Main_END_B = 2068;
int randomDrownedMainAModelId() {
  return randomNumberInRange(AST_Drowned_Main_START_A, AST_Drowned_Main_END_A);
}
int randomDrownedMainBModelId() {
  return randomNumberInRange(AST_Drowned_Main_START_B, AST_Drowned_Main_END_B);
}
int randomDrownedMainModelId() {
  int randomRoll = randomNumberInRange(0, 100);
  if(randomRoll < 50) {
    return randomDrownedMainAModelId();
  }
  return randomDrownedMainBModelId();
}

const string  SIL_WalkerZom = "SIL_WalkerZom";
const string  SIL_WandererZom = "SIL_WandererZom"; // use same as SIL_WalkerZom
const int EG_WalkerZom_START = 2128;
const int EG_WalkerZom_END = 2131;
int randomWalkerZomModelId() {
  return randomNumberInRange(EG_WalkerZom_START, EG_WalkerZom_END);
}

// get caller tag, generate model id if applicable and set appearance type
void main()
{
    object oCreature = OBJECT_SELF;
    string sCreatureTag = GetTag(oCreature);
    int modelId = 0;
    if(sCreatureTag == EG_AshConvertM) {
        SetCreatureAppearanceType(oCreature, randomAshMModelId());
    }
    if(sCreatureTag == EG_AshConvertF) {
        SetCreatureAppearanceType(oCreature, randomAshFModelId());
    }
    if(sCreatureTag == AST_Drowned_Main) {
        SetCreatureAppearanceType(oCreature, randomDrownedMainModelId());
    }
    if(sCreatureTag == SIL_WalkerZom) {
        SetCreatureAppearanceType(oCreature, randomWalkerZomModelId());
    }
    if(sCreatureTag == SIL_WandererZom) {
        SetCreatureAppearanceType(oCreature, randomWalkerZomModelId());
    }
    if(sCreatureTag == "ghost_t4a")
    {
        int nRandom = Random(2);
        if(nRandom == 0)
        {
            SetCreatureAppearanceType(oCreature, 3101);
        }
        else
        {
            SetCreatureAppearanceType(oCreature, 3110);
        }
    }
}
