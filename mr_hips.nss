#include "mr_hips_inc"
#include "tsw_class_func"
///////////////////////////////////////
//MadRabbit's HIPS Feat              //
//Created By : MadRabbit             //
//Created On : April 14, 2009        //
//Email : mad_rabbit_land@hotmail.com//
///////////////////////////////////////
//Hakpack script to be used with a new Pseudo HIPS ability.
//You can modify it and save it in your module if you want to recreate how the
//new HIPS ability works.
//I've included detailed notes on how this works.
//The HIPS delay can be modified in mr_hips_inc
//Evenflow's HIPS scripts served as a basis for designing this and thus credit
//to him is deserved.

//FUNCTIONS

//Temporarily gives oSneak the orginal HIPS feat for 3 seconds
void SetHasTemporaryHIPS(object oSneak)
{
    //Declare the variables needed.
    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oSneak);
    itemproperty iHIPS = ItemPropertyBonusFeat(31);

    //Thanks to Bioware's horses, all players have skins.
    //If oSkin is a valid object then apply HIPS and end function
    if (GetIsObjectValid(oSkin))
    {
        AddItemProperty(DURATION_TYPE_TEMPORARY, iHIPS, oSkin, 3.0f);
        return;
    }

    //If there is no skin, then create one and give it the HIPS feat
    oSkin = CreateItemOnObject("x2_it_emptyskin", oSneak);
    AddItemProperty(DURATION_TYPE_TEMPORARY, iHIPS, oSkin, 3.0f);
    AssignCommand(oSneak, ClearAllActions());
    DelayCommand(0.25, AssignCommand(oSneak, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR)));
}

int CheckForHarmfulEffects(object oSneak)
{
    effect eEffect = GetFirstEffect(oSneak);
    int nType;

    while (GetIsEffectValid(eEffect)) {
        nType = GetEffectType(eEffect);

        if (nType == EFFECT_TYPE_CHARMED || nType == EFFECT_TYPE_CONFUSED ||
            nType == EFFECT_TYPE_CUTSCENE_PARALYZE || nType == EFFECT_TYPE_DOMINATED ||
            nType == EFFECT_TYPE_FRIGHTENED || nType == EFFECT_TYPE_PARALYZE ||
            nType == EFFECT_TYPE_PETRIFY || nType == EFFECT_TYPE_SLEEP ||
            nType == EFFECT_TYPE_STUNNED || nType == EFFECT_TYPE_TIMESTOP)
            return TRUE;

        eEffect = GetNextEffect(oSneak); }

    return FALSE;
}

//MAIN CODE

void main()
{
    //The hak replaces the shadowdancer's HIPS feat with a pseudo version of HIPS
    //that gives the shadowdancer's unlimited uses of an innate HIPS ability.
    //Stealth mode no longer triggers HIPS.
    //This script controls all the behavior of the new HIPS feat
    //OBJECT SELF = User of the innate ability

    if (GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH)) {
        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
        return; }

    int nAction = GetCurrentAction();

    /*
    if (nAction == ACTION_ATTACKOBJECT) {
        SendMessageToPC(OBJECT_SELF, "You cannot enter stealth while in combat!");
        return; }
    */

    if (nAction == ACTION_CASTSPELL) {
        SendMessageToPC(OBJECT_SELF, "You cannot enter stealth while casting a spell!");
        return; }

    if (nAction == ACTION_REST) {
       SendMessageToPC(OBJECT_SELF, "You cannot enter stealth while resting!");
        return; }

    if (CheckForHarmfulEffects(OBJECT_SELF)) {
        SendMessageToPC(OBJECT_SELF, "You cannot use stealth mode at this time!");
        return; }

    //If a delay is defined and they are flagged for a check, then the heartbeat
    //script hasnt picked up on them being out of stealth mode yet and we need
    //to prohibit them from using the ability
    if (GetLocalInt(OBJECT_SELF, "MR_HIPS_CHK") && HIPS_DELAY != 0.0) {
        SendMessageToPC(OBJECT_SELF, "You must wait before using this ability again!");
        return; }

    //Check to see if they can use the feat
    //If they are flagged, abort the script.
    if (GetLocalInt(OBJECT_SELF, "MR_HIPS")) {
        SendMessageToPC(OBJECT_SELF, "You must wait before using this ability again!");
        return; }

    //At this point, we can assume it's safe to enter HIPS.

    //We still need the orginal HIPS feat so we will give that to player temporarily
    SetHasTemporaryHIPS(OBJECT_SELF);

    //Move the sneak into stealth mode
    //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEthereal(), OBJECT_SELF, 0.8);
    DelayCommand(0.5, SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE));

    //Flag them as ready to be checked if there is a delay in place
    if (HIPS_DELAY != 0.0)
        DelayCommand(0.5, SetLocalInt(OBJECT_SELF, "MR_HIPS_CHK", 1));

    //Class mechanics
    string sSpellType = "Guile";
    DoMartialMechanic(sSpellType, "Single", 0, OBJECT_SELF);
}

