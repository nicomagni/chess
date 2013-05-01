//
//  Pawn.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Pawn.h"
#import "Board.h"

@implementation Pawn

- (id) initWithColor:(int)color {
    self = [super init];
    self.color = color;
    if(color == 1){
        self.imageResourceName = @"black_pawn.png";
    }else{
        self.imageResourceName = @"white_pawn.png";
    }
    return self;
}

- (void) printPosition{
    NSLog(@"Pawn: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

BOOL initialPosition(int row) {
    return row == 6;
}

BOOL isEmpty(int position){
    
    //Implement Me
    return YES;
}



- (BOOL) move:(int)toPosition {
    
    if([self couldMoveToPosition:toPosition]){
        [super move:toPosition];
    }
}

-(BOOL) couldMoveToPosition:(int)toPosition{
    
    if(![super couldMoveToPosition:toPosition]){
        return NO;
    }
    
    // If pawn is black it should move foward if not backwards
    int startColumn = [self.mathUtils getColumnIndexForPosition:self.position];
    int startRow = [self.mathUtils getRowIndexForPosition:self.position];
    
    int endColumn = [self.mathUtils getColumnIndexForPosition:toPosition];
    int endRow = [self.mathUtils getRowIndexForPosition:toPosition];
    
    if((endRow - startRow) == 2 && startColumn == endColumn){
        return initialPosition(startRow);
    }else{
        if((endRow - startRow) == 1 && startColumn == endColumn){
            return true;
        }else if((endRow - startRow) == 1 && startColumn - endColumn >= 1 ){
            //right movement
            return true;
        }else if((endRow - startRow) == 1 && endColumn - startColumn <= 1){
            //left movement
            return true;
        }
    }
}


- (BOOL) isOponentPiece: (int) position for: (int) myColor{
    if([self.board positions][position] != [NSNull null] &&
       [((Piece*)[self.board positions][position]) color]  != myColor){
        return YES;
    }
    return NO;
}

- (NSString*) description{
    return (self.color == 1 ? @" Black-Pawn " : @" White-Pawn ");
}


@end
