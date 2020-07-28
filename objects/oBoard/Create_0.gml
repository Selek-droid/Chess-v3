#region Declarations

x = (room_width/2) - (BOARD_WIDTH/2);
y = (room_height/2) - (BOARD_HEIGHT/2);

GrangerColor = global.HermioneColor;

selectedPiece = 0;
pickedUp = false;
oldIndex = 0;
newIndex = 0;
capture = false;

animateSprite = false;
spriteInMotion = false;




spriteX = 0;
spriteY = 0;
deltaX = 0;
deltaY = 0;
loc = 0;

// contents of squares: Piece, Color.

contents[1] = 0;
contents[0] = 0;

SouthCanCastleLeft = true;
SouthCanCastleRight = true;
NorthCanCastleLeft = true;
NorthCanCastleRight = true;

CaptureTimer = 0;
RepetitionTimer = 0;


BlackRook = COLOR.BLACK | PIECE.ROOK;
BlackKnight = COLOR.BLACK | PIECE.KNIGHT;
BlackBishop = COLOR.BLACK | PIECE.BISHOP;
BlackKing = COLOR.BLACK | PIECE.KING;
BlackQueen = COLOR.BLACK | PIECE.QUEEN;
BlackPawn = COLOR.BLACK | PIECE.PAWN;
WhiteRook = COLOR.WHITE | PIECE.ROOK;
WhiteKnight = COLOR.WHITE | PIECE.KNIGHT;
WhiteBishop = COLOR.WHITE | PIECE.BISHOP;
WhiteKing = COLOR.WHITE | PIECE.KING;
WhiteQueen = COLOR.WHITE | PIECE.QUEEN;
WhitePawn = COLOR.WHITE | PIECE.PAWN;

#endregion

// Initialize and populate board.

for (var xx = 0; xx < 72; xx += 1;) map[xx] = 0;

if !(global.endgameSetup)
{
	if (global.HermioneColor == COLOR.BLACK)
	{
		map[0] = COLOR.BLACK | PIECE.ROOK;
		map[1] = COLOR.BLACK | PIECE.KNIGHT;
		map[2] = BlackBishop;
		map[3] = BlackKing;
		map[4] = BlackQueen;
		map[5] = BlackBishop;
		map[6] = BlackKnight;
		map[7] = BlackRook;
		map[8] = BlackPawn;
		map[9] = BlackPawn;
		map[10] = BlackPawn;
		map[11] = BlackPawn;
		map[12] = BlackPawn;
		map[13] = BlackPawn;
		map[14] = BlackPawn;
		map[15] = BlackPawn;
		map[48] = WhitePawn;
		map[49] = WhitePawn;
		map[50] = WhitePawn;
		map[51] = WhitePawn;
		map[52] = WhitePawn;
		map[53] = WhitePawn;
		map[54] = WhitePawn;
		map[55] = WhitePawn;
		map[56] = WhiteRook;
		map[57] = WhiteKnight;
		map[58] = WhiteBishop;
		map[59] = WhiteQueen;
		map[60] = WhiteKing;
		map[61] = WhiteBishop;
		map[62] = WhiteKnight;
		map[63] = WhiteRook;
		map[64] = SOUTH;   // where is mover sitting
		map[65] = COLOR.WHITE;   // whose turn
		map[66] = WHITE_CASTLE.BOTH_WAYS;
		map[67] = BLACK_CASTLE.BOTH_WAYS; 
		map[68] = CaptureTimer;   // For 50-move stalemnate
		map[69] = RepetitionTimer;   // for stalemate
		map[70] = EN_PASSANT.UNAVAILBLE;
	}

	else if global.HermioneColor == COLOR.WHITE
	{
		map[0] = WhiteRook;
		map[1] = WhiteKnight;
		map[2] = WhiteBishop;
		map[3] = WhiteKing;
		map[4] = WhiteQueen;
		map[5] = WhiteBishop;
		map[6] = WhiteKnight;
		map[7] = WhiteRook;
		map[8] = WhitePawn;
		map[9] = WhitePawn;
		map[10] = WhitePawn;
		map[11] = WhitePawn;
		map[12] = WhitePawn;
		map[13] = WhitePawn;
		map[14] = WhitePawn;
		map[15] = WhitePawn;
		map[48] = BlackPawn;
		map[49] = BlackPawn;
		map[50] = BlackPawn;
		map[51] = BlackPawn;
		map[52] = BlackPawn;
		map[53] = BlackPawn;
		map[54] = BlackPawn;
		map[55] = BlackPawn;
		map[56] = BlackRook;
		map[57] = BlackKnight;
		map[58] = BlackBishop;
		map[59] = BlackQueen;
		map[60] = BlackKing;
		map[61] = BlackBishop;
		map[62] = BlackKnight;
		map[63] = BlackRook;
		map[64] = SOUTH;   // where is mover sitting
		map[65] = COLOR.WHITE;   // whose turn
		map[66] = WHITE_CASTLE.BOTH_WAYS;
		map[67] = BLACK_CASTLE.BOTH_WAYS; 
		map[68] = CaptureTimer;   // For 50-move stalemnate
		map[69] = RepetitionTimer;   // for stalemate
		map[70] = EN_PASSANT.UNAVAILBLE;
	}
}

