//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ asystem ]---------------------------------------------------//
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
Komenda pozwala zarz�dza� actorami na serwerze
*/


// Notatki skryptera:
/*
W fazie produkcji	
*/

YCMD:asystem(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		if(IsAScripter(playerid) || IsAHeadAdmin(playerid))
		{
			ShowPlayerDialogEx(playerid, 9992, DIALOG_STYLE_LIST, "Mrucznik Role-Play", "Zaznacz aktora\nPrzenies do siebie\nUstaw Animacje\nZmien HP\nResetuj", "Akceptuj", "Odrzu�"); 
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}


