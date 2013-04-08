//
//  Piece.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/5/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Piece.h"
#import "MathUtils.h"

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
    NSAssert(NO, @"You must implement me!");
    return NO;
}

- (BOOL)couldMoveToPosition:(int)position{
    NSAssert(NO, @"You must implement me!");
    return NO;
}

- (id) initWithColor:(int)color
{
    NSAssert(NO, @"You must implement me!");
    return Nil;
}

@end
