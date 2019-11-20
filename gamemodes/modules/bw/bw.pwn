//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    bw                                                     //
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//
//Opis:
/*
	Zawiera system rannego i BW.
*/
// Autor: Creative
// Data utworzenia: 19.11.2019

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
stock IsPlayerAimingEx(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
    (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
    return 0;
}

InfoMedicsInjury(injureplayer, bool:injury, bool:bw)
{
	new string[144], pZone[MAX_ZONE_NAME], type[144];
	GetPlayer2DZone(injureplayer, pZone, MAX_ZONE_NAME);
	format(type, sizeof(type), (bw ? "Nieprzytomny" : "Ranny"));
	if(injury)
	{
		format(string, sizeof(string), "{FFFFFF}��{6A5ACD} CENTRALA: {FF0000}%s {FFFFFF}- lokalizacja: {FF0000}%s", type, pZone);
	}
	else if(bw)
	{
		format(string, sizeof(string), "{FFFFFF}��{6A5ACD} CENTRALA: {FF0000}%s {FFFFFF}pacjent w salach pooperacyjnych", type);
	}
	SendClientMessageToAll(COLOR_GRAD2, "#1 Wysy�am komunikat do ERS");
	SendTeamMessage(4, COLOR_ALLDEPT, string);
	return 1;
}
NadajRanny(playerid, customtime = 0)
{
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
	SetPVarInt(playerid, "bw-vw", GetPlayerVirtualWorld(playerid));
	SetPVarInt(playerid, "bw-int", GetPlayerInterior(playerid));
	SendClientMessageToAll(COLOR_GRAD2, "#2: NadajRanny");
	if(!customtime) customtime = INJURY_TIME;
	PlayerInfo[playerid][pBW] = 0;
	PlayerInfo[playerid][pInjury] = customtime;
	SetPlayerChatBubble(playerid, "** Ranny **", COLOR_PANICRED, 30.0, (customtime * 1000));
	InfoMedicsInjury(playerid, true, false);
	return 1;
}
NadajBW(playerid, customtime = 0)
{
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
	SetPVarInt(playerid, "bw-vw", GetPlayerVirtualWorld(playerid));
	SetPVarInt(playerid, "bw-int", GetPlayerInterior(playerid));
	SendClientMessageToAll(COLOR_GRAD2, "#2-2: NadajBW");
	//TogglePlayerControllable(playerid, 0);
	if(!customtime) customtime = BW_TIME;
	PlayerInfo[playerid][pInjury] = 0;
	PlayerInfo[playerid][pBW] = customtime;
	SetPlayerChatBubble(playerid, "** Nieprzytomny **", COLOR_PANICRED, 30.0, (customtime * 1000));
	InfoMedicsInjury(playerid, false, true);
	return 1;
}
FreezePlayerOnInjury(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "#3: FreezePlayerOnInjury");
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
	SetTimerEx("FreezePlayer", 1500, false, "i", playerid);
	return 1;
}
PlayerEnterVehOnInjury(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "#4: PlayerEnterVehOnInjury");
	Player_RemoveFromVeh(playerid);
	ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "{FF542E}Jeste� ranny!\n{FFFFFF}Nie mo�esz wsi��� do pojazdu.");
	return 1;
}
PlayerChangeWeaponOnInjury(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "#5: PlayerChangeWeaponOnInjury");
	SetPlayerArmedWeapon(playerid, starabron[playerid]);
	return 1;
}
ZespawnujGraczaBW(playerid)
{
	new string[256], type[144];
	MedicBill[playerid] = 0;
	MedicTime[playerid] = 0;
	NeedMedicTime[playerid] = 0;
	SetPlayerHealth(playerid, INJURY_HP);
	SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "bw-vw"));
	SetPlayerInterior(playerid, GetPVarInt(playerid, "bw-int"));
	SetPlayerFacingAngle(playerid, GetPVarInt(playerid, "bw-faceangle"));
	SetCameraBehindPlayer(playerid);
	format(type, sizeof(type), (PlayerInfo[playerid][pBW] > 0 ? "nieprzytomny" : "ranny"));
	format(string, sizeof(string), "{FF542E}Jeste� %s!\n{FFFFFF}Mo�esz wezwa� pomoc (/wezwij medyk, /dzwon 911) lub poczeka� %d sekund.\nZalecamy odgrywa� odniesione obra�enia.", type, (PlayerInfo[playerid][pBW] > 0 ? PlayerInfo[playerid][pBW] : PlayerInfo[playerid][pInjury]));
	ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", string); 
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
	SendClientMessageToAll(COLOR_GRAD2, "#6 ZespawnujGraczaBW");
	SetPlayerPosEx(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	//TogglePlayerControllable(playerid, 0);
	return 1;
}
//-----------------<[ Timery: ]>-------------------
RannyTimer(playerid)
{
	new string[256], i = playerid;
	if(GetPVarInt(i, "bw-sync") != 1 && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
	{
		SetPVarInt(i, "bw-sync", 1);
	}
	if(PlayerInfo[i][pInjury] > 0)
	{
		SendClientMessageToAll(COLOR_GRAD2, "------Timer: RannyTimer");
		ApplyAnimation(i, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
		PlayerInfo[i][pInjury]-=2;
		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Ranny: %d", PlayerInfo[i][pInjury]);
		GameTextForPlayer(i, string, 2500, 3);
		SetPlayerChatBubble(playerid, "** Ranny **", COLOR_PANICRED, 30.0, (PlayerInfo[i][pInjury] * 1000));
		if(PlayerInfo[i][pInjury] <= 0)
		{
			format(string, sizeof(string), "{AAF542}Obudzi�e� si�!\n{FFFFFF}Twoja posta� odnios�a obra�enia, kt�re zalecamy odgrywa�.");
			ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", string); 
			SendClientMessageToAll(COLOR_GRAD2, "#7: O�ywiam gracza, nikt go nie dobi�");
			ZdejmijBW(playerid);
			/* tutaj dobicie gracza jesli nie uratowany
			PlayerInfo[i][pInjury] = 999;
			SetPlayerHealth(i, 0); */
		}
	}
	return 1;
}

BWTimer(playerid)
{
	new string[128], i = playerid;
	if(GetPVarInt(i, "bw-sync") != 1 && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
	{
		SetPVarInt(i, "bw-sync", 1);
	}
	if(PlayerInfo[playerid][pBW] > 0)
	{
		SendClientMessageToAll(COLOR_GRAD2, "------Timer: BWTimer");
		ApplyAnimation(i, "CRACK", "crckidle1", 4.0, 1, 0, 0, 1, 0, 1);
		PlayerInfo[i][pBW]-=2;
		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Nieprzytomny: %d", PlayerInfo[i][pBW]);
		GameTextForPlayer(i, string, 2500, 3);
		SetPlayerChatBubble(playerid, "** Nieprzytomny **", COLOR_PANICRED, 30.0, (PlayerInfo[i][pBW] * 1000));
		if(PlayerInfo[i][pBW] <= 0)
		{
			ZdejmijBW(i);
			GameTextForPlayer(i, "~n~~n~~g~~h~Obudziles sie", 5000, 5);
		}
	}
	return 1;
}

ZespawnujGraczaSzpitalBW(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "#9: ZespawnujGraczaSzpitalBW");
	new randbed = random(sizeof(HospitalBeds));
	SetPVarInt(playerid, "bw-vw", 90);
	SetPVarInt(playerid, "bw-int", 0);
	//SetPVarInt(playerid, "bw-faceangle", HospitalBeds[randbed][3]);
	PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
	PlayerInfo[playerid][pPos_x] = HospitalBeds[randbed][0];
	PlayerInfo[playerid][pPos_y] = HospitalBeds[randbed][1];
	PlayerInfo[playerid][pPos_z] = HospitalBeds[randbed][2];		
	PlayerInfo[playerid][pMuted] = 1;
	ZespawnujGraczaBW(playerid);
	SetPlayerCameraPos(playerid,HospitalBeds[randbed][0] + 3, HospitalBeds[randbed][1], HospitalBeds[randbed][2]);
	SetPlayerCameraLookAt(playerid,HospitalBeds[randbed][0], HospitalBeds[randbed][1], HospitalBeds[randbed][2]);
	return 1;
}

NadajWLBW(killerid, victim, bool:bw)
{
	SendClientMessageToAll(COLOR_GRAD2, "#10: NadajWLBW");
	new string[144];
	new playerid = victim;
	format(string, sizeof(string), (bw ? "Morderstwo" : "Zranienie"));
	if(IsACop(playerid))
	{
		PoziomPoszukiwania[killerid] += 2;
		strcat(string, " Policjanta");
	}
	if(lowcaz[killerid] == playerid)
		strcat(string, " �owcy Nagr�d");
	if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER || GetPlayerState(killerid) == PLAYER_STATE_PASSENGER)
		strcat(string, " z okna pojazdu");

	PlayerPlaySound(killerid, 1083, 0.0, 0.0, 0.0);
	PoziomPoszukiwania[killerid] ++;
	SetPlayerCriminal(killerid, INVALID_PLAYER_ID, string);
	if(PoziomPoszukiwania[killerid] >= 10)
	{
		sendTipMessageEx(killerid, COLOR_LIGHTRED, "Masz ju� 10 list�w go�czych!");
		sendTipMessage(killerid, "Zaczynasz stawa� si� coraz bardziej smakowity dla �owc�w! Pilnuj si�!"); 
	}
}

ZdejmijBW(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "#11: ZdejmijBW");
	new i = playerid;
	PlayerInfo[i][pBW]=0;
	PlayerInfo[i][pInjury]=0;
	PlayerInfo[i][pMuted] = 0;
	PlayerRequestMedic[playerid] = 0;
	TogglePlayerControllable(i, 1);
	SetPVarInt(i, "bw-sync", 0);
	ClearAnimations(i);
	SetPlayerSpecialAction(i,SPECIAL_ACTION_NONE);
	SetPlayerChatBubble(playerid, " ", 0xFF0000FF, 100.0, 1000);
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end