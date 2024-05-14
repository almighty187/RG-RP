#include <YSI\y_hooks>
#include <YSI\y_utils>


new CountingPlayer;
hook OnGameModeInit()
{
	print("[DCC] Connecting to Discord...");
	SetTimer("BotStatus", 1000, true);
	return 1;
}
hook OnPlayerConnect(playerid)
{
	CountingPlayer++;
    return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
	CountingPlayer--;
    return 1;
}
forward BotStatus(playerid);
public BotStatus(playerid)
{
	new string[256];
	format(string, sizeof(string), "with %d players!", CountingPlayer);
	DCC_SetBotActivity(string);
}
stock GetPlayerIdByName(playername[])
{
    new playerid;
    for (playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
        if (!IsPlayerConnected(playerid))
            continue;

        new pname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, pname, sizeof(pname));
        if (!strcmp(pname, playername, true))
            return playerid;
    }
    return INVALID_PLAYER_ID; // Player not found
}
stock SendDiscordMessage(channel, message[])
{
	switch(channel)
	{
		// #admin
		case 0:
		{
			g_AdminChannelId = DCC_FindChannelById("1228466336737394738");
			DCC_SendChannelMessage(g_AdminChannelId, message);
		}
		// #admin-warnings
		case 1:
		{
			g_AdminWarningsChannelId = DCC_FindChannelById("1228466371839393883");
			DCC_SendChannelMessage(g_AdminWarningsChannelId, message);
		}
		// #headadmin
		case 2:
		{
			g_HeadAdminChannelId = DCC_FindChannelById("1228466401573077093");
			DCC_SendChannelMessage(g_HeadAdminChannelId, message);
		}
		// #server-errors
		case 3:
		{
			g_ServerErrorsChannelId = DCC_FindChannelById("1228466427217055876");
			DCC_SendChannelMessage(g_ServerErrorsChannelId, message);
		}
		// #bot channel
		case 4:
		{
			g_ServerBotChannelId = DCC_FindChannelById("1232040142206668882");
			DCC_SendChannelMessage(g_ServerBotChannelId, message);
		}
		//ipwhitelist
		case 5:
		{
			g_PrivateChannelId = DCC_FindChannelById("1232017069428576336");
			DCC_SendChannelMessage(g_PrivateChannelId, message);
		}
	}
	return 1;
}

