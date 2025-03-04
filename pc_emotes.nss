// In this example script, the OnPlayerChat event is being used to support
// chat-based emotes. Players can type predetermined commands into their chat
// window to get their avatar to perform emotes instead of using their radial menu.
// This technique could be used to provide players with emote animations or even
// sequences of animations not normally available from their radial menu in addition
// to the ones that are there.
// In this example two commands are implemented: sitting on the ground, and
// worshiping. The predetermined commands coded to be recognized for these are
// "*emote sit" and "*emote worship". To give further indication that the command
// was understood, and to prevent every other player in earshot from hearing the
// PC's emote command, the script echos the command back to the PC in his message
// window and lowers the volume of the echoed message so that only he will hear it.
// The example does not care what volume the chat was spoken at, but if it was
// desirable to treat different volumes of chat differently, the GetPCChatVolume
// function would be employed to make that determination.

#include "tsw_egpuz_3"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"
#include "inc_timer"
#include "tsw_set_ears"
#include "tsw_touch_toggle"
#include "tsw_remove_wepfx"
#include "tsw_add_wepfx"
#include "tsw_rank_emote"
#include "tsw_get_rndmloc"
#include "0i_win_layouts"
#include "loot_gen_items"

//TSW NUI Resources Old
#include "inc_nui_resource"

//Tablet and Keypad Includes, added 10.05.2024
#include "tsw_nui_keyp"
#include "tsw_nui_tablet"

//hVFX & gVFX Includes, added 30.12.2024
#include "tsw_nui_hat"

//NWNX Plugins
#include "nwnx_time"
#include "nwnx_util"


// DeleteConv - currently inaccessible as the related chat command has been commented out
void DeleteConv(object oPC)
{
 BeginConversation("tsw_del", oPC);
}

void DmSendMessage(object oPC,string sMessage)
{
    if ((GetIsDM(oPC) || GetIsDMPossessed(oPC)))
            {
            object oNextPC = GetFirstPC();
            while (oNextPC !=OBJECT_INVALID)
            {
                FloatingTextStringOnCreature(sMessage,oNextPC,FALSE);
                oNextPC = GetNextPC();
            }

        }
}

