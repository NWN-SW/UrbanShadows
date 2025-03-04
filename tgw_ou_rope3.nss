//::////////////////////////////////////////////////////////////////////////////
//:: TGW_OU_ROPEUP
/*
  Synopsis: A PC clicks on a rope and the screen fades out.  If the PC does
  not have the strength and/or dexterity to successfully climb up, the PC falls
  to the ground, the screen fades in, damage is delt to the PC, he/she gets up,
  wabbles around as if stunned from the fall, then a message is sent to the PC.
  If the PC succeeds at climbing, he/she is transported to the destination, and
  a message is sent to the PC.

  This script is placed in the "OnUsed" script of a rope whose tag is in the
  form of TGW_WELLxx (where xx is a two-digit number like 01, 07, 26, 99....)
  For each rope with the previously mentioned tag and "OnUsed" script, a
  well, waypoint, etc. with a tag in the form of TGW_WELLxx should be created
  somewhere in the module. To make a two-way transition, see TGW_OU_WELL.

  The novice user is encouraged to change any Descretionary Variables
  but should not alter other aspects of this script.

  Using the default script, it is easier to climb down than up.  There is also
  more damage delt if the character fails going down.  An alternate means of
  getting out of the area where the rope is located is essential.  If you use
  the default, you can garauntee that the PC climb (or fall) down without any
  garauntee of escape.

  To see where this well/rope combination was first used, look for "CEP A TRUE
  GLOBAL WORLD" in the PW Action category online.

 */
//:: Created By: HercNav
//:: Created On: 07/24/2004

void main()
{
//::////////////////////////////////////////////////////////////////////////////
//::////////////////////////////////////////////////////////////////////////////
//Descretionary variables
    //PC must have a strength higher than this number to climb
    int nStrCheck = 1; //Default = 12
    //PC must have a dexterity higher than this number to climb
    int nDexCheck = 1; //Default = 9
    //Damage delt to player if either ability score fails
    int nDamage = d10(1); //Default = d10(1)
    //Message to PC if either ability score fails
    string sSuccess = "You successfully climb the Ivy Vine."; //Default = "You successfully climb the rope."
    //Message to PC if both ability scores pass
    string sFail = "Your attempt to climb the Ivy Vine failed, and you fell."; //Default = "Your attempt to climb rope failed, and you fell."
//::////////////////////////////////////////////////////////////////////////////
//::////////////////////////////////////////////////////////////////////////////

//Non-descretionary variables
    //Get the rope's complete tag in the form of a string
    string sOrig = GetTag(OBJECT_SELF);
    //Get the last two digits in the rope's tag
    string sLastTwo = GetStringRight(sOrig, 2);
    //Place those last two digits at the end of a string
    string sDest = "TGW_WELL" + sLastTwo;
    //Make that string the tag of the destination
    object oDest = GetObjectByTag(sDest);
    //Make the destination object a location
    location lDest = GetLocation(oDest);
    //Make the PC an object
    object oPC = GetLastUsedBy();
//Dramatic Scene!
    //Fade out
    FadeToBlack(oPC, FADE_SPEED_SLOWEST);
        //Determine if the PC has the strength to successfully climb the rope
        if (GetAbilityScore(oPC, ABILITY_STRENGTH) <= nStrCheck)
           {
           //PC fails to climb up; put the PC on his/her back
           DelayCommand(1.0, (AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 3.0))));
           //Fade in
           DelayCommand(4.0, (FadeFromBlack(oPC, FADE_SPEED_SLOWEST)));
           //Deal Damage to PC
           DelayCommand(2.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, (EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL)), oPC, 0.0f)));
           //Make the PC sway as if drunk
           DelayCommand(4.0, (AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 5.0))));
           //Announce to PC that he/she has failed
           DelayCommand(7.0, (FloatingTextStringOnCreature(sFail, oPC, FALSE)));
           return;
           }
        //Determine if the PC has the dexterity to successfully climb the rope
        if (GetAbilityScore(oPC, ABILITY_DEXTERITY) <= nDexCheck)
           {
           //PC fails to climb up; put the PC on his/her back
           DelayCommand(1.0, (AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 3.0))));
           //Fade in
           DelayCommand(4.0, (FadeFromBlack(oPC, FADE_SPEED_SLOWEST)));
           //Deal Damage to PC
           DelayCommand(2.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, (EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL)), oPC, 0.0f)));
           //Make the PC sway as if drunk
           DelayCommand(4.0, (AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 5.0))));
           //Announce to PC that he/she has failed
           DelayCommand(7.0, (FloatingTextStringOnCreature(sFail, oPC, FALSE)));
           return;
           }
//The PC has the strength and dexterity to climb up
    //Move the PC to the top of the rope
    AssignCommand(oPC, ActionJumpToLocation(lDest));
    //Fade in
    DelayCommand(5.0, (FadeFromBlack(oPC, FADE_SPEED_SLOWEST)));
    //Announce to the PC that he/she has succeeded
    DelayCommand(1.0f, FloatingTextStringOnCreature(sSuccess, oPC, FALSE));
}

