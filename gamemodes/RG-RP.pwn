/*


		  _____     _____       _____    _____
		 |  __ \   / ____|  _  |  __ \  |  __ \
		 | |__) | | |  __  (_) | |__) | | |__) |
		 |  _  /  | | |_ |     |  _  /  |  ___/
		 | | \ \  | |__| |  _  | | \ \  | |
		 |_|  \_\  \_____| (_) |_|  \_\ |_|
				(Development Team)

	Current Developers:
	*** Director of SA:MP Development:
		N0FeaR
	** Development Staff:
		187
*/

#include <a_samp>
#pragma disablerecursion
#pragma warning disable 206
#pragma warning disable 213
#define SERVER_GM_TEXT "RG:RP v1.0.0"
#define SSCANF_NO_NICE_FEATURES

#undef  MAX_PLAYERS
#define MAX_PLAYERS (500)
#include <RGRP> // This prevent for theft of the script

#if defined SOCKET_ENABLED
#include <socket>
#endif


#include "./includes/maincore/defines.pwn"
#include "./includes/maincore/enums.pwn"
#include "./includes/maincore/variables.pwn"
#include "./includes/maincore/wrappers.pwn"
#include "./includes/maincore/timers.pwn"
#include "./includes/maincore/functions.pwn"
#include "./includes/maincore/mysql.pwn"
#include "./includes/maincore/OnPlayerLoad.pwn"
#include "./includes/maincore/callbacks.pwn"
#include "./includes/maincore/textdraws.pwn"
#include "./includes/maincore/streamer.pwn"
#include "./includes/maincore/OnDialogResponse.pwn"
#include "./includes/maincore/discord.pwn"
//#include "./includes/maincore/OnPlayerRequestDownload.pwn" This is for 0.3DL we will have it disabled for now

#if defined AREA_DEBUG
#include "./includes/areadebug.pwn"
#endif

//streamer includes
//#include "./includes/streamer/removebuildings.pwn" We put all removebuilding code in FS instead
#include "./includes/streamer/areas.pwn"
#include "./includes/streamer/buttons.pwn"
#include "./includes/streamer/objects.pwn"
#include "./includes/streamer/pickups.pwn"
#include "./includes/streamer/textlabels.pwn"
#include "./includes/streamer/vehicles.pwn"
#include "./includes/streamer/OnPlayerEditDynamicObject.pwn"

//admin includes
#include "./includes/admin/aahtm.pwn"
#include "./includes/admin/admin.pwn"
#include "./includes/admin/helper.pwn"
#include "./includes/admin/auctionsystem.pwn"
#include "./includes/admin/bugreport.pwn"
#include "./includes/admin/flags.pwn"
#include "./includes/admin/gift.pwn"
#include "./includes/admin/reportsystem.pwn"
#include "./includes/admin/serveroffences.pwn"
#include "./includes/admin/vouchers.pwn"
#include "./includes/admin/watchdogs.pwn"
#include "./includes/admin/intlist.pwn"
#include "./includes/admin/anticheat.pwn"
#include "./includes/admin/spectate.pwn"
#include "./includes/admin/watch.pwn"
#include "./includes/admin/newbie.pwn"
#include "./includes/admin/ban.pwn"
#include "./includes/admin/newstaffban.pwn"

//business includes
#include "./includes/business/247items.pwn"
#include "./includes/business/ammunation.pwn"
#include "./includes/business/businesscore.pwn"
#include "./includes/business/mailsystem.pwn"

//By N0FeaR
#include "./includes/n0fear/locations.pwn"
#include "./includes/n0fear/locate.pwn"
#include "./includes/n0fear/skill.pwn"
#include "./includes/n0fear/talkanim.pwn"
#include "./includes/n0fear/htmhouses.pwn"
#include "./includes/n0fear/vendingmachine.pwn"
#include "./includes/n0fear/labeldraw.pwn"
#include "./includes/n0fear/paperboy.pwn"
#include "./includes/n0fear/streetsweeper.pwn"
#include "./includes/n0fear/actors.pwn"
#include "./includes/n0fear/walkstyle.pwn"
#include "./includes/n0fear/newturfs.pwn"

// 187
#include "./includes/187/mydrugs.pwn"

