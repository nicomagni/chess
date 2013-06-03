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
    self.type = 0;
    return self;
}

- (void) printPosition{
    NSLog(@"Pawn: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (BOOL) initialPosition:(int) row {
    return row == 6;
}

- (BOOL) isEmpty:(int) position{
    
    return [[[self board] positions][position] isEqual: [NSNull null]];
}



- (BOOL) move:(int)toPosition {
    
    if([self couldMoveToPosition:toPosition]){
        return [super move:toPosition];
    }
    return NO;
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
    
    if((startRow - endRow) == 2 && startColumn == endColumn){
        return [self initialPosition:startRow];
    }else{
        if((startRow - endRow) == 1 && startColumn == endColumn && [self isEmpty:toPosition]){
            return YES;
        }else if((startRow - endRow) == 1 && startColumn - endColumn == 1 && [self isOponentPiece:toPosition for:2]){
            //right movement
            return YES;
        }else if((startRow - endRow) == 1 && endColumn - startColumn == 1 && [self isOponentPiece:toPosition for:2]){
            //left movement
            return YES;
        }
    }
    return NO;
}


- (BOOL) isOponentPiece: (int) position for: (int) myColor{
    if(![[self.board positions][position] isEqual:[NSNull null]]){
        if([((Piece*)[self.board positions][position]) color]  != myColor){
            return YES;
        }
    }
return NO;
}

- (NSString*) description{
    return (self.color == 1 ? @" Black-Pawn " : @" White-Pawn ");
}


@end
