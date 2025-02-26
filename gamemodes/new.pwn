#include <a_samp>

#define CENTER_X  -198.0499
#define CENTER_Y -1393.2760
#define CENTER_Z  5.5555

#define GORA_POS -2327.5261, -1619.4628, 483.7123

#define TestWork:%0(%1) TESTWORK_%0(%1)

new Text:SelectTD;
enum ENUM_PLAYER_INFO
{
	playerVehilce [ 8 ],
	playerTrailer,
	playerSelectVehicle,

	playerTimerCamera,
	Float:playerCameraAngle,

	bool:playerDeath,
}
new PlayerInfo [ MAX_PLAYERS ] [ ENUM_PLAYER_INFO ];

enum ENUM_VEHICLE_INFO
{
	vehModel,
	Float:vehX,
	Float:vehY,
	Float:vehZ,
	Float:vehRZ,
}

new VehicleInformation [ 8 ] [ ENUM_VEHICLE_INFO ] = {
	{405,-207.6749,-1397.4238,5.7914,114.810},
	{422,-201.2802,-1401.9264,5.3121,158.480},
	{429,-196.0370,-1403.1210,4.6190,193.886},
	{434,-192.4258,-1399.8394,4.7107,230.354},
	{440,-189.1937,-1389.9502,4.6187,283.867},
	{478,-194.6935,-1383.4391,4.9581,340.939},
	{479,-200.8891,-1382.7098,5.2720,12.8756},
	{451,-207.3629,-1387.4221,5.7098,48.4085}
};

static const VehicleNames[212][] = {
   "Landstalker",  "Bravura",  "Buffalo", "Linerunner", "Perennial", "Sentinel",
   "Dumper",  "Firetruck" ,  "Trashmaster" ,  "Stretch",  "Manana",  "Infernus",
   "Voodoo", "Pony",  "Mule", "Cheetah", "Ambulance",  "Leviathan",  "Moonbeam",
   "Esperanto", "Taxi",  "Washington",  "Bobcat",  "Mr Whoopee", "BF Injection",
   "Hunter", "Premier",  "Enforcer",  "Securicar", "Banshee", "Predator", "Bus",
   "Rhino",  "Barracks",  "Hotknife",  "Trailer",  "Previon", "Coach", "Cabbie",
   "Stallion", "Rumpo", "RC Bandit",  "Romero", "Packer", "Monster",  "Admiral",
   "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer",  "Turismo", "Speeder",
   "Reefer", "Tropic", "Flatbed","Yankee", "Caddy", "Solair","Berkley's RC Van",
   "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron","RC Raider","Glendale",
   "Oceanic", "Sanchez", "Sparrow",  "Patriot", "Quad",  "Coastguard", "Dinghy",
   "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",  "Regina",  "Comet", "BMX",
   "Burrito", "Camper", "Marquis", "Baggage", "Dozer","Maverick","News Chopper",
   "Rancher", "FBI Rancher", "Virgo", "Greenwood","Jetmax","Hotring","Sandking",
   "Blista Compact", "Police Maverick", "Boxville", "Benson","Mesa","RC Goblin",
   "Hotring Racer", "Hotring Racer", "Bloodring Banger", "Rancher",  "Super GT",
   "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropdust", "Stunt",
   "Tanker", "RoadTrain", "Nebula", "Majestic", "Buccaneer", "Shamal",  "Hydra",
   "FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona",
   "FBI Truck", "Willard", "Forklift","Tractor","Combine","Feltzer","Remington",
   "Slamvan", "Blade", "Freight", "Streak","Vortex","Vincent","Bullet","Clover",
   "Sadler",  "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob",  "Tampa",
   "Sunrise", "Merit",  "Utility Truck",  "Nevada", "Yosemite", "Windsor",  "Monster",
   "Monster","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RCTiger",
   "Flash","Tahoma","Savanna", "Bandito", "Freight", "Trailer", "Kart", "Mower",
   "Dune", "Sweeper", "Broadway", "Tornado", "AT-400",  "DFT-30", "Huntley",
   "Stafford", "BF-400", "Newsvan","Tug","Trailer","Emperor","Wayfarer","Euros",
   "Hotdog", "Club", "Trailer", "Trailer","Andromada","Dodo","RC Cam", "Launch",
   "LSPD Cruiser", "SFPD Cruiser","LVPD Cruiser","Police Ranger",
   "Picador",   "S.W.A.T. Van",  "Alpha",   "Phoenix",   "Glendale",   "Sadler",
   "Luggage Trailer","Luggage Trailer","Stair Trailer", "Boxville", "Farm Plow",
   "Utility Trailer"
};

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	SetGameModeText("Blank Script");
	AddPlayerClass(0, CENTER_X, CENTER_Y, CENTER_Z, 21.6609, 0, 0, 0, 0, 0, 0);

	SelectTD = TextDrawCreate(290.0000, 190.0000, "SPAWN"); // пусто
	TextDrawLetterSize(SelectTD, 0.4000, 1.6000);
	TextDrawAlignment(SelectTD, 1);
	TextDrawColor(SelectTD, -1);
	TextDrawBackgroundColor(SelectTD, 255);
	TextDrawFont(SelectTD, 1);
	TextDrawSetProportional(SelectTD, 1);
	TextDrawSetShadow(SelectTD, 0);
	TextDrawSetSelectable(SelectTD, true);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