//core includes
#include "./includes/core/acceptcancel.pwn"
#include "./includes/core/advertisements.pwn"
#include "./includes/core/banking.pwn"
#include "./includes/core/chat.pwn"
#include "./includes/core/fireworks.pwn"
#include "./includes/core/helpcmds.pwn"
#include "./includes/core/hospital.pwn"
#include "./includes/core/lotto.pwn"
#include "./includes/core/lselevator.pwn"
#include "./includes/core/marriage.pwn"
#include "./includes/core/namechange.pwn"
#include "./includes/core/phone.pwn"
#include "./includes/core/radio.pwn"
#include "./includes/core/service.pwn"
#include "./includes/core/storage.pwn"
#include "./includes/core/tutorial.pwn"
#include "./includes/core/upgrades.pwn"
#include "./includes/core/vactions.pwn"
#include "./includes/core/weapons.pwn"
#include "./includes/core/damage.pwn"
#include "./includes/core/health.pwn"
#include "./includes/core/teams.pwn"
#include "./includes/core/stats.pwn"
#include "./includes/core/timefuncs.pwn"
#include "./includes/core/camerafuncs.pwn"
#include "./includes/core/clearcheckpoint.pwn"
#include "./includes/core/maintenance.pwn"
#include "./includes/core/countrycheck.pwn"
#include "./includes/core/countdown.pwn"
#include "./includes/core/filehandle.pwn"
#include "./includes/core/initgamemode.pwn"
#include "./includes/core/login.pwn"
#include "./includes/core/miscload.pwn"
#include "./includes/core/proxdetector.pwn"
#include "./includes/core/setplayerspawn.pwn"
#include "./includes/core/streamprep.pwn"
#include "./includes/core/emailcheck.pwn"
#include "./includes/core/AccountSettings.pwn"
#include "./includes/core/deluxegps.pwn"
//#include "./includes/core/vending.pwn" // Old system don't need this anymore

//dynamic core includes
#include "./includes/dynamic/doors.pwn"
#include "./includes/dynamic/garages.pwn"
#include "./includes/dynamic/gates.pwn"
#include "./includes/dynamic/houses.pwn"
#include "./includes/dynamic/mapicons.pwn"
#include "./includes/dynamic/motds.pwn"
#include "./includes/dynamic/paynsprays.pwn"
#include "./includes/dynamic/textlabels.pwn"
#include "./includes/dynamic/impound.pwn"
#include "./includes/dynamic/speedcamera.pwn"
#include "./includes/dynamic/arrestpoints.pwn"
#include "./includes/dynamic/dynsu.pwn"
#include "./includes/dynamic/housemarket.pwn"
#include "./includes/dynamic/ddsale.pwn"
#include "./includes/dynamic/parking.pwn"
#include "./includes/dynamic/MetalDetectors.pwn"
#include "./includes/dynamic/points.pwn"

//vehicle system includes
#include "./includes/vehsystem/vehiclecore.pwn"
#include "./includes/vehsystem/drivingtest.pwn"
#include "./includes/vehsystem/Server_DMV.pwn"
#include "./includes/vehsystem/speedo.pwn"
#include "./includes/vehsystem/tow.pwn"
#include "./includes/vehsystem/VLP.pwn"
#include "./includes/vehsystem/helmet.pwn"
#include "./includes/vehsystem/groupvehs.pwn"
#include "./includes/vehsystem/playervehs.pwn"
#include "./includes/vehsystem/cratevehicles.pwn"

//event kernels includes
//#include "./includes/events/bday.pwn"
#include "./includes/events/event.pwn"
#include "./includes/events/eventpoints.pwn"
#include "./includes/events/fif.pwn"
#include "./includes/events/findtheflag.pwn"
#include "./includes/events/hungergames.pwn"
#include "./includes/events/paintball.pwn"
#include "./includes/events/rewardplay.pwn"
#include "./includes/events/rfl.pwn"
#include "./includes/events/xmas.pwn"
#include "./includes/events/zombies.pwn"
#include "./includes/events/valentine.pwn"
//#include "./includes/events/festival.pwn"
//#include "./includes/events/stpatricks.pwn"
#include "./includes/events/memorial.pwn"

