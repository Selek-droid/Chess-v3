

if keyboard_check_pressed(vk_space)
{
	global.HermioneColor = COLOR.BLACK;
	room_goto_next();
}

if keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_control)
{
	global.HermioneColor = COLOR.WHITE;
	room_goto_next();
}

if keyboard_check_pressed(vk_down) 
{
	global.HermioneColor = COLOR.BLACK;
	global.endgameSetup = true;
	room_goto_next();
}

if keyboard_check_pressed(vk_escape)
	game_end();