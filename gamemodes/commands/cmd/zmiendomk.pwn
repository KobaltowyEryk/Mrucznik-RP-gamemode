//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zmiendomk ]-----------------------------------------------//
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

YCMD:zmiendomk(playerid, params[], help)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new para1, level;
        if( sscanf(params, "k<fix>d", para1, level))
        {
            sendTipMessage(playerid, "U�yj /setdomk [playerid/Cz��Nicku] [id domu]");
            return 1;
        }


        if (PlayerInfo[playerid][pAdmin] == 5000)
        {
            if(IsPlayerConnected(para1))
            {
                if(para1 != INVALID_PLAYER_ID)
                {
                    GetPlayerName(para1, giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    Dom[PlayerInfo[para1][pDom]][hKupiony] = level;
                    ZapiszDom(PlayerInfo[para1][pDom]);
					Log(adminLog, INFO, "Admin %s zmieni� %s stan kupienia domu na %d", GetPlayerLogName(playerid), GetPlayerLogName(para1), level);
                    format(string, sizeof(string), "   Tw�j stan domu zosta� zmieniony na dom nr %d przez %s", level, sendername);
                    SendClientMessage(para1, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "   Zmieni�e� stan dom graczowi %s na dom nr %d.", giveplayer,level);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                }
            }
        } 
				else
        {
            noAccessMessage(playerid);
        }
    }
    return 1;
}
