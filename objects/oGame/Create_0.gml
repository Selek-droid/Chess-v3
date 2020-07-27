state = "Initializing";
AIOpening = true;
AIMadeScriptedMove = false;
history = ds_list_create();
formattedHistory = ds_list_create();
turn = 1;
depthOfSearch = 1;
testDepth = 2;

if global.HermioneColor == BLACK
{
notationX[7] = "h";
notationX[6] = "g";
notationX[5] = "f";
notationX[4] = "e";
notationX[3] = "d";
notationX[2] = "c";
notationX[1] = "b";
notationX[0] = "a";

notationY[7] = "1";
notationY[6] = "2";
notationY[5] = "3";
notationY[4] = "4";
notationY[3] = "5";
notationY[2] = "6";
notationY[1] = "7";
notationY[0] = "8";
}

else
{
notationX[7] = "a";
notationX[6] = "b";
notationX[5] = "c";
notationX[4] = "d";
notationX[3] = "e";
notationX[2] = "f";
notationX[1] = "g";
notationX[0] = "h";
	
notationY[7] = "8";
notationY[6] = "7";
notationY[5] = "6";
notationY[4] = "5";
notationY[3] = "4";
notationY[2] = "3";
notationY[1] = "2";
notationY[0] = "1";
}