if global.endgameSetup
{
	global.HermioneColor = COLOR.BLACK;
	map[3] = BlackKing;
	map[11] = WhitePawn;
	map[19] = WhiteKing;
}
	
// Piece-square tables ============================================

AIpawnTable [63] = 1000;  // AI back rank; pawns never here until promoted
AIpawnTable [62] = 1000;
AIpawnTable [61] = 1000;
AIpawnTable [60] = 1000;
AIpawnTable [59] = 1000;
AIpawnTable [58] = 1000;
AIpawnTable [57] = 1000;
AIpawnTable [56] = 1000;

AIpawnTable [55] = 50;  // AI on verge of promotion
AIpawnTable [54] = 50;
AIpawnTable [53] = 50;
AIpawnTable [52] = 50;
AIpawnTable [51] = 50;
AIpawnTable [50] = 50;
AIpawnTable [49] = 50;
AIpawnTable [48] = 50;

AIpawnTable [47] = 10;  // AI control center][player's side of board 
AIpawnTable [46] = 10;
AIpawnTable [45] = 20;
AIpawnTable [44] = 30;
AIpawnTable [43] = 30;
AIpawnTable [42] = 20;
AIpawnTable [41] = 10;
AIpawnTable [40] = 10;

AIpawnTable [7][4] = 5;  // AI control center][player side of board 
AIpawnTable [6][4] = 5;
AIpawnTable [5][4] = 10;
AIpawnTable [4][4] = 25;
AIpawnTable [3][4] = 25;
AIpawnTable [2][4] = 10;
AIpawnTable [1][4] = 5;
AIpawnTable [0][4] = 5;

AIpawnTable [7][3] = 0;  // AI's K4/Q4 etc][AI side of board 
AIpawnTable [6][3] = 0;
AIpawnTable [5][3] = 0;
AIpawnTable [4][3] = 20;
AIpawnTable [3][3] = 20;
AIpawnTable [2][3] = 0;
AIpawnTable [1][3] = 0;
AIpawnTable [0][3] = 0;

AIpawnTable [7][2] = 5;  // AI's K3/Q3 etc][AI side of board 
AIpawnTable [6][2] = -5;
AIpawnTable [5][2] = -10;
AIpawnTable [4][2] = 0;
AIpawnTable [3][2] = 0;
AIpawnTable [2][2] = -10;
AIpawnTable [1][2] = -5;
AIpawnTable [0][2] = 5;

AIpawnTable [7][1] = 5;  // AI's starting pawn row 
AIpawnTable [6][1] = 10;
AIpawnTable [5][1] = 10;
AIpawnTable [4][1] = -20;
AIpawnTable [3][1] = -20;
AIpawnTable [2][1] = 10;
AIpawnTable [1][1] = 10;
AIpawnTable [0][1] = 5;

AIpawnTable [7][0] = 0;  // AI's pawns never here][behind start row 
AIpawnTable [6][0] = 0;
AIpawnTable [5][0] = 0;
AIpawnTable [4][0] = 0;
AIpawnTable [3][0] = 0;
AIpawnTable [2][0] = 0;
AIpawnTable [1][0] = 0;
AIpawnTable [0][0] = 0;


// --------------------------------------------

HumanPawnTable [7][7] = 0;  // behind pawns starting spot][so never used
HumanPawnTable [6][7] = 0;
HumanPawnTable [5][7] = 0;
HumanPawnTable [4][7] = 0;
HumanPawnTable [3][7] = 0;
HumanPawnTable [2][7] = 0;
HumanPawnTable [1][7] = 0;
HumanPawnTable [0][7] = 0;

HumanPawnTable [7][6] = 5;  // human starting pawn row
HumanPawnTable [6][6] = 10;  
HumanPawnTable [5][6] = 10;  
HumanPawnTable [4][6] = -20;  
HumanPawnTable [3][6] = -20;  
HumanPawnTable [2][6] = 10;  
HumanPawnTable [1][6] = 10;  
HumanPawnTable [0][6] = 5;  

HumanPawnTable [7][5] = 5;  // row 3. Protect king; holes on edges
HumanPawnTable [6][5] = -5; 
HumanPawnTable [5][5] = -10; 
HumanPawnTable [4][5] = 0; 
HumanPawnTable [3][5] = 0; 
HumanPawnTable [2][5] = -10; 
HumanPawnTable [1][5] = -5; 
HumanPawnTable [0][5] = 5; 

HumanPawnTable [7][4] = 0; // row4. Control center.
HumanPawnTable [6][4] = 0;
HumanPawnTable [5][4] = 0;
HumanPawnTable [4][4] = 20;
HumanPawnTable [3][4] = 20;
HumanPawnTable [2][4] = 0;
HumanPawnTable [1][4] = 0;
HumanPawnTable [0][4] = 0;

