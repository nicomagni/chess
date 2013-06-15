//
//  Board.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/5/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Board.h"
#import "Knight.h"
#import "Pawn.h"
#import "Tower.h"
#import "Queen.h"
#import "King.h"
#import "Bishop.h"

@implementation Board;

- (id) init
{
    if(self = [super init]){
        _pieces = [[NSMutableSet alloc] initWithCapacity:32];
        _positions = [[NSMutableArray alloc] initWithCapacity:64];
        for(int i = 0; i< 64; i++)
        {
            [_positions addObject:[NSNull null]];
        }
    }
    return self;
}

- (id) initWithArray:(NSArray*)boardArray{
     if(self = [super init]){
         NSLog(@"Init Array");
         _pieces = [[NSMutableSet alloc] initWithCapacity:32];
         _positions = [[NSMutableArray alloc] initWithCapacity:64];
         for (int i = 0; i < 64; i++) {
             if([boardArray[i] isEqual:[NSNull null]]){
                 [_positions addObject:[NSNull null]];
             }else{
                 int type = [[boardArray[i] objectForKey:@"type"] intValue];
                 int color = [[boardArray[i] objectForKey:@"white"] intValue];
                 Piece* currentPiece = [self getPieceFromType:type andColor:color];
                 [currentPiece setPosition:i];
                 [_pieces addObject:currentPiece];
//                 NSLog(@" color %d, type %d , position %d ", color, type, i);
                 [_positions addObject:currentPiece];
                 
             }
         }

     }
    return self;
}

- (Piece*) getPieceFromType:(int)type andColor:(int)color{
    switch (type) {
        case kPawn:{
            Pawn *pawn = [[Pawn alloc] initWithColor:color];
            [pawn setBoard:self];
            return pawn;
        }
        case kBishop:{
            Bishop *bishop = [[Bishop alloc] initWithColor:color];
            [bishop setBoard:self];
            return bishop;
        }
        case kKing:{
            King *king = [[King alloc] initWithColor:color];
            [king setBoard:self];
            return king;
        }
        case kTower:{
            Tower *tower = [[Tower alloc] initWithColor:color];
            [tower setBoard:self];
            return tower;
        }
        case kQueen:{
            Queen *queen = [[Queen alloc] initWithColor:color];
            [queen setBoard:self];
            return queen;
        }
        case kKnight:{
            Knight *knight = [[Knight alloc] initWithColor:color];
            [knight setBoard:self];
            return knight;
        }
            

    }
}

- (Board*) createNewBoardMyColoris:(int)myColor{
    [_pieces addObjectsFromArray:(getPawns(self,myColor))];
    [_pieces addObjectsFromArray:(getTowers(self,myColor))];
    [_pieces addObjectsFromArray:(getKnights(self,myColor))];
    [_pieces addObjectsFromArray:(getBishops(self,myColor))];
    [_pieces addObjectsFromArray:(getQueens(self,myColor))];
    [_pieces addObjectsFromArray:(getKings(self,myColor))];
    for (Piece *piece in _pieces) {
        _positions[[piece position]] = piece;
    }
    [self setCheck:-1];
    [self setCheckmate:-1];
    
    return self;
}

- (void) printBoard{
    NSLog(@"Avaliable pieces: %d", [self.pieces count]);
    for (Piece *piece in _pieces) {
        [piece printPosition];
    }
    NSLog(@"Board:");
    for (int i = 0; i < 64; i = i + 8) {
        NSLog(@"| %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ |",_positions[i],_positions[i + 1],_positions[i + 2],_positions[i + 3],_positions[i + 4],_positions[i + 5],_positions[i + 6],_positions[i + 7]);
    }
        
}

- (Board*) copyBoard{
    Board * newBoard = [[Board alloc] init];
    for (Piece * piece in self.pieces) {
        Piece * auxPiece = [piece copyPiece];
        [auxPiece setBoard:newBoard];
        [newBoard.pieces addObject:auxPiece];
    }
    for (Piece *piece in newBoard.pieces) {
        newBoard.positions[piece.position] = piece;
    }
    [newBoard setCheck:-1];
    [newBoard setCheckmate:-1];

    return newBoard;
}

- (void) rotateBoard{
    int j = 63;
    NSLog(@"Rotando el tablero.");
    for(int i = 0; i< 32; i++){
        Piece *swapPiece = self.positions[i];
        self.positions[i] = self.positions[j-i];
        self.positions[j-i] = swapPiece;
        if(![self.positions[i] isEqual:[NSNull null]]){
            [self changePiece:self.positions[i] newPosition:i oldPosition:j-i];
        }
        if(![self.positions[j-i] isEqual:[NSNull null]]){
            [self changePiece:self.positions[j-i] newPosition:j-i oldPosition:i];
        }
       // NSLog(@" origin position %d, destination %d ,cambio %@,por %@", i, j-i, self.positions[i],self.positions[j-i]);
    }
}

- (void)changePiece:(Piece*)piece newPosition:(int)newPostition oldPosition:(int)oldPosition {
    for(Piece* currentPiece in self.pieces){
        if(currentPiece.position == oldPosition){
            currentPiece.position = newPostition;
        }
    }
}

