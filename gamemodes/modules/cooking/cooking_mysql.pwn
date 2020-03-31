//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                  cooking                                                  //
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
// Data utworzenia: 03.03.2020
//Opis:
/*
	System gotowania potraw
*/

//

// DB structure:
// CREATE TABLE IF NOT EXISTS `mru_player_cooking` (
// `id` int(11) NOT NULL,
//   `owner` int(11) NOT NULL,
//   `model` int(11) NOT NULL,
//   `name` varchar(20) COLLATE latin1_general_ci NOT NULL,
//   `weight` int(11) NOT NULL,
//   `type` int(11) NOT NULL
// ) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
//
// ALTER TABLE `mru_player_cooking` ADD PRIMARY KEY (`id`), ADD KEY `owner` (`owner`);
// ALTER TABLE `mru_player_cooking` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;


//------------------<[ MySQL: ]>--------------------
MruMySQL_CookedMealsDialog(playerid)
{
	//TODO: MySQL
	new string[(44+MAX_COOKED_NAME)*50]; //message length: 12+1+MAX_COOKED_NAME+9+12+2=56, 64 for safety

	new Cache:result = mysql_query(mruMySQL_Connection, 
		sprintf("SELECT id, model, name, weight, type FROM mru_player_cooking WHERE owner='%d' ORDER BY id DESC LIMIT 50", 
		PlayerInfo[playerid][pUID]
	));

	if(cache_is_valid(result))
	{
		new rows = cache_num_rows();
		new id, model, name[MAX_COOKED_NAME], weight, type;
		DynamicGui_Init(playerid);
		for(new i; i < rows; i++)
		{
			cache_get_value_index_int(i, 0, id);
			cache_get_value_index_int(i, 1, model);
			cache_get_value_index(i, 2, name);
			cache_get_value_index_int(i, 3, weight);
			cache_get_value_index_int(i, 4, type);

			strcat(string, sprintf("%i\t%s~n~~g~~h~%dg\n", model, Odpolszcz(name), weight));
			DynamicGui_AddRow(playerid, id);
		}
		if(rows == 0)
		{
			sendErrorMessage(playerid, "Nie masz nic do zjedzenia.");
			return 1;
		}
		string[strlen(string)-1] = '\0';
		cache_delete(result);
	}

    ShowPlayerDialogEx(playerid, DIALOG_EATING, DIALOG_STYLE_PREVIEW_MODEL, "Twoje potrawy", string, "Jedz", "Anuluj");
	return 1;
}

MruMySQL_AddCookedMeal(playerid, model, name[], weight, type)
{
	mysql_query(mruMySQL_Connection, 
		sprintf("INSERT INTO mru_player_cooking (owner, model, name, weight, type) VALUES ('%d', '%d', '%s', '%d', '%d')",
		PlayerInfo[playerid][pUID], model, name, weight, type
	));
	return cache_insert_id();
}

MruMySQL_EatCookedMeal(playerid, id)
{
	//TODO: MySQL
	// new result[128];
	// new name[MAX_COOKED_NAME], weight, type;

	// mysql_query(sprintf("SELECT name, weight, type FROM mru_player_cooking WHERE id='%d'", id));
	// mysql_store_result();
	// {
	// 	mysql_fetch_row_format(result, "|");
	// 	sscanf(result, "p<|>s["#MAX_COOKED_NAME"]dd", name, weight, type);
    //     mysql_free_result();
	// }

	// EatCookedMeal(playerid, name, weight, type);

	// mysql_query(sprintf("DELETE FROM mru_player_cooking WHERE id='%d'", id));
	// return;
}

//end