HumanPawnTable [7][3] = 5;  // row 5.  Center again.
HumanPawnTable [6][3] = 5;
HumanPawnTable [5][3] = 10;
HumanPawnTable [4][3] = 25;
HumanPawnTable [3][3] = 25;
HumanPawnTable [2][3] = 10;
HumanPawnTable [1][3] = 5;
HumanPawnTable [0][3] = 5;

HumanPawnTable [7][2] = 10;  // row 6.  Center again.
HumanPawnTable [6][2] = 10;
HumanPawnTable [5][2] = 20;
HumanPawnTable [4][2] = 30;
HumanPawnTable [3][2] = 30;
HumanPawnTable [2][2] = 20;
HumanPawnTable [1][2] = 10;
HumanPawnTable [0][2] = 10;

HumanPawnTable [7][1] = 50;  // row 7.  Verge of promotion.
HumanPawnTable [6][1] = 50;
HumanPawnTable [5][1] = 50;
HumanPawnTable [4][1] = 50;
HumanPawnTable [3][1] = 50;
HumanPawnTable [2][1] = 50;
HumanPawnTable [1][1] = 50;
HumanPawnTable [0][1] = 50;

HumanPawnTable [7][0] = 1000; // row 8. Becomes different piece if promoted.
HumanPawnTable [6][0] = 1000;
HumanPawnTable [5][0] = 1000;
HumanPawnTable [4][0] = 1000;
HumanPawnTable [3][0] = 1000;
HumanPawnTable [2][0] = 1000;
HumanPawnTable [1][0] = 1000;
HumanPawnTable [0][0] = 1000;

// ============== Rook tables

AIRookTable [7][7] = 0;  // Until endgame][no reason to be here
AIRookTable [6][7] = 0;
AIRookTable [5][7] = 0;
AIRookTable [4][7] = 0;
AIRookTable [3][7] = 0;
AIRookTable [2][7] = 0;
AIRookTable [1][7] = 0;
AIRookTable [0][7] = 0;

AIRookTable [7][6] = -5;  // AI likes human second row
AIRookTable [6][6] = 10;
AIRookTable [5][6] = 10;
AIRookTable [4][6] = 10;
AIRookTable [3][6] = 10;
AIRookTable [2][6] = 10;
AIRookTable [1][6] = 10;
AIRookTable [0][6] = -5;

AIRookTable [7][5] = -5;  // keep off the edge files
AIRookTable [6][5] = 0;
AIRookTable [5][5] = 0;
AIRookTable [4][5] = 0;
AIRookTable [3][5] = 0;
AIRookTable [2][5] = 0;
AIRookTable [1][5] = 0;
AIRookTable [0][5] = -5;

AIRookTable [7][4] = -5;
AIRookTable [6][4] = 0;
AIRookTable [5][4] = 0;
AIRookTable [4][4] = 0;
AIRookTable [3][4] = 0;
AIRookTable [2][4] = 0;
AIRookTable [1][4] = 0;
AIRookTable [0][4] = -5;

AIRookTable [7][3] = -5;
AIRookTable [6][3] = 0;
AIRookTable [5][3] = 0;
AIRookTable [4][3] = 0;
AIRookTable [3][3] = 0;
AIRookTable [2][3] = 0;
AIRookTable [1][3] = 0;
AIRookTable [0][3] = -5;

AIRookTable [7][2] = -5;
AIRookTable [6][2] = 0;
AIRookTable [5][2] = 0;
AIRookTable [4][2] = 0;
AIRookTable [3][2] = 0;
AIRookTable [2][2] = 0;
AIRookTable [1][2] = 0;
AIRookTable [0][2] = -5;

AIRookTable [7][1] = -5;
AIRookTable [6][1] = 0;
AIRookTable [5][1] = 0;
AIRookTable [4][1] = 0;
AIRookTable [3][1] = 0;
AIRookTable [2][1] = 0;
AIRookTable [1][1] = 0;
AIRookTable [0][1] = -5;

AIRookTable [7][0] = 0;
AIRookTable [6][0] = 0;
AIRookTable [5][0] = 0;
AIRookTable [4][0] = 5;
AIRookTable [3][0] = 5;
AIRookTable [2][0] = 0;
AIRookTable [1][0] = 0;
AIRookTable [0][0] = 0;

// Human rooks: ----------------------------------------------------

HumanRookTable [7][7] = 0;
HumanRookTable [6][7] = 0;
HumanRookTable [5][7] = 0;
HumanRookTable [4][7] = 5;
HumanRookTable [3][7] = 5;
HumanRookTable [2][7] = 0;
HumanRookTable [1][7] = 0;
HumanRookTable [0][7] = 0;

HumanRookTable [7][6] = -5;
HumanRookTable [6][6] = 0;
HumanRookTable [5][6] = 0;
HumanRookTable [4][6] = 0;
HumanRookTable [3][6] = 0;
HumanRookTable [2][6] = 0;
HumanRookTable [1][6] = 0;
HumanRookTable [0][6] = -5;

