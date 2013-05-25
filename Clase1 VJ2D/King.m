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
    if(color == 1){
        self.imageResourceName = @"black_king.png";
    }else{
        self.imageResourceName = @"white_king.png";
    }
    self.type = 5;
    return self;
}

- (void) printPosition{
    NSLog(@"King: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
    return (self.color == 1 ? @" Black-King " : @" White-King ");

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
    NSLog(@"Salio antes");
    int startColumn = [self.mathUtils getColumnIndexForPosition:self.position];
    int startRow = [self.mathUtils getRowIndexForPosition:self.position];
    
    int endColumn = [self.mathUtils getColumnIndexForPosition:toPosition];
    int endRow = [self.mathUtils getRowIndexForPosition:toPosition];
    return (abs(startColumn - endColumn) <= 1 && abs(startRow - endRow) <= 1);


}

@end
