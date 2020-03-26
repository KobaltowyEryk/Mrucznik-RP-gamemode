//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  choroby                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 07.02.2020
//Opis:
/*
	System chor�b.
*/

//

//-----------------<[ Funkcje: ]>-------------------
//Koronawirus
public WuhanCouching(playerid, disease, value)
{
	ChatMe(playerid, "zaczyna kaszle�.");
	ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0, 1);
	return 1;
}
public DusznosciEffect(playerid, disease, value)
{
	ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0999, 0, 1, 1, 1, 1, 1);
	ChatMe(playerid, "zaczyna si� dusi�.");
	defer LoweringHP(playerid, PlayerInfo[playerid][pUID], value, true, false);
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}
public FeverEffect(playerid, disease, value)
{
	ChatMe(playerid, "ma gor�czk�, poci si� i czuje si� s�abo.");
	new Float:hp;
	GetPlayerHealth(playerid, hp);

	new Float:loss = value;
	SetPlayerHealth(playerid, (hp - loss < 0) ? 1.0 : hp-loss);
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}
public KoronawirusDeathEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("Koronawirus doszcz�tnie wyniszczy� organizm %s", GetNick(playerid)));
	ChatMe(playerid, "upada na ziemie i zaczyna umiera�");
	TogglePlayerControllable(playerid, 0);
	defer LoweringHP(playerid, PlayerInfo[playerid][pUID], value, true, true);
	ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0999, 0, 1, 1, 1, 1, 1);
	return 1;
}

//Grypa
public FeelingBadEffect(playerid, disease, value)
{
	ChatMe(playerid, "poczu� si� �le.");
	ApplyAnimation(playerid, "FAT", "IDLE_tired", 4.0999, 0, 0, 0, 0, 0, 1);
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}
public CouchingEffect(playerid, disease, value)
{
	ChatMe(playerid, "zaczyna kaszle�.");
	ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0, 1);

	if(random(20) == 1)//5% szans
	{
		InfectPlayer(playerid, ZAPALENIE_PLUC);
	}
	return 1;
}
public HPLossEffect(playerid, disease, value)
{
	new Float:hp;
	GetPlayerHealth(playerid, hp);

	new Float:loss = value;
	SetPlayerHealth(playerid, (hp - loss < 0) ? 1.0 : hp-loss);
	ChatMe(playerid, "czuje si� s�abo.");
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}

//Zapalenie p�uc
public HPLossToDeathEffect(playerid, disease, value)
{
	new Float:hp;
	GetPlayerHealth(playerid, hp);

	new Float:loss = value;
	if(hp - loss <= 0)
	{
		NadajRanny(playerid, INJURY_TIME_DISEASES);
	}
	else SetPlayerHealth(playerid, hp-loss);
	ChatMe(playerid, "poczu� mocny b�l.");
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}

//Zatrucie
public FartEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("wok� %s unosi si� nieprzyjemna wo� przetrawionego jedzenia.", GetNick(playerid)));
	return 1;
}
public DiarrheaEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("z nogawki %s cieknie br�zowy p�yn.", GetNick(playerid)));
	return 1;
}
public ShittingEffect(playerid, disease, value)
{
	ChatMe(playerid, "nie wytrzymuje ci�nienia i zaczyna defekowa� si� w gacie.");
	return 1;
}
public AbdominalPainEffect(playerid, disease, value)
{
	ChatMe(playerid, "czuje ostry b�l �o��dka.");
	new Float:hp;
	GetPlayerHealth(playerid, hp);

	new Float:loss = value;
	SetPlayerHealth(playerid, (hp - loss < 0) ? 1.0 : hp-loss);
}
public VomitEffect(playerid, disease, value)
{
	ChatMe(playerid, "zaczyna wymiotowa�.");
	ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.0999, 0, 0, 0, 0, 0, 1);
	return 1;
}

//Padaka
public EpilepsyEffect(playerid, disease, value)
{
	ApplyAnimation(playerid, "CRACK", "crckdeth1", 4.1, 0, 1, 1, 1, 1, 1);
	ChatMe(playerid, "upada na ziemi� i zaczyna si� trz��� oraz wykonywa� niekontrolowane ruchy.");
	TogglePlayerControllable(playerid, 0); //TODO: nie odmra�a� gdy gracz ju� by� zamro�ony
	defer LoweringHP(playerid, PlayerInfo[playerid][pUID], value, true, true);
	return 1;
}

//Tourett
public TourettShoutEffect(playerid, disease, value)
{
	//TODO:
	// static shouts[][] = {
	// 	""
	// };

	// Krzyk(playerid, shouts[random(sizeof(shouts))]);
	switch(random(4))
	{
		case 0: ChatMe(playerid, "chrz�ka.");
		case 1: ChatMe(playerid, "wykonuje tik nerwowy.");
		case 2: ChatMe(playerid, "uderza si� d�oni� w g�ow�.");
		case 3: ChatMe(playerid, "miauczy.");
	}
}
public TourettPermanentEffect(playerid, disease, value)
{
	TourettActive[playerid] = 1;
}
public TourettPermanentEffect_Off(playerid, disease, value)
{
	TourettActive[playerid] = 0;
}

//Astma
public AnaphylacticShock(playerid, disease, value)
{
	ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0999, 0, 1, 1, 1, 1, 1);
	ChatMe(playerid, "nie mo�e oddycha� i zaczyna si� dusi�.");
	TogglePlayerControllable(playerid, 0); //TODO: nie odmra�a� gdy gracz ju� by� zamro�ony
	defer LoweringHP(playerid, PlayerInfo[playerid][pUID], value, true, true);
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}