HumanRookTable [7][5] = -5;
HumanRookTable [6][5] = 0;
HumanRookTable [5][5] = 0;
HumanRookTable [4][5] = 0;
HumanRookTable [3][5] = 0;
HumanRookTable [2][5] = 0;
HumanRookTable [1][5] = 0;
HumanRookTable [0][5] = -5;

HumanRookTable [7][4] = -5;
HumanRookTable [6][4] = 0;
HumanRookTable [5][4] = 0;
HumanRookTable [4][4] = 0;
HumanRookTable [3][4] = 0;
HumanRookTable [2][4] = 0;
HumanRookTable [1][4] = 0;
HumanRookTable [0][4] = -5;

HumanRookTable [7][3] = -5;
HumanRookTable [6][3] = 0;
HumanRookTable [5][3] = 0;
HumanRookTable [4][3] = 0;
HumanRookTable [3][3] = 0;
HumanRookTable [2][3] = 0;
HumanRookTable [1][3] = 0;
HumanRookTable [0][3] = -5;

HumanRookTable [7][2] = -5;
HumanRookTable [6][2] = 0;
HumanRookTable [5][2] = 0;
HumanRookTable [4][2] = 0;
HumanRookTable [3][2] = 0;
HumanRookTable [2][2] = 0;
HumanRookTable [1][2] = 0;
HumanRookTable [0][2] = -5;

HumanRookTable [7][1] = -5;
HumanRookTable [6][1] = 10;
HumanRookTable [5][1] = 10;
HumanRookTable [4][1] = 10;
HumanRookTable [3][1] = 10;
HumanRookTable [2][1] = 10;
HumanRookTable [1][1] = 10;
HumanRookTable [0][1] = -5;

HumanRookTable [7][0] = 0;
HumanRookTable [6][0] = 0;
HumanRookTable [5][0] = 0;
HumanRookTable [4][0] = 0;
HumanRookTable [3][0] = 0;
HumanRookTable [2][0] = 0;
HumanRookTable [1][0] = 0;
HumanRookTable [0][0] = 0;

// AI Knight table ==========================================================

AIKnightTable [7][7] = -50;  // AI's most distant row == AI K8 etc
AIKnightTable [6][7] = -40;
AIKnightTable [5][7] = -30;
AIKnightTable [4][7] = -30;
AIKnightTable [3][7] = -30;
AIKnightTable [2][7] = -30;
AIKnightTable [1][7] = -40;
AIKnightTable [0][7] = -50;

AIKnightTable [7][6] = -40;
AIKnightTable [6][6] = -20;
AIKnightTable [5][6] = 0;
AIKnightTable [4][6] = 5;
AIKnightTable [3][6] = 5;
AIKnightTable [2][6] = 0;
AIKnightTable [1][6] = -20;
AIKnightTable [0][6] = -40;

AIKnightTable [7][5] = -30;  // AI's 6th row
AIKnightTable [6][5] = 0;
AIKnightTable [5][5] = 10;
AIKnightTable [4][5] = 15;
AIKnightTable [3][5] = 15;
AIKnightTable [2][5] = 10;
AIKnightTable [1][5] = 0;
AIKnightTable [0][5] = -30;

AIKnightTable [7][4] = -30;  // AI's 5th row
AIKnightTable [6][4] = 5;
AIKnightTable [5][4] = 15;
AIKnightTable [4][4] = 20;
AIKnightTable [3][4] = 20;
AIKnightTable [2][4] = 15;
AIKnightTable [1][4] = 5;
AIKnightTable [0][4] = -30;

AIKnightTable [7][3] = -30;  // 4th row
AIKnightTable [6][3] = 0;
AIKnightTable [5][3] = 15;
AIKnightTable [4][3] = 20;
AIKnightTable [3][3] = 20;
AIKnightTable [2][3] = 15;
AIKnightTable [1][3] = 0;
AIKnightTable [0][3] = -30;

AIKnightTable [7][2] = -30;  // AI's 3rd row == AI K3 etc
AIKnightTable [6][2] = 5;
AIKnightTable [5][2] = 10;
AIKnightTable [4][2] = 15;
AIKnightTable [3][2] = 15;
AIKnightTable [2][2] = 10;
AIKnightTable [1][2] = 5;
AIKnightTable [0][2] = -30;

AIKnightTable [7][1] = -40;  // AIs 2nd row = AI K2 etc
AIKnightTable [6][1] = -20;
AIKnightTable [5][1] = 0;
AIKnightTable [4][1] = 5;
AIKnightTable [3][1] = 5;
AIKnightTable [2][1] = 0;
AIKnightTable [1][1] = -20;
AIKnightTable [0][1] = -40;

AIKnightTable [7][0] = -50;  // 1st row
AIKnightTable [6][0] = -40;
AIKnightTable [5][0] = -30;
AIKnightTable [4][0] = -30;
AIKnightTable [3][0] = -30;
AIKnightTable [2][0] = -30;
AIKnightTable [1][0] = -40;
AIKnightTable [0][0] = -30;