forward L_SpawnPlayer ( playerid );
public L_SpawnPlayer ( playerid )
{
	SpawnPlayer ( playerid );
	SetPlayerPos ( playerid, CENTER_X, CENTER_Y+100.0, CENTER_Z+10.0);
	TogglePlayerControllable ( playerid, 0 );

	TestWork:setMovingCamera ( playerid );
	return 1;
}

public OnPlayerConnect(playerid)
{
	TestWork:resetPlayer ( playerid );

	SetTimerEx ( "L_SpawnPlayer", 200, false, "i", playerid );
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	TestWork:stopMovingCamera ( playerid );
	TestWork:destroyAllVehicle ( playerid );
	
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetCameraBehindPlayer ( playerid );
	TogglePlayerControllable ( playerid, 1 );
	
	if ( PlayerInfo [ playerid ] [ playerDeath ] == true )
	{
		PlayerInfo [ playerid ] [ playerDeath ] = false;
		SetPlayerPos ( playerid, CENTER_X, CENTER_Y+100.0, CENTER_Z+10.0);
		TestWork:setMovingCamera ( playerid );
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	PlayerInfo [ playerid ] [ playerDeath ] = true;
	TestWork:destroyAllVehicle ( playerid );
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if ( newstate == PLAYER_STATE_DRIVER )
    {
        new vehicleid = GetPlayerVehicleID ( playerid ),
			body_dialog [ 256 ];

		format ( body_dialog, sizeof body_dialog, "{FFFFFF}Вы сели в {bebebe}%s{FFFFFF}, желаете телепортируем на гору?", VehicleNames [ GetVehicleModel ( vehicleid ) - 400 ] );
		
		PlayerInfo [ playerid ] [ playerSelectVehicle ] = vehicleid;
		ShowPlayerDialog ( playerid, 228, DIALOG_STYLE_MSGBOX, "Горка", body_dialog, "Да", "Нет" );
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	if ( PlayerInfo [ forplayerid ] [ playerTrailer ] == vehicleid )
		AttachTrailerToVehicle ( PlayerInfo [ forplayerid ] [ playerTrailer ], PlayerInfo [ forplayerid ] [ playerSelectVehicle ] );

	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch ( dialogid )
	{
		case 228:
		{
			if ( !response )
				return RemovePlayerFromVehicle ( playerid );

			TestWork:destroyAllVehicle ( playerid, 1);

			SetVehiclePos ( PlayerInfo [ playerid ] [ playerSelectVehicle ], GORA_POS );

			PlayerInfo [ playerid ] [ playerTrailer ] = 
				CreateVehicle ( 607, GORA_POS, 0.0, 1, 1, -1);
		}
	}

	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if ( clickedid == SelectTD )
		TestWork:stopMovingCamera ( playerid );

    return 0;
}

stock TestWork:destroyAllVehicle ( playerid, type = 0 )
{
	if ( type == 0 && PlayerInfo [ playerid ] [ playerTrailer ] != INVALID_VEHICLE_ID )
	{
		DestroyVehicle ( PlayerInfo [ playerid ] [ playerTrailer ] );
		PlayerInfo [ playerid ] [ playerTrailer ] = INVALID_VEHICLE_ID;
	}

	if ( type == 0 && PlayerInfo [ playerid ] [ playerSelectVehicle ] != INVALID_VEHICLE_ID )
	{
		PlayerInfo [ playerid ] [ playerSelectVehicle ] = INVALID_VEHICLE_ID;
		DestroyVehicle ( PlayerInfo [ playerid ] [ playerSelectVehicle ] );
	}
	
	for ( new i = 0; i < 8; i ++ )
	{
		if ( PlayerInfo [ playerid ] [ playerVehilce ] [ i ] == INVALID_VEHICLE_ID )
			continue;
		
		if ( type == 1 && PlayerInfo [ playerid ] [ playerVehilce ] [ i ] == PlayerInfo [ playerid ] [ playerSelectVehicle ] )
			continue;

		DestroyVehicle ( PlayerInfo [ playerid ] [ playerVehilce ] [ i ] );

		PlayerInfo [ playerid ] [ playerVehilce ] [ i ] = INVALID_VEHICLE_ID;
	}

	return 1;
}

stock TestWork:resetPlayer ( playerid )
{
	PlayerInfo [ playerid ] [ playerTimerCamera ] = -1;

	PlayerInfo [ playerid ] [ playerSelectVehicle ] = INVALID_VEHICLE_ID;

	for ( new i = 0; i < 8; i ++ )
		PlayerInfo [ playerid ] [ playerVehilce ] = INVALID_VEHICLE_ID;	

	return 1;
}

stock TestWork:setMovingCamera ( playerid )
{
	TestWork:stopMovingCamera ( playerid );

	TextDrawShowForPlayer ( playerid, SelectTD );
	SelectTextDraw ( playerid, 0xFFFFFFFF );

	for ( new i = 0; i < 8; i ++ )
	{
		PlayerInfo [ playerid ] [ playerVehilce ] [ i ] = 
			CreateVehicle ( VehicleInformation [ i ] [ vehModel ], VehicleInformation [ i ] [ vehX ], VehicleInformation [ i ] [ vehY ], VehicleInformation [ i ] [ vehZ ], VehicleInformation [ i ] [ vehRZ ], 17, 17, -1 );
	}

	PlayerInfo [ playerid ] [ playerTimerCamera ] = 
		SetTimerEx ( "UpdateCamera", 100, true, "i", playerid );
	
	return 1;
}

stock Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    return floatsqroot((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2));
}

stock TestWork:stopMovingCamera ( playerid )
{
	if ( PlayerInfo [ playerid ] [ playerTimerCamera ] == -1 )
		return 1;
	
	KillTimer ( PlayerInfo [ playerid ] [ playerTimerCamera ] );
	PlayerInfo [ playerid ] [ playerTimerCamera ] = -1;

	TextDrawHideForPlayer ( playerid, SelectTD );
	CancelSelectTextDraw ( playerid );

	new Float:CameraX, 
		Float:CameraY,
		Float:CameraZ;
    
	GetPlayerCameraPos ( playerid, CameraX, CameraY, CameraZ );
	SetPlayerPos ( playerid, CameraX, CameraY, CameraZ - 5.0 );
	
	SetCameraBehindPlayer ( playerid );

	new Float:carX,
		Float:carY,
		Float:carZ,
		Float:minDist = 228,
		vehicleid;

	for ( new i = 0; i < 8; i ++ )
	{
		if ( PlayerInfo [ playerid ] [ playerVehilce ] [ i ] == INVALID_VEHICLE_ID )
			continue;

		GetVehiclePos ( PlayerInfo [ playerid ] [ playerVehilce ] [ i ], carX, carY, carZ );

		new Float:distance = GetDistanceBetweenPoints ( CameraX, CameraY, CameraZ - 5.0, carX, carY, carZ );
		
		if ( distance > minDist )
			continue;
		
		minDist = distance;
        vehicleid = PlayerInfo [ playerid ] [ playerVehilce ] [ i ];
	}

	GetVehiclePos ( vehicleid, carX, carY, carZ );
	
	new Float:angle = atan2 ( carY - CameraY, carX - CameraX );
	angle = 450 - angle;
	angle = angle > 360 ? angle - 360 : angle;
	SetPlayerFacingAngle ( playerid, -angle );
	
	SetCameraBehindPlayer ( playerid );
	return 1;
}

forward UpdateCamera ( playerid );
public UpdateCamera ( playerid )
{
    PlayerInfo [ playerid ] [ playerCameraAngle ] -= 5.0;
    if (PlayerInfo [ playerid ] [ playerCameraAngle ]  >= 360.0) PlayerInfo [ playerid ] [ playerCameraAngle ]  = 0.0;

    new Float:CameraX = CENTER_X + 10 * floatsin(PlayerInfo [ playerid ] [ playerCameraAngle ] , degrees);
    new Float:CameraY = CENTER_Y + 10 * floatcos(PlayerInfo [ playerid ] [ playerCameraAngle ] , degrees);
    new Float:CameraZ = CENTER_Z + 5.0;

    SetPlayerCameraPos ( playerid, CameraX, CameraY, CameraZ );
    SetPlayerCameraLookAt ( playerid, CENTER_X, CENTER_Y, CENTER_Z );

    return 1;
}