public DCC_OnMessageCreate(DCC_Message:message)
{
	new realMsg[100], DCC_Channel:channel, DCC_User:author, channel_name[32], user_name[32 + 1], author_id[20 + 1]; //szMessage[128]
    DCC_GetMessageContent(message, realMsg);

    new bool:IsBot;
    DCC_IsUserBot(author, IsBot);

 	DCC_GetMessageChannel(message, channel);
	DCC_GetMessageAuthor(message, author);
    DCC_GetChannelName(channel, channel_name);
    DCC_GetUserName(author, user_name);
	DCC_GetUserId(author, author_id);
    printf("[DCC] OnChannelMessage (Channel %s): Author %s sent message: %s", channel_name, user_name, realMsg);
	/*new command_name[25], params[150];
	if(sscanf(realMsg, "s[25]S()[150]", command_name, params))
    {
		return 0;
    }
    if(!strcmp(command_name, "<@1033336963610202183> help", true))
    {
		new str[256];
		new DCC_Embed:embed = DCC_CreateEmbed();
				format(str, sizeof str, "__**List of commands**__");
				DCC_SetEmbedTitle(embed, str);
				DCC_SetEmbedColor(embed, 0x669900);
				format(str, sizeof(str),"***<@1033336963610202183> player*** - Show stats for the specified player.\n\
										***<@1033336963610202183> turfs*** - Turfs information; who occupies them and when they're vulnerable again.\n\
										***<@1033336963610202183> points*** - Points information; who occupies them and when they're vulnerable again.\n\
										***<@1033336963610202183> gangs*** - List of the official gangs and their respective leaders.\n\
										***<@1033336963610202183> factions*** - List of the official factions and their respective leaders.");
				DCC_SetEmbedDescription(embed, str);
				DCC_SendChannelEmbedMessage(g_ServerBotChannelId, embed);
				printf("%d", channel);
	}
	if(!strcmp(command_name, "<@1033336963610202183> player", true))
    {
				new name[MAX_PLAYER_NAME];
                if(sscanf(params, "s[32]", name))
				{
					new string[144];
					format(string, sizeof(string), "<@%s>, use the following format: /player <player_name> (Example usage: /player John_Smith)", author_id);
					return SendDiscordMessage(7, string);
				}

				new tmpName[24], str[256];
				mysql_escape_string(name, tmpName);
				mysql_format(MainPipeline, str, sizeof(str), "SELECT `Username`, `DonateRank`, `Level`, `ConnectedTime`, `Member`, `PhoneNr`, `Model` FROM `accounts` WHERE `Username` = '%s'", tmpName);
				mysql_tquery(MainPipeline, str, "OnBotCheck", "s", author_id);
	}*/

	if(!strcmp(channel_name, "admin", true))
    {
        if(realMsg[0] == '/') // Prefix for bot commands.
        {
			if(strfind(realMsg, "help", true, 1) != -1)
            {
                SendDiscordMessage(0, "works");
            }
            if(strfind(realMsg, "kick", true, 1) != -1)
            {
                new player, reason[128];
                if(sscanf(realMsg[6], "us[128]", player, reason)) return SendDiscordMessage(0, "USAGE: /kick [player] [reason]");
                if(!IsPlayerConnected(player)) return SendDiscordMessage(0, "That player is not connected.");

                new string[144];
                format(string, sizeof(string), "%s (%d) has been kicked from the server by <@%s>.", GetPlayerNameEx(player), player, author_id);
                SendDiscordMessage(0, string);

                KickEx(player);
            }

        }
    }
	if(!strcmp(channel_name, "lead-admin", true))
    {
        if(realMsg[0] == '/') // Prefix for bot commands.
        {
			if(strfind(realMsg, "stopserver", true, 1) != -1)
            {
				SendRconCommand("exit");
                SendDiscordMessage(2, "Server stopped.");
            }
        }
    }
	if(!strcmp(channel_name, "ip-whitelist", true))
    {
        if(realMsg[0] == '/') // Prefix for bot commands.
        {
			if(strfind(realMsg, "ipwhitelist", true, 1) != -1)
            {
				new giveplayer[MAX_PLAYER_NAME], ip[16];
                if(sscanf(realMsg[13], "s[24]s[16]", giveplayer, ip)) return SendDiscordMessage(5, "USAGE: /ipwhitelist [admin name] [IP]");


                new tmpName[24], tmpIP[16], query[256];
				mysql_escape_string(giveplayer, tmpName);
				mysql_escape_string(ip, tmpIP);
				mysql_format(MainPipeline, query, sizeof(query), "UPDATE `accounts` SET `SecureIP`='%s' WHERE `Username`='%s'", tmpIP, tmpName);
				mysql_tquery(MainPipeline, query, "OnIPWhitelistDiscord", "ss", author_id, tmpName);
				DCC_DeleteMessage(message);

            }
        }
    }
	if(!strcmp(channel_name, "bot-channel", true))
    {
		/*if(!strcmp(realMsg, "<@1033336963610202183> player",true)) // Prefix for bot commands.
		{
			new name[MAX_PLAYER_NAME];
			if(sscanf(realMsg[31], "s[32]", name))
			{
					SendDiscordMessage(7, "string 1");
			}
			SendDiscordMessage(7, "string 2");
		}*/
        if(realMsg[0] == '/') // Prefix for bot commands.
        {
			if(strfind(realMsg, "help", true, 1) != -1 && realMsg[5] == '\0')
            {
				new str[2000];
				new DCC_Embed:embed = DCC_CreateEmbed();
				format(str, sizeof str, "__**List of commands**__");
				DCC_SetEmbedTitle(embed, str);
				DCC_SetEmbedColor(embed, 0x669900);
				format(str, sizeof(str),"***/player*** - Show stats for the specified player.\n\
										***/gangs*** - List of the official gangs and their respective leaders.\n\
										***/factions*** - List of the official factions and their respective leaders.\n\
										***/turfs*** - Turfs information; who occupies them and when they're vulnerable again.\n\
										***/points*** - Points information; who occupies them and when they're vulnerable again.");
				DCC_SetEmbedDescription(embed, str);
				DCC_SendChannelEmbedMessage(g_ServerBotChannelId, embed);
			}
            if(strfind(realMsg, "player", true, 1) != -1)
            {

				new name[MAX_PLAYER_NAME];
                if(sscanf(realMsg[8], "s[24]", name))
				{
					new string[144];
					format(string, sizeof(string), "<@%s>, use the following format: /player <player_name> (Example usage: /player John_Smith)", author_id);
					return SendDiscordMessage(7, string);
				}

				new tmpName[24], str[256];

				for (new i = 0; i < strlen(name); i++)
				{
					if (name[i] == ' ')
						name[i] = '_';
				}
				mysql_escape_string(name, tmpName);
				mysql_format(MainPipeline, str, sizeof(str), "SELECT `Username`, `DonateRank`, `Level`, `ConnectedTime`, `Member`, `PhoneNr`, `Model` FROM `accounts` WHERE `Username` = '%s'", tmpName);
				mysql_tquery(MainPipeline, str, "OnBotCheck", "s", author_id);

            }
			if(strfind(realMsg, "points", true, 1) != -1)
            {
				new DCC_Embed:embed = DCC_CreateEmbed(), tsstring[2048], name[32], timeleft[32];
				tsstring = "";
				DCC_SetEmbedTitle(embed, "__**Points**__");
				DCC_SetEmbedColor(embed, 0x669900);
				for(new point=0; point < MAX_POINTS; point++)
				{
					if(DynPoints[point][poPos][0] && DynPoints[point][poLocked] != 1)
					{
						if(DynPoints[point][poCaptureGroup] >= 0) strcpy(name, arrGroupData[DynPoints[point][poCaptureGroup]][g_szGroupName]);
						else name = "None";
						if(DynPoints[point][poTimer] > 0) format(timeleft, sizeof(timeleft), "%d hours left", DynPoints[point][poTimer]);
						else format(timeleft, sizeof(timeleft), "Vulnerable :timer:");
						format(tsstring, sizeof(tsstring), "%s **%s** | Owner: **%s** (%s) | **%s** \n\n", tsstring, DynPoints[point][poName],name,DynPoints[point][poCaptureName],timeleft);
					}
				}
				DCC_SetEmbedDescription(embed, tsstring);
				DCC_SendChannelEmbedMessage(channel, embed);
			}
        }
    }
	/*if(channel == g_AdminChannelId && strcmp(user_name, "RG-RP Bot#9091", true))//define user_name to prevent duplicate D -> S messages
	{
		format(szMessage, sizeof(szMessage), "* [Discord] Administrator %s: %s", user_name, realMsg);
		ABroadCast(COLOR_YELLOW, szMessage, 2, true, true);
	}
	else if(channel == g_HeadAdminChannelId && strcmp(user_name, "RG-RP Bot#9091", true)) //define user_name to prevent duplicate D -> S messages
	{
		format(szMessage, sizeof(szMessage), "(PRIVATE) [Discord] Administrator %s: %s", user_name, realMsg);
		ABroadCast(COLOR_GREEN, szMessage, 1337, true, true);
	}*/
    return 1;
}

