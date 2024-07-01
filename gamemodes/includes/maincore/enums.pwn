/*
    	 		 /$$   /$$  /$$$$$$          /$$$$$$$  /$$$$$$$
				| $$$ | $$ /$$__  $$        | $$__  $$| $$__  $$
				| $$$$| $$| $$  \__/        | $$  \ $$| $$  \ $$
				| $$ $$ $$| $$ /$$$$ /$$$$$$| $$$$$$$/| $$$$$$$/
				| $$  $$$$| $$|_  $$|______/| $$__  $$| $$____/
				| $$\  $$$| $$  \ $$        | $$  \ $$| $$
				| $$ \  $$|  $$$$$$/        | $$  | $$| $$
				|__/  \__/ \______/         |__/  |__/|__/

//--------------------------------[ENUMS.PWN]--------------------------------


 * Copyright (c) 2016, Next Generation Gaming, LLC
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are not permitted in any case.
 *
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*new const Drugs[][] = {
	"LSD",
	"Cannabis",
	"Meth",
	"Heroin",
	"Cocaine",
	"Crack",
	"Opium",
	"Ecstasy",
	"Speed",
	"Alcohol",
	"Demerol",
	"Morphine",
	"Haloperidol",
	"Aspirin"
};


new const szIngredients[][] = {
	"Morning Glory Seeds",
	"Cannabis Seeds",
	"Muriatic Acid",
	"Lye",
	"Ethyl Ether",
	"Ephedrine",
	"Distilled Water",
	"Opium Poppy",
	"Lime",
	"Cocaine Plant Extract",
	"Baking Soda",
	"Cocaine Plant Powder",
	"N-Benzynol",
	"PMK Oil",
	"MDMA Crystals",
	"Caffeine"
};*/ // see ya

new const Drugs[][] = {
	"Pot",
	"Crack",
	"Meth",
	"Ecstasy",
	"Heroin"
};
new const ArmsDealerItems[][] =
{
	"9mm",
	"Sdpistol",
	"MP5",
	"Tec-9",
	"Micro Uzi",
	"Rifle",
	"Shotgun",
	"Desert Eagle",
	"AK-47",
	"M4A1",
	"Combat Shotgun",
	"Sniper Rifle"
};

new const ArmsDealerCosts[][] =
{
	"500",
	"1000",
	"2500",
	"2500",
	"3000",
	"3000",
	"4000",
	"5000",
	"10000",
	"15000",
	"20000",
	"30000"
};


enum eGroupData {
	g_SlotHolder[MAX_PLAYER_NAME],
	g_iGroupType,
	g_szGroupName[GROUP_MAX_NAME_LEN],
	g_iLockerGuns[MAX_GROUP_WEAPONS],
	g_iLockerCost[MAX_GROUP_WEAPONS],
	g_iAllegiance,
	g_iBugAccess,
	g_iFindAccess,
	g_iRadioAccess,
	g_iDeptRadioAccess,
	g_iIntRadioAccess,
	g_iGovAccess,
	g_iTreasuryAccess,
	g_hDutyColour,
	g_hRadioColour,
	g_iLockerStock,
	g_iFreeNameChange,
	g_iFreeNameChangeDiv,
	g_iSpikeStrips,
	g_iBarricades,
	g_iCones,
	g_iFlares,
	g_iBarrels,
	g_iLadders,
	g_iBudget,
	g_iBudgetPayment,
	Float: g_fCratePos[3],
	g_iPaycheck[MAX_GROUP_RANKS],
	g_iCrateIsland,
	Text3D: g_tCrate3DLabel,
	g_iLockerCostType,
	g_iCratesOrder,
	gTempNum,
	gCasefile,
	gLEOArrest,
	g_iJCount,
	g_iTackleAccess,
	Float: g_fGaragePos[3],
	g_iWheelClamps,
	g_iDoCAccess,
	g_iMedicAccess,
	g_iDMVAccess,
	g_iOOCChat,
	g_hOOCColor,
	g_iPot,
	g_iCrack,
	g_iMeth,
	g_iEcstasy,
	g_iHeroin,
	g_iSyringes,
	g_iOpium,
	g_iMaterials,
	g_iWeapons[50],
	g_iClothes[MAX_GROUP_RANKS],
	g_iTurfCapRank,
	g_iPointCapRank,
	g_iWithdrawRank[5],
	g_iTurfTokens,
	g_iMemberCount,
	g_iCrimeType,
	g_iDrugs[sizeof(Drugs)],
	//g_iIngredients[sizeof(szIngredients)],
	g_iGroupToyID,
	g_iRivals[MAX_GROUP_RIVALS],
	g_iTurfTax,
	g_iTapes,
	// by N0FeaR
	gArmsDealer,
	gDrugDealer,
	gArmsSkin,
	gDrugSkin,
	gArmsDealerUse,
	gDrugDealerUse,
	Float:gArmsX,
	Float:gArmsY,
	Float:gArmsZ,
	Float:gArmsA,
	Float:gDrugX,
	Float:gDrugY,
	Float:gDrugZ,
	Float:gDrugA,
	gArmsWorld,
	gDrugWorld,
	gDrugCrack,
	gDrugPot,
	gDrugMeth,
	gDrugEcstasy,
	gDrugHeroin,
	gArmsMaterials,
	gArmsPrices[sizeof(ArmsDealerItems)],
	gDrugPrices[sizeof(Drugs)],
	gArmsHPAmmo,
	gArmsPoisonAmmo,
	gArmsFMJAmmo,
	Text3D:gText[2],
	gPickup,
	gActors[2],
	g_adMapIcon,
	g_ddMapIcon
}

enum PlantData
{
	 pOwner,
	 pObject,
	 pPlantType,
	Float: pPos[3],
	 pVirtual,
	 pInterior,
	 pGrowth,
	 pExpires,
	pDrugsSkill,
	pObjectSpawned,
}

new Plants[MAX_PLAYERS][PlantData];

enum eLockerData {
	g_iLockerSQLId,
	Float: g_fLockerPos[3],
	g_iLockerVW,
	g_iLockerShare,
	Text3D: g_tLocker3DLabel,
	g_iLockerAreaID
}

enum eJurisdictionData {
	g_iJurisdictionSQLId,
	g_iAreaName[64]
}

enum eGroupVehData {
	gv_iSQLID,
	gv_iDisabled, // is equal to 1 when a car has been despawned due to a group not being able to afford it | 2 for dvstorage
	gv_iSpawnedID, // In-game spawned ID of vehicle
	gv_igID, // ID of group (faction) (0 if unrestricted - for civilian use)
	gv_igDivID, // ID of division restriction (0 if unrestricted)
	gv_irID, // ID of rank restriction (0 if unrestricted)
	gv_iType, // (0 - standard | 1 - Crate Transport)
	gv_iLoadMax, //(ie if type is set to 1, and vLoadMax set to 2, car will have a max capacity of 2 crates)
	gv_iModel, // Model of Vehicle
	gv_iPlate[32],
	Float:gv_fMaxHealth, //Maximum Health of Vehicle
	Float:gv_fFuel, // gas level of the vehicle
	gv_iCol1, // Color 1
	gv_iCol2, // Color 2
	gv_iVW,
	gv_iInt,
	Float:gv_fX, // X axis
	Float:gv_fY, // Y axis
	Float:gv_fZ, // Z axis
	Float:gv_fRotZ, // Vehicle Z Rotation
	gv_iUpkeep, // Upkeep fee - costs faction $
	gv_iMod[15],
	gv_iSiren
}

enum eGroupVehObjectData {
	gv_iAttachedObjectID,
	gv_iAttachedObjectModel, // For permanently attached vehicle objects.. ie lightbar, neons
	Float:gv_fObjectX,
	Float:gv_fObjectY,
	Float:gv_fObjectZ,
	Float:gv_fObjectRX,
	Float:gv_fObjectRY,
	Float:gv_fObjectRZ,
	gv_fObjectText[32],
	gv_fObjectMatSize,
	gv_fObjectFont[32],
	gv_fObjectSize,
	gv_fObjectColor,
	gv_fObjectBGColor
}