//dynamic group system includes
#include "./includes/group/gang.pwn"
#include "./includes/group/citizenship.pwn"
//#include "./includes/group/contract.pwn"
#include "./includes/group/hitman.pwn"
#include "./includes/group/fires.pwn"
#include "./includes/group/gov.pwn"
#include "./includes/group/groupcore.pwn"
#include "./includes/group/judicial.pwn"
#include "./includes/group/lea.pwn"
#include "./includes/group/medic.pwn"
#include "./includes/group/news.pwn"
#include "./includes/prison_system.pwn"
#include "./includes/group/racing.pwn"
#include "./includes/group/taxi.pwn"
#include "./includes/group/towing.pwn"
//#include "./includes/group/turfs.pwn"
#include "./includes/group/cratesystem.pwn"
#include "./includes/group/callsystem.pwn"
//#include "./includes/group/gangshipment.pwn"
//#include "./includes/group/gangcrates.pwn"
//#include "./includes/group/gangrobbery.pwn"
#include "./includes/group/GovArms.pwn"
#include "./includes/group/grouppay.pwn"
#include "./includes/group/gangtags.pwn"
#include "./includes/group/GunLicense.pwn"
#include "./includes/group/sanews.pwn"
#include "./includes/group/casefile.pwn"
#include "./includes/group/groupweapons.pwn"

//job system includes
#include "./includes/jobs/bartender.pwn"
#include "./includes/jobs/bodyguard.pwn"
#include "./includes/jobs/boxing.pwn"
#include "./includes/jobs/craftsman.pwn"
#include "./includes/jobs/detective.pwn"
#include "./includes/jobs/drugs.pwn"
#include "./includes/jobs/garbage.pwn"
#include "./includes/fishingsystem.pwn"
#include "./includes/jobs/jobcore.pwn"
#include "./includes/jobs/dynjobcore.pwn"
#include "./includes/jobs/lawyer.pwn"
#include "./includes/jobs/mechanic.pwn"
#include "./includes/jobs/pizzaboy.pwn"
#include "./includes/jobs/shipment.pwn"
#include "./includes/jobs/taxi.pwn"
#include "./includes/jobs/treasure.pwn"
#include "./includes/jobs/whore.pwn"
#include "./includes/jobs/armsdealer.pwn"
//#include "./includes/jobs/newshipment.pwn" - not supposed to be in yet! Don't forget to uncomment the reset, line 1975 in callbacks.pwn
#include "./includes/core/drugcore.pwn"

//perk system includes
#include "./includes/perks/boombox.pwn"
#include "./includes/perks/backpack.pwn"
#include "./includes/perks/dedicated.pwn"
#include "./includes/perks/famed.pwn"
#include "./includes/perks/poker.pwn"
#include "./includes/perks/shopcore.pwn"
#include "./includes/perks/tokens.pwn"
#include "./includes/perks/toys.pwn"
#include "./includes/perks/vipcore.pwn"
#include "./includes/perks/casino.pwn"
#include "./includes/perks/horsey.pwn"

//#include "./includes/core/ammo.pwn"
#include "./includes/core/phone_new.pwn"
#include "./includes/core/payphones.pwn"
#include "./includes/group/rivalry.pwn"

// WIP
#include "./includes/core/ATMs.pwn"
#include "./includes/core/Banks.pwn"
#include "./includes/core/entexit.pwn"
#include "./includes/vehsystem/vehauto.pwn"
#include "./includes/DBLog.pwn"
#include "./includes/core/Player_Interact.pwn"


// Jingles WIP
#include "./includes/core/minigame.pwn"
//#include "./includes/admin/anticheat2.pwn"
#include "./includes/furnituretextures.pwn"
#include "./includes/furniture.pwn"
#include "./includes/group/elections.pwn"
//#include "./includes/events/naturaldisaster.pwn"

// Westen WIP
//#include "./includes/dynamic/dynpolls2.pwn"

// Jason WIP
//#include "./includes/core/interact.pwn"
main(){}

public OnGameModeInit()
{
	print("Preparing the gamemode, please wait...");
	g_mysql_Init();
	return 1;
}

public OnGameModeExit()
{
	print("Exiting the gamemode, please wait..."); // Added this for easier access to find logs about the gamemode exiting
    g_mysql_Exit();
	return 1;
}

AntiDeAMX()
{
    new a[][] = {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}
