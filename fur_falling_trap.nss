// Falling Trap
// Version 1.0 by Box
// Version 1.3 by Lost Dragon
//
// Use:  Draw a trigger in the shape that you wish your pit to be in.
//
// Change the tag of the trigger using the following template as a guide
//
// pitfall_dc_hii_f_m
//
// dc = DC to fall in pit for reflex save
// hii = Height of fall (amount you fall in feet -> used to calculate damage (can be 0 to 200)
// f = fatal or not (0 = lets you die if you lose enough hp, 1 = takes away appropriate hp down to 1)
// m  = makes trap happen once or more than once.  0 = always happens, 1 = happens once per PC
//
// Make the NAME of your trigger match the TAG of the waypoint you want to land in
//
// Damage is done at 1d6 Per 10 feet Maximum 20d6 Max of 20d6 per DMG
//
//*************************************
// (*) 1.0 edit to clean up code and add ability check 5/16/2003 (Lost Dragon)
// (*) 1.1 changed the ability check to a reflex save 5/18/2003 (Lost Dragon)
// (*) 1.2 added substring checks.  One script can now handle all pit traps (Lost Dragon)
// (*) 1.3 added code to use trigger NAME to tell code what waypoint TAG to find for landing
//*************************************
//
// Put this in the OnEnter of a trigger
// Lost Dragon is the intellectual property of DeBray Bailey

void main()
{
object oTarget;
location lLanding;

string sTag = GetTag(OBJECT_SELF); // What is trigger's tag?
string sName = GetName(OBJECT_SELF); // What is name of trigger?
string sSoundName01 = "as_cv_bldgcrumb1"; // Sound that is played when triggered (Building Crumbling)
// string sSoundName02 = "bf_med_flesh"; // Optional sound played when player hits the ground (THUNK) - a bit redundant with knockdown, IMO
string sWords = "You slid into a crypt pit!"; // Floaty Text for the end of the trap
string sSave = "You gaze at the ceiling far above and wonder how you survived!"; // Floaty Text in case you choose a non Fatal Trap

string subdeath = GetSubString(sTag, 15, 1);   // get 1 character of tag that's 15 characters over from left
string subheight =  GetSubString(sTag, 11, 3); // get 3 characters of tag that's 11 characters over
string subdc = GetSubString(sTag, 8, 2);       // get 2 characters of tag that's 8 characters over
string subonce = GetSubString(sTag, 17, 1);    // get 1 character of tag that's 17 characters over

int iDeath = StringToInt(subdeath);  // now turn the characters we grabbed above into an int the game can use
int iHeight = StringToInt(subheight);
int nDC = StringToInt(subdc);
int iOnce = StringToInt(subonce);

oTarget = GetWaypointByTag(sName); // Look for waypoint with tag that is the same as the name of triger
lLanding = GetLocation(oTarget);   // Get the location of that waypoint

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;  // only players can fall

if (iOnce)  // can this pitfall be triggered more than once?
{
    int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
    if (DoOnce==TRUE) return;  // nope, it can't
    SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
}

int nRoll = ReflexSave(oPC, nDC, SAVING_THROW_TYPE_TRAP, OBJECT_SELF);
if(nRoll >= 1)
      return; // you pass your reflex save (or are immune) - no falling in the pit for you!
else          // uh oh, ability check failed, down the pit you go
   {
if (iHeight>10) iHeight=10; // Max of 20d6 per DMG
    int iDamage = d6(iHeight/10);
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,PlaySound(sSoundName01));
    AssignCommand(oPC,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oPC)));
    AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oPC, 1.5f));
    AssignCommand(oPC,ActionJumpToLocation(lLanding));
    DelayCommand(0.2,SetCommandable(FALSE,oPC));
    DelayCommand(1.2, AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0f)));
    DelayCommand(1.4, AssignCommand(oPC,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oPC))));
if (iDeath)  DelayCommand(1.6, AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage((GetCurrentHitPoints(oPC) - 1), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL), oPC)));
if (!iDeath) DelayCommand(1.6, AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL), oPC)));
    // AssignCommand(oPC,PlaySound(sSoundName02));  // comment this out if you don't want the "thump" sound to play
    DelayCommand(2.5, FloatingTextStringOnCreature(sWords, oPC, FALSE));  // Display words only above the PC's head
if (iDeath) DelayCommand(4.5, FloatingTextStringOnCreature(sSave, oPC, FALSE));
    DelayCommand(4.6,SetCommandable(TRUE,oPC));
   }
}

