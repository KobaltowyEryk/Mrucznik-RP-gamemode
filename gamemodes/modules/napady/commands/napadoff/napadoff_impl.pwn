//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    anim                                                    //
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
// Autor: Sanda�
// Data utworzenia: 17.02.2024


//

//------------------<[ Implementacja: ]>-------------------
command_napadoff_Impl(playerid)
{
    if(PlayerInfo[playerid][pAdmin] > 0 || IsAScripter(playerid))
    {
        new string[256];
        Heist_HeistOFF = 1;
        format(string, sizeof(string), "%s [ID: %d] wy��czy� napady.", GetNickEx(playerid), playerid);
		ABroadCast(COLOR_PANICRED,string,1);
        SendCommandLogMessage(string);
		Log(adminLog, INFO, "%s manualnie wy��czy� system napad�w.", GetPlayerLogName(playerid));  
    }
    return 1;
}

//end