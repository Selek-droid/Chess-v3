

if keyboard_check_pressed(vk_space)
{
	global.HermioneColor = BLACKSIDE;
	room_goto_next();
}

if keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_control)
{
	global.HermioneColor = WHITESIDE;
	room_goto_next();
}

if keyboard_check_pressed(vk_down) 
{
	global.HermioneColor = BLACKSIDE;
	global.endgameSetup = true;
	room_goto_next();
}

if keyboard_check_pressed(vk_escape)
	game_end();