// Human knights ================================================================

HumanKnightTable [7][7] = -50;
HumanKnightTable [6][7] = -40;
HumanKnightTable [5][7] = -30;
HumanKnightTable [4][7] = -30;
HumanKnightTable [3][7] = -30;
HumanKnightTable [2][7] = -30;
HumanKnightTable [1][7] = -40;
HumanKnightTable [0][7] = -50;

HumanKnightTable [7][6] = -40;
HumanKnightTable [6][6] = -20;
HumanKnightTable [5][6] = 0;
HumanKnightTable [4][6] = 5;
HumanKnightTable [3][6] = 5;
HumanKnightTable [2][6] = 0;
HumanKnightTable [1][6] = -20;
HumanKnightTable [0][6] = -40;

HumanKnightTable [7][5] = -30;
HumanKnightTable [6][5] = 5;
HumanKnightTable [5][5] = 10;
HumanKnightTable [4][5] = 15;
HumanKnightTable [3][5] = 15;
HumanKnightTable [2][5] = 10;
HumanKnightTable [1][5] = 5;
HumanKnightTable [0][5] = -30;

HumanKnightTable [7][4] = -30;
HumanKnightTable [6][4] = 0;
HumanKnightTable [5][4] = 15;
HumanKnightTable [4][4] = 20;
HumanKnightTable [3][4] = 20;
HumanKnightTable [2][4] = 15;
HumanKnightTable [1][4] = 0;
HumanKnightTable [0][4] = -30;

HumanKnightTable [7][3] = -30;
HumanKnightTable [6][3] = 5;
HumanKnightTable [5][3] = 15;
HumanKnightTable [4][3] = 20;
HumanKnightTable [3][3] = 20;
HumanKnightTable [2][3] = 15;
HumanKnightTable [1][3] = 5;
HumanKnightTable [0][3] = -30;

HumanKnightTable [7][2] = -30;
HumanKnightTable [6][2] = 0;
HumanKnightTable [5][2] = 10;
HumanKnightTable [4][2] = 15;
HumanKnightTable [3][2] = 15;
HumanKnightTable [2][2] = 10;
HumanKnightTable [1][2] = 0;
HumanKnightTable [0][2] = -30;

HumanKnightTable [7][1] = -40;
HumanKnightTable [6][1] = -20;
HumanKnightTable [5][1] = 0;
HumanKnightTable [4][1] = 0;
HumanKnightTable [3][1] = 0;
HumanKnightTable [2][1] = 0;
HumanKnightTable [1][1] = -20;
HumanKnightTable [0][1] = -40;

HumanKnightTable [7][0] = -50;
HumanKnightTable [6][0] = -40;
HumanKnightTable [5][0] = -30;
HumanKnightTable [4][0] = -30;
HumanKnightTable [3][0] = -30;
HumanKnightTable [2][0] = -30;
HumanKnightTable [1][0] = -40;
HumanKnightTable [0][0] = -50;

// =============   AI Bishops ========================================

AIBishopTable [7][7] = -20;
AIBishopTable [6][7] = -10;
AIBishopTable [5][7] = -10;  
AIBishopTable [4][7] = -10;
AIBishopTable [3][7] = -10;
AIBishopTable [2][7] = -10;  
AIBishopTable [1][7] = -10;
AIBishopTable [0][7] = -20;

AIBishopTable [7][6] = -10;
AIBishopTable [6][6] = 0;
AIBishopTable [5][6] = 0;  
AIBishopTable [4][6] = 0;
AIBishopTable [3][6] = 0;
AIBishopTable [2][6] = 0;  
AIBishopTable [1][6] = 0;
AIBishopTable [0][6] = -10;

AIBishopTable [7][5] = -10;
AIBishopTable [6][5] = 0;
AIBishopTable [5][5] = 5;  
AIBishopTable [4][5] = 10;
AIBishopTable [3][5] = 10;
AIBishopTable [2][5] = 5;  
AIBishopTable [1][5] = 0;
AIBishopTable [0][5] = -10;

AIBishopTable [7][4] = -10;
AIBishopTable [6][4] = 5;
AIBishopTable [5][4] = 5;  
AIBishopTable [4][4] = 10;
AIBishopTable [3][4] = 10;
AIBishopTable [2][4] = 5;  
AIBishopTable [1][4] = 5;
AIBishopTable [0][4] = -10;

AIBishopTable [7][3] = -10;
AIBishopTable [6][3] = 0;
AIBishopTable [5][3] = 10;  
AIBishopTable [4][3] = 10;
AIBishopTable [3][3] = 10;
AIBishopTable [2][3] = 10;  
AIBishopTable [1][3] = 0;
AIBishopTable [0][3] = -10;

AIBishopTable [7][2] = -10;
AIBishopTable [6][2] = 10;
AIBishopTable [5][2] = 10;  
AIBishopTable [4][2] = 10;
AIBishopTable [3][2] = 10;
AIBishopTable [2][2] = 10;  
AIBishopTable [1][2] = 10;
AIBishopTable [0][2] = -10;

