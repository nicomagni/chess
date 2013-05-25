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
    if(color == 1){
        self.imageResourceName = @"black_queen.png";
    }else{
        self.imageResourceName = @"white_queen.png";
    }
    self.type = 4;
    return self;
}

- (void) printPosition{
    NSLog(@"Queen: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
    return (self.color == 1 ? @"Black-Queen " : @"White-Queen");
}

- (BOOL)move:(int)toPosition
{
    if([self couldMoveToPosition:toPosition]){
        [super move:toPosition];
    }
}

- (BOOL)couldMoveToPosition:(int)toPosition{
    if(![super couldMoveToPosition:toPosition]){
        return NO;
    }
    Bishop * bishop = [[Bishop alloc] initWithColor:self.color];
    bishop.position = self.position;
    Tower * tower = [[Tower alloc] initWithColor:self.color];
    tower.position = self.position;

    return [bishop couldMoveToPosition:toPosition] || [tower couldMoveToPosition:toPosition];
    
}


@end
