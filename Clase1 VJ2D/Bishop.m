//
//  Bishop.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Bishop.h"
#import "Board.h"

@implementation Bishop

- (id) initWithColor:(int)color {
    self = [super init];
    self.color = color;
    if(color == 1){
        self.imageResourceName = @"black_bishop.png";
    }else{
        self.imageResourceName = @"white_bishop.png";
    }
    self.type = kBishop;
    return self;
}

- (void) printPosition{
    NSLog(@"Bishop: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
    return (self.color == 1 ? @"Black-Bishop" : @"White-Bishop");
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
    
    BOOL ans = false;
    ans |= [self lookInBackDiagonalFor:toPosition];
    ans |= [self lookInLeftDiagonalFor:toPosition];
    ans |= [self lookInRightDiagonalFor:toPosition];
    ans |= [self lookInTopDiagonalFor:toPosition];
    
    return ans;

}

- (BOOL)lookInTopDiagonalFor:(int)toPosition
{
    //Creating diagonal point
    int currentPosition = self.position;
    int piecesInpathCount = 0;
    BOOL outsideBoard = NO;
    
    while (!outsideBoard) {
        currentPosition -= 7;
        outsideBoard = currentPosition < 0;
        
        if(toPosition == currentPosition){
            //HERE remains the validation if exist another piece in the path
            return piecesInpathCount == 0;
        }else if(!outsideBoard && ![[self.board positions][currentPosition] isEqual:[NSNull null]]){
            //The end posiiton it's empty or is another piece.
            piecesInpathCount++;
        }

    }
    
    return NO;
}

- (BOOL)lookInBackDiagonalFor:(int)toPosition
{
    //Creating diagonal point
    int currentPosition = self.position;
    int piecesInpathCount = 0;
    BOOL outsideBoard = NO;
    
    while (!outsideBoard) {
        currentPosition += 7;
        outsideBoard = currentPosition > 63;
        
        if(toPosition == currentPosition){
            //HERE remains the validation if exist another piece in the path
           return piecesInpathCount == 0;
        }else if(!outsideBoard && ![[self.board positions][currentPosition] isEqual:[NSNull null]]){
            //The end posiiton it's empty or is another piece.
            piecesInpathCount++;
        }

    }
    return NO;
}

- (BOOL)lookInRightDiagonalFor:(int)toPosition
{
    //Creating diagonal point
    int currentPosition = self.position;
    int piecesInpathCount = 0;
    BOOL outsideBoard = NO;
    
    while (!outsideBoard) {
        currentPosition += 9;
        outsideBoard = currentPosition > 63;
        
        if(toPosition == currentPosition){
            //HERE remains the validation if exist another piece in the path
            return piecesInpathCount == 0;
        }else if(!outsideBoard && ![[self.board positions][currentPosition] isEqual:[NSNull null]]){
            //The end posiiton it's empty or is another piece.
            piecesInpathCount++;
        }

    }
    return NO;
}

- (BOOL)lookInLeftDiagonalFor:(int)toPosition
{
    //Creating diagonal point
    int currentPosition = self.position;
    int piecesInpathCount = 0;
    BOOL outsideBoard = NO;
    
    while (!outsideBoard) {
        currentPosition -= 9;
        outsideBoard = currentPosition < 0;
        
        if(toPosition == currentPosition){
            //HERE remains the validation if exist another piece in the path
           return piecesInpathCount == 0;
        }else if(!outsideBoard && ![[self.board positions][currentPosition] isEqual:[NSNull null]]){
            //The end posiiton it's empty or is another piece.
            piecesInpathCount++;
        }
    }
    return NO;
}

@end