AIBishopTable [7][1] = -10;
AIBishopTable [6][1] = 5;
AIBishopTable [5][1] = 0;  
AIBishopTable [4][1] = 0;
AIBishopTable [3][1] = 0;
AIBishopTable [2][1] = 0;  
AIBishopTable [1][1] = 5;
AIBishopTable [0][1] = -10;

AIBishopTable [7][0] = -20;
AIBishopTable [6][0] = -10;
AIBishopTable [5][0] = -25;  
AIBishopTable [4][0] = -10;
AIBishopTable [3][0] = -10;
AIBishopTable [2][0] = -25;  
AIBishopTable [1][0] = -10;
AIBishopTable [0][0] = -20;


// =========== Human bishops ----------------------------------

HumanBishopTable [7][7] = -20;
HumanBishopTable [6][7] = -10;
HumanBishopTable [5][7] = -25;  // experiment with B starting squares
HumanBishopTable [4][7] = -10;
HumanBishopTable [3][7] = -10;
HumanBishopTable [2][7] = -25;  // experiment with B starting squares
HumanBishopTable [1][7] = -10;
HumanBishopTable [0][7] = -20;

HumanBishopTable [7][6] = -10;
HumanBishopTable [6][6] = 5;
HumanBishopTable [5][6] = 0;  
HumanBishopTable [4][6] = 0;
HumanBishopTable [3][6] = 0;
HumanBishopTable [2][6] = 0;  
HumanBishopTable [1][6] = 5;
HumanBishopTable [0][6] = -10;

HumanBishopTable [7][5] = -10;
HumanBishopTable [6][5] = 10;
HumanBishopTable [5][5] = 10;  
HumanBishopTable [4][5] = 10;
HumanBishopTable [3][5] = 10;
HumanBishopTable [2][5] = 10;  
HumanBishopTable [1][5] = 10;
HumanBishopTable [0][5] = -10;

HumanBishopTable [7][4] = -10;
HumanBishopTable [6][4] = 0;
HumanBishopTable [5][4] = 10;  
HumanBishopTable [4][4] = 10;
HumanBishopTable [3][4] = 10;
HumanBishopTable [2][4] = 10;  
HumanBishopTable [1][4] = 0;
HumanBishopTable [0][4] = -10;

HumanBishopTable [7][3] = -10;
HumanBishopTable [6][3] = 5;
HumanBishopTable [5][3] = 5;  
HumanBishopTable [4][3] = 10;
HumanBishopTable [3][3] = 10;
HumanBishopTable [2][3] = 5;  
HumanBishopTable [1][3] = 5;
HumanBishopTable [0][3] = -10;

HumanBishopTable [7][2] = -10;
HumanBishopTable [6][2] = 0;
HumanBishopTable [5][2] = 5;  
HumanBishopTable [4][2] = 10;
HumanBishopTable [3][2] = 10;
HumanBishopTable [2][2] = 5;  
HumanBishopTable [1][2] = 0;
HumanBishopTable [0][2] = -10;

HumanBishopTable [7][1] = -10;
HumanBishopTable [6][1] = 0;
HumanBishopTable [5][1] = 0;  
HumanBishopTable [4][1] = 0;
HumanBishopTable [3][1] = 0;
HumanBishopTable [2][1] = 0;  
HumanBishopTable [1][1] = 0;
HumanBishopTable [0][1] = -10;

HumanBishopTable [7][0] = -20;
HumanBishopTable [6][0] = -10;
HumanBishopTable [5][0] = -10;  
HumanBishopTable [4][0] = -10;
HumanBishopTable [3][0] = -10;
HumanBishopTable [2][0] = -10;  
HumanBishopTable [1][0] = -10;
HumanBishopTable [0][0] = -20;

// ========= AI Queen tables ===========

AIQueenTable [7][7] = -20;
AIQueenTable [6][7] = -10;
AIQueenTable [5][7] = -10;
AIQueenTable [4][7] = -5;
AIQueenTable [3][7] = -5;
AIQueenTable [2][7] = -10;
AIQueenTable [1][7] = -10;
AIQueenTable [0][7] = -20;

AIQueenTable [7][6] = -10;
AIQueenTable [6][6] = 0;
AIQueenTable [5][6] = 0;
AIQueenTable [4][6] = 0;
AIQueenTable [3][6] = 0;
AIQueenTable [2][6] = 0;
AIQueenTable [1][6] = 0;
AIQueenTable [0][6] = -10;

AIQueenTable [7][5] = -10;  // AI's 6th row -- Q6 etc
AIQueenTable [6][5] = 0;
AIQueenTable [5][5] = 5;
AIQueenTable [4][5] = 5;
AIQueenTable [3][5] = 5;
AIQueenTable [2][5] = 5;
AIQueenTable [1][5] = 0;
AIQueenTable [0][5] = -10;

