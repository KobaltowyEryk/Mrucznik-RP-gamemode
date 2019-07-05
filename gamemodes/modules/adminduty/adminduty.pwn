//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 adminduty                                                 //
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
	Zawiera system s�u�by administratora.
	W tym pliku dok�adnie:
		> G��wne CMD adminduty
		> Funkcja SprawdzZnaki
		> Funkcja AdminDutyPlayer - ustawia graczu adminduty
		> Funkcja GetPlayerAdminDutyStatus - pobiera status, czy gracz jest na adminduty.
		> Timer do AdminDuty
*/
// Autor: Simeone
// Data utworzenia: 04.05.2019

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
GetPlayerAdminDutyStatus(playerid)
{
	new valueAdminStatus = GetPVarInt(playerid, "dutyadmin");
	return valueAdminStatus; 
}
AdminDutyPlayer(playerid, status)
{
	new string[128];	
	if(status == 1)//Je�eli ma wej��
	{
		AdminDutyTimer[playerid] = SetTimerEx("AdminDutyCzas", 60000, true, "i", playerid);
		format(string, sizeof(string), "Administrator %s wszed� na s�u�b� administratora!", GetNick(playerid));
		SendAdminMessage(COLOR_RED, string); 
		MSGBOX_Show(playerid, "Admin Duty ~g~ON", MSGBOX_ICON_TYPE_OK);	
		SetPVarInt(playerid, "dutyadmin", 1);
		SetPlayerColor(playerid, 0xFF0000FF);
		firstDutyAdmin[playerid] = 1; 
	}
	else//Je�eli ma zej��
	{	
		SetPVarInt(playerid, "dutyadmin", 0); 
		SetPlayerColor(playerid,TEAM_HIT_COLOR);
		//Komunikaty
		format(string, sizeof(string), "@DUTY: Wykona�e� ->  %d ban�w | %d warn�w | %d kick�w | %d innych akcji!", iloscBan[playerid],iloscWarn[playerid],iloscKick[playerid], (iloscInne[playerid]+iloscAJ[playerid])); 
		sendErrorMessage(playerid, string); 
		MSGBOX_Show(playerid, "Admin Duty ~r~OFF", MSGBOX_ICON_TYPE_OK);
		sendTipMessage(playerid, "Dzi�kujemy za sumienn� s�u�b�, administratorze!"); 	
		//Timer's kill
		KillTimer(AdminDutyTimer[playerid]);
	}
	return 1;
}


//-----------------<[ Timery: ]>-------------------
forward AdminDutyCzas(playerid);
public AdminDutyCzas(playerid)
{
	AdminDutyMinuty[playerid]++;
	if(AdminDutyMinuty[playerid] == 60)
	{
		AdminDutyGodziny[playerid]++;
		AdminDutyMinuty[playerid] = 0;
	
	}
	return 1;
}


//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end