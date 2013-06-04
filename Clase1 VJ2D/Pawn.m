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

- (BOOL) initialPosition:(int) row player:(int) color {
    if(color == 1){
        return row == 1;
    }else if (color == 2){
        return row == 6;
    }
    return NO;
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
    int move = self.color == 1 ? -1: 1;
    int startColumn = [self.mathUtils getColumnIndexForPosition:self.position];
    int startRow = [self.mathUtils getRowIndexForPosition:self.position];
    
    int endColumn = [self.mathUtils getColumnIndexForPosition:toPosition];
    int endRow = [self.mathUtils getRowIndexForPosition:toPosition];
    
    if((startRow - endRow) == (2 * move) && startColumn == endColumn && [self isEmpty:toPosition]){
            return [self initialPosition:startRow player: self.color];
    }else{
        if((startRow - endRow) == (1 * move) && startColumn == endColumn && [self isEmpty:toPosition]){
            return [self validateCheck:self.color piece: self.position to: toPosition];
        }else if((startRow - endRow) == (1 * move) && startColumn - endColumn == (1 * move) && [self isOponentPiece:toPosition for:self.color]){
            return [self validateCheck: self.color piece: self.position to: toPosition];
        }else if((startRow - endRow) == (1 * move) && endColumn - startColumn == (1 * move) && [self isOponentPiece:toPosition for:self.color]){
            return [self validateCheck: self.color piece: self.position to: toPosition];
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

-(NSMutableArray *)canEat:(Board *)board{
    NSMutableArray * positions = [[NSMutableArray alloc] initWithCapacity:4];

    int move = self.color == 1? -1 : 1;
    
    if( [self couldMoveToPosition:(self.position - (7 * move))]){
        [positions addObject:[NSNumber numberWithInt:(self.position - (7 * move))]];
    }
    if( [self couldMoveToPosition:(self.position - (8 * move))]){
        [positions addObject:[NSNumber numberWithInt:(self.position - (8 * move))]];
    }
    if( [self couldMoveToPosition:(self.position - (9 * move))]){
        [positions addObject:[NSNumber numberWithInt:(self.position - (9 * move))]];
    }
    if( [self couldMoveToPosition:(self.position - (2 * 8 * move))]){
        [positions addObject:[NSNumber numberWithInt:(self.position - (2 * 8 * move))]];
    }

    return positions;
}

- (BOOL) validateCheck: (int) color piece: (int) position to: (int) toPosition{
    // Looks if my King is checked and validates that my move removes it.
    if(color == self.board.check){
        Board * auxBoard = [self.board copy];
        [auxBoard.positions[position] move:toPosition];
        if(auxBoard.check == color || auxBoard.checkmate == color){
            return NO;
        }
    }
}

- (NSString*) description{
    return (self.color == 1 ? @" Black-Pawn " : @" White-Pawn ");
}


@end
