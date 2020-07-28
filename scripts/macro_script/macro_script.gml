function macro_script() {
	
#macro BOARD_WIDTH 640
#macro BOARD_HEIGHT 640
#macro SQUARE_SIZE 80

// #macro WHITE 0
// #macro BLACK 1
//#macro WHITESIDE 32
//#macro BLACKSIDE 64

//#macro PAWN 1
//#macro PROMOTING_PAWN 2
//#macro MOVING2_PAWN 3
//#macro KNIGHT 4
//#macro BISHOP 5
//#macro LEFT_ROOK 6
//#macro RIGHT_ROOK 7
//#macro ROOK 8
//#macro QUEEN 9
//#macro KING 10
//#macro KING_CCL 11
//#macro KING_CCR 12
//#macro KING_CCB 13

#macro SOUTH 0
#macro NORTH 1

#macro VKING 20000
#macro VQUEEN 1000
#macro VROOK 550
#macro VBISHOP 350
#macro VKNIGHT 350
#macro VPAWN 100


//#macro WHITE_PAWN 1
//#macro WHITE_PAWN_MOVED2 2
//#macro WHITE_ROOK_LEFT 3
//#macro WHITE_ROOK_RIGHT 4
//#macro WHITE_KNIGHT 5
//#macro WHITE_BISHOP 6
//#macro WHITE_QUEEN 7
//#macro WHITE_KING 

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


//enum White	
//{
//	Pawn,
//	MovingPawn,
//	PromotingPawn,
//	LeftRook,
//	RightRook,
//	Rook,
//	Knight,
//	Bishop,
//	Queen,
//	King,
//	KingCCL,
//	KingCCR,
//	KingCCB,
//}

//enum Black
//{
//	Pawn,
//	MovingPawn,
//	PromotingPawn,
//	LeftRook,
//	RightRook,
//	Rook,
//	Knight,
//	Bishop,
//	Queen,
//	King,
//	KingCCL,
//	KingCCR,
//	KingCCB,
//}
	
}


