//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ zablokujtel ]----------------------------------------------//
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

YCMD:zablokujtel(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        //if(PlayerInfo[playerid][pDonateRank] > 0 || PlayerInfo[playerid][pLevel] >= 3)
        //{
		if (!PhoneOnline[playerid])
		{
			PhoneOnline[playerid] = 1;
            MSGBOX_Show(playerid, "Telefon ~r~OFF", MSGBOX_ICON_TYPE_OK);
		}
		else if (PhoneOnline[playerid])
		{
			PhoneOnline[playerid] = 0;
            MSGBOX_Show(playerid, "Telefon ~g~ON", MSGBOX_ICON_TYPE_OK);
		}
		//}
		//else
		//{
		//    SendClientMessage(playerid, COLOR_GREY, "   Nie masz 3 levela / Nie posiadasz Konta premium !");
        //   return 1;
		//}
	}
	return 1;
}