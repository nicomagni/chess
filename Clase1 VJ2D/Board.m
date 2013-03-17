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

@implementation Board

- (id) init
{
    if(self = [super init]){
        _pieces = [[NSMutableSet alloc] initWithCapacity:32];
        
    }
}

- (NSMutableSet*) getPawns {
    NSMutableSet * pawns = [[NSMutableSet alloc] initWithCapacity:16];
    for (int i = 8; i < 2 * 8; i ++) {
        Pawn *pawn = [[Pawn alloc] init];
        [pawn setPosition:i];
        [pawns addObject:pawn];
    }
    for (int i = 6 * 8; i < 8 * 7; i ++) {
        Pawn *pawn = [[Pawn alloc] init];
        [pawn setPosition:i];
        [pawns addObject:pawn];
    }
}


- (NSMutableSet*) getTowers {
    NSMutableSet * towers = [[NSMutableSet alloc] initWithCapacity:4];
    for (int i = 0; i < 2 * 2; i ++) {
        Tower* tower = [[Tower alloc] init];
        [towers addObject:tower];
    }
    
}

- (NSMutableArray*) getKnights {
    NSMutableArray * knights = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 0; i < 2 * 2; i ++) {
        knights[i] = [[Knight alloc] init];
    }
}

- (NSMutableArray*) getQueen {
    NSMutableArray * queens = [[NSMutableArray alloc] initWithCapacity:2];
    for (int i = 0; i < 1 * 2; i ++) {
        queens[i] = [[Queen alloc] init];
    }
}

- (NSMutableArray*) getKing {
    NSMutableArray * kings = [[NSMutableArray alloc] initWithCapacity:2];
    for (int i = 0; i < 1 * 2; i ++) {
        kings[i] = [[King alloc] init];
    }
}

- (NSMutableArray*) getBishop {
    NSMutableArray * bishop = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 0; i < 8; i ++) {
        bishop[i] = [[Bishop alloc] init];
    }
}

@end