enum eBiz {
    bName[MAX_BUSINESS_NAME],
	bOwner,
	bOwned,
	bOwnerName[MAX_PLAYER_NAME],
	bValue,
	bType,
	bLevel,
	bLevelProgress,
	bAutoSale,
	bSafeBalance,
	bInventory,
	bInventoryCapacity,
	bStatus,
	bRankPay[6],
	Float: bExtPos[4],
	Float: bIntPos[4],
	Float: bSupplyPos[3],
	bInt,
	bVW,
	bMinInviteRank,
	bMinGiveRankRank,
	bMinSupplyRank,
	bMinSafeRank,
	bMinInventoryRank,
	bMinStatusRank,
	bMinDoorRank,
	bGunsOffered[31],
	bSkinsOffered[300],
	bToysOffered[100],
	bItemPrices[21],
	bTotalSales,
	bTotalProfits,
	Text3D: bStateText,
	Text3D: bDoorText,
	Text3d: bDoorText2,
	Text3D: bSupplyText,
	bPickup,
	bPickup_int,
	bAutoPay,
	Float: bGasPrice,
	bStrictPrice,
	bOrderBy[MAX_PLAYER_NAME],
	bOrderState,
	bOrderAmount,
	bOrderDate[30],
	bCustomExterior,
	bCustomInterior,
	bGrade,

	Float: GasPumpPosX[MAX_BUSINESS_GAS_PUMPS],
	Float: GasPumpPosY[MAX_BUSINESS_GAS_PUMPS],
	Float: GasPumpPosZ[MAX_BUSINESS_GAS_PUMPS],
	Float: GasPumpAngle[MAX_BUSINESS_GAS_PUMPS],
	Float: GasPumpCapacity[MAX_BUSINESS_GAS_PUMPS],
	Float: GasPumpGallons[MAX_BUSINESS_GAS_PUMPS],
	GasPumpObjectID[MAX_BUSINESS_GAS_PUMPS],
	Text3D: GasPumpInfoTextID[MAX_BUSINESS_GAS_PUMPS],
	Text3D: GasPumpSaleTextID[MAX_BUSINESS_GAS_PUMPS],
	Float: GasPumpSaleGallons[MAX_BUSINESS_GAS_PUMPS],
	Float: GasPumpSalePrice[MAX_BUSINESS_GAS_PUMPS],
	GasPumpTimer[MAX_BUSINESS_GAS_PUMPS],
	GasPumpVehicleID[MAX_BUSINESS_GAS_PUMPS],

