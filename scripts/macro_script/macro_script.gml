function macro_script() {
	
#macro BOARD_WIDTH 640
#macro BOARD_HEIGHT 640
#macro SQUARE_SIZE 80

#macro SOUTH 0
#macro NORTH 1

#macro VKING 20000
#macro VQUEEN 1000
#macro VROOK 550
#macro VBISHOP 350
#macro VKNIGHT 350
#macro VPAWN 100

#macro ITS_COLOR 8
#macro ITS_TYPE 7

enum COLOR 
{
    WHITE = 0,
    BLACK = 8
}
enum PIECE 
{
    KING = 6,
    QUEEN = 5,
    ROOK = 4,
    BISHOP = 3,
    KNIGHT = 2,
    PAWN = 1,
}

enum WHITE_CASTLE
{
	BOTH_WAYS = 3,
	ONLY_LEFT = 2,
	ONLY_RIGHT = 1,
	NOPE = 0,
}

enum BLACK_CASTLE
{
	BOTH_WAYS = 3,
	ONLY_LEFT = 2,
	ONLY_RIGHT = 1,
	NOPE = 0,
}

enum EN_PASSANT
{
	P6 = 7, // if on column 8, switch will default to it. Saving space.
	P5 = 6,
	P4 = 5,
	P3 = 4,
	P2 = 3,
	P1 = 2,
	P0 = 1,
	UNAVAILBLE = 0
}
}

function GetXCoordinate(mapIndex)
{
	var xCoord = mapIndex mod 8;
}