//Schizofrenia paranoidalna
//TODO: wi�cej efekt�w
public HallucinationsEffect(playerid, disease, value)
{
	ChatMe(playerid, "zaczyna widzie� niestworzone rzeczy.");
	SetPlayerDrunkLevel(playerid, 8000);
	SetPlayerWeather(playerid, -66);
	defer HallucinationsOff(playerid);
	return 1;
}

//Zombie effects
public ZombieSkinEffect(playerid, disease, value)
{
	//TODO
	SetPlayerSkin(playerid, 20004+random(3));
	return 1;
}
public ZombieSkinEffect_Off(playerid, disease, value)
{
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	return 1;
}
public ZombieTalkEffect(playerid, disease, value)
{
	//TODO
}

//HIV
public ReducedImmunityEffect(playerid, disease, value)
{
	ChatMe(playerid, "czuje, �e jego organizm ma obni�on� odporno��");
	PlayerImmunity[playerid] = 1;
	DecreaseImmunity(playerid);
	return 1;
}
public RandomInfectionEffect(playerid, disease, value)
{
	new rand = random(eDiseases);
	InfectPlayer(playerid, eDiseases:rand);
}

//Astygmatyzm
public AstigmatismEffect(playerid, disease, value)
{
	ChatMe(playerid, "widzi niewyra�nie.");
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 1);
	return 1;
}
public AstigmatismEffect_Off(playerid, disease, value)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 1000);
	return 1;
}

//Parkinson/niedow�ad r�k
public ShakingHandsEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("r�ce %s zaczynaj� si� trz��� w niekontrolowany przez niego spos�b.", GetNick(playerid)));
	return 1;
}
public ShootingSkillEffect(playerid, disease, value)
{
	ChatMe(playerid, "trz�s� mu si� r�ce.");
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 1);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 1);

	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 1);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 1);

	return 1;
}
public ShootingSkillEffect_Off(playerid, disease, value)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 1000);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 500);
	return 1;
}

//Uraz
public BleedingEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("Z rany %s zaczyna p�yn�� krew.", GetNick(playerid)));
	defer LoweringHP(playerid, PlayerInfo[playerid][pUID], value, false, false);
	return 1;
}
public GetGangreneEffect(playerid, disease, value)
{
	if(random(20) == 1) //5% szans
	{
		InfectPlayer(playerid, GANGRENA);
	}
	return 1;
}
public FaintEffect(playerid, disease, value)
{
	ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0999, 0, 1, 1, 1, 1, 1);
	ChatMe(playerid, "omdla�.");
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}

//Gangrena
public PurulenceEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("Z rany %s zaczyna wycieka� ropa.", GetNick(playerid)));
	defer LoweringHP(playerid, PlayerInfo[playerid][pUID], value, true, false);

	if(random(20) == 0)
	{
		InfectPlayer(playerid, PARKINSON);
	}
	return 1;
}
public RottenFleshEffect(playerid, disease, value)
{
	ChatMe(playerid, "gor�czkuje, a z jego rany wydobywa si� smr�d zgnilizny.");
	defer LoweringHP(playerid, PlayerInfo[playerid][pUID], value, false, false);
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}

//PTSD
public HideWeaponEffect(playerid, disease, value)
{
	SetPlayerArmedWeapon(playerid, 0);
	ChatMe(playerid, "jest wyra�nie zestresowany");
	Krzyk(playerid, "RATUNKU, POMOCY! To znowu Oni!");
	return 1;
}
public ThrowWeaponEffect(playerid, disease, value)
{
	new weapon = GetPlayerWeapon(playerid);
	ChatMe(playerid, "przera�ony powracaj�cymi wspomnieniami w postaci halucynacji, wyrzuca trzyman� bro�.");
	RemoveWeaponFromSlot(playerid, GetWeaponSlot(weapon));
	return 1;
}
public ThrowAllWeaponsEffect(playerid, disease, value)
{
	ChatMe(playerid, "panikuje i pozbywa si� wszelkiego uzbrojenia.");
	Command_ReProcess(playerid, "wyrzucbronie", false);
	return 1;
}
public FearEffect(playerid, disease, value)
{
	ChatMe(playerid, "zaczyna odczuwa� irracjonalny strach.");
	ApplyAnimation(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0, 1);
	return 1;
}

//others
public BlackoutEffect(playerid, disease, value)
{
	ShowPlayerFadeScreenToBlank(playerid, 20, 255, 255, 255, 255);
	SetPlayerDrunkLevel(playerid, 3000);
	return 1;
}
public DeathEffect(playerid, disease, value)
{
	ChatMe(playerid, "umar� na skutek choroby.");
	NadajBW(playerid, INJURY_TIME_DISEASES);
	ZespawnujGraczaSzpitalBW(playerid);
	return 1;
}


//effects timers
timer LoweringHP[500](playerid, uid, hpLoss, bool:death, bool:freeze)
{
	if(!IsPlayerConnected(playerid) || uid != PlayerInfo[playerid][pUID]) 
		return;

	if(hpLoss <= 0) 
	{
		if(freeze) TogglePlayerControllable(playerid, 1);
		return;
	}

	new Float:hp;
	GetPlayerHealth(playerid, hp);
	if(hp <= 2)
	{
		if(death)
		{
			ChatMe(playerid, "umar� na skutek choroby");
			NadajBW(playerid, INJURY_TIME_DISEASES);
			ZespawnujGraczaSzpitalBW(playerid);
		}
		return;
	}
	SetPlayerHealth(playerid, hp-1);

	if(PlayerImmunity[playerid] <= 0)
		defer LoweringHP(playerid, uid, hpLoss-1, death, freeze);
}

timer HallucinationsOff[60000](playerid)
{
	SetPlayerWeather(playerid, ServerWeather);
}
