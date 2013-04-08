//
//  Piece.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/5/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Piece.h"
#import "MathUtils.h"
#import "Board.h"

@implementation Piece : NSObject


- (id) init
{
    self = [super init];
    self.mathUtils = [[MathUtils alloc] initWithColumngCount:8 andRowCount:8];
    
    return self;
}

-(void) printPosition
{
    NSLog(@"%d:%d",(_position/8), (_position%8));
}

- (BOOL) move :(int)toPosition{
    [self.board positions][self.position] = [NSNull null];
    self.position = toPosition;
    [self.board positions][toPosition] = self;

    return YES;
}

- (BOOL)couldMoveToPosition:(int)position{
    Piece * endPiece = [self.board positions][position];
    Piece * startPiece = [self.board positions][self.position];
    BOOL isValid = position >= 0 || position <= 63 || self.position != position;
    
    if([endPiece isEqual:[NSNull null]] || [startPiece isEqual:[NSNull null]]){
        return isValid;
    }else{
        return isValid && [startPiece color] != [endPiece color];
    }
    
}

- (id) initWithColor:(int)color
{
    NSAssert(NO, @"You must implement me!");
    return Nil;
}



@end
