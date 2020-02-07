//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  business                                                 //
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
// Autor: Simeone
// Data utworzenia: 04.02.2020
//Opis:
/*
	System biznes�w Mrucznik'a Role Play 2.0 
*/

//

//-----------------<[ Funkcje: ]>-------------------
BizExist(value)
{
	if(mBiz[value][b_enX] != 0)
	{
		return true;
	}
	return false; 
}
stock FreeBizID()
{
	for(new i; i <= MAX_BIZ; i++)
	{
		if(!BizExist(i))
		{
			return i; 
		}
	} 
	return INVALID_BUSINESSID;
}
stock CreateMBiz(playerid, bCost, bName[64])
{
	//=====================================[Sprawdzanie poprawno�ci]============================
	if(loadedBiz+1 >= MAX_BIZ)
    {
        sendErrorMessage(playerid, "Serwer osi�gn�� maksymaln� warto�� biznes�w!"); 
        return 1;
    }
	
	
	//======================[Pobieranie informacji, tworzenie zmiennych]========================
	new Float:posX, Float:posY, Float:posZ; 
	GetPlayerPos(playerid, posX, posY, posZ);
	new pZone[MAX_ZONE_NAME];
	GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
	new query[1024];
	new bIDE = FreeBizID();
	//=====================================[Polecenie do bazy danych]============================
	format(query, sizeof(query), "INSERT INTO `mru_biz` (`ID`, `ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Cost`, `Location`, `MoneyPocket`) VALUES ('%d', '%d', '%s', '%s', '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d', '%d', '%d', '%s', '%d')", 
	bIDE, 
	0,
	"Brak",
	bName,
	posX, 
	posY,
	posZ,
	posX,
	posY,
	posZ,
	0,
	0,
	PLOCAL_DEFAULT,
	bCost,
	pZone,
	0);
	mysql_query(query);


	//================================[Tworzenie biznesu w czasie realnym]=========================
	mysql_real_escape_string(bName, mBiz[bIDE][b_Name]); 
	mysql_real_escape_string("Brak", mBiz[bIDE][b_Name_Owner]);
	mysql_real_escape_string("[Default MOTD] Witaj w biznesie", mBiz[bIDE][b_motd]); 
	mBiz[bIDE][b_ownerUID] = 0; 
	mBiz[bIDE][b_moneyPocket] = 0; 
	mBiz[bIDE][b_enX] = posX;
	mBiz[bIDE][b_enY] = posY;
	mBiz[bIDE][b_enZ] = posZ; 
	mBiz[bIDE][b_exX] = posX;
	mBiz[bIDE][b_exY] = posY;
	mBiz[bIDE][b_exZ] = posZ; 
	mBiz[bIDE][b_int] = 0;
	mBiz[bIDE][b_vw] = 0;
	mBiz[bIDE][b_pLocal] = PLOCAL_DEFAULT; 
	mBiz[bIDE][b_cost] = bCost;
	mysql_real_escape_string(pZone, mBiz[bIDE][b_Location]);
	mBiz[bIDE][b_TYPE] = BTYPE_DEFAULT; 
	mBiz[bIDE][b_TYPE2] = BTYPE2_DEFAULT; 
	CreateDynamic3DTextLabel(mBiz[bIDE][b_Name], 0x008080FF, mBiz[bIDE][b_enX], mBiz[bIDE][b_enY], mBiz[bIDE][b_enZ]+0.4, 10.0);
    CreateDynamicPickup(1272, 1, mBiz[bIDE][b_enX], mBiz[bIDE][b_enY], mBiz[bIDE][b_enZ]-0.4, 0, 0, -1, STREAMER_PICKUP_SD); 
	loadedBiz++; 
	Log(businessLog, INFO, "BusinessGod %s stworzyl biznes %s", GetPlayerLogName(playerid), GetBusinessLogName(bIDE));
	return 1;
}
CreateBusinessIcon()
{
	for(new i; i <= MAX_BIZ; i++)
	{
		if(BizExist(i))
		{
			CreateDynamic3DTextLabel(mBiz[i][b_Name], 0x008080FF, mBiz[i][b_enX], mBiz[i][b_enY], mBiz[i][b_enZ]+0.4, 10.0);
    		CreateDynamicPickup(1272, 1, mBiz[i][b_enX], mBiz[i][b_enY], mBiz[i][b_enZ]-0.4, 0, 0, -1, STREAMER_PICKUP_SD); 
		}
	}
}
GiveBizToPlayer(playerid, bIDE, bType, bType2)
{
	new string[124]; 
	mysql_real_escape_string(GetNick(playerid), mBiz[bIDE][b_Name_Owner]); 
	mBiz[bIDE][b_ownerUID] = PlayerInfo[playerid][pUID]; 
	mBiz[bIDE][b_moneyPocket] = 0; 
	mBiz[bIDE][b_TYPE] = bType; 
	mBiz[bIDE][b_TYPE2] = bType2; 
	sendTipMessage(playerid, "Zakupi�e� nowy biznes!");
	format(string, sizeof(string), "ID [%d] NAME [%s]", bIDE, mBiz[bIDE][b_Location]); 
	SendClientMessage(playerid, COLOR_RED, string); 
	Log(businessLog, INFO, "Gracz %s kupil biznes %s", GetPlayerLogName(playerid), GetBusinessLogName(bIDE));
	return 1;
}
IsABusinessGod(playerid)//Pozwala zarz�dza� biznesami
{
	if(PlayerInfo[playerid][pAdmin] >= 5000)//Tylko dla H@
	{
		return true;
	}
	return false; 
}
IsPlayerNearBusinessDoor(playerid)//Powoduje wej�cie do biznesu
{
	new string[124];
	for(new i2; i2<=MAX_BIZ; i2++)
	{
		if(i2 == MAX_BIZ)
		{
			break;
		}
		if(BizExist(i2))
		{
			if(IsPlayerInRangeOfPoint(playerid, 4.0, mBiz[i2][b_enX], mBiz[i2][b_enY], mBiz[i2][b_enZ])
			&& GetPlayerVirtualWorld(playerid) == 0)
			{
				if(mBiz[i2][b_enX] == mBiz[i2][b_exX]
				&& mBiz[i2][b_enY] == mBiz[i2][b_exY]
				&& mBiz[i2][b_enX] == mBiz[i2][b_exZ])
				{
					sendErrorMessage(playerid, "Ten biznes nie posiada wn�trza!"); 
					sendTipMessage(playerid, "Aby skorzysta� z udogodnie� biznesu sta� w jego ikonce"); 
				}
				else
				{
					SetPlayerPos(playerid, mBiz[i2][b_exX], mBiz[i2][b_exY], mBiz[i2][b_exZ]);
					SetPlayerVirtualWorld(playerid, mBiz[i2][b_vw]);
					SetPlayerInterior(playerid, mBiz[i2][b_int]); 
					SetPLocal(playerid, mBiz[i2][b_pLocal]);
					format(string, sizeof(string), "%s", mBiz[i2][b_motd]);
					sendTipMessageEx(playerid, COLOR_GREEN, string); 
				}
				return 1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 4.0, mBiz[i2][b_exX], mBiz[i2][b_exY], mBiz[i2][b_exZ])
			&& GetPlayerVirtualWorld(playerid) != 0)
			{
				SetPlayerPos(playerid, mBiz[i2][b_enX], mBiz[i2][b_enY], mBiz[i2][b_enZ]);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0); 
				SetPLocal(playerid, PLOCAL_DEFAULT);
				format(string, sizeof(string), "Zapraszamy ponownie do %s!", mBiz[i2][b_Name]);
				sendTipMessageEx(playerid, COLOR_GREEN, string); 
				return 1;	
			}
		}
	}
	return 0; 
}
CheckPlayerBusiness(playerid)
{
	for(new i; i <= MAX_BIZ; i++)
	{
		if(BizExist(i))
		{
			if(mBiz[i][b_ownerUID] == PlayerInfo[playerid][pUID])
			{
				PlayerInfo[playerid][pBusinessOwner] = i;
				sendTipMessage(playerid, "Pomy�lnie przypisano biznes");  
				break;
			}
		}
	}
	return 1;
}
GetTypeNameBiz(bIDE)
{
	new typeName[64];
	format(typeName, 64, "Brak"); 
	if(mBiz[bIDE][b_TYPE] == BTYPE_SERVICES)
	{
		if(mBiz[bIDE][b_TYPE2] == BTYPE2_SHOP)
		{
			format(typeName, sizeof(typeName), "Sklep 24-7"); 
		}
		else if(mBiz[bIDE][b_TYPE2] == BTYPE2_CLOTHESSHOP)
		{
			format(typeName, sizeof(typeName), "Sklep z ubraniami");
		}
		else if(mBiz[bIDE][b_TYPE2] == BTYPE2_CASINO)
		{
			format(typeName, sizeof(typeName), "Kasyno");
		}
		else if(mBiz[bIDE][b_TYPE2] == BTYPE2_RESTAURANT)
		{
			format(typeName, sizeof(typeName), "Restauracja");
		}
	}
	else if(mBiz[bIDE][b_TYPE] == BTYPE_INDUSTRY)
	{
		format(typeName, sizeof(typeName), "Przemys�owe co�"); 
	}
	return typeName;
}
//end