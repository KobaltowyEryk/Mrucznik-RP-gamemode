//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   dmvon                                                   //
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
// Data utworzenia: 24.09.2019


//

//------------------<[ Implementacja: ]>-------------------
command_dmvon_Impl(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 10 || IsAScripter(playerid))
    {
        new string[124];
        CreateActorsInDMV(playerid);
        sendTipMessage(playerid, "W��czy�e� boty w urz�dzie miasta LS!");
        format(string, sizeof(string), "Administrator %s w��czy� zautomatyzowany Urz�d miasta na godzin�!"); 
        SendMessageToAdminEx(string, COLOR_P@, 2);     
    }
    else
    {
        noAccessMessage(playerid); 
    }
    return 1;
}

//end