forward OnIPWhitelistDiscord(author_id[], name[]);
public OnIPWhitelistDiscord(author_id[], name[])
{
    new string[128];

    if(cache_affected_rows()) {
        format(string, sizeof(string), "<@%s> has successfully whitelisted %s's account.", author_id, name);
        SendDiscordMessage(5, string);
        format(string, sizeof(string), "[DISCORD] %s has IP Whitelisted %s", author_id, name);
        Log("logs/whitelist.log", string);
    }
    else {
        format(string, sizeof(string), "<@%s>, there was an issue with whitelisting %s's account.", author_id, name);
        SendDiscordMessage(5, string);
    }

    return 1;
}

forward OnBotCheck(author_id[], channel);
public OnBotCheck(author_id[], channel)
{
		new string[128], name[24], skin_image[200], str[256];
		new rows;
		cache_get_row_count(rows);
		if(rows)
		{
			cache_get_value_name(0, "Username", name, 25);
			cache_get_value_name(0, "DonateRank", string);new drank = strval(string);
			cache_get_value_name(0, "Level", string); new level = strval(string);
			cache_get_value_name(0, "ConnectedTime", string);new phours = strval(string);
			cache_get_value_name(0, "Member", string); new member = strval(string);
			cache_get_value_name(0, "PhoneNr", string);new phone = strval(string);
			cache_get_value_name(0, "Model", string); new skinid = strval(string);
			//https://gtaundergroundmod.com/resources/media/skins/%d.png
			//https://weedarr.wdfiles.com/local--files/skinlistc/102.png
			format(skin_image, sizeof skin_image, "https://www.rpg2.b-zone.ro/public/img/Skins/%d.png", skinid);

			new pnumber[20], employer[GROUP_MAX_NAME_LEN], drankname[15];

			if(drank > 0)
			{
				switch(drank)
				{
					case 1: drankname = "Bronze VIP";
					case 2: drankname = "Silver VIP";
					case 3: drankname = "Gold VIP";
					case 4: drankname = "Platinum VIP";
					case 5: drankname = "VIP Moderator";
				}
			}
			if(phone == 0) pnumber = "None"; else format(pnumber, sizeof(pnumber), "%d", phone);
			if(0 <= member < MAX_GROUPS) {
				format(employer, (GROUP_MAX_NAME_LEN), "%s", arrGroupData[member][g_szGroupName]);
			}
			else {
				format(employer, (GROUP_MAX_NAME_LEN), "None");
			}
			new DCC_Embed:embed = DCC_CreateEmbed();
			format(str, sizeof str, "__**%s's stats.**__", name);
			DCC_SetEmbedTitle(embed, str);
			DCC_SetEmbedColor(embed, 0x669900);
			DCC_SetEmbedThumbnail(embed, skin_image);
			//DCC_SetEmbedImage(embed, skin_image);
			if(drank > 0)
			{
				format(str, sizeof(str),"***%s***\n\
				***Level:***ㅤ%d\n\
				***Playing Hours:***ㅤ%d\n\
				***Phone Number:***ㅤ%s\n\
				***Group:***ㅤ%s",
				drankname,
				level,
				phours,
				pnumber,
				employer);
			} else
			{
				format(str, sizeof(str),"***Level:***ㅤ%d\n\
				***Playing Hours:***ㅤ%d\n\
				***Phone Number:***ㅤ%s\n\
				***Group:***ㅤ%s",
				level,
				phours,
				pnumber,
				employer);
			}
			DCC_SetEmbedDescription(embed, str);
			format(str, sizeof(str), "<@%s>, here is the stats of **%s**", author_id, name);
			DCC_SendChannelEmbedMessage(g_ServerBotChannelId, embed, str);
		}
		else
		{
			format(str, sizeof(str), "<@%s>, specified player does not exist.", author_id);
			SendDiscordMessage(4, str);
		}
		return 1;
}
/*forward OnPostPlayerStat(playerid);
public OnPostPlayerStat(playerid)
{
	new DCC_Message:message = DCC_GetCreatedMessage();
    if(StatMessage != DCC_Message:0 )
    {
        DCC_DeleteInternalMessage(StatMessage);
    }
	StatMessage = message;
    StatTarget = playerid;
    DCC_CreateReaction(message, DCC_CreateEmoji("👢"));
    DCC_CreateReaction(message, DCC_CreateEmoji("🔨"));
	//DCC_SetMessagePersistant(message, true);
}*/
/*public DCC_OnChannelMessage(DCC_Channel:channel, DCC_User:author, const message[])
{
    if(betaserver == 0) {
        new channel_name[32], author_name[32], szMessage[128];
        DCC_GetChannelName(channel, channel_name);
        DCC_GetUserName(author, author_name);
        printf("[DCC] OnChannelMessage (Channel %s): Author %s sent message: %s", channel_name, author_name, message);
        if(!strcmp(channel_name, "admin") && strcmp(author_name, "SAMP-Bot", true) != 0)
        {
            format(szMessage, sizeof(szMessage), "* [Discord] Administrator %s: %s", author_name, message);
            ABroadCast(COLOR_YELLOW, szMessage, 2, true, true);
        }
        else if(!strcmp(channel_name, "headadmin") && strcmp(author_name, "SAMP-Bot", true) != 0)
        {
            format(szMessage, sizeof(szMessage), "(PRIVATE) [Discord] Administrator %s: %s", author_name, message);
            ABroadCast(COLOR_GREEN, szMessage, 1337, true, true);
        }
    }
    return 1;
}*/
/*public DCC_OnChannelMessage(DCC_Channel:channel, DCC_User:author, const message[])
{
	if(betaserver == 0) {
		new channel_name[32], szMessage[128];
		DCC_GetChannelName(channel, channel_name);
		printf("[DCC] OnChannelMessage (Channel %s): Author %s sent message: %s", channel_name, author, message);
		if(!strcmp(channel_name, "admin", true) && strcmp(author, "SAMP-Bot", true))
		{
			format(szMessage, sizeof(szMessage), "* [Discord] Administrator %s: %s", author, message);
			ABroadCast(COLOR_YELLOW, szMessage, 2, true, true);
		}
		else if(!strcmp(channel_name, "headadmin", true) && strcmp(author, "SAMP-Bot", true))
		{
			format(szMessage, sizeof(szMessage), "(PRIVATE) [Discord] Administrator %s: %s", author, message);
			ABroadCast(COLOR_GREEN, szMessage, 1337, true, true);
		}
	}
	return 1;
}
