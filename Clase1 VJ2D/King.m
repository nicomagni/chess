//
//  King.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "King.h"
#import "Board.h"
#import <math.h>

@implementation King : Piece

- (id) initWithColor:(int)color {
    self = [super init];
    self.color = color;
    if(color == 0){
        self.imageResourceName = @"black_king.png";
    }else{
        self.imageResourceName = @"white_king.png";
    }
    self.type = kKing;
    return self;
}

- (void) printPosition{
    NSLog(@"King: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
    return (self.color == 0 ? @" Black-King " : @" White-King ");
}

- (King *) copyPiece{
    King * piece = [[King alloc] initWithColor:self.color];
    [piece setPosition:self.position];
    return piece;
}

- (BOOL)move:(int)toPosition
{
    if([self couldMoveToPosition:toPosition checkingCheck:YES]){
        return [super move:toPosition];
    }
    return NO;
}

- (BOOL)couldMoveToPosition:(int)toPosition  checkingCheck: (BOOL) checkCheck{
    
    if(![super couldMoveToPosition:toPosition checkingCheck:checkCheck]){
        return NO;
    }
    NSLog(@"Salio antes");
    int startColumn = [self.mathUtils getColumnIndexForPosition:self.position];
    int startRow = [self.mathUtils getRowIndexForPosition:self.position];
    
    int endColumn = [self.mathUtils getColumnIndexForPosition:toPosition];
    int endRow = [self.mathUtils getRowIndexForPosition:toPosition];
    return (abs(startColumn - endColumn) <= 1 && abs(startRow - endRow) <= 1);


}
- (NSMutableArray *)canEat{
    NSMutableArray * positions = [[NSMutableArray alloc] init];
    if([self couldMoveToPosition:(self.position - 9) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - 9 )]];
    }
    if([self couldMoveToPosition:(self.position - 8) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - 8 )]];
    }
    if([self couldMoveToPosition:(self.position - 7) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - 7 )]];
    }
    if([self couldMoveToPosition:(self.position - 1) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - 1 )]];
    }
    if([self couldMoveToPosition:(self.position + 1) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position + 1 )]];
    }
    if([self couldMoveToPosition:(self.position + 7) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position + 7 )]];
    }
    if([self couldMoveToPosition:(self.position + 8) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position + 8 )]];
    }
    if([self couldMoveToPosition:(self.position + 9) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position + 9 )]];
    }
    
    return positions;
}

@end
