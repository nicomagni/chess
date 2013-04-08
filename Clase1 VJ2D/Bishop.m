//
//  Bishop.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Bishop.h"

@implementation Bishop

- (id) initWithColor:(int)color {
    self = [super init];
    self.color = color;
    if(color == 1){
        self.imageResourceName = @"black_bishop.png";
    }else{
        self.imageResourceName = @"white_bishop.png";
    }
    return self;
}

- (void) printPosition{
    NSLog(@"Bishop: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
    return (self.color == 1 ? @"Black-Bishop" : @"White-Bishop");
}

- (BOOL)couldMoveToPosition:(int)toPosition{
    
    if(toPosition < 0 || toPosition > 63){
        return NO;
    }
    
    BOOL ans = [self lookInBackDiagonalFor:toPosition];
    ans |= [self lookInLeftDiagonalFor:toPosition];
    ans |= [self lookInRightDiagonalFor:toPosition];
    ans |= [self lookInTopDiagonalFor:toPosition];
    
    return ans;

}

- (BOOL)lookInTopDiagonalFor:(int)toPosition
{
    //Creating diagonal point
    int currentPosition = self.position;
    
    BOOL outsideBoard = NO;
    while (!outsideBoard) {
        if(toPosition == currentPosition){
            //HERE remains the validation if exist another piece in the path
            return YES;
        }
    currentPosition -= 7;
    outsideBoard = currentPosition < 0;
    }
return NO;
}

- (BOOL)lookInBackDiagonalFor:(int)toPosition
{
    //Creating diagonal point
    int currentPosition = self.position;
    
    BOOL outsideBoard = NO;
    while (!outsideBoard) {
        if(toPosition == currentPosition){
            //HERE remains the validation if exist another piece in the path
            return YES;
        }
        currentPosition += 7;
        outsideBoard = currentPosition > 63;
    }
    return NO;
}

- (BOOL)lookInRightDiagonalFor:(int)toPosition
{
    //Creating diagonal point
    int currentPosition = self.position;
    
    BOOL outsideBoard = NO;
    while (!outsideBoard) {
        if(toPosition == currentPosition){
            //HERE remains the validation if exist another piece in the path
            return YES;
        }
        currentPosition += 9;
        outsideBoard = currentPosition > 63;
    }
    return NO;
}

- (BOOL)lookInLeftDiagonalFor:(int)toPosition
{
    //Creating diagonal point
    int currentPosition = self.position;
    
    BOOL outsideBoard = NO;
    while (!outsideBoard) {
        if(toPosition == currentPosition){
            //HERE remains the validation if exist another piece in the path
            return YES;
        }
        currentPosition -= 9;
        outsideBoard = currentPosition < 0;
    }
    return NO;
}

@end
