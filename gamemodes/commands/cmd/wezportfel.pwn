//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ wezportfel ]----------------------------------------------//
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

YCMD:wezportfel(playerid, params[], help)
{
	if(IsAPrzestepca(playerid))
	{
		if(PlayerInfo[playerid][pRank] < 2)
		{
			sendTipMessage(playerid, "Potrzebujesz rangi 2 lub wy�szej, �eby m�c zabiera� pieni�dze!");
			return 1;
		}
		new giveplayerid;
		if(sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U�yj /wezportfel [id/nick]");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid) && giveplayerid != INVALID_PLAYER_ID)
		{
			if(PlayerTied[giveplayerid] > 0 || PlayerInfo[giveplayerid][pBW] > 0 || PlayerInfo[giveplayerid][pInjury] > 0)
			{
				if(PlayerTied[giveplayerid] != 1)
				{
					sendTipMessage(playerid, "Gracz musi by� zwi�zany.");
					return 1;
				}
				if(ProxDetectorS(8.0, playerid, giveplayerid))
				{
					if(Kajdanki_JestemSkuty[playerid] ||
						PlayerTied[playerid] || 
						PlayerInfo[playerid][pBW] ||
						PlayerInfo[playerid][pInjury]
					)
					{
						sendTipMessage(playerid, "Jeste� zakuty, ranny lub pobity, nie mo�esz okrada� w tym stanie.");
						return 1;
					}
					if(PlayerInfo[giveplayerid][pMember] == 0 && PlayerInfo[giveplayerid][pLider] == 0 && (GetPlayerOrg(giveplayerid) == 0
					 || GetPlayerOrgType(giveplayerid) == ORG_TYPE_CLUB || GetPlayerOrgType(giveplayerid) == ORG_TYPE_BIZNES))
					{
						sendTipMessage(playerid, "Nie mo�esz okrada� cywili.");
						return 1;
					}
					new pieniadze = 1000000;
					if(giveplayerid == playerid) { sendErrorMessage(playerid, "Nie mo�esz okra�� sam siebie!"); return 1; }
					if(okradziony[giveplayerid] == 0)
					{
						if(kaska[giveplayerid] >= 1)
						{
							if(PlayerInfo[giveplayerid][pConnectTime] >= 2)
							{
								new string[128];
								if(kaska[giveplayerid] >= pieniadze)
								{
									SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("%s zabra� Ci portfel z $%d w �rodku", GetNick(playerid), pieniadze));
									SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Zabra�e� portfel %s, w �rodku jest $%d", GetNick(giveplayerid), pieniadze));
									format(string, sizeof(string), "* %s zabiera portfel %s razem z %d$", GetNick(playerid), GetNick(giveplayerid), pieniadze);
									ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
									Log(payLog, INFO, "%s zabra� portfel %s razem z %d$", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), pieniadze);
									DajKase(playerid, pieniadze);
									ZabierzKase(giveplayerid, pieniadze);
									okradziony[giveplayerid] = 1;
									PoziomPoszukiwania[playerid] += 3;
									SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Porwanie + kradzie�");
									return 1;
								}
								
								pieniadze = kaska[giveplayerid];
								SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("%s zabra� Ci portfel z $%d w �rodku", GetNick(playerid), pieniadze));
								SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Zabra�e� portfel %s, w �rodku jest $%d", GetNick(giveplayerid), pieniadze));
								format(string, sizeof(string), "* %s zabiera portfel %s razem z %d$", GetNick(playerid), GetNick(giveplayerid), pieniadze);
								ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
								Log(payLog, INFO, "%s zabra� portfel %s razem z %d$", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), pieniadze);
								DajKase(playerid, pieniadze);
								ZabierzKase(giveplayerid, pieniadze);
								okradziony[giveplayerid] = 1;
								PoziomPoszukiwania[playerid] += 3;
								SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Porwanie + kradzie�");	
								return 1;							
							}
							else
							{
								sendErrorMessage(playerid, "Ten gracz za ma�o gra !");
							}
						}
						else
						{
							sendErrorMessage(playerid, "Ten gracz nie ma nic przy sobie !");
						}
					}
					else
					{
						sendErrorMessage(playerid, "Ta osoba nie ma portfela, ju� jej kto� zabra� !");
					}
				}
				else
				{
					sendErrorMessage(playerid, "Ten gracz nie jest w pobli�u Ciebie !");
					return 1;
				}
			}
			else
			{
				sendTipMessage(playerid, "Ta osoba nie jest zwi�zana lub nie ma BW/nie jest ranna!");
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza !");
			return 1;
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jeste� cz�onkiem / liderem rodziny !");
	}
	return 1;
}
