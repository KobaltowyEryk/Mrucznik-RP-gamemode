//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ wk ]--------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:wk(playerid, params[], help)
{
    if(PlayerInfo[playerid][pKluczeAuta] != 0)
    {
        new uid = Car_GetIDXFromUID(PlayerInfo[playerid][pKluczeAuta]);
        if(uid != -1) 
		{
			CarData[uid][c_Keys] = 0;
		}
  		PlayerInfo[playerid][pKluczeAuta] = 0;
  		sendTipMessage(playerid, "Kluczyki wywalone (skr�t komendy: /wk)", COLOR_LIGHTBLUE);

		//log
		Log(payLog, INFO, "%s wyrzuci� kluczyki do pojazdu %s",
			GetPlayerLogName(playerid),
			GetCarDataLogName(uid));
  	}
  	else
  	{
  	    sendErrorMessage(playerid, "Nie masz kluczy");
  	}
	return 1;
}