	Float: bParkPosX[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	Float: bParkPosY[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	Float: bParkPosZ[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	Float: bParkAngle[MAX_BUSINESS_DEALERSHIP_VEHICLES],

	Float: bPurchaseX[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	Float: bPurchaseY[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	Float: bPurchaseZ[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	Float: bPurchaseAngle[MAX_BUSINESS_DEALERSHIP_VEHICLES],

	bColor1[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	bColor2[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	bModel[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	bPrice[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	Float: bHealth[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	Float: bFuel[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	Lock[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	bVehID[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	DealershipVehStock[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	DealershipVehOrder[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	Text3D:bVehicleLabel[MAX_BUSINESS_DEALERSHIP_VEHICLES],
	bMonths,

	bGymEntryFee,
	bGymType, // 1 = swimming pool
	bMapIcon,
	bMIcon,
	bGymBoxingArena1[2],
	bGymBoxingArena2[2],
	bGymBikePlayers[10],
	bGymBikeVehicles[10],

	bMaxLevel,
	bAreaID[2],
	bPhoneNr
}

enum StoreItemCostEnum
{
	ItemValue
}

enum CargoArrayData
{
	Float:PosX,
	Float:PosY,
	Float:PosZ
}

enum WeaponsEnum
{
	WeaponId,
	WeaponMats,
	WeaponMinLevel
}

enum pkrInfo
{
	pkrActive,
	pkrPlaced,
	pkrObjectID,
	pkrMiscObjectID[MAX_POKERTABLEMISCOBJS],
	Text3D:pkrText3DID,
	Float:pkrX,
	Float:pkrY,
	Float:pkrZ,
	Float:pkrRX,
	Float:pkrRY,
	Float:pkrRZ,
	pkrVW,
	pkrInt,
	pkrPlayers,
	pkrActivePlayers,
	pkrActiveHands,
	pkrSlot[6],
	pkrPass[32],
	pkrLimit,
	pkrPulseTimer,
	pkrBuyInMax,
	pkrBuyInMin,
	pkrBlind,
	pkrTinkerLiveTime,
	pkrDelay,
	pkrSetDelay,
	pkrPos,
	pkrRotations,
	pkrSlotRotations,
	pkrActivePlayerID,
	pkrActivePlayerSlot,
	pkrRound,
	pkrStage,
	pkrActiveBet,
	pkrDeck[52],
	pkrCCards[5],
	pkrPot,
	pkrWinners,
	pkrWinnerID,
};

enum ShopItem
{
	sItemPrice,
	//sSold,
	//sMade,
}

enum vehProp
{
	vCarVestKit,
	vCarWindow0,
	vCarWindow1,
	vCarWindow2,
	vCarWindow3,
	vCarWindows,
	vLastDriver[MAX_PLAYER_NAME]
}

enum lockerWeapons
{
	lwGroup,
	lwWep[46],
	lwRank[16]
}

enum crateOrders
{
	coGroup,
	coFacility,
	coCrates,
	coPerCrate,
	coOrderBy[MAX_PLAYER_NAME],
	coDelivered,
	coStatus,
	coTime
}

enum crateInfo
{
	cbObject,
	Text3D: cbTextID,
	cbFacility,
	cbGroup,
	Float:cbPos[3],
	cbInVeh,
	cbOnVeh,
	cbInt,
	cbVw,
	cbWep[16],
	cbWepAmount[16],
	cbMats,
	cbPlacedBy[MAX_PLAYER_NAME],
	cbLifespan,
	cbTransfer,
	cbDoor,
	cbDoorType,
	cbPrice,
	cbPaid,
	cbActive
}

enum crateFacInfo
{
	Text3D: cfTextID,
	cfPickupID,
	cfMapIcon,
	cfId,
	cfName[32],
	cfGroup,
	Float: cfPos[4],
	cfInt,
	cfVw,
	cfProdMax,
	cfProdPrep,
	cfProdReady,
	cfProdTimer,
	cfProdStatus,
	cfProdCost,
	cfProdMulti,
	cfRaidTimer,
	cfCooldown,
	cfRaidable,
	cfActive,
	cfTimer
}

enum CrateVehInfo {
	cvSpawnID,
	cvId,
	cvModel,
	cvColor[2],
	cvGroupID,
	cvRank,
	cvSpawned,
	cvDisabled,
	cvImpound,
	cvTickets,
	Float:cvMaxHealth,
	Float:cvHealth,
	Float:cvFuel,
	cvType,
	Float:cvPos[4],
	cvInt,
	cvVw,
	cvCrateMax,
	cvForkObject,
	cvCrate,
	cvCrateLoad
}

enum Auction
{
    BiddingFor[64],
	InProgress,
	Bid,
	Bidder,
	Expires,
	Wining[MAX_PLAYER_NAME],
	Increment,
	Timer,
}

enum Barrel
{
	Float:sX,
	Float:sY,
	Float:sZ,
	sObjectID,
	sDeployedBy[MAX_PLAYER_NAME],
	sDeployedByStatus,
	sDeployedAt[MAX_ZONE_NAME]
}

enum Barricade
{
	Float:sX,
	Float:sY,
	Float:sZ,
	sObjectID,
	sObject,
	sDeployedBy[MAX_PLAYER_NAME],
	sDeployedByStatus,
	sDeployedAt[MAX_ZONE_NAME]
}

enum Flare
{
	Float:sX,
	Float:sY,
	Float:sZ,
	sObjectID,
	sDeployedBy[MAX_PLAYER_NAME],
	sDeployedByStatus,
	sDeployedAt[MAX_ZONE_NAME]
}

enum Cone
{
	Float:sX,
	Float:sY,
	Float:sZ,
	sObjectID,
	sDeployedBy[MAX_PLAYER_NAME],
	sDeployedByStatus,
	sDeployedAt[MAX_ZONE_NAME]
}

enum Spikes
{
	Float:sX,
	Float:sY,
	Float:sZ,
	sObjectID,
	sPickupID,
	sDeployedBy[MAX_PLAYER_NAME],
	sDeployedByStatus,
	sDeployedAt[MAX_ZONE_NAME]
}

enum Ladder
{
	Float:sX,
	Float:sY,
	Float:sZ,
	sObjectID,
	sPickupID,
	sDeployedBy[MAX_PLAYER_NAME],
	sDeployedByStatus,
	sDeployedAt[MAX_ZONE_NAME]
}

enum Sign
{
	Float:sX,
	Float:sY,
	Float:sZ,
	sObjectID,
	sObject,
	sDeployedBy[MAX_PLAYER_NAME],
	sDeployedByStatus,
	sDeployedAt[MAX_ZONE_NAME]
}

enum Tape
{
    Float:sX,
	Float:sY,
	Float:sZ,
	sObjectID,
	sDeployedBy[MAX_PLAYER_NAME],
	sDeployedByStatus,
	sDeployedAt[MAX_ZONE_NAME],
  iDeployedByGroup
}

enum Plant
{
	 pOwner,
	 pObject,
	 pPlantType,
	Float: pPos[3],
	 pVirtual,
	 pInterior,
	 pGrowth,
	 pExpires,
	pDrugsSkill,
	pObjectSpawned,
}

enum BusinessSale
{
	bID,
	bBusinessID,
	 bText[128],
	 bPrice,
	 bAvailable,
	 bPurchased,
	 bType,
}

enum SAZONE_MAIN { //Betamaster
	SAZONE_NAME[28],
	Float:SAZONE_AREA[6]
};

enum MAIN_ZONES { //Betamaster
	SAZONE_NAME[28],
	Float:SAZONE_AREA[6]
};

enum callinfo
{
	HasBeenUsed,
	Area[28],
	MainZone[28],
	Description[128],
	CallFrom,
	RespondingID,
	Type,
 	TimeToExpire,
	BeingUsed,
	CallExpireTimer,
	ReplyTimerr,
	CallVehicleId,
	c_iGroupID,
	c_iBusinessID
}

enum reportinfo
{
	HasBeenUsed,
	Report[128],
	ReportFrom,
	CheckingReport,
 	TimeToExpire,
	BeingUsed,
	ReportExpireTimer,
	ReplyTimerr,
	ReportPriority,
	ReportLevel
}

enum pBoxingStats
{
	TitelName[128],
	TitelWins,
	TitelLoses,
};

enum EventKernelEnum
{
	EventAdvisor,
	EventStatus,
	EventType,
	EventInfo[128],
	Float: EventHealth,
	Float: EventArmor,
	Float: EventPositionX,
	Float: EventPositionY,
	Float: EventPositionZ,
	EventInterior,
	EventWorld,
	EventWeapons[5],
	EventTeamColor[2],
    EventTeamSkin[2],
    EventLimit,
    EventTime,
	EventFootRace,
    EventPlayers,
    EventRequest,
    EventStartRequest,
    EventCreator,
    EventStaff[5],
    EventJoinStaff,
	EventCustomInterior,
    VipOnly,
    Float: EventTeamPosX1,
    Float: EventTeamPosY1,
    Float: EventTeamPosZ1,
    Float: EventTeamPosX2,
    Float: EventTeamPosY2,
    Float: EventTeamPosZ2
}

enum PaintBallArenaEnum
{
	pbSQLId,
	pbArenaName[64],
	pbOwner[MAX_PLAYER_NAME],
	pbPassword[64],
	pbActive,
	pbExploitPerm,
	pbFlagInstagib,
	pbFlagNoWeapons,
	pbTimeLeft,
	pbGameType,
	pbLocked,
	pbLimit,
	pbPlayers,
	pbTeamRedKills,
	pbTeamRedDeaths,
	pbTeamRedScores,
	pbTeamBlueKills,
	pbTeamBlueDeaths,
	pbTeamBlueScores,
	pbTeamRed,
	pbTeamBlue,
	Float:pbHillX,
	Float:pbHillY,
	Float:pbHillZ,
	Float:pbHillRadius,
	Text3D:pbHillTextID,
	pbWorldBonds[3],
	pbBidMoney,
	pbMoneyPool,
	pbWeapons[3],
	pbVirtual,
	pbInterior,
	pbFlagRedActive,
	pbFlagBlueActive,
	pbFlagRedActiveTime,
	pbFlagBlueActiveTime,
	Text3D:pbTeamRedTextID,
	Text3D:pbTeamBlueTextID,
	Text3D:pbFlagRedTextID,
	Text3D:pbFlagBlueTextID,
	pbFlagRedID,
	pbFlagBlueID,
	Float: pbHealth,
	Float: pbArmor,
	Float: pbFlagRedSpawn[3],
	Float: pbFlagBlueSpawn[3],
	Float: pbFlagRedPos[3],
	Float: pbFlagBluePos[3],
	Float: pbDeathmatch1[4],
	Float: pbDeathmatch2[4],
	Float: pbDeathmatch3[4],
	Float: pbDeathmatch4[4],
	Float: pbTeamRed1[4],
	Float: pbTeamRed2[4],
	Float: pbTeamRed3[4],
	Float: pbTeamBlue1[4],
	Float: pbTeamBlue2[4],
	Float: pbTeamBlue3[4],
	pbWar,
	pbVeh1Model,
	pbVeh1ID,
	Float: pbVeh1X,
	Float: pbVeh1Y,
	Float: pbVeh1Z,
	Float: pbVeh1A,
	pbVeh2Model,
	pbVeh2ID,
	Float: pbVeh2X,
	Float: pbVeh2Y,
	Float: pbVeh2Z,
	Float: pbVeh2A,
	pbVeh3Model,
	pbVeh3ID,
	Float: pbVeh3X,
	Float: pbVeh3Y,
	Float: pbVeh3Z,
	Float: pbVeh3A,
	pbVeh4Model,
	pbVeh4ID,
	Float: pbVeh4X,
	Float: pbVeh4Y,
	Float: pbVeh4Z,
	Float: pbVeh4A,
	pbVeh5Model,
	pbVeh5ID,
	Float: pbVeh5X,
	Float: pbVeh5Y,
	Float: pbVeh5Z,
	Float: pbVeh5A,
	pbVeh6Model,
	pbVeh6ID,
	Float: pbVeh6X,
	Float: pbVeh6Y,
	Float: pbVeh6Z,
	Float: pbVeh6A
};

enum TurfWarsEnum
{
	twName[64],
	twOwnerId,
	twLocked,
	twSpecial,
	twVulnerable,
	twAttemptId,
	twTimeLeft,
	twGangZoneId,
	twAreaId,
	twActive,
	twFlash,
	twFlashColor,
	Float: twMinX,
	Float: twMinY,
	Float: twMaxX,
	Float: twMaxY,
};

enum pFishing
{
	pFish1[20],
	pFish2[20],
	pFish3[20],
	pFish4[20],
	pFish5[20],
	pWeight1,
	pWeight2,
	pWeight3,
	pWeight4,
	pWeight5,
	pFid1,
	pFid2,
	pFid3,
	pFid4,
	pFid5,
	pLastFish,
	pFishID,
	pLastWeight,
};

enum hNews
{
	hTaken1,
	hTaken2,
	hTaken3,
	hTaken4,
	hTaken5,
	hTaken6,
	hTaken7,
	hTaken8,
	hTaken9,
	hTaken10,
	hTaken11,
	hTaken12,
	hTaken13,
	hTaken14,
	hTaken15,
	hTaken16,
	hTaken17,
	hTaken18,
	hTaken19,
	hTaken20,
	hTaken21,
	hAdd1[64],
	hAdd2[64],
	hAdd3[64],
	hAdd4[64],
	hAdd5[64],
	hAdd6[64],
	hAdd7[64],
	hAdd8[64],
	hAdd9[64],
	hAdd10[64],
	hAdd11[64],
	hAdd12[64],
	hAdd13[64],
	hAdd14[64],
	hAdd15[64],
	hAdd16[64],
	hAdd17[64],
	hAdd18[64],
	hAdd19[64],
	hAdd20[64],
	hAdd21[64],
	hContact1[64],
	hContact2[64],
	hContact3[64],
	hContact4[64],
	hContact5[64],
	hContact6[64],
	hContact7[64],
	hContact8[64],
	hContact9[64],
	hContact10[64],
	hContact11[64],
	hContact12[64],
	hContact13[64],
	hContact14[64],
	hContact15[64],
	hContact16[64],
	hContact17[64],
	hContact18[64],
	hContact19[64],
	hContact20[64],
	hContact21[64],
};

enum sInfo
{
	sStorage,
	sAttached,
	sCash,
	sPot,
	sCrack,
	sMats,
	sHouseID,
	sVehicleSlot
};

enum pInfo
{
	pId,
	pAdminName[MAX_PLAYER_NAME],
	pUsername[MAX_PLAYER_NAME],
	pOnline,
	pLevel,
	pAdmin,
	pAdminLevel,
	pDonateRank,
	gPupgrade,
	pConnectHours,
	pReg,
	pSex,
	pBirthDate[11],
	pOrigin,
	pCash,
	pHospital,
	pMuted,
	pPrisonReason[128],
	pPrisonedBy[MAX_PLAYER_NAME],
	pRMuted,
	pRMutedTotal,
	pRMutedTime,
	pDMRMuted,
	pVMuted,
	pVMutedTime,
	pExp,
	pAccount,
	pCrimes,
	pPaintTeam,
	pKills,
	pDeaths,
	pArrested,
	pPhoneBook,
	pLottoNr,
	pFishes,
	pBiggestFish,
	pJob,
	pAutoTextReply[64],
	pPhonePrivacy,
	pJob2,
	pJob3,
	p911Muted,
	pNMute,
	pNMuteTotal,
	pADMute,
	pADMuteTotal,
	pHelpMute,
	pPayCheck,
	pHeadValue,
	pJailTime,
	pWRestricted,
	pMats,
	pNation,
	pSlotHolder,
	pLeader,
	pMember,
	pDivision,
	pBadge[9],
	pSpeakerPhone,
	pRank,
	pDetSkill,
	pSexSkill,
	pBoxSkill,
	pLawSkill,
	pMechSkill,
	pTruckSkill,
	pWantedLevel,
	// pCannabis,
	// pCrack,
	pHelper,
	pFitness,
	pArmsSkill,
	pDrugSmuggler,
	pFishSkill,
	Float:pHealth,
	Float:pArmor,
	Float:pSHealth,
	pInt,
	pBanAppealer,
	pPR,
	pHR,
	pAP,
	pSecurity,
	pShopTech,
	pFactionModerator,
	pGangModerator,
	pUndercover,
	pTogReports,
	pModel,
	pPnumber,
	pPhousekey,
	pPhousekey2,
	pPhousekey3,
	Float:pPos_x,
	Float:pPos_y,
	Float:pPos_z,
	Float:pPos_r,
	pCarLic,
	pSpeedo,
	pFlyLic,
	pBoatLic,
	pFishLic,
	pGunLic,
	pGuns[12],
	pAGuns[12],
	pConnectSeconds,
	pPayDayHad,
	pCDPlayer,
	pWins,
	pLoses,
	pTut,
	pWarns,
	pC4,
	pC4Get,
	pC4Used,
	pMarriedID,
	pMarriedName[MAX_PLAYER_NAME],
	pLock,
	pLockCar,
	pSprunk,
	pCigar,
	pPole,
	pSpraycan,
	pRope,
	pRags,
	pDice,
	pBombs,
	pDuty,
	pFightStyle,
	pEmail[128],
	pIP[16],
	pSecureIP[16],
	pBanned,
	pPermaBanned,
	pDisabled,
	pStaffBanned,
	pAccent,
	pCHits,
	pFHits,
	pCrates,
	pVW,
	pRenting,
	pTempVIP,
	pBuddyInvited,
	pVIPInviteDay,
	pTokens,
	pPaintTokens,
	pDrugsTime,
	pLawyerTime,
	pGangWarn,
	pCSFBanned,
	pMechTime,
	pSexTime,
	pLawyerFreeTime,
	pGiftTime,
	pContractBy[MAX_PLAYERS],
	pContractDetail[64],
	pRadio,
	pRadioFreq,
	pDutyHours,
	pAcceptedHelp,
	pAcceptReport,
	pShopTechOrders,
	pTrashReport,
	pInsurance,
	pTriageTime,
	pVehicleKeys,
	pVehicleKeysFrom,
	pTaxiLicense,
	pTicketTime,
	pScrewdriver,
	pWristwatch,
	pWristwatchState,
	pSurveillance,
	pSmslog,
	pTire,
	pFirstaid,
	pRccam,
	pReceiver,
	pGPS,
	pGPSState,
	pSweep,
	pSweepLeft,
	pBugged,
	pCheckCash,
	pChecks,
	pWeedObject,
	pWSeeds,
	pWarrant[128],
	pJudgeJailTime,
	pJudgeJailType,
	pBeingSentenced,
	pProbationTime,
	pDMKills,
	pOrder,
	pOrderConfirmed,
	pCallsAccepted,
	pPatientsDelivered,
	pLiveBanned,
	pFreezeBank,
	pFreezeHouse,
	pFreezeCar,
	pServiceTime,
	pFirework,
	pBoombox,
	pHydration,
	pRacePlayerLaps,
	pDoubleEXP,
	pEXPToken,
	pRingtone,
	pVIPM,
	pVIPMO,
	pVIPExpire,
	pHitman,
	pHitmanLeader,
	pHitmanBlacklisted,
	pBlacklistReason[64],
	pGVip,
	pSMod,
	pWatchdog,
	pPSFCannabis,
	pPSFCrack,
	pPSFMats,
	pVIPSold,
	pGoldBoxTokens,
	Float: pRewardHours,
	pRewardDrawChance,
	pRVehRestricted,
	pRVehWarns,
	pLastRVehWarn,
	pFlagged,
	pPaper,
	pMailEnabled,
	pMailbox,
	pBusiness,
	pBusinessRank,
	pTreasureSkill,
	pMetalDetector,
	pHelpedBefore,
	pTrickortreat, // REUSED FOR ST PATRICK'S DAY LUCKY CHARMS AS PER JOHN
	pLastCharmReceived,
	pRHMutes,
	pRHMuteTime,
	pGiftCode,
	pTable,
	pOpiumSeeds,
	pRawOpium,
	pHeroin,
	pSyringes,
	pSkins,
	pForcePasswordChange,
	pCredits,
	pHealthCare,
	pTotalCredits,
	pReceivedCredits,
	pRimMod,
	pHasTazer,
	pHasCuff,
	pCarVoucher,
	pReferredBy[MAX_PLAYER_NAME],
	pPendingRefReward,
	pRefers,
	pFamed,
	pFMuted,
	pDefendTime,
	pPVIPVoucher,
	pVehicleSlot,
	pToySlot,
	pRFLTeam,
	pRFLTeamL,
	pVehVoucher,
	pSVIPVoucher,
	pGVIPVoucher,
	pGiftVoucher,
	pFallIntoFun,
	pHungerVoucher,
	pBoughtCure,
	pVials,
	pAdvertVoucher,
	pShopCounter,
	pShopNotice,
	pSVIPExVoucher,
	pGVIPExVoucher,
	pVIPSellable,
	pReceivedPrize,
	pVIPSpawn,
	pFreeAdsDay,
	pFreeAdsLeft,
	pBuddyInvites,
	pReceivedBGift,
	pLastBirthday,
	pVIPJob,
	pNonRPMeter,
	pAccountRestricted,
	pWatchlist,
	pWatchlistTime,
	pBackpack, // 0 = no bckpk 1 = small 2 = med 3 = large
	pBEquipped,
	pBItems[12], // 0 = food 5 = medkit 6 = gun1 7 = gun2 8 = gun3 9 = gun4 10 = gun5 11 = Energy Bars
	pBDrugs[sizeof(Drugs)],
	pBStoredH,
	pBStoredV,
	pBugReportTimeout,
	pDigCooldown,
	pToolBox,
	pCrowBar,
	pCarLockPickSkill,
	pLockPickVehCount,
	pLockPickTime,
	pSEC,
	pBM,
	pASM,
	pIsolated,
	pWantedJailTime,
	pWantedJailFine,
	pNextNameChange,
	pExamineDesc[128],
	pFavStation[255],
	pDedicatedPlayer,
	pDedicatedEnabled,
	pDedicatedMuted,
	pDedicatedWarn,
	pHolsteredWeapon,
	mInventory[MAX_MICROITEMS],
	mPurchaseCount[MAX_MICROITEMS],
	mCooldown[MAX_MICROITEMS],
	mBoost[2], // Job | Skill
	mShopCounter,
	mNotice,
	zFuelCan,
	bTicket,
	pJailedInfo[5], // 0 id - 1 fine - 2 time - 3 warn - 4 wep restriction
	pJailedWeapons[12],
	pVIPMod,
	pLastPass[65],
	pEventTokens,
	pVIPGuncount,
	pBailPrice,
	pWallpaper,
	pPhoneColor,
	/*p_iDrug[sizeof(Drugs)],
	p_iDrugQuality[sizeof(Drugs)],
	p_iDrugTaken[sizeof(Drugs)],
	p_iAddicted[sizeof(Drugs)],
	p_iAddictedLevel[sizeof(Drugs)],
	p_iIngredient[sizeof(szIngredients)],*/ // see ya
	pDrugs[sizeof(Drugs)],
	pToggledChats[MAX_CHATSETS], // see AccountSettings.pwn for coressponding chat IDs.
	pChatbox[MAX_CHATSETS], // see AccountSettings.pwn for coressponding chat IDs.
	Float:pGroupToy[9],
	pGroupToyBone,
	pFurnitureSlots,
	pHouseBuilder,
	pPrisonCredits,
	pPrisonMaterials,
	pPrisonWineTime,
	pPrisonCell,
	p_iPrisonDrug[sizeof(Drugs)],
	pFishWeight,
	pFishingSkill,
	pGarbageSkill,
	pLastPoll,
	pSmugSkill,
	pProAimFlags,
	pPollKey1[128],
	pPollKey2[128],
	pPollKey3[128],
	pUsingTruck,
	pShipmentOptions[10],
	pCurrentShipment,
	pDedicatedHours,
	pDedicatedDaymarker[11],
	pDedicatedTimestamp[11],
	pWalkStyle,
	pTurfShow,
	pFlagCredits,
	pFlagClaimed,
	pHorse,
	//added by N0FeaR
	pDealerGang,
	pAdminCount,
	GHName[MAX_PLAYER_NAME],
	StaffPosition,
	AdvisorPosition,
	AdmPromBy[180],
	AdmPromDate[180],
	BannedBy[180],
	BannedReason[300],
	HLMadeBy[180],
	HLMadeDate[180],
	HLPromBy[180],
	HLPromDate[180],
	AdmBanCount,
	KickCount,
	pAnimUse,
	pFurnID,
    Float:pFurn[4],
    Float:pFurnR[4]
};

enum pvInfo
{
	pvSlotId,
    Float:pvPosX,
	Float:pvPosY,
	Float:pvPosZ,
 	Float:pvPosAngle,
	pvId,
	pvModelId,
	pvLock,
	pvLocked,
	pvPaintJob,
	pvColor1,
	pvColor2,
	pvMods[MAX_MODS],
	pvAllowedPlayerId,
	pvPark,
	//pvNumberPlate[32], // sz
	pvPrice,
	pvTicket,
	pvWeapons[3],
	pvWepUpgrade,
	pvImpounded,
	pvSpawned,
	pvDisabled,
	pvPlate[32],
	pvRestricted,
	Float: pvFuel,
	Float: pvHealth,
	pvVW,
	pvInt,
	pvCrashFlag,
	pvCrashVW,
	Float:pvCrashX,
	Float:pvCrashY,
	Float:pvCrashZ,
	Float:pvCrashAngle,
	pvAlarm,
	pvAlarmTriggered,
	pvBeingPickLocked,
	pvBeingPickLockedBy,
	pvLastLockPickedBy[MAX_PLAYER_NAME],
	pvLocksLeft,
	pvDrugs[sizeof(Drugs)]
};

enum ptInfo
{
	ptID,
    ptModelID,
	ptBone,
	ptTradable,
	ptSpecial,
	ptAutoAttach,
    Float:ptPosX,
	Float:ptPosY,
	Float:ptPosZ,
	Float:ptRotX,
	Float:ptRotY,
	Float:ptRotZ,
	Float:ptScaleX,
	Float:ptScaleY,
	Float:ptScaleZ,
};

enum hInfo
{
	hSQLId,
	hOwned,
	hLevel,
	hCustomInterior,
	hDescription[16],
	hOwnerID,
	hOwnerName[MAX_PLAYER_NAME],
	Float: hExteriorX,
	Float: hExteriorY,
	Float: hExteriorZ,
	Float: hExteriorR,
	Float: hExteriorA,
	Float: hInteriorX,
	Float: hInteriorY,
	Float: hInteriorZ,
	Float: hInteriorR,
	Float: hInteriorA,
	hExtIW,
	hExtVW,
	hIntIW,
	hIntVW,
	hLock,
	hRentable,
	hRentFee,
	hValue,
	hSafeMoney,
	hPot,
	hCrack,
	hMaterials,
	hHeroin,
	hMeth,
	hEcstasy,
	hWeapons[5],
	hGLUpgrade,
	hPickupID,
	hPickupID_int,
	Text3D: hTextID,
	Text3D:hTextID_int,
	hCustomExterior,
	Float: hMailX,
	Float: hMailY,
	Float: hMailZ,
	Float: hMailA,
	hMailType,
	hMailObjectId,
	Text3D: hMailTextID,
	Float: hClosetX,
	Float: hClosetY,
	Float: hClosetZ,
	Text3D: hClosetTextID,
	hSignDesc[64],
	Float:hSign[4],
	hSignExpire,
	hSignObj,
	Text3D:hSignText,
	hLastLogin,
	hExpire,
	hInactive,
	hIgnore,
	hCounter,
	Listed,
	ListingPrice,
	LinkedDoor[5],
	PendingApproval,
	ListedTimeStamp,
	ListingDescription[128],
	LinkedGarage[2],
	hAreaID[2],
	h_iLights,
	hFurniture[MAX_FURNITURE_SLOTS],
	hFurnitureLoaded,
	hMapIcon,
	hExists
};

enum dmpInfo
{
	dmpSQLId,
	dmpMapIconID,
	Float: dmpPosX,
	Float: dmpPosY,
	Float: dmpPosZ,
	dmpMarkerType,
	dmpColor,
	dmpVW,
	dmpInt,
}

enum ddInfo
{
	ddSQLId,
	ddDescription[128],
	ddOwner,
	ddOwnerName[42],
	ddPickupID,
	ddPickupID_int,
	ddAreaID,
	ddAreaID_int,
	Text3D: ddTextID,
	ddCustomInterior,
	ddExteriorVW,
	ddExteriorInt,
	ddInteriorVW,
	ddInteriorInt,
	Float: ddExteriorX,
	Float: ddExteriorY,
	Float: ddExteriorZ,
	Float: ddExteriorA,
	Float: ddInteriorX,
	Float: ddInteriorY,
	Float: ddInteriorZ,
	Float: ddInteriorA,
	ddCustomExterior,
	ddType,
	ddRank,
	ddVIP,
	ddFamed,
	ddDPC,
	ddAllegiance,
	ddGroupType,
	ddFaction,
	ddAdmin,
	ddWanted,
	ddVehicleAble,
	ddColor,
	ddPickupModel,
	ddPass[24],
	ddLocked,
	ddLastLogin,
	ddExpire,
	ddInactive,
	ddIgnore,
	ddCounter,
	dMapIcon,
	dMIcon
};

enum gInfo
{
    gGATE,
    gHID,
	Float: gSpeed,
	Float: gRange,
	gModel,
	gVW,
	gInt,
	Float:gPosX,
	Float:gPosY,
	Float:gPosZ,
	Float:gRotX,
	Float:gRotY,
	Float:gRotZ,
	Float:gPosXM,
	Float:gPosYM,
	Float:gPosZM,
	Float:gRotXM,
	Float:gRotYM,
    Float:gRotZM,
    gStatus,
    gPass[24],
	gAllegiance,
	gGroupType,
	gGroupID,
    gRenderHQ,
	gTimer,
	gAutomate,
	gLocked,
	gTIndex,
	gTModel,
	gTTXD[64],
	gTTexture[64],
	gTColor,
	gFacility
};

enum ePoints
{
	epObjectID,
	Text3D: epText3dID,
	Float:epPosX,
	Float:epPosY,
	Float:epPosZ,
	epVW,
	epInt,
	epPrize[64],
	epFlagable,
};

/*enum cmdInfo
{
    id,
	name[255],
	params[255],
	description[255],
	type,
	subtype,
	perms
};*/

/*enum pCrime
{
	pBplayer[32],
	pAccusing[32],
	pAccusedof[32],
	pVictim[32],
};*/

enum _scInfoEnum
{
	_scDatabase,            // database ID
	bool:_scActive,         // whether or not the speed camera array pos is in use
	Float:_scPosX,          // x position of speedcam
	Float:_scPosY,          // y position of speedcam
	Float:_scPosZ,          // z position of speedcam
	Text3D: _scTextID,
	Float:_scRotation,      // rotation of speedcam
	Float:_scRange,         // range that the speedcam will capture at
	Float:_scLimit,         // speed limit that will trigger the speedcam capture callback
	_scObjectId,            // self-explanatory
};

enum mbInfo
{
	mbVW,
	mbInt,
	mbModel,
	Float: mbPosX,
	Float: mbPosY,
	Float: mbPosZ,
	Float: mbAngle,
	mbObjectId,
	Text3D: mbTextId
}

enum tlInfo
{
	tlSQLId,
	tlText[128],
	tlPickupID,
	Text3D: tlTextID,
	Float: tlPosX,
	Float: tlPosY,
	Float: tlPosZ,
	tlVW,
	tlInt,
	tlColor,
	tlPickupModel
}

enum pnsInfo
{
	pnsSQLId,
	pnsStatus,
	Float: pnsPosX,
	Float: pnsPosY,
	Float: pnsPosZ,
	pnsVW,
	pnsInt,
	pnsPickupID,
	Text3D: pnsTextID,
	pnsMapIconID,
	pnsGroupCost,
	pnsRegCost
}

enum arrestInfo
{
	arrestSQLId,
	arrestType,
	Float: arrestPosX,
	Float: arrestPosY,
	Float: arrestPosZ,
	arrestVW,
	arrestInt,
	Float: JailPos1[3],
	Float: JailPos2[3],
	jailVW,
	jailInt,
	Text3D: arrestTextID,
	arrestPickupID
}

enum eJailBoxing {
	bool:bInProgress = false,
	iParticipants,
	iDocBoxingCountdown = 4,
	iDocCountDownTimer
}

enum impoundInfo
{
	impoundSQLId,
	Float: impoundPosX,
	Float: impoundPosY,
	Float: impoundPosZ,
	impoundVW,
	impoundInt,
	Text3D: impoundTextID,
	impoundicon
}

enum HoldingEnumAll
{
	holdingmodelid,
	holdingprice,
	holdingmodelname[24]
}

enum HoldingEnum
{
	holdingmodelid,
	holdingprice,
	holdingmodelname[24]
}

enum AC_STRUCT_INFO {
	Float:LastOnFootPosition[3],
	checkmaptp,
	maptplastclick,
	Float:maptp[3]
}

enum mdcInfo
{
	mdcCrime[64],
	mdcIssuer[24],
	mdcActive,
}

// Relay For Life
enum rflinfo
{
	RFLsqlid,
	RFLused,
	RFLname[25],
	RFLmembers,
	RFLleader[MAX_PLAYER_NAME],
	RFLlaps
}

// Hunger Games
enum HUNGER_PLAYER_INFO
{
	hgInEvent,
	Float: hgLastPosition[3],
	Float: hgLastHealth,
	Float: hgLastArmour,
	hgLastVW,
	hgLastInt,
	hgLastWeapon[12],
	hgVoucher,
	PlayerText: hgPlayerText,
	PlayerText: hgLoadingText,
	PlayerText: hgTimeLeftText,
	PlayerText: hgCreditsText
}

enum HUNGER_BACKPACK_INFO
{
	hgBackpackId,
	hgBackpackPickupId,
	Text3D: hgBackpack3DText,
	hgBackpackType,
	Float: hgBackpackPos[3],
	hgActiveEx
}

/*enum GANG_TAG_INFO
{
	gt_SQLID,
	gt_Object,
	Float:gt_PosX,
	Float:gt_PosY,
	Float:gt_PosZ,
	Float:gt_PosRX,
	Float:gt_PosRY,
	Float:gt_PosRZ,
	gt_VW,
	gt_Int,
	gt_ObjectID,
	gt_Used,
	gt_Family,
	gt_Time,
	gt_TimeLeft,
	gt_Timer
}*/

enum FIREWORK_INFO
{
	fireworkId,
	Float: fireworkPos[3]
}

/* Dynamic Gift Box Stuff
Note: dgGVIP = 7 Days | dgGVIPEx = 1 Month
Example:
	dgVar[dgMoney][0] = Is it enabled?
	dgVar[dgMoney][1] = Quantity of gift available
	dgVar[dgMoney][2] = Quantity of money the player will receive
	dgVar[dgMoney][3] = Rarity Category of Item (Common, Less Common, Rare, Super Rare)
*/
enum dgItems
{
	dgMoney,
	dgRimKit,
	dgFirework,
	dgGVIP,
	dgGVIPEx,
	dgSVIP,
	dgSVIPEx,
	dgCarSlot,
	dgToySlot,
	dgArmor,
	dgFirstaid,
	dgDDFlag,
	dgGateFlag,
	dgCredits,
	dgPriorityAd,
	dgHealthNArmor,
	dgGiftReset,
	dgMaterial,
	dgWarning,
	dgPot,
	dgCrack,
	dgPaintballToken,
	dgVIPToken,
	dgRespectPoint,
	dgCarVoucher,
	dgBuddyInvite,
	dgLaser,
	dgCustomToy,
	dgAdmuteReset,
	dgNewbieMuteReset,
	dgRestrictedCarVoucher,
	dgPlatinumVIPVoucher
};

enum PollData
{
	PollID,
	PollQuestion[255],
	PollVotes[MAX_POLLS_CHOICES],
	LastReset
}

enum garInfo
{
	gar_SQLId,
	gar_Owner,
	gar_OwnerName[24],
	Float: gar_ExteriorX,
	Float: gar_ExteriorY,
	Float: gar_ExteriorZ,
	Float: gar_ExteriorA,
	gar_ExteriorVW,
	gar_ExteriorInt,
	gar_CustomExterior,
	Float: gar_InteriorX,
	Float: gar_InteriorY,
	Float: gar_InteriorZ,
	Float: gar_InteriorA,
	gar_InteriorVW,
	gar_Pass[24],
	gar_Locked,
	Text3D: gar_TextID,
	gar_AreaID,
	gar_AreaID_int,
	gar_PickupID,
};

enum eHospitalBedData {
	bool:bBedOccupied[MAX_HOSPITALBEDS],
	iCountDown[MAX_HOSPITALBEDS],
	iTimer[MAX_HOSPITALBEDS]
}

enum FallIntoFun
{
	FIFHours,
	FIFChances
}

enum ParkingMeterInfo
{
	MeterActive,
	MeterRate,
	Float:MeterRange,
	Float:MeterPosition[6],
	Float:ParkedPosition[4],
	ParkingMeterObject,
	Text3D:ParkingMeterText,
	AssignedVehicle,
	PaymentExpiry,
};

new EditingMeterID[MAX_PLAYERS];
new ParkingMeterInformation[MAX_PARKING_METERS][ParkingMeterInfo];


enum eGangTags {
	gt_iObjectID,
	Text3D:gt_iTextID
}
new arrGangTags[MAX_GANGTAGS][eGangTags];

enum e_JobData {
	Text3D: jTextID,
	jPickupID,
	jMapMarker,
	jMarkerID,
	jId,
	jType,
	Float:jPos[3],
	jVw,
	jInt,
	jLevel,
	jAreaID
}
new JobData[MAX_JOBPOINTS][e_JobData];

enum e_FireData {
	Float:fire_fPos[3],
	fire_iObjectID,
	fire_iTypeID,
	fire_iAreaID,
	iServerFires,
	fire_iTextID[32],
	fire_iHealth
}
new arrFires[MAX_FIRES][e_FireData];
/*
enum e_FireData {
	Float: fPos[3],
	fObjectID,
	fAreaID,
	Text3D: fTextID,
	fHealth,
	fTypeID
}
new FireData[MAX_FIRES][e_FireData];
*/

/*enum e_JobVehData {
	jveh_iTypeID,
	jveh_iVehID
}
new JobVehData[MAX_JOB_VEHICLES][e_JobVehData];
*/


/*enum eBlackMarket {
	bm_iGroupID,
	bm_iSeized,
	bm_iPickupID,
	bm_iAreaID,
	Float:bm_fPos[3],
	Text3D:bm_iTextID,
	Text3D:bm_iDelTextID,
	bm_iIngredientAmount[sizeof(szIngredients)],
	bm_iIngredientPrice[sizeof(szIngredients)],
	bm_iIngredientSmugglePay[sizeof(szIngredients)]
}
new arrBlackMarket[MAX_GROUPS][eBlackMarket];*/

enum e_PayPhoneData {
	pp_iNumber,
	pp_iCallerID,
	pp_iObjectID,
	pp_iAreaID,
	Text3D:pp_iTextID
}
new arrPayPhoneData[MAX_PAYPHONES][e_PayPhoneData];

/*enum eDynPoints {
	po_iType,
	po_szPointName[MAX_PLAYER_NAME],
	Float:po_fPos[3],
	po_iCapturable,
	po_iGroupID,
	po_iPickupID,
	po_iZoneID,
	po_iAreaID,
	po_iBigAreaID,
	Text3D:po_iTextID,
	Text3D:po_iDelTextID
}
new arrPoint[MAX_DYNPOINTS][eDynPoints];*/

enum PointData
{
	Text3D: poTextID,
	poID,
	poName[MAX_PLAYER_NAME],
	poType,
	Float:poPos[3],
	Float:poPos2[3],
	Float:CapturePos[3],
	poVW,
	poInt,
	po2VW,
	po2Int,
	poBoat,
	poCaptureName[MAX_PLAYER_NAME],
	poCaptureGroup,
	poCapperGroup, // Group ID of the capture
	poCapping, // Player ID of the capture
	poCapturable,
	poTimer,
	poAmountHour, // Used for the hourly rate for gangs
	poAmount[5], // Used for the Player VIP rank
	poLocked,
	poPickupID,
	poPName[MAX_PLAYER_NAME],
	poTimeLeft,
	poTimeCapLeft,
	CapTimer
}
new DynPoints[MAX_POINTS][PointData];

enum fPoint
{
	pointID,
	pointVW3,
	Float:Pointx,
	Float:Pointy,
	Float:Pointz,
	Type,
	Vulnerable,
	MatPoint,
	CratePoint,
	Announced,
	ClaimerId,
	ClaimerTeam,
	TimeToClaim,
	TimeLeft,
	Owner[32],
	PlayerNameCappings[MAX_PLAYER_NAME],
	CapperName[MAX_PLAYER_NAME],
	Name[32],
	TakeOverTimerStarted,
	TakeOverTimer,
	Text3D:TextLabel,
	CaptureTimerEx2,
	Stock,
	Text3D:CaptureProccess,
	Text3D:CaptureProgress,
	CaptureProccessEx,
	Float: Capturex,
	Float: Capturey,
	Float: Capturez,
	CapTime,
	CapFam,
	CapName[MAX_PLAYER_NAME],
	CapCrash,
	PointPickupID
}


enum eMetDetData {
	metdet_iObjectID,
	metdet_iAreaID,
	Text3D:metdet_iTextID
}
new arrMetalDetector[MAX_METALDETECTORS][eMetDetData];

enum eTurfWars {

	tw_iLinkedID,
	tw_iAreaID,
	tw_iGZoneID,
	tw_iGroupID,
	tw_iHealth,
	tw_iLevel,
	tw_iTraffic,
	tw_iDeaths,
	tw_iRevenue,
	bool:tw_bVulnerable
}
//new arrTurfWars[MAX_TURFS][eTurfWars];


// All player booleans variables go here to reduce memory:
enum PlayerBit:(<<= 1) {

	dr_bitUsedDrug = 1, // keep 1
	dr_bitInDrugEffect,
	phone_bitState,
	phone_bitCamState,
	phone_bitTraceState,
	bitFPS,
	f_bCursor,
	pTurfRadar
};
new PlayerBit:arrPlayerBits[MAX_PLAYERS];

/*enum eTurfWarsBits:(<<= 1) {

	// tw_bVulnerable = 1,
	tw_bDisabled = 1,
	tw_bHeadquarter,
	tw_bShutdown,
	tw_bTurfMode

};
new eTurfWarsBits:arrTurfWarsBits[MAX_TURFS];*/

enum e_AntiCheat {

	ac_iVehID,
	ac_iShots[2],
	Float:ac_fPos[3],
	ac_iSpeed,
	Float:ac_fCamPos[6],
	Float:ac_fCamFVector[6],
	Float:ac_fPlayerAngle[2],
	ac_iLastTargetID,
	ac_fAimAccuracy,
	ac_iFlags[AC_MAX],
	ac_iCommandCount,
	//ac_iPlayerAreaID,
	Float:ac_fProbability,
	ac_iCheatingIndex[2],
	ac_iIsCheating,
	ac_inTrainingMode
}
new arrAntiCheat[MAX_PLAYERS][e_AntiCheat];


enum e_bAntiCheat:(<<= 1) {

	ac_bitValidPlayerHealth = 1, // keep 1
	ac_bitValidPlayerPos,
	ac_bitValidPlayerArmour,
	ac_bitValidSpectating,
	ac_bitDied
};
new e_bAntiCheat:arrPAntiCheat[MAX_PLAYERS];


enum eUfo {
	ufo_iObjectID[13],
	ufo_iPlayerID
}

enum helpInfo
{
	HelpID,
	HelpName[128],
	HelpParam[128],
	HelpDesc[255],
	HelpType,
	HelpSubtype,
	HelpLevel
}
new Help[MAX_HELP_ENTRIES][helpInfo];


enum e_LocationData
{
	e_LocationName[32],
	Float:e_LocationX,
	Float:e_LocationY,
	Float:e_LocationZ
};

new const g_arrLocationData[][e_LocationData] = {

	{"Los Santos", 1529.6, -1691.2, 13.3},
    {"San Fierro", -1605.0, 720.0, 12.0},
	{"Las Venturas", 1699.2, 1435.1, 10.7},
	{"Los Santos VIP Lounge", 1810.39, -1601.15, 13.54},
	{"All Saints General Hospital", 1192.78, -1292.68, 13.38},
	{"County General Hospital", 2000.05, -1409.36, 16.99},
	{"Ganton GYM", 2227.60, -1674.89, 14.62},
	{"Mulholland Bank", 1487.91, -1030.60, 23.66},
	{"Glen Park", 1986.69, -1300.49, 25.03},
	{"Las Colinas", 2155.5400, -1011.4443, 62.9631},
	{"Department of Corrections", 1435.95, -2695.33, 13.59},
	{"IC Prison", 558.1121, 1458.6663, 6000.4712},
	{"Demorgan", 112.67, 1917.55, 18.72},
	{"FBI Headquarters", 1076.1061, -1702.9403, 13.5469},
	{"OOC Prison", -1158.285644, 2894.152343, 9993.131835},
	/*{"Stadium1", -1424.93, -664.59, 1059.86, 4},
	{"Stadium2", -1395.96, -208.20, 1051.28, 7},
	{"Stadium3", -1410.72, 1591.16, 1052.53, 14},
	{"Stadium4", -1394.20, 987.62, 1023.96, 15},
	{"Int1", 1416.107000, 0.268620, 1000.926000},*/
    {"Dillimore", 648.6864, -573.1471, 16.2432},
	{"Palomino", 2231.578613, -48.729660, 26.484375},
	{"Montgomery", 1253.70, 343.73, 19.41},
    {"Los Santos Modshop", 1040.0186, -1032.6984, 31.9714},
    {"San Fierro Modshop", -2709.8462, 218.4532, 4.1797},
    {"San Fierro Airport", -1412.5375, -301.8998, 14.1411}
};

enum e_InteriorData
{
	e_InteriorName[32],
	e_InteriorID,
	Float:e_InteriorX,
	Float:e_InteriorY,
	Float:e_InteriorZ
};

new const g_arrInteriorData[][e_InteriorData] =
{
	{"24/7 1", 17, -25.884498, -185.868988, 1003.546875},
    {"24/7 2", 10, 6.091179, -29.271898, 1003.549438},
    {"24/7 3", 18, -30.946699, -89.609596, 1003.546875},
    {"24/7 4", 16, -25.132598, -139.066986, 1003.546875},
    {"24/7 5", 4, -27.312299, -29.277599, 1003.557250},
    {"24/7 6", 6, -26.691598, -55.714897, 1003.546875},
    {"Airport Ticket", 14, -1827.147338, 7.207417, 1061.143554},
    {"Airport Baggage", 14, -1861.936889, 54.908092, 1061.143554},
    {"Shamal", 1, 1.808619, 32.384357, 1199.593750},
    {"Andromada", 9, 315.745086, 984.969299, 1958.919067},
    {"Ammunation 1", 1, 286.148986, -40.644397, 1001.515625},
    {"Ammunation 2", 4, 286.800994, -82.547599, 1001.515625},
    {"Ammunation 3", 6, 296.919982, -108.071998, 1001.515625},
    {"Ammunation 4", 7, 314.820983, -141.431991, 999.601562},
    {"Ammunation 5", 6, 316.524993, -167.706985, 999.593750},
    {"Ammunation Booths", 7, 302.292877, -143.139099, 1004.062500},
    {"Ammunation Range", 7, 298.507934, -141.647048, 1004.054748},
    {"Blastin Fools Hallway", 3, 1038.531372, 0.111030, 1001.284484},
    {"Budget Inn Motel Room", 12, 444.646911, 508.239044, 1001.419494},
    {"Jefferson Motel", 15, 2215.454833, -1147.475585, 1025.796875},
    {"Off Track Betting Shop", 3, 833.269775, 10.588416, 1004.179687},
    {"Sex Shop", 3, -103.559165, -24.225606, 1000.718750},
    {"Meat Factory", 1, 963.418762, 2108.292480, 1011.030273},
    {"Zero's RC shop", 6, -2240.468505, 137.060440, 1035.414062},
    {"Dillimore Gas", 0, 663.836242, -575.605407, 16.343263},
    {"Catigula's Basement", 1, 2169.461181, 1618.798339, 999.976562},
    {"FC Janitor Room", 10, 1889.953369, 1017.438293, 31.882812},
    {"Woozie's Office", 1, -2159.122802, 641.517517, 1052.381713},
    {"Binco", 15, 207.737991, -109.019996, 1005.132812},
    {"Didier Sachs", 14, 204.332992, -166.694992, 1000.523437},
    {"Prolaps", 3, 207.054992, -138.804992, 1003.507812},
    {"Suburban", 1, 203.777999, -48.492397, 1001.804687},
    {"Victim", 5, 226.293991, -7.431529, 1002.210937},
    {"Zip", 18, 161.391006, -93.159156, 1001.804687},
    {"Club", 17, 493.390991, -22.722799, 1000.679687},
    {"Bar", 11, 501.980987, -69.150199, 998.757812},
    {"Lil' Probe Inn", 18, -227.027999, 1401.229980, 27.765625},
    {"Jay's Diner", 4, 457.304748, -88.428497, 999.554687},
    {"Gant Bridge Diner", 5, 454.973937, -110.104995, 1000.077209},
    {"Secret Valley Diner", 6, 435.271331, -80.958938, 999.554687},
    {"World of Coq", 1, 452.489990, -18.179698, 1001.132812},
    {"Welcome Pump", 1, 681.557861, -455.680053, -25.609874},
    {"Burger Shot", 10, 375.962463, -65.816848, 1001.507812},
    {"Cluckin' Bell", 9, 369.579528, -4.487294, 1001.858886},
    {"Well Stacked Pizza", 5, 373.825653, -117.270904, 1001.499511},
    {"Rusty Browns Donuts", 17, 381.169189, -188.803024, 1000.632812},
    {"Denise's Room", 1, 244.411987, 305.032989, 999.148437},
    {"Katie's Room", 2, 271.884979, 306.631988, 999.148437},
    {"Helena's Room", 3, 291.282989, 310.031982, 999.148437},
    {"Michelle's Room", 4, 302.180999, 300.722991, 999.148437},
    {"Barbara's Room", 5, 322.197998, 302.497985, 999.148437},
    {"Millie's Room", 6, 346.870025, 309.259033, 999.155700},
    {"Sherman Dam", 17, -959.564392, 1848.576782, 9.000000},
    {"Planning Dept", 3, 384.808624, 173.804992, 1008.382812},
    {"Area 51", 0, 223.431976, 1872.400268, 13.734375},
    {"LS Gym", 5, 772.111999, -3.898649, 1000.728820},
    {"SF Gym", 6, 774.213989, -48.924297, 1000.585937},
    {"LV Gym", 7, 773.579956, -77.096694, 1000.655029},
    {"B-Dup's House", 3, 1527.229980, -11.574499, 1002.097106},
    {"B-Dup's Crack Pad", 2, 1523.509887, -47.821197, 1002.130981},
    {"CJ's House", 3, 2496.049804, -1695.238159, 1014.742187},
    {"Madd Doggs Mansion", 5, 1267.663208, -781.323242, 1091.906250},
    {"OG Loc's House", 3, 513.882507, -11.269994, 1001.565307},
    {"Ryders House", 2, 2454.717041, -1700.871582, 1013.515197},
    {"Sweet's House", 1, 2527.654052, -1679.388305, 1015.498596},
    {"Crack Factory", 2, 2543.462646, -1308.379882, 1026.728393},
    {"Big Spread Ranch", 3, 1212.019897, -28.663099, 1000.953125},
    {"Fanny batters", 6, 761.412963, 1440.191650, 1102.703125},
    {"Strip Club", 2, 1204.809936, -11.586799, 1000.921875},
    {"Strip Club (Private Room)", 2, 1204.809936, 13.897239, 1000.921875},
    {"Unnamed Brothel", 3, 942.171997, -16.542755, 1000.929687},
    {"Tiger Skin Brothel", 3, 964.106994, -53.205497, 1001.124572},
    {"Pleasure Domes", 3, -2640.762939, 1406.682006, 906.460937},
    {"Liberty City Outside", 1, -729.276000, 503.086944, 1371.971801},
    {"Liberty City Inside", 1, -794.806396, 497.738037, 1376.195312},
    {"Gang House", 5, 2350.339843, -1181.649902, 1027.976562},
    {"Colonel Furhberger's", 8, 2807.619873, -1171.899902, 1025.570312},
    {"Crack Den", 5, 318.564971, 1118.209960, 1083.882812},
    {"Warehouse 1", 1, 1412.639892, -1.787510, 1000.924377},
    {"Warehouse 2", 18, 1302.519897, -1.787510, 1001.028259},
    {"Sweet's Garage", 0, 2522.000000, -1673.383911, 14.866223},
    {"Lil' Probe Inn Toilet", 18, -221.059051, 1408.984008, 27.773437},
    {"Unused Safe House", 12, 2324.419921, -1145.568359, 1050.710083},
    {"RC Battlefield", 10, -975.975708, 1060.983032, 1345.671875},
    {"Barber 1", 2, 411.625976, -21.433298, 1001.804687},
    {"Barber 2", 3, 418.652984, -82.639793, 1001.804687},
    {"Barber 3", 12, 412.021972, -52.649898, 1001.898437},
    {"Tatoo Parlor 1", 16, -204.439987, -26.453998, 1002.273437},
    {"Tatoo Parlor 2", 17, -204.439987, -8.469599, 1002.273437},
    {"Tatoo Parlor 3", 3, -204.439987, -43.652496, 1002.273437},
    {"LS Police HQ", 6, 246.783996, 63.900199, 1003.640625},
    {"SF Police HQ", 10, 246.375991, 109.245994, 1003.218750},
    {"LV Police HQ", 3, 288.745971, 169.350997, 1007.171875},
    {"Driving School", 3, -2029.798339, -106.675910, 1035.171875},
    {"8-Track", 7, -1398.065307, -217.028900, 1051.115844},
    {"Bloodbowl", 15, -1398.103515, 937.631164, 1036.479125},
    {"Dirt Track", 4, -1444.645507, -664.526000, 1053.572998},
    {"Kickstart", 14, -1465.268676, 1557.868286, 1052.531250},
    {"Vice Stadium", 1, -1401.829956, 107.051300, 1032.273437},
    {"SF Garage", 0, -1790.378295, 1436.949829, 7.187500},
    {"LS Garage", 0, 1643.839843, -1514.819580, 13.566620},
    {"SF Bomb Shop", 0, -1685.636474, 1035.476196, 45.210937},
    {"Blueberry Warehouse", 0, 76.632553, -301.156829, 1.578125},
    {"LV Warehouse 1", 0, 1059.895996, 2081.685791, 10.820312},
    {"LV Warehouse 2 (hidden part)", 0, 1059.180175, 2148.938720, 10.820312},
    {"Caligula's Hidden Room", 1, 2131.507812, 1600.818481, 1008.359375},
    {"Bank", 0, 2315.952880, -1.618174, 26.742187},
    {"Bank (Behind Desk)", 0, 2319.714843, -14.838361, 26.749565},
    {"LS Atrium", 18, 1710.433715, -1669.379272, 20.225049}
};
/*
enum eSafeData {
	g_iDBID,
	g_iType,
	g_iTypeID,
	g_iMoney,
	g_iInitialMoney,
	g_iVW,
	g_iInt,
	g_iModelID,
	g_iObjectID,
	g_iRobberyPickup,
	g_iRobbed,
	g_tRobbedTime,
	Float:g_fPos[6],
	g_szName[MAX_PLAYER_NAME],
	g_iPin[5],
	Text3D:g_iTextLabel
}
new SafeData[MAX_SAFES][eSafeData];


enum eMoneyBagData {
	g_iObjectID[2],
	g_iPlayerID,
	Float:g_fPos[3],
	g_iMoney,
	g_szPlayerName[MAX_PLAYER_NAME],
	Text3D:g_iTextLabel
}
new MoneyBagData[MAX_ROBBERS][eMoneyBagData];
*/
