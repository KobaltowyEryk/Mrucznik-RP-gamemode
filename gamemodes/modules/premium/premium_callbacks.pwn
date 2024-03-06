//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  premium                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 04.05.2019
//Opis:
/*
	Monetyzacja, us�ugi premium.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnGameModeInit() 
{
	PremiumRequestClient = RequestsClient("https://mrucznik-rp.pl/applications/nexus/interface/licenses/");
}


forward OnMCInfoCompleted(Request:id, E_HTTP_STATUS:status, Node:node);
public OnMCInfoCompleted(Request:id, E_HTTP_STATUS:status, Node:node)
{
	new playerid = MAP_get_val_val(PremiumRequestToPlayerID, _:id);
    MAP_remove_val(PremiumRequestToPlayerID, _:id);

    if(status == HTTP_STATUS_OK) 
	{
		new playerRequestID = GetPVarInt(playerid, "mc_request");
		if(playerRequestID != _:id)
		{
			DialogAktywujMC_Fail(playerid, "Brak sp�jno�ci ID.");
			return;
		}

		new pack_id;
    	new err = JsonGetInt(node, "purchase_pkg", pack_id);
		if(err)
		{
			DialogAktywujMC_Fail(playerid, "Nie uda�o si� odczyta� odpowiedzi systemu sprawdzania paczki.");
			return;
		}

		new mc = PobierzMcPaczki(pack_id);
		if(mc <= 0)
		{
			DialogAktywujMC_Fail(playerid, "Ten klucz licencyjny nie aktywuje paczki Mrucznik Coin�w.");
			return;
		}

		_MruGracz(playerid, "Znaleziono Paczk� MC, trwa aktywacja...");

		new email[256], kod[64];
		GetPVarString(playerid, "mc_email", email, 256);
		GetPVarString(playerid, "mc_kod", kod, 64);

		// send request, handler: OnMCActivationCompleted
		AktywujMC(playerid, email, kod, mc);
	}
	else
	{
		DialogAktywujMC_Fail(playerid, "Niepoprawna odpowied� systemu sprawdzania paczki.");
	}
	return;
}

forward OnMCActivationCompleted(Request:id, E_HTTP_STATUS:status, Node:node);
public OnMCActivationCompleted(Request:id, E_HTTP_STATUS:status, Node:node) 
{
	new playerid = MAP_get_val_val(PremiumRequestToPlayerID, _:id);
    MAP_remove_val(PremiumRequestToPlayerID, _:id);

    if(status == HTTP_STATUS_OK) 
	{
		new playerRequestID = GetPVarInt(playerid, "mc_request");
		if(playerRequestID != _:id)
		{
			DialogAktywujMC_Fail(playerid, "Brak sp�jno�ci ID.");
			return;
		}

		new response[64];
	    new err = JsonGetString(node, "response", response);
		if(err) 
		{
			DialogAktywujMC_Fail(playerid, "Nie uda�o si� odczyta� odpowiedzi systemu aktywacji paczki.");
			return;
		}

		if(strcmp(response, "OKAY", true) != 0)
		{
			DialogAktywujMC_Fail(playerid, "System aktywacji paczki nie odpowiedzia� OK.");
			return;
		}

		new mc = GetPVarInt(playerid, "mc_request_amount");
		if(mc <= 0)
		{
			DialogAktywujMC_Fail(playerid, "System aktywacji paczki nie otrzyma� poprawnej ilo�ci Mrucznik Coin�w.");
			return;
		}

		// nadaj MC
		DajMC(playerid, mc);
		Log(premiumLog, INFO, "%s aktywowa� paczk� z %d Mrucznik Coinami", GetPlayerLogName(playerid), mc);

		// komunikat
		new string[64];
		format(string, sizeof(string),"Paczka %d Mrucznik Coin�w aktywowana!", mc);
		_MruGracz(playerid, string);
		DialogAktywujMC_Success(playerid, mc);

		// muzyka mission passed
		PlayerPlaySound(playerid, 183, 0.0, 0.0, 0.0);
		SetTimerEx("StopPlayerSound", 8200, false, "%d", playerid);
    }
	else if(status == HTTP_STATUS_BAD_REQUEST)
	{
		new errorCode[64];
		JsonGetString(node, "errorCode", errorCode, sizeof(errorCode));

		if(strcmp(errorCode, "MAX_USES", true) == 0)
		{
			DialogAktywujMC_Fail(playerid, "Ten kod by� ju� aktywowany wcze�niej.");
			return;
		}
		
		DialogAktywujMC_Fail(playerid, "Niepoprawna odpowied� systemu aktywacji paczki.");
	}
	else
	{
		DialogAktywujMC_Fail(playerid, "Nierozpoznana odpowied� systemu aktywacji paczki.");
	}
	return;
}

//end