AIQueenTable [7][4] = -5;  //AI 5th row
AIQueenTable [6][4] = 0;
AIQueenTable [5][4] = 5;
AIQueenTable [4][4] = 5;
AIQueenTable [3][4] = 5;
AIQueenTable [2][4] = 5;
AIQueenTable [1][4] = 0;
AIQueenTable [0][4] = -5;

AIQueenTable [7][3] = 0;
AIQueenTable [6][3] = 0;
AIQueenTable [5][3] = 5;
AIQueenTable [4][3] = 5;
AIQueenTable [3][3] = 5;
AIQueenTable [2][3] = 5;
AIQueenTable [1][3] = 0;
AIQueenTable [0][3] = -5;  // asymmetry

AIQueenTable [7][2] = -10;
AIQueenTable [6][2] = 5;
AIQueenTable [5][2] = 5;
AIQueenTable [4][2] = 5;
AIQueenTable [3][2] = 5;
AIQueenTable [2][2] = 5;
AIQueenTable [1][2] = 0; // asymmetry
AIQueenTable [0][2] = -10;

AIQueenTable [7][1] = -10;
AIQueenTable [6][1] = 0;
AIQueenTable [5][1] = 5;
AIQueenTable [4][1] = 0;
AIQueenTable [3][1] = 0;
AIQueenTable [2][1] = 0;
AIQueenTable [1][1] = 0;   // yes][asymmerty
AIQueenTable [0][1] = -10;

AIQueenTable [7][0] = -20;
AIQueenTable [6][0] = -10;
AIQueenTable [5][0] = -10;
AIQueenTable [4][0] = -5;
AIQueenTable [3][0] = -5;
AIQueenTable [2][0] = -10;
AIQueenTable [1][0] = -10;
AIQueenTable [0][0] = -20;


// -------------- Human Queens --------------

HumanQueenTable [7][7] = -20;
HumanQueenTable [6][7] = -10;
HumanQueenTable [5][7] = -10;
HumanQueenTable [4][7] = -5;
HumanQueenTable [3][7] = -5;
HumanQueenTable [2][7] = -10;
HumanQueenTable [1][7] = -10;
HumanQueenTable [0][7] = -20;

HumanQueenTable [7][6] = -10;
HumanQueenTable [6][6] = 0;
HumanQueenTable [5][6] = 5;
HumanQueenTable [4][6] = 0;
HumanQueenTable [3][6] = 0;
HumanQueenTable [2][6] = 0;  // asymmetry
HumanQueenTable [1][6] = 0;
HumanQueenTable [0][6] = -10;

HumanQueenTable [7][5] = -10;
HumanQueenTable [6][5] = 5;
HumanQueenTable [5][5] = 5;
HumanQueenTable [4][5] = 5;
HumanQueenTable [3][5] = 5;
HumanQueenTable [2][5] = 5;
HumanQueenTable [1][5] = 0;  // deliberate asymmetry
HumanQueenTable [0][5] = -10;

HumanQueenTable [7][4] = 0;
HumanQueenTable [6][4] = 0;
HumanQueenTable [5][4] = 5;
HumanQueenTable [4][4] = 5;
HumanQueenTable [3][4] = 5;
HumanQueenTable [2][4] = 5;
HumanQueenTable [1][4] = 0;
HumanQueenTable [0][4] = -5;   // deliberate asymmetry

HumanQueenTable [7][3] = -5;   
HumanQueenTable [6][3] = 0;
HumanQueenTable [5][3] = 5;
HumanQueenTable [4][3] = 5;
HumanQueenTable [3][3] = 5;
HumanQueenTable [2][3] = 5;
HumanQueenTable [1][3] = 0;
HumanQueenTable [0][3] = -5;

HumanQueenTable [7][2] = -10;
HumanQueenTable [6][2] = 0;
HumanQueenTable [5][2] = 5;
HumanQueenTable [4][2] = 5;
HumanQueenTable [3][2] = 5;
HumanQueenTable [2][2] = 5;
HumanQueenTable [1][2] = 0;
HumanQueenTable [0][2] = -10;

HumanQueenTable [7][1] = -10;
HumanQueenTable [6][1] = 0;
HumanQueenTable [5][1] = 0;
HumanQueenTable [4][1] = 0;
HumanQueenTable [3][1] = 0;
HumanQueenTable [2][1] = 0;
HumanQueenTable [1][1] = 0;
HumanQueenTable [0][1] = -10;

HumanQueenTable [7][0] = -20;
HumanQueenTable [6][0] = -10;
HumanQueenTable [5][0] = -10;
HumanQueenTable [4][0] = -5;
HumanQueenTable [3][0] = -5;
HumanQueenTable [2][0] = -10;
HumanQueenTable [1][0] = -10;
HumanQueenTable [0][0] = -20;

// ============= AI KING =====================

AIKingTable [7][7] = -30;
AIKingTable [6][7] = -30;
AIKingTable [5][7] = -40;
AIKingTable [4][7] = -50;
AIKingTable [3][7] = -50;
AIKingTable [2][7] = -40;
AIKingTable [1][7] = -30;
AIKingTable [0][7] = -30;

