//
//  Queen.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Queen.h"
#import "Bishop.h"
#import "Tower.h"


@implementation Queen

- (id) initWithColor:(int)color {
    self = [super init];
    self.color = color;
    if(color == 0){
        self.imageResourceName = @"black_queen.png";
    }else{
        self.imageResourceName = @"white_queen.png";
    }
    self.type = kQueen;
    return self;
}

- (void) printPosition{
    NSLog(@"Queen: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
    return (self.color == 0 ? @"Black-Queen " : @"White-Queen");
}

- (BOOL)move:(int)toPosition
{
    if([self couldMoveToPosition:toPosition]){
       return [super move:toPosition];
    }
    return NO;
}

- (BOOL)couldMoveToPosition:(int)toPosition{
    if(![super couldMoveToPosition:toPosition]){
        return NO;
    }
    Bishop * bishop = [[Bishop alloc] initWithColor:self.color];
    [bishop setPosition: self.position];
    [bishop setBoard: self.board];
    Tower * tower = [[Tower alloc] initWithColor:self.color];
    [tower setPosition: self.position ];
    [tower setBoard: self.board];

    //return [bishop couldMoveToPosition:toPosition] || [tower couldMoveToPosition:toPosition];
    BOOL towerType = [tower couldMoveToPosition:toPosition];
    BOOL bishopType = [bishop couldMoveToPosition:toPosition];

    return towerType || bishopType;
    
}


@end
