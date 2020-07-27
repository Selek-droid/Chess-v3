

if keyboard_check_pressed(vk_space)
{
	global.HermioneColor = BLACK;
	room_goto_next();
}

if keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_control)
{
	global.HermioneColor = WHITE;
	room_goto_next();
}

if keyboard_check_pressed(vk_down) 
{
	global.HermioneColor = BLACK;
	global.endgameSetup = true;
	room_goto_next();
}

if keyboard_check_pressed(vk_escape)
	game_end();