- (BOOL) lookForChecks: (int) color{
    NSMutableSet* positions = [[NSMutableSet alloc] init];
    Piece *myKing;
    for (Piece * piece in self.pieces) {
        if(piece.color != color){
            [positions addObjectsFromArray:[piece canEat]];
        }else{
            if([piece class] == [King class]){
                myKing = piece;
            }
        }
    }
    if([positions containsObject:[NSNumber numberWithInt:myKing.position]]){
        for (NSNumber* pos in [myKing canEat]) {
            if(![positions containsObject:[NSNumber numberWithInt:myKing.position]]){
                self.check = color;
                self.checkmate = -1;
                return YES;
            }
        }
        self.check = -1;
        self.checkmate = color;
        return YES;
    }
    return NO;
    
}

- (NSMutableArray*) getBoardArray{
    NSMutableArray* piecesArray = [[NSMutableArray alloc] initWithCapacity:64];
    for(int i = 0; i< 64; i++){
        Piece *piece = self.positions[i];
        if(![piece isEqual:[NSNull null]]){
            NSNumber *type = [[NSNumber alloc] initWithInt:piece.type];
            [piecesArray addObject:@{@"type":type , @"white": [NSNumber numberWithInt:piece.color % 2]}];
           // [piecesArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:type ,@"type", piece.color == 0, @"color", nil]];
        }else{
            [piecesArray addObject:[NSNull null]];
        }
    }

    return piecesArray;
}

NSMutableArray* getPawns(Board* board, int myColor) {
    NSMutableArray * pawns = [[NSMutableArray alloc] initWithCapacity:16];
    int otherColor = myColor == 1 ? 0:1;
    for (int i = 8; i < 2 * 8; i ++) {
        Pawn *pawn = [[Pawn alloc] initWithColor:myColor];
        [pawn setPosition:i];
        [pawn setBoard:board];
        [pawns addObject:pawn];
    }
    for (int i = 6 * 8; i < 8 * 7; i ++) {
        Pawn *pawn = [[Pawn alloc] initWithColor:otherColor];
        [pawn setPosition:i];
        [pawn setColor:otherColor];
        [pawn setBoard:board];
        [pawns addObject:pawn];
    }
    return pawns;
}


NSMutableArray* getTowers(Board* board, int myColor) {
    NSMutableArray * towers = [[NSMutableArray alloc] initWithCapacity:4];
    int otherColor = myColor == 1 ? 0:1;
    for (int i = 0; i < 8; i = i + 7) {
        Tower* tower = [[Tower alloc] initWithColor:myColor];
        [tower setPosition:i];
        [tower setColor:myColor];
        [tower setBoard:board];
        [towers addObject:tower];
    }
    for (int i = 56; i < 64; i = i + 7) {
        Tower* tower = [[Tower alloc] initWithColor:otherColor];
        [tower setPosition:i];
        [tower setColor:otherColor];
        [tower setBoard:board];
        [towers addObject:tower];
    }
    return towers;
}

NSMutableArray* getKnights(Board* board, int myColor) {
    NSMutableArray * knights = [[NSMutableArray alloc] initWithCapacity:4];
    int otherColor = myColor == 1 ? 0:1;
    for (int i = 1; i < 7; i = i + 5) {
        Knight * knight = [[Knight alloc] initWithColor:myColor];
        [knight setPosition:i];
        [knight setColor:myColor];
        [knight setBoard:board];
        [knights addObject:knight];
    }
    for (int i = 57; i < 63; i = i + 5) {
        Knight * knight = [[Knight alloc] initWithColor:otherColor];
        [knight setPosition:i];
        [knight setColor:otherColor];
        [knight setBoard:board];
        [knights addObject:knight];
    }
    return knights;
}

NSMutableArray* getBishops(Board* board, int myColor) {
    NSMutableArray * bishops = [[NSMutableArray alloc] initWithCapacity:4];
    int otherColor = myColor == 1 ? 0:1;
    for (int i = 2; i < 6; i = i + 3) {
        Bishop * bishop = [[Bishop alloc] initWithColor:myColor];
        [bishop setPosition:i];
        [bishop setColor:myColor];
        [bishop setBoard:board];
        [bishops addObject:bishop];
    }
    for (int i = 58; i < 62; i = i + 3) {
        Bishop * bishop = [[Bishop alloc] initWithColor:otherColor];
        [bishop setPosition:i];
        [bishop setColor:otherColor];
        [bishop setBoard:board];
        [bishops addObject:bishop];
    }
    return bishops;
}


NSMutableArray* getQueens(Board* board, int myColor) {
    NSMutableArray * queens = [[NSMutableArray alloc] initWithCapacity:2];
    int otherColor = myColor == 1 ? 0:1;
    Queen * queen1 = [[Queen alloc] initWithColor:myColor];
    [queen1 setPosition:4];
    [queen1 setColor:myColor];
    [queen1 setBoard:board];
    [queens addObject:queen1];
    Queen * queen2 = [[Queen alloc] initWithColor:otherColor];
    [queen2 setPosition:60];
    [queen2 setColor:otherColor];
    [queen2 setBoard:board];
    [queens addObject:queen2];
    return queens;
}

NSMutableArray* getKings(Board* board, int myColor) {
    NSMutableArray * kings = [[NSMutableArray alloc] initWithCapacity:2];
    int otherColor = myColor == 1 ? 0:1;
    King * king1 = [[King alloc] initWithColor:myColor];
    [king1 setPosition:3];
    [king1 setColor:myColor];
    [king1 setBoard:board];
    [kings addObject:king1];
    King * king2 = [[King alloc] initWithColor:otherColor];
    [king2 setPosition:59];
    [king2 setColor:otherColor];
    [king2 setBoard:board];
    [kings addObject:king2];
    return kings;

}

@end
