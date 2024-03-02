//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  lidercar                                                 //
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
// Autor: mrucznik
// Data utworzenia: 10.02.2024


//

//------------------<[ Implementacja: ]>-------------------
command_lidercar_Impl(playerid, akcja[16], opcje[256])
{
    if(!orgIsLeader(playerid) && PlayerInfo[playerid][pLider] == 0)
    {
        sendErrorMessage(playerid, "Nie jeste� liderem!");
        return 1;
    }

	if(!IsPlayerInAnyVehicle(playerid))
	{
        sendErrorMessage(playerid, "Musisz by� w poje�dzie, kt�ry chcesz edytowa�!");
        return 1;
    }

    new vehicleID = GetPlayerVehicleID(playerid);
    new vehicleUID = VehicleUID[vehicleID][vUID];
	if(!IsPlayerOwnFractionCar(playerid, vehicleID))
	{
        sendErrorMessage(playerid, "Ten pojazd nie nale�y do Twojej organizacji!");
        return 1;
    }
    if(strcmp(akcja, "", true) != 0)
        Log(serverLog, INFO, "Lider %s u�y� /lidercar, akcja: %s", GetNick(playerid), akcja);
    // choose command action
	if(strcmp(akcja, "parkuj", true) == 0) {
        command_lidercar_parkuj(playerid);
    } else if(strcmp(akcja, "przemaluj", true) == 0) {
        command_lidercar_przemaluj(playerid, vehicleID, opcje);
    } else if(strcmp(akcja, "ranga", true) == 0) {
        command_lidercar_ranga(playerid, vehicleUID, opcje);
    } else {
        sendErrorMessage(playerid, "Niepoprawna opcja!");
        StaryCzas[playerid] -= 200;
        Command_ReProcess(playerid, "lidercar", true);
    }

    return 1;
}

command_lidercar_parkuj(playerid)
{
    StaryCzas[playerid] -= 200;
    Command_ReProcess(playerid, "zaparkuj", false);
    return 1;
}

command_lidercar_przemaluj(playerid, vehicleID, opcje[256])
{
    new color1, color2;
    if(sscanf(opcje, "dd", color1, color2))
    {
        sendTipMessage(playerid, "U�yj /lidercar przemaluj [kolor 1] [kolor 2]");
        sendTipMessage(playerid, "Uwaga! Koszt przemalowania: 1500$");
        return 1;
    }

    // change color
    ChangeVehicleColor(vehicleID, color1, color2);
    MRP_ChangeVehicleColor(vehicleID, color1, color2);

    // send message, take money
    SendClientMessage(playerid, COLOR_PINK, "Pojazd przemalowany! -1500$");
    ZabierzKase(playerid, 1500);
    return 1;
}

command_lidercar_ranga(playerid, vehicleUID, opcje[256])
{
    new rank;
    if(sscanf(opcje, "d", rank))
    {
        sendTipMessage(playerid, "U�yj /lidercar ranga [ranga od kt�rej mo�na u�ywa� pojazdu]");
        return 1;
    }

    if(rank < 0 || rank > 9) 
    {
        sendErrorMessage(playerid, "Ranga od 0 do 9!");
        return 1;
    }

    // save rank
    CarData[vehicleUID][c_Rang] = rank;
    Car_Save(vehicleUID, CAR_SAVE_OWNER);

    // send message
    new string[128];
    format(string, sizeof(string), "Od teraz tylko osoby z %d rang� b�d� mog�y u�ywa� tego pojazdu.", rank);
    SendClientMessage(playerid, COLOR_PINK, string);
    return 1;
}

//end