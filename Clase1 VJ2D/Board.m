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
    }
    return self;
}

- (Board*) createNewBoard:(Board *)board{
    [board.pieces addObjectsFromArray:([Board getPawns])];
    [board.pieces addObjectsFromArray:([Board getTowers])];
    [board.pieces addObjectsFromArray:([Board getKnights])];
    [board.pieces addObjectsFromArray:([Board getBishops])];
    [board.pieces addObjectsFromArray:([Board getQueens])];
    [board.pieces addObjectsFromArray:([Board getKings])];
    return board;
}

- (void) printBoard{
    NSLog(@"Pieces loaded: %d", [self.pieces count]);
    for (Piece *piece in _pieces) {
        [piece printPosition];
    }
        
}

+ (NSMutableArray*) getPawns {
    NSMutableArray * pawns = [[NSMutableArray alloc] initWithCapacity:16];
    for (int i = 8; i < 2 * 8; i ++) {
        Pawn *pawn = [[Pawn alloc] init];
        [pawn setPosition:i];
        [pawn setColor:1];
        [pawns addObject:pawn];
    }
    for (int i = 6 * 8; i < 8 * 7; i ++) {
        Pawn *pawn = [[Pawn alloc] init];
        [pawn setPosition:i];
        [pawn setColor:2];
        [pawns addObject:pawn];
    }
    return pawns;
}


+ (NSMutableArray*) getTowers {
    NSMutableArray * towers = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 0; i < 8; i = i + 7) {
        Tower* tower = [[Tower alloc] init];
        [tower setPosition:i];
        [tower setColor:1];
        [towers addObject:tower];
    }
    for (int i = 56; i < 64; i = i + 7) {
        Tower* tower = [[Tower alloc] init];
        [tower setPosition:i];
        [tower setColor:2];
        [towers addObject:tower];
    }
    return towers;
}

+ (NSMutableArray*) getKnights {
    NSMutableArray * knights = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 1; i < 7; i = i + 5) {
        Knight * knight = [[Knight alloc] init];
        [knight setPosition:i];
        [knight setColor:1];
        [knights addObject:knight];
    }
    for (int i = 57; i < 63; i = i + 5) {
        Knight * knight = [[Knight alloc] init];
        [knight setPosition:i];
        [knight setColor:2];
        [knights addObject:knight];
    }
    return knights;
}

+ (NSMutableArray*) getBishops {
    NSMutableArray * bishops = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 2; i < 6; i = i + 3) {
        Bishop * bishop = [[Bishop alloc] init];
        [bishop setPosition:i];
        [bishop setColor:1];
        [bishops addObject:bishop];
    }
    for (int i = 58; i < 62; i = i + 3) {
        Bishop * bishop = [[Bishop alloc] init];
        [bishop setPosition:i];
        [bishop setColor:2];
        [bishops addObject:bishop];
    }
    return bishops;
}


+ (NSMutableArray*) getQueens {
    NSMutableArray * queens = [[NSMutableArray alloc] initWithCapacity:2];
    Queen * queen1 = [[Queen alloc] init];
    [queen1 setPosition:3];
    [queen1 setColor:1];
    [queens addObject:queen1];
    Queen * queen2 = [[Queen alloc] init];
    [queen2 setPosition:59];
    [queen2 setColor:2];
    [queens addObject:queen2];
    return queens;
}

+ (NSMutableArray*) getKings {
    NSMutableArray * kings = [[NSMutableArray alloc] initWithCapacity:2];
    King * king1 = [[King alloc] init];
    [king1 setPosition:4];
    [king1 setColor:1];
    [kings addObject:king1];
    King * king2 = [[King alloc] init];
    [king2 setPosition:60];
    [king2 setColor:2];
    [kings addObject:king2];
    return kings;

}

@end
