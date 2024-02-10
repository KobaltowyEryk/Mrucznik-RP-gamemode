//------------------------------------------<< Generated source >>-------------------------------------------//
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
// Kod wygenerowany automatycznie narz�dziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN� NADPISANE PO WYWO�ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------
#include "lidercar_impl.pwn"

//-------<[ initialize ]>-------
command_lidercar()
{
    new command = Command_GetID("lidercar");

    //aliases
    Command_AddAlt(command, "liderveh");
    Command_AddAlt(command, "leadercar");
    Command_AddAlt(command, "leaderveh");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:lidercar(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda dla lider�w frakcji i organizacji pozwalaj�ca zarz�dza� ich pojazdem.");
        return 1;
    }
    //fetching params
    new akcja[8], opcje[256];
    if(sscanf(params, "s[8]S()[256]", akcja, opcje))
    {
        sendTipMessage(playerid, "U�yj /lidercar [parkuj/przemaluj/ranga] [opcje specyficzne dla wybranej akcji] ");
        return 1;
    }
    
    //command body
    return command_lidercar_Impl(playerid, akcja, opcje);
}