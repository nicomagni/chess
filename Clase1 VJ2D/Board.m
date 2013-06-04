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

- (Board*) createNewBoard{
    [_pieces addObjectsFromArray:(getPawns(self))];
    [_pieces addObjectsFromArray:(getTowers(self))];
    [_pieces addObjectsFromArray:(getKnights(self))];
    [_pieces addObjectsFromArray:(getBishops(self))];
    [_pieces addObjectsFromArray:(getQueens(self))];
    [_pieces addObjectsFromArray:(getKings(self))];
    for (Piece *piece in _pieces) {
        _positions[[piece position]] = piece;
    }
    [self setCheck:0];
    [self setCheckmate:0];
    
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
        Piece * auxPiece = [piece copy];
        [auxPiece setBoard:newBoard];
        [newBoard.pieces addObject:auxPiece];
    }
    for (Piece *piece in newBoard.pieces) {
        newBoard.positions[piece.position] = piece;
    }
    [self setCheck:0];
    [self setCheckmate:0];

    return newBoard;
}

- (BOOL) lookForChecks{
    //TODO:
    return NO;
}

- (NSMutableArray*) getBoardArray{
    NSMutableArray* piecesArray = [[NSMutableArray alloc] initWithCapacity:64];
    for(int i = 0; i< 64; i++){
        Piece *piece = self.positions[i];
        if(![piece isEqual:[NSNull null]]){
            NSNumber *type = [[NSNumber alloc] initWithInt:piece.type];
            [piecesArray addObject:@{@"type":type , @"white": [NSNumber numberWithInt:piece.color]}];
           // [piecesArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:type ,@"type", piece.color == 0, @"color", nil]];
        }else{
            [piecesArray addObject:[NSNull null]];
        }
    }

    return piecesArray;
}

NSMutableArray* getPawns(Board* board) {
    NSMutableArray * pawns = [[NSMutableArray alloc] initWithCapacity:16];
    for (int i = 8; i < 2 * 8; i ++) {
        Pawn *pawn = [[Pawn alloc] initWithColor:1];
        [pawn setPosition:i];
        [pawn setBoard:board];
        [pawns addObject:pawn];
    }
    for (int i = 6 * 8; i < 8 * 7; i ++) {
        Pawn *pawn = [[Pawn alloc] initWithColor:2];
        [pawn setPosition:i];
        [pawn setColor:2];
        [pawn setBoard:board];
        [pawns addObject:pawn];
    }
    return pawns;
}


NSMutableArray* getTowers(Board* board) {
    NSMutableArray * towers = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 0; i < 8; i = i + 7) {
        Tower* tower = [[Tower alloc] initWithColor:1];
        [tower setPosition:i];
        [tower setColor:1];
        [tower setBoard:board];
        [towers addObject:tower];
    }
    for (int i = 56; i < 64; i = i + 7) {
        Tower* tower = [[Tower alloc] initWithColor:2];
        [tower setPosition:i];
        [tower setColor:2];
        [tower setBoard:board];
        [towers addObject:tower];
    }
    return towers;
}

NSMutableArray* getKnights(Board* board) {
    NSMutableArray * knights = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 1; i < 7; i = i + 5) {
        Knight * knight = [[Knight alloc] initWithColor:1];
        [knight setPosition:i];
        [knight setColor:1];
        [knight setBoard:board];
        [knights addObject:knight];
    }
    for (int i = 57; i < 63; i = i + 5) {
        Knight * knight = [[Knight alloc] initWithColor:2];
        [knight setPosition:i];
        [knight setColor:2];
        [knight setBoard:board];
        [knights addObject:knight];
    }
    return knights;
}

NSMutableArray* getBishops(Board* board) {
    NSMutableArray * bishops = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 2; i < 6; i = i + 3) {
        Bishop * bishop = [[Bishop alloc] initWithColor:1];
        [bishop setPosition:i];
        [bishop setColor:1];
        [bishop setBoard:board];
        [bishops addObject:bishop];
    }
    for (int i = 58; i < 62; i = i + 3) {
        Bishop * bishop = [[Bishop alloc] initWithColor:2];
        [bishop setPosition:i];
        [bishop setColor:2];
        [bishop setBoard:board];
        [bishops addObject:bishop];
    }
    return bishops;
}


NSMutableArray* getQueens(Board* board) {
    NSMutableArray * queens = [[NSMutableArray alloc] initWithCapacity:2];
    Queen * queen1 = [[Queen alloc] initWithColor:1];
    [queen1 setPosition:4];
    [queen1 setColor:1];
    [queen1 setBoard:board];
    [queens addObject:queen1];
    Queen * queen2 = [[Queen alloc] initWithColor:2];
    [queen2 setPosition:60];
    [queen2 setColor:2];
    [queen2 setBoard:board];
    [queens addObject:queen2];
    return queens;
}

NSMutableArray* getKings(Board* board) {
    NSMutableArray * kings = [[NSMutableArray alloc] initWithCapacity:2];
    King * king1 = [[King alloc] initWithColor:1];
    [king1 setPosition:3];
    [king1 setColor:1];
    [king1 setBoard:board];
    [kings addObject:king1];
    King * king2 = [[King alloc] initWithColor:2];
    [king2 setPosition:59];
    [king2 setColor:2];
    [king2 setBoard:board];
    [kings addObject:king2];
    return kings;

}



@end