// OnPlayerChat script.
void main()
{

  object oPC = GetPCChatSpeaker();
  string sModuleName = NWNX_Util_GetEnvironmentVariable("NWNX_TSW_SERVER_TYPE");
  string sSinglePlayer = GetPCPublicCDKey(oPC, FALSE);

  if(!GetIsPC(oPC))
  {   return;   }
  //Stances

  ExecuteScript("pc_set_stance", OBJECT_SELF);
  //Egypt Puzzle 1
  if (!GetIsDM(oPC) && !GetIsDMPossessed(oPC))
  {
    ExecuteScript("tsw_egpuz_chat1", OBJECT_SELF);
    if (GetLocalString(oPC,"sTriggerTag")!= "")
    {
        ExecuteScript("tsw_lib_riddle",OBJECT_SELF);
    }

  }
  //Shifter Forms
  ExecuteScript("pc_shifter_app", OBJECT_SELF);

  //Get lobby waypoint
  object oWP = GetWaypointByTag("MAIN_LOBBY_WP");

  // First determine which PC's chat triggered the event.
  // If the PC is not valid, perhaps his computer crashed, do nothing more.

  // Next, determine what was spoken, and change it to all lower case to make
  // parsing through it easier and to have the commands be case insensitive. We
  // also trim all leading spaces from the front because we want to ignore them.
  string sCommand = GetStringLowerCase(GetPCChatMessage());
  while((sCommand != "") && (GetStringLeft(sCommand, 1) == " "))
  {
    sCommand = GetStringRight(sCommand, GetStringLength(sCommand) -1);
  }

      if (!GetIsDM(oPC) && !GetIsDMPossessed(oPC))
  {     int nVolume = GetPCChatVolume();
        if (nVolume == TALKVOLUME_SHOUT)
        {
            SetPCChatVolume(TALKVOLUME_TALK);
        }
  }



  // If the first seven letters of the chat spoken is not our pre-determined command
  // keyword "*emote ", then ignore the chat completely and do nothing more.
  // In this case, the chat will go out normally to everybody that can hear it just
  // like it would if no special OnPlayerChat script was being used at all.

  if(GetStringLeft(sCommand, 1) != "/" && GetStringLeft(sCommand, 1) != "-" && GetStringLeft(sCommand, 1) != "@" )
  {
    if (GetLocalInt(oPC,"iDMTarget") == 1)
    {
        SetLocalString(oPC,"sDMCommand",sCommand);
     FloatingTextStringOnCreature("Your input is : " + sCommand + " - Make sure to double check it to avoid mistakes.",oPC,FALSE);

    }
     else
     {
      return;
     }
  }

  // Next, strip off the "/" keyword from the front of the command and trim
  // all leading and trailing spaces present in what's left over. This lets the
  // players be a little less accurate with the spacing of their chat command and
  // still allows our script to recognize it as a valid emote request. What we end
  // up with is just the specific emote command requested by the player.
  string sEmote = GetStringRight(sCommand, GetStringLength(sCommand) -1);
  while((sEmote != "") && (GetStringLeft(sEmote, 1) == " "))
  {   sEmote = GetStringRight(sEmote, GetStringLength(sEmote) -1);   }

  while((sEmote != "") && (GetStringRight( sEmote, 1) == " "))
  {   sEmote = GetStringLeft(sEmote, GetStringLength(sEmote) -1);   }

  // Now we check the emote requested to see if it is one we provide for them, and
  // if so, set a variable to keep track of which animation sequence to play for the
  // emote requested. Should the requested emote not be something we support, simply
  // ignore it and let the chat go out like normal.
  int iAnimation = -1;


	
  // DM only section :
  if (FindSubString(sEmote,"dmtg",0)==0)
  {
    SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_PLAYER_TARGET, "tsw_on_target");
	EnterTargetingMode(oPC);

    if ((GetIsDM(oPC) || GetIsDMPossessed(oPC)))
    {
        SetLocalInt(oPC,"iDMTarget",1);
        FloatingTextStringOnCreature("Entered Targeting mode : speak your command and click on the target",oPC,FALSE);
        EnterTargetingMode(oPC);
	}
  }
  else if (sEmote == "setplot")
  {  
	SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_PLAYER_TARGET, "tsw_on_target");
	SetLocalString(oPC,"sTargetMode",sEmote);
	EnterTargetingMode(oPC);
  }

    else if (sEmote == "signalresetstart")
    {
        DmSendMessage(oPC,"SERVER RESET WARNING : A server reset has been planned in about 5 to 10 minutes. Best to stay safe until then.");

    }

    else if (sEmote == "signalresetcancel")
    {
        DmSendMessage(oPC,"SERVER RESET WARNING : The reset has been cancelled. Have fun!");
    }

  else if(sEmote == "sit")
  {   iAnimation = ANIMATION_LOOPING_SIT_CROSS;   }
  else if(sEmote == "bow")
    {
        iAnimation = ANIMATION_FIREFORGET_BOW;
    }
  else if(sEmote == "testshotgun_988")
    {
        string sWeapon = GetRandomItem();
        int nCount = 0;
        while(sWeapon != "shotgun")
        {
            SendMessageToPC(oPC, "Attempt " + IntToString(nCount) + ": " + sWeapon);
            sWeapon = GetRandomItem();
            nCount = nCount + 1;
        }
    }
  else if(sEmote == "drink")
  {   iAnimation = ANIMATION_FIREFORGET_DRINK;   }
  else if(sEmote == "greet" || sEmote == "greeting" || sEmote == "wave")
  {   iAnimation = ANIMATION_FIREFORGET_GREETING;   }
  else if(sEmote == "bored")
  {   iAnimation = ANIMATION_FIREFORGET_PAUSE_BORED;   }
  else if(sEmote == "scratch")
  {   iAnimation = ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD;   }
  else if(sEmote == "read")
  {   iAnimation = ANIMATION_FIREFORGET_READ;   }
  else if(sEmote == "salute")
  {   iAnimation = ANIMATION_FIREFORGET_SALUTE;   }
  else if(sEmote == "spasm")
  {   iAnimation = ANIMATION_LOOPING_SPASM;   }
  else if(sEmote == "taunt")
  {   iAnimation = ANIMATION_FIREFORGET_TAUNT;   }
  else if(sEmote == "laugh")
    {
        iAnimation = ANIMATION_LOOPING_TALK_LAUGHING;
    }
  else if(sEmote == "auto_engage")
    {
        int nEngage = SQLocalsPlayer_GetInt(oPC, "AUTO_ENGAGE_SETTING");
        if(nEngage == 0)
        {
            SQLocalsPlayer_SetInt(oPC, "AUTO_ENGAGE_SETTING", 1);
            SendMessageToPC(oPC, "You will no longer auto engage enemies after using an ability in melee range.");
        }
        else
        {
            SQLocalsPlayer_SetInt(oPC, "AUTO_ENGAGE_SETTING", 0);
            SendMessageToPC(oPC, "You will now auto engage enemies after using an ability in melee range.");
        }
    }

      else if(sEmote == "no_opp")
    {
        int nEngage = SQLocalsPlayer_GetInt(oPC, "NO_OPP_SETTING");
        if(nEngage == 0)
        {
            SQLocalsPlayer_SetInt(oPC, "NO_OPP_SETTING", 1);
            SendMessageToPC(oPC, "Your character will no longer perform Attacks of Opportunity.");
        }
        else
        {
            SQLocalsPlayer_SetInt(oPC, "NO_OPP_SETTING", 0);
            SendMessageToPC(oPC, "Your character will perform Attacks of Opportunity.");
        }
    }
  else if(sEmote == "victory1")
  {   iAnimation = ANIMATION_FIREFORGET_VICTORY1;   }
  else if(sEmote == "victory2")
  {   iAnimation = ANIMATION_FIREFORGET_VICTORY2;   }
  else if(sEmote == "victory3")
  {   iAnimation = ANIMATION_FIREFORGET_VICTORY3;   }
  else if(sEmote == "dead1")
  {   iAnimation = ANIMATION_LOOPING_DEAD_BACK;   }
  else if(sEmote == "dead2")
  {   iAnimation = ANIMATION_LOOPING_DEAD_FRONT;   }
  else if(sEmote == "listen")
  {   iAnimation = ANIMATION_LOOPING_LISTEN;   }
  else if(sEmote == "look")
  {   iAnimation = ANIMATION_LOOPING_LOOK_FAR;   }
  else if(sEmote == "meditate" || sEmote == "pray")
  {
    iAnimation = ANIMATION_LOOPING_MEDITATE;
    RunEgyptPuzzleThree(oPC);
  }
  else if(sEmote == "dm_setgnomedone_944")
  {
    SQLocalsPlayer_SetInt(oPC, "GNOME_QUEST", 13);
    AddJournalQuestEntry("Gnome_Quest", 13, oPC, FALSE);
  }
  else if(sEmote == "gnome")
  {
    int nGnomeCheck = SQLocalsPlayer_GetInt(oPC, "GNOME_QUEST");
    if(nGnomeCheck >= 13)
    {
        ExecuteScript("tsw_play_gnm_ins", oPC);
    }
    else
    {
        SendMessageToPC(oPC, "You must complete the evil gnome quest to use this command.");
    }
  }
  else if(sEmote == "drunk")
  {   iAnimation = ANIMATION_LOOPING_PAUSE_DRUNK;   }
  else if(sEmote == "destroy_area_8661")
  {
    object oThisArea = GetArea(oPC);
    DelayCommand(30.0, ExecuteScript("tsw_destroy_area", oThisArea));
  }
  else if(sEmote == "tired")
  {   iAnimation = ANIMATION_LOOPING_PAUSE_TIRED;   }
  else if(sEmote == "pause")
  {   iAnimation = ANIMATION_LOOPING_PAUSE2;   }
  else if(sEmote == "talkforce" || sEmote == "angry")
  {   iAnimation = ANIMATION_LOOPING_TALK_FORCEFUL;   }
  else if(sEmote == "talklaugh")
  {   iAnimation = ANIMATION_LOOPING_TALK_LAUGHING;   }
  else if(sEmote == "talknormal" || sEmote == "normal" || sEmote == "stop")
  {   iAnimation = ANIMATION_LOOPING_TALK_NORMAL;   }
  else if(sEmote == "talkplead" || sEmote == "beg")
  {   iAnimation = ANIMATION_LOOPING_TALK_PLEADING;   }
  else if(sEmote == "worship")
  {   iAnimation = ANIMATION_LOOPING_WORSHIP;   }
  else if(sEmote == "conjure1")
  {   iAnimation = ANIMATION_LOOPING_CONJURE1;   }
  else if(sEmote == "conjure2")
  {
    iAnimation = ANIMATION_LOOPING_CONJURE2;
  }
  else if(sEmote == "otherworld_132132")
  {   ExecuteScript("othwld_sirens", OBJECT_SELF);   }
  else if(sEmote == "tailor")
  {
    if(GetTimerEnded("TAILOR_EMOTE_USE", oPC))
    {
        object oArea = GetArea(oPC);
        string sTag = GetTag(oArea);
        sTag = GetStringLeft(sTag, 3);
        if(sTag != "OS_" && sTag != "OE_")
        {
            SendMessageToPC(oPC, "You cannot summon Myr outside of Otherworld safe areas. He's scared.");
        }
        else
        {
            location lMyrSpot = GetNewRandomLocation(GetLocation(oPC));
            object oMyr = CreateObject(OBJECT_TYPE_CREATURE, "tlr_emote_sum", lMyrSpot, TRUE);
            //Make it have no hit box.
            effect nTouch = EffectCutsceneGhost();
            nTouch = SupernaturalEffect(nTouch);
            DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, nTouch, oMyr));
            SetObjectVisualTransform(oMyr, OBJECT_VISUAL_TRANSFORM_SCALE, 0.1, OBJECT_VISUAL_TRANSFORM_LERP_LINEAR, 117.0);
            DestroyObject(oMyr, 120.0);
            SetTimer("TAILOR_EMOTE_USE", 120, oPC);
        }
    }
    else
    {
        SendMessageToPC(oPC, "You wait must two minutes before summoning the mirror again.");
    }
  }
  else if(sEmote == "hardcore")
  {
    int nCheck = SQLocalsPlayer_GetInt(oPC, "AM_HARDCORE");
    if(nCheck == 1)
    {
        effect eStone = EffectVisualEffect(VFX_DUR_IOUNSTONE_RED);
        effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_RED);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStone, oPC, 10.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlow, oPC, 10.0);
    }
  }
  else if(sEmote == "reputation" || sEmote == "rep")
  {
    string sRep = GetDeity(oPC);
    SendMessageToPC(oPC, sRep);
  }
  else if(sEmote == "who_hidden")
  {
    int nWho = SQLocalsPlayer_GetInt(oPC, "WHO_COMMAND_TOGGLE");
    if(nWho == 0)
    {
        SQLocalsPlayer_SetInt(oPC, "WHO_COMMAND_TOGGLE", 1);
        SendMessageToPC(oPC, "Your location is now hidden.");
    }
    else
    {
        SQLocalsPlayer_SetInt(oPC, "WHO_COMMAND_TOGGLE", 0);
        SendMessageToPC(oPC, "Your location is now visible.");
    }
  }
  else if(sEmote == "ears_fox")
  {
    SetEars(823, oPC);
  }
  else if(sEmote == "alchem_fix")
  {
    ExecuteScript("tsw_alchem_fix", oPC);
  }
  else if(sEmote == "touch_toggle")
  {
    TouchToggle(oPC);
  }
  //Recalls the masters pet to their position
  else if(sEmote == "petrecall")
  {
    object oPet = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    if(GetTimerEnded("PET_RECALL_TIMER", oPC))
    {
        AssignCommand(oPet, JumpToObject(oPC));
        SetTimer("PET_RECALL_TIMER", 10, oPC);
    }
    else
    {
        SendMessageToPC(oPC, "You can only use the pet recall command once every ten seconds.");
    }
  }
  else if(sEmote == "remove_weapon_vfx")
  {
    RemoveWeaponVFX(oPC);
  }
  else if(sEmote == "add_vfx_fire")
  {
    AddWeaponVFX(oPC, "Fire");
  }
  else if(sEmote == "add_vfx_cold")
  {
    AddWeaponVFX(oPC, "Cold");
  }
  else if(sEmote == "add_vfx_electric")
  {
    AddWeaponVFX(oPC, "Electrical");
  }
  else if(sEmote == "add_vfx_acid")
  {
    AddWeaponVFX(oPC, "Acid");
  }
  else if(sEmote == "add_vfx_sonic")
  {
    AddWeaponVFX(oPC, "Sonic");
  }
  else if(sEmote == "add_vfx_holy")
  {
    AddWeaponVFX(oPC, "Holy");
  }
  else if(sEmote == "add_vfx_evil")
  {
    AddWeaponVFX(oPC, "Evil");
  }
  else if(sEmote == "rank")
  {
    RankEmote(oPC);
  }
  else if(sEmote == "hidehelmet")
  {
    object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    if(GetHiddenWhenEquipped(oItem))
    {
        SetHiddenWhenEquipped(oItem, FALSE);
        SendMessageToPC(oPC, "Showing helmet.");
    }
    else
    {
        SetHiddenWhenEquipped(oItem, TRUE);
        SendMessageToPC(oPC, "Hiding helmet.");
    }
  }
  else if(sEmote == "hidecloak")
  {
    object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    if(GetHiddenWhenEquipped(oItem))
    {
        SetHiddenWhenEquipped(oItem, FALSE);
        SendMessageToPC(oPC, "Showing cloak.");
    }
    else
    {
        SetHiddenWhenEquipped(oItem, TRUE);
        SendMessageToPC(oPC, "Hiding cloak.");
    }
  }
  else if(sEmote == "hideoffhand")
  {
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    if(GetHiddenWhenEquipped(oItem))
    {
        SetHiddenWhenEquipped(oItem, FALSE);
        SendMessageToPC(oPC, "Showing off-hand..");
    }
    else
    {
        SetHiddenWhenEquipped(oItem, TRUE);
        SendMessageToPC(oPC, "Hiding off-hand.");
    }
  }
  else if(sEmote == "debuff")
  {
    effect eEffect = GetFirstEffect(oPC);
    if(!GetIsInCombat(oPC))
    {
        while(GetIsEffectValid(eEffect))
        {
            RemoveEffect(oPC, eEffect);
            eEffect = GetNextEffect(oPC);
        }
    }
  }
  else if(sEmote == "point")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM1;
  }
  else if(sEmote == "think")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM2;
  }
  else if(sEmote == "holdhead")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM3;
  }
  else if(sEmote == "crossarms" || sEmote == "foldarms")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM4;
  }
  else if(sEmote == "jump")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM5;
  }
  else if(sEmote == "followme")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM6;
  }
  else if(sEmote == "herocrouch")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM7;
  }
  else if(sEmote == "hangbyhands")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM8;
  }
  else if(sEmote == "dig")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM9;
  }
  else if(sEmote == "layside")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM10;
  }
  else if(sEmote == "kneel")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM11;
  }
  else if(sEmote == "layback")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM12;
  }
  else if(sEmote == "layback2")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM13;
  }
  else if(sEmote == "praystand")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM14;
  }
  else if(sEmote == "praise")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM15;
  }
  else if(sEmote == "nope")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM16;
  }
  else if(sEmote == "pushups")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM17;
  }
  else if(sEmote == "layback3")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM18;
  }
  else if(sEmote == "situps")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM19;
  }
  else if(sEmote == "jumpingjacks")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM20;
  }
  else if(sEmote == "squats")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM21;
  }
  else if(sEmote == "clap")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM22;
  }
  else if(sEmote == "salute2")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM23;
  }
  else if(sEmote == "facepalm")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM24;
  }
  else if(sEmote == "handhip")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM25;
  }
  else if(sEmote == "leanwall")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM26;
  }
  else if(sEmote == "prisoner")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM27;
  }
  else if(sEmote == "flex")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM28;
  }
  else if(sEmote == "dejected")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM29;
  }
  else if(sEmote == "handsback")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM30;
  }
  else if(sEmote == "layfront")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM31;
  }
  else if(sEmote == "shrug")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM32;
  }
  else if(sEmote == "computer")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM33;
  }
  else if(sEmote == "kneeup")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM34;
  }
  else if(sEmote == "holdhead2")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM35;
  }
  else if(sEmote == "layside2")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM36;
  }
  else if(sEmote == "sit2")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM37;
  }
  else if(sEmote == "sit3")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM38;
  }
  else if(sEmote == "layback4")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM39;
  }
  else if(sEmote == "cheer2")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM40;
  }
  else if(sEmote == "shieldwall")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM41;
  }
  else if(sEmote == "dance")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM42;
  }
  else if(sEmote == "dance2")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM43;
  }
  else if(sEmote == "smoke")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM44;
  }
  else if(sEmote == "drink2")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM45;
  }
  else if(sEmote == "swordthrow")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM46;
  }
  else if(sEmote == "grenadethrow")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM47;
  }
  else if(sEmote == "push")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM51;
  }
  else if(sEmote == "paraderest")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM52;
  }
  else if(sEmote == "dance3")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM53;
  }
  else if(sEmote == "flute")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM54;
  }
  else if(sEmote == "guitar")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM55;
  }
  else if(sEmote == "magicchoke")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM56;
  }
  else if(sEmote == "pointpistol")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM57;
  }
  else if(sEmote == "seethe")
  {
    iAnimation = ANIMATION_LOOPING_CUSTOM61;
  }
  else if(sEmote == "necro_golem")
  {
    SQLocalsPlayer_SetInt(oPC, "NECRO_DEATH_MODEL", 1);
  }
  else if(sEmote == "necro_grave")
  {
    SQLocalsPlayer_SetInt(oPC, "NECRO_DEATH_MODEL", 2);
  }
  else if(sEmote == "necro_default")
  {
    SQLocalsPlayer_DeleteInt(oPC, "NECRO_DEATH_MODEL");
  }
  else if(sEmote == "summ_bear")
  {
    SQLocalsPlayer_SetInt(oPC, "SUMM_PACT_MODEL", 1);
  }
  else if(sEmote == "summ_wolf")
  {
    SQLocalsPlayer_SetInt(oPC, "SUMM_PACT_MODEL", 2);
  }
  else if(sEmote == "summ_lizard")
  {
    SQLocalsPlayer_SetInt(oPC, "SUMM_PACT_MODEL", 3);
  }
  else if(sEmote == "summ_default")
  {
    SQLocalsPlayer_DeleteInt(oPC, "SUMM_PACT_MODEL");
  }
  else if(sEmote == "dm_reputation_132132")
  {
    //AddReputation(oPC, 100);
  }
  else if(sEmote == "res_x_plus")
  {
    float fX = SQLocalsPlayer_GetFloat(oPC, "PC_RESOURCE_X_POS");
    fX = fX + 5.0;
    SendMessageToPC(oPC, "Setting X position to: " + FloatToString(fX));
    SQLocalsPlayer_SetFloat(oPC, "PC_RESOURCE_X_POS", fX);
    UpdateBinds(oPC);
    DrawResourceBars(oPC);
  }
  else if(sEmote == "res_x_minus")
  {
    float fX = SQLocalsPlayer_GetFloat(oPC, "PC_RESOURCE_X_POS");
    fX = fX - 5.0;
    if(fX < 5.0)
    {
        SendMessageToPC(oPC, "X position too low.");
        return;
    }
    SendMessageToPC(oPC, "Setting X position to: " + FloatToString(fX));
    SQLocalsPlayer_SetFloat(oPC, "PC_RESOURCE_X_POS", fX);
    UpdateBinds(oPC);
    DrawResourceBars(oPC);
  }
  else if(sEmote == "res_y_plus")
  {
    float fY = SQLocalsPlayer_GetFloat(oPC, "PC_RESOURCE_Y_POS");
    fY = fY + 5.0;
    SendMessageToPC(oPC, "Setting Y position to: " + FloatToString(fY));
    SQLocalsPlayer_SetFloat(oPC, "PC_RESOURCE_Y_POS", fY);
    UpdateBinds(oPC);
    DrawResourceBars(oPC);
  }
  else if(sEmote == "res_y_minus")
  {
    float fY = SQLocalsPlayer_GetFloat(oPC, "PC_RESOURCE_Y_POS");
    fY = fY - 5.0;
    if(fY < 5.0)
    {
        SendMessageToPC(oPC, "Y position too low.");
        return;
    }
    SendMessageToPC(oPC, "Setting Y position to: " + FloatToString(fY));
    SQLocalsPlayer_SetFloat(oPC, "PC_RESOURCE_Y_POS", fY);
    UpdateBinds(oPC);
    DrawResourceBars(oPC);
  }
  else if(sEmote == "edit_description" || sEmote == "edit_desc" || sEmote == "edit_portrait" || sEmote == "edit_port")
  {
      FloatingTextStringOnCreature("Command deprecated for now, you should buy a tablet from Bria and use the \"profile\" icon",oPC);
    //PopUpCharacterDescriptionGUIPanel(oPC);
  }
  else if(sEmote == "light_grey" || sEmote == "light_blue" || sEmote == "light_orange" || sEmote == "light_purple" ||
          sEmote == "light_red" || sEmote == "light_white" || sEmote == "light_yellow")
  {
    if(sEmote == "light_grey")
    {
        SQLocalsPlayer_SetInt(oPC, "PC_LIGHT_COLOUR", VFX_DUR_LIGHT_GREY_10);
    }
    else if(sEmote == "light_blue")
    {
        SQLocalsPlayer_SetInt(oPC, "PC_LIGHT_COLOUR", VFX_DUR_LIGHT_BLUE_10);
    }
    else if(sEmote == "light_orange")
    {
        SQLocalsPlayer_SetInt(oPC, "PC_LIGHT_COLOUR", VFX_DUR_LIGHT_ORANGE_10);
    }
    else if(sEmote == "light_purple")
    {
        SQLocalsPlayer_SetInt(oPC, "PC_LIGHT_COLOUR", VFX_DUR_LIGHT_PURPLE_10);
    }
    else if(sEmote == "light_red")
    {
        SQLocalsPlayer_SetInt(oPC, "PC_LIGHT_COLOUR", VFX_DUR_LIGHT_RED_10);
    }
    else if(sEmote == "light_white")
    {
        SQLocalsPlayer_SetInt(oPC, "PC_LIGHT_COLOUR", VFX_DUR_LIGHT_WHITE_10);
    }
    else if(sEmote == "light_yellow")
    {
        SQLocalsPlayer_SetInt(oPC, "PC_LIGHT_COLOUR", VFX_DUR_LIGHT_YELLOW_10);
    }
  }
  else if(sEmote == "who")
  {
    ExecuteScript("pc_who_command", OBJECT_SELF);
  }

  else if(sEmote == "deleteme")
  {
    AssignCommand(oPC, DeleteConv(oPC));
  }

  else if(sEmote == "list" || sEmote == "help")
  {
    SendMessageToPC(oPC, "====== SYSTEM ======");
    SendMessageToPC(oPC, "/add_vfx_type - Adds a visual effect to your main-hand weapon. Replace the word 'type' with Fire, Cold, Electric, Acid, Sonic, Holy, or Evil.");
    SendMessageToPC(oPC, "/alchem_fix - Use this command if you think your Alchemite may be broken.");
    SendMessageToPC(oPC, "/auto_engage - Enable or disable auto engaging enemies in melee range after using an ability.");
    SendMessageToPC(oPC, "/debuff - Removes all active spell effects without resting. Cannot be used while in combat.");
    SendMessageToPC(oPC, "/deleteme - Delete your character for good this time.");
    SendMessageToPC(oPC, "/ears_fox - Toggle on and off fox ears.");
    SendMessageToPC(oPC, "/edit_desc or /edit_port - Edit your portrait and description.");
    SendMessageToPC(oPC, "/hardcore - Show others how brave and cool you are.");
    SendMessageToPC(oPC, "/help- Display this list.");
    SendMessageToPC(oPC, "/hideobject - Toggles the visibility of the object. Replace the word object with helmet, cloak, or offhand.");
    SendMessageToPC(oPC, "/lightup - Toggle On/Off a light aura around the character.");
    SendMessageToPC(oPC, "/light_xxxx - Set your light colour. Options are blue, grey, orange, purple, red, white, and yellow.");
    SendMessageToPC(oPC, "/list - Display this list.");
    SendMessageToPC(oPC, "/listdm - List of DM only commands.");
    SendMessageToPC(oPC, "/listemotes1 - Display the emote list part 1 ");
    SendMessageToPC(oPC, "/listemotes2 - Display the emote list part 2 ");
    SendMessageToPC(oPC, "/no_opp - Toggle on/off the ability for your character to perform Attacks of opportunity.");
    SendMessageToPC(oPC, "/petrecall - Summons your pet to your location. Has a 10-second cooldown.");
    SendMessageToPC(oPC, "/remove_weapon_vfx - Removes any VFX properties from your main-hand weapon.");
    SendMessageToPC(oPC, "/res_x_plus - Move resource bars right. Bind to hotbar custom macro for ease of use.");
    SendMessageToPC(oPC, "/res_x_minus - Move resource bars left.");
    SendMessageToPC(oPC, "/res_y_plus - Move resource bars down.");
    SendMessageToPC(oPC, "/res_y_minus - Move resource bars up.");
    SendMessageToPC(oPC, "/rank - Display your faction rank.");
    SendMessageToPC(oPC, "/reputation - Display your current reputation.");
	SendMessageToPC(oPC, "/setplot - Toggles an item's plot flag. Plot items cannot be sold/witch-it'd.");
    SendMessageToPC(oPC, "/tailor - Summons the tailoring mirror. Usable once every 30 minutes.");
    SendMessageToPC(oPC, "/touch_toggle - Toggles the collision of your character. Turns back on in combat.");
    SendMessageToPC(oPC, "/who - Display all players and their location.");
    SendMessageToPC(oPC, "/who_hidden - Toggle your location visibility for the /who commmand.");
  }
    else if(sEmote == "listemotes1")
  {
    SendMessageToPC(oPC, "====== EMOTES ======");
    SendMessageToPC(oPC, "/angry - Angry hand gestures.");
    SendMessageToPC(oPC, "/normal - Slight head bob to emulate talking.");
    SendMessageToPC(oPC, "/beg - Raise hands pleadingly.");
    SendMessageToPC(oPC, "/worship - Kneel and genuflect.");
    SendMessageToPC(oPC, "/conjure1 - Swirling hand motion. Mimics last spell effect.");
    SendMessageToPC(oPC, "/conjure2 - Raised arms motion. Mimics last spell effect.");
    SendMessageToPC(oPC, "/listen - Listen for sounds.");
    SendMessageToPC(oPC, "/look - Look around.");
    SendMessageToPC(oPC, "/meditate /pray - Kneel and press hands together.");
    SendMessageToPC(oPC, "/drunk - Sway while standing.");
    SendMessageToPC(oPC, "/tired - Lean forward and breathe heavily.");
    SendMessageToPC(oPC, "/greet /greeting /wave - Wave your hand.");
    SendMessageToPC(oPC, "/bored - Stretch.");
    SendMessageToPC(oPC, "/scratch - Scratch your head.");
    SendMessageToPC(oPC, "/read - Read from paper.");
    SendMessageToPC(oPC, "/salute - Raise hand to head in salute.");
    SendMessageToPC(oPC, "/spasm - Body spasms.");
    SendMessageToPC(oPC, "/taunt - Does a 'get at me' chest puff.");
    SendMessageToPC(oPC, "/laugh - Throw head back and laugh.");
    SendMessageToPC(oPC, "/victory1 /victory2 /victory3 - Various cheers.");
    SendMessageToPC(oPC, "/dead1 - Lie on your back.");
    SendMessageToPC(oPC, "/dead2 - Lie on your front.");
    SendMessageToPC(oPC, "/sit - Sit on the ground.");
    SendMessageToPC(oPC, "/bow - Bow respectfully.");
    SendMessageToPC(oPC, "/drink - Drink from a bottle.");
    SendMessageToPC(oPC, "/point - Point forward.");
    SendMessageToPC(oPC, "/think - Thinking position.");
    SendMessageToPC(oPC, "/holdhead - Hold your head.");
    SendMessageToPC(oPC, "/crossarms - Cross arms over chest.");
    SendMessageToPC(oPC, "/jump - Jump forward.");
    SendMessageToPC(oPC, "/followme - Gesture for others to follow.");
    SendMessageToPC(oPC, "/herocrouch - Superhero crouch.");
    SendMessageToPC(oPC, "/hangbyhands - Suspend and hang by hands shackled in air.");
    SendMessageToPC(oPC, "/dig - Dig with pickaxe animation. Pickaxe sold separately.");
    SendMessageToPC(oPC, "/layside - Lay on side.");
    SendMessageToPC(oPC, "/kneel - Kneel on one knee.");
    SendMessageToPC(oPC, "/layback - Lay back with hands on stomach.");
    SendMessageToPC(oPC, "/layback2 - Lay back partially upright.");
  }
      else if(sEmote == "listemotes2")
  {
    SendMessageToPC(oPC, "/praystand - Hands together praying while standing.");
    SendMessageToPC(oPC, "/praise - Praise the sun!");
    SendMessageToPC(oPC, "/nope - Sassy. Swervy. Hold my weave.");
    SendMessageToPC(oPC, "/pushups - Do pushups.");
    SendMessageToPC(oPC, "/layback3 - Lay back with hands behind head.");
    SendMessageToPC(oPC, "/situps - Do situps. Don't actually do situps though. They're bad for your back.");
    SendMessageToPC(oPC, "/jumpingjacks - Do jumping jacks.");
    SendMessageToPC(oPC, "/squats - Do squats.");
    SendMessageToPC(oPC, "/clap - Clap with moderate excitement.");
    SendMessageToPC(oPC, "/salute2 - Looping salute.");
    SendMessageToPC(oPC, "/facepalm - Conjure a rocket, mount it, fly around in circles for three seconds before launching into the air. Just kidding, it's just a face palm.");
    SendMessageToPC(oPC, "/handhip - Stand with hand on hip.");
    SendMessageToPC(oPC, "/leanwall - Lean against wall, slouch slightly, foot on wall.");
    SendMessageToPC(oPC, "/prisoner - Kneel with hands bound behind.");
    SendMessageToPC(oPC, "/flex - Display your Guild of Gains membership.");
    SendMessageToPC(oPC, "/dejected - Raise a knee, lean forward, look tired or sad.");
    SendMessageToPC(oPC, "/handsback - Stand at attention.");
    SendMessageToPC(oPC, "/layfront - Lay down face forward.");
    SendMessageToPC(oPC, "/shrug - Shrug.");
    SendMessageToPC(oPC, "/computer - Lean forward as if looking at a monitor or console.");
    SendMessageToPC(oPC, "/kneeup - ????");
    SendMessageToPC(oPC, "/holdhead2 - Crouch while holding your head.");
    SendMessageToPC(oPC, "/layside2 - Lay on your side a bit differently.");
    SendMessageToPC(oPC, "/sit2 - Sit with legs spread.");
    SendMessageToPC(oPC, "/sit3 - Sit with legs crossed.");
    SendMessageToPC(oPC, "/layback4 - Lay back partially, hands on stomach.");
    SendMessageToPC(oPC, "/cheer2 - Boisterous cheer.");
    SendMessageToPC(oPC, "/shieldwall - Very shield. Much Spartan. Wow.");
    SendMessageToPC(oPC, "/dance - Dance with hands up.");
    SendMessageToPC(oPC, "/dance2 - Shakira, Shakira.");
    SendMessageToPC(oPC, "/smoke - Inhale partially burnt dried vegetation.");
    SendMessageToPC(oPC, "/drink2 - Drink loop.");
    SendMessageToPC(oPC, "/swordthrow - Throw a melee weapon.");
    SendMessageToPC(oPC, "/grenadethrow - Throw a grenade.");
    SendMessageToPC(oPC, "/push - Push.");
    SendMessageToPC(oPC, "/paraderest - Military parade rest.");
    SendMessageToPC(oPC, "/dance3 - More dance.");
    SendMessageToPC(oPC, "/flute - Play flute. Flute not included.");
    SendMessageToPC(oPC, "/guitar - Play guitar. Guitar not included.");
    SendMessageToPC(oPC, "/magicchoke - I find your lack of faith disturbing.");
    SendMessageToPC(oPC, "/pointpistol - Point with pistol.");
    SendMessageToPC(oPC, "/seethe - So angry.");
    }
    else if ((GetIsDM(oPC) || GetIsDMPossessed (oPC)) && sEmote == "listdm")
    {
        SendMessageToPC(oPC, "====== DM COMMANDS ======");

    SendMessageToPC(oPC, "signalresetstart - Sends a message to all players to inform them of an upcoming reset. Does nothing on its own except sending a message");
    SendMessageToPC(oPC, "signalresetcancel - Best used if signalresetstart was called shortly before. Simply announces that the reset is postponned, does nothing else on its own.");
    SendMessageToPC(oPC, "Typing /dmtg enters the targeting mode. From that point, your next message will be stored and a new message overrides the previous one.");
    SendMessageToPC(oPC, "When you're satisfied with your command message, send it and click on your target.");
    SendMessageToPC(oPC, " ");
    SendMessageToPC(oPC, "= = = = = LIST OF OPTIONS FOR DMTG = = = = = ");
    SendMessageToPC(oPC, "msg whateveryouwanttosay");
    SendMessageToPC(oPC, "  -> Send a floating text message to the target player and all others in a 30m radius around.");
    SendMessageToPC(oPC, " ");
    SendMessageToPC(oPC, "model xyz ");
    SendMessageToPC(oPC, "  -> Set appearance to whatever XYZ was. Example : model 170 turns the target into a wererat. ");
    SendMessageToPC(oPC, " ");
    SendMessageToPC(oPC, "name newname ");
    SendMessageToPC(oPC, "  -> Set a new name for the target.");
    SendMessageToPC(oPC, " ");
    SendMessageToPC(oPC, "size x.y" );
    SendMessageToPC(oPC, "  -> Multiply the target's model scale by x.y (float). Example : size 2.5  Can go below 1 but never below 0");
    SendMessageToPC(oPC, " ");
    SendMessageToPC(oPC, "vfx x_y.zi ");
    SendMessageToPC(oPC, "  -> Adds the VFX with id n°x to the target.");
    SendMessageToPC(oPC, "     _y.zi is optional, where y.z is a float to scale the size of the VFX (See above for example) and i is to set that effect as a one timer(instant)");
    SendMessageToPC(oPC, " ");
    SendMessageToPC(oPC, "getfct ");
    SendMessageToPC(oPC, "  -> Prints target's faction to chat log for the DM to see ");
    SendMessageToPC(oPC, " ");
    SendMessageToPC(oPC, "giverep x");
    SendMessageToPC(oPC, "  -> Grants x reputation points to target. Reminder : X is automatically doubled for hardcore characters.");
    }

  else if (sEmote == "lightup")
  {

            object oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);

           itemproperty jLight = ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_WHITE);
            if(GetItemHasItemProperty(oItem,ITEM_PROPERTY_LIGHT) == FALSE )
            {
               FloatingTextStringOnCreature("Lights Enabled",oPC,TRUE);
               AssignCommand(oPC,PlaySound("Camera Manual Cl"));
               AddItemProperty(DURATION_TYPE_PERMANENT,jLight,oItem);

            }
            else
            {
                itemproperty ipLoop=GetFirstItemProperty(oItem);
                while (GetIsItemPropertyValid(ipLoop))
                {
                if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_LIGHT)
                {RemoveItemProperty(oItem, ipLoop);}


                ipLoop=GetNextItemProperty(oItem);
                }

            }
  }

    //If module name is SecretWorldDev, we send the webhook to the dev server's discord buzzer channel.
   else if (sModuleName == "Dev" || sSinglePlayer == "") {

        //Development Commands for NUI WINDOWS
        if (sEmote == "dev_key") {

            //Debug Message
            //SendMessageToPC(oPC, "Debug Message 1A: pc_emotes.nss");

            // Open keypad interface. Needs to be commented out in final version.
            Nui_Keypad_Window(oPC);
            return;
        }

        else if (sEmote == "dev_tab") {
            // Open tablet NUI interface. Needs to be commented out in final version.
            Nui_Tablet_Window(oPC);
            return;
        }

        else if (sEmote == "dev_tabc") {
            // Close tablet interface.Needs to be commented out in final version.
            DestroyNuiTablet(oPC);
            return;
        }

		else if (sEmote == "devport007") {
			SendMessageToPC(oPC, "Porting to dev area.");
			object oWPdev = GetWaypointByTag("devport007");  // Name of the dev area waypoint
			if (GetIsObjectValid(oWPdev))
			{
				//SendMessageToPC(oPC, "Waypoint found.");
				location lWPdev = GetLocation(oWPdev); // For added compatibility, get location first
				AssignCommand(oPC, ClearAllActions());  // Clear queued actions
				DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lWPdev))); // Create jump action
				SetPCChatVolume(TALKVOLUME_SILENT_TALK); // Hide output text so noone else sees the command being spoken
				return; // Break execution here to stop the code below from interfering with the port
			}
			else
			{
				SendMessageToPC(oPC, "Waypoint invalid.");
			}
		}
		
		else if (sEmote == "dev_hat") {
			Nui_Hat_Window(oPC);
			SendMessageToPC(oPC, "DEBUG 018: Hat Window Called via Dev Command");
            return;
		}

        else if (sEmote == "dev_date") {
            string sModuleDate = SQLite_GetSystemDate();
            SendMessageToPC(oPC, "ModuleDate: " + sModuleDate);
            return;
        }

        else if (sEmote == "dev_time") {
            string sModuleTime = SQLite_GetSystemTime();
            SendMessageToPC(oPC, "ModuleTime: " + sModuleTime);
            return;
        }

    }



  else
  {
    if (GetLocalInt(oPC,"iDMTarget") !=1)
    {
      SendMessageToPC(oPC, "Unrecognized command. Type /list to view all available chat commands.");
    }
  }





  // Next step is to force them to actually perform the animation sequence for five
  // game rounds.
  if (iAnimation != -1)
  {
    float fDuration = RoundsToSeconds(999999);
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionPlayAnimation(iAnimation, 1.0, fDuration));
  }
  // Finally, change the volume of the chat to a tell. Only the player whose chat
  // fired the event will hear the command and it will show up green in his message
  // window to give a further clue that the command was recognized and processed. We
  // will also change the text of what he originally said a little bit (just to see
  // how that is done) by prepending the string "Emote Command Received: " onto
  // the front end of what he originally typed. Note that the GetPCChatMessage is
  // called again rather than using the sCommand variable which already contains the
  // text he typed in because we don't want the lowercase version of it to echo
  // back. We want him to see exactly what he originally typed in.
  //sCommand = "You " + GetPCChatMessage();
  SetPCChatMessage(sCommand);       // Change the text of the chat.
  SetPCChatVolume(TALKVOLUME_SILENT_TALK); // Make it silent.

  // After the script ends, the (new) chat message will be sent by the engine in accordance with the current volume setting.
}


