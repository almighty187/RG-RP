////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
#include <YSI\y_hooks>


hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	if(arrAntiCheat[playerid][ac_iFlags][AC_DIALOGSPOOFING] > 0) return 1;
	
	switch(dialogid)
	{
		case DIALOG_WALKSTYLE:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
						SetPlayerWalkStyle(playerid,WALKSTYLE_GANG1);
	   				case 1:
					   	SetPlayerWalkStyle(playerid,WALKSTYLE_GANG2);
		     		case 2:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_NORMAL);
			     	case 3:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_SEXY);
			     	case 4:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_SEXY2);
			     	case 5:
				 		SetPlayerWalkStyle(playerid,WALKSTYLE_OLD);
			     	case 6:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_FATOLD);
			     	case 7:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_FAT);
			     	case 8:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_SNEAK);
			     	case 9:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_BLIND);
			     	case 10:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_ARMED);
			     	case 11:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_POLICE);
			     	case 12:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_LADY);
			     	case 13:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_LADY2);
			     	case 14:
					 	SetPlayerWalkStyle(playerid,WALKSTYLE_DRUNK);
			     	case 15:
					 	RemovePlayerWalkStyle(playerid);
		        }
		    }
	    }
    }
    return 0;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_WALK)
	{
		if (GetPVarInt(playerid, "Injured") == 0 && PlayerInfo[playerid][pMuted] == 0 && GetPVarInt(playerid, "PlayerCuffed") == 0)
		{
			if(GetPlayerWalkStyle(playerid) > 0)
			{
				switch(GetPlayerWalkStyle(playerid))
				{
					case WALKSTYLE_GANG1: ApplyAnimation(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1,1);
					case WALKSTYLE_GANG2: ApplyAnimation(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1,1);
     				case WALKSTYLE_NORMAL: ApplyAnimation(playerid,"ped","WALK_player",4.1,1,1,1,1,1,1);
	        		case WALKSTYLE_SEXY: ApplyAnimation(playerid,"ped","WOMAN_walksexy",4.1,1,1,1,1,1,1);
  	        		case WALKSTYLE_SEXY2: ApplyAnimation(playerid,"PED","WOMAN_walkpro",4.1,1,1,1,1,1);
		  	        case WALKSTYLE_OLD: ApplyAnimation(playerid,"PED","WALK_old",4.1,1,1,1,1,1,1);
  	         		case WALKSTYLE_FATOLD: ApplyAnimation(playerid,"PED","WALK_fatold",4.1,1,1,1,1,1);
          			case WALKSTYLE_FAT: ApplyAnimation(playerid,"PED","WALK_fat",4.1,1,1,1,1,1);
		  	        case WALKSTYLE_SNEAK: ApplyAnimation(playerid,"PED","Player_Sneak",4.1,1,1,1,1,1,1);
		  	        case WALKSTYLE_BLIND: ApplyAnimation(playerid,"PED","Walk_Wuzi",4.1,1,1,1,1,1,1);
		  	        case WALKSTYLE_ARMED: ApplyAnimation(playerid,"PED","WALK_armed",4.1,1,1,1,1,1,1);
		  	        case WALKSTYLE_POLICE: ApplyAnimation(playerid,"POLICE","Cop_move_FWD",4.1,1,1,1,1,1,1);
		  	        case WALKSTYLE_LADY: ApplyAnimation(playerid,"PED","WOMAN_walknorm",4.1,1,1,1,1,1);
		  	        case WALKSTYLE_LADY2: ApplyAnimation(playerid,"PED","WOMAN_walkbusy",4.1,1,1,1,1,1);
		  	        case WALKSTYLE_DRUNK: ApplyAnimation(playerid,"PED","WALK_drunk",4.1,1,1,1,1,1);
					//SetPVarInt(playerid, "AnimUse" , 1);
		    	}
   			}
		}
	}
	if(oldkeys & KEY_WALK)
	{
		if (GetPVarInt(playerid, "Injured") == 0 && PlayerInfo[playerid][pMuted] == 0 && GetPVarInt(playerid, "PlayerCuffed") == 0)
		{
  			if(GetPlayerWalkStyle(playerid) > 0)
     		{
       			ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0, 1);
   			}
		}
	}
	return 1;
}
CMD:walkstyle(playerid, params[])
{
	if(gPlayerLogged{playerid} == 0) return SendErrorMessage(playerid, "You must be logged in to use this.");
	if(PlayerCuffed[playerid] == 1) return 	SendErrorMessage(playerid, "You cannot use this while cuffed");
	{
		ShowPlayerDialog(playerid,DIALOG_WALKSTYLE,DIALOG_STYLE_LIST,"Walk Style","Gang 1\nGang 2\nNormal\nSexy\nSexy2\nOld\nFat-Old\nFat\nSneaking\nBlind\nArmed\nPolice\nLady\nLady2\nDrunk\nRemove","Select","Cancel");
	}
 	return 1;
}
//============================================//
forward SetPlayerWalkStyle(playerid,style);
public SetPlayerWalkStyle(playerid,style)
{
	SendServerMessage(playerid, "Walkstyle changed.");
	SendServerMessage(playerid, "[TIP] {FFFFFF}Hold '~k~~SNEAK_ABOUT~' to start walking, then release '~k~~SNEAK_ABOUT~' to stop.");
	return SetPVarInt(playerid, "WalkStyle", style);
}
//============================================//
forward GetPlayerWalkStyle(playerid);
public GetPlayerWalkStyle(playerid)
{
	return GetPVarInt(playerid, "WalkStyle");
}
//============================================//
forward RemovePlayerWalkStyle(playerid);
public RemovePlayerWalkStyle(playerid)
{
    SendServerMessage(playerid, "Walkstyle removed.");
	return DeletePVar(playerid,"WalkStyle");
}