AIKingTable [7][6] = -30;
AIKingTable [6][6] = -30;
AIKingTable [5][6] = -40;
AIKingTable [4][6] = -50;
AIKingTable [3][6] = -50;
AIKingTable [2][6] = -40;
AIKingTable [1][6] = -30;
AIKingTable [0][6] = -30;

AIKingTable [7][5] = -30;
AIKingTable [6][5] = -30;
AIKingTable [5][5] = -40;
AIKingTable [4][5] = -50;
AIKingTable [3][5] = -50;
AIKingTable [2][5] = -40;
AIKingTable [1][5] = -30;
AIKingTable [0][5] = -30;

AIKingTable [7][4] = -30;
AIKingTable [6][4] = -30;
AIKingTable [5][4] = -40;
AIKingTable [4][4] = -50;
AIKingTable [3][4] = -50;
AIKingTable [2][4] = -40;
AIKingTable [1][4] = -30;
AIKingTable [0][4] = -30;

AIKingTable [7][3] = -20;
AIKingTable [6][3] = -30;
AIKingTable [5][3] = -30;
AIKingTable [4][3] = -40;
AIKingTable [3][3] = -40;
AIKingTable [2][3] = -30;
AIKingTable [1][3] = -30;
AIKingTable [0][3] = -20;

AIKingTable [7][2] = -10;
AIKingTable [6][2] = -20;
AIKingTable [5][2] = -20;
AIKingTable [4][2] = -20;
AIKingTable [3][2] = -20;
AIKingTable [2][2] = -20;
AIKingTable [1][2] = -20;
AIKingTable [0][2] = -10;

AIKingTable [7][1] = 20;
AIKingTable [6][1] = 20;
AIKingTable [5][1] = 0;
AIKingTable [4][1] = 0;
AIKingTable [3][1] = 0;
AIKingTable [2][1] = 0;
AIKingTable [1][1] = 20;
AIKingTable [0][1] = 20;

AIKingTable [7][0] = 20;
AIKingTable [6][0] = 30;
AIKingTable [5][0] = 10;
AIKingTable [4][0] = 0;
AIKingTable [3][0] = 0;
AIKingTable [2][0] = 10;
AIKingTable [1][0] = 30;
AIKingTable [0][0] = 20;


// ---------------- Human King ---------------------------

HumanKingTable [7][7] = 20;
HumanKingTable [6][7] = 30;
HumanKingTable [5][7] = 10;
HumanKingTable [4][7] = 0;
HumanKingTable [3][7] = 0;
HumanKingTable [2][7] = 10;
HumanKingTable [1][7] = 30;  
HumanKingTable [0][7] = 20;

HumanKingTable [7][6] = 20;
HumanKingTable [6][6] = 20;
HumanKingTable [5][6] = 0;
HumanKingTable [4][6] = 0;
HumanKingTable [3][6] = 0;
HumanKingTable [2][6] = 0;
HumanKingTable [1][6] = 20;
HumanKingTable [0][6] = 20;

HumanKingTable [7][5] = -10;
HumanKingTable [6][5] = -20;
HumanKingTable [5][5] = -20;
HumanKingTable [4][5] = -20;
HumanKingTable [3][5] = -20;
HumanKingTable [2][5] = -20;
HumanKingTable [1][5] = -20;
HumanKingTable [0][5] = -10;

HumanKingTable [7][4] = -20;
HumanKingTable [6][4] = -30;
HumanKingTable [5][4] = -30;
HumanKingTable [4][4] = -40;
HumanKingTable [3][4] = -40;
HumanKingTable [2][4] = -30;
HumanKingTable [1][4] = -30;
HumanKingTable [0][4] = -20;

HumanKingTable [7][3] = -30;
HumanKingTable [6][3] = -30;
HumanKingTable [5][3] = -40;
HumanKingTable [4][3] = -50;
HumanKingTable [3][3] = -50;
HumanKingTable [2][3] = -40;
HumanKingTable [1][3] = -30;
HumanKingTable [0][3] = -30;

HumanKingTable [7][2] = -30;
HumanKingTable [6][2] = -30;
HumanKingTable [5][2] = -40;
HumanKingTable [4][2] = -50;
HumanKingTable [3][2] = -50;
HumanKingTable [2][2] = -40;
HumanKingTable [1][2] = -30;
HumanKingTable [0][2] = -30;

HumanKingTable [7][1] = -30;
HumanKingTable [6][1] = -30;
HumanKingTable [5][1] = -40;
HumanKingTable [4][1] = -50;
HumanKingTable [3][1] = -50;
HumanKingTable [2][1] = -40;
HumanKingTable [1][1] = -30;
HumanKingTable [0][1] = -30;

HumanKingTable [7][0] = -30;
HumanKingTable [6][0] = -30;
HumanKingTable [5][0] = -40;
HumanKingTable [4][0] = -50;
HumanKingTable [3][0] = -50;
HumanKingTable [2][0] = -40;
HumanKingTable [1][0] = -30;
HumanKingTable [0, 0] = -30;


