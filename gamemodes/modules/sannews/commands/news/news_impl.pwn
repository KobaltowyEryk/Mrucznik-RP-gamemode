//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    news                                                   //
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
// Data utworzenia: 13.09.2019


//

//------------------<[ Implementacja: ]>-------------------
command_news_Impl(playerid, newsText[256])
{
    if(!IsASN(playerid))
    {
        sendErrorMessage(playerid, "Nie jeste� z frakcji San News!"); 
        return 1;
    }
    else
    {
        if(PlayerInfo[playerid][pRank] == 0) return sendErrorMessage(playerid, "Masz za nisk� rang�!"); 
    }

    if(AntySpam[playerid] == 1)
    {
        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 3 sekund");
        return 1;
    }
    if(!PlayerConditionToNews(playerid))
    {
        return 1;
    }
    if(strlen(newsText) < 3)
    {
        sendTipMessage(playerid, "/news [Tekst]");
        return 1;
    }
    if(strlen(newsText) > 105)
    {
        sendErrorMessage(playerid, "Twoja wiadomo�� by�a zbyt d�uga, skr�� j�!"); 
        return 1;
    }
    if(strfind(newsText, "@here", true) != -1 || strfind(newsText, "@everyone", true) != -1 || strfind(newsText, "<@", true) != -1) 
    {
        SendClientMessage(playerid, COLOR_WHITE, "Tw�j news zawiera niedozwolone znaki! (@)");
        return 1;
    }
    TalkOnNews(playerid, newsText);
    return 1;
}

//end