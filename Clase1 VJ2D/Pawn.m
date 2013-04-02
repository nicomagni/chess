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

- (void) printPosition{
    NSLog(@"Pawn: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

BOOL initialPosition(int pos) {
    
    if(pos/8 == 1 ||  pos/8 == 6){
        return YES;
    }
    return NO;
}

BOOL isEmpty(int position){
    
    //Implement Me
    return YES;
}

- (BOOL) move:(int)toPosition {
    
    if(toPosition < 0 || toPosition > 63){
        return NO;
    }

    // If pawn is black it should move foward if not backwards
    int pawnDirection = self.color == 1 ? 8 : -8;
    
    if(initialPosition(self.position) && [self isEmpty:toPosition] &&
       (toPosition == self.position + pawnDirection || toPosition == self.position + (2* pawnDirection))){
        [self.board positions][self.position] = [NSNull null];
        [self.board positions][toPosition] = self;
        self.position = toPosition;
        return YES;
    }else if(self.position%8 > 0 && self.position%8 < 7 && [self isOponentPiece:toPosition for:self.color]){
        if(pawnDirection == 8){
            if( self.position + 7 == toPosition || self.position + 9 == toPosition){
                [self.board positions][self.position] = [NSNull null];
                [self.board positions][toPosition] = self;
                self.position = toPosition;
                return YES;
            }
            return NO;
        }else{
            if( self.position - 7 == toPosition || self.position - 9 == toPosition){
                [self.board positions][self.position] = [NSNull null];
                [self.board positions][toPosition] = self;
                self.position = toPosition;
                return YES;
            }
            return NO;
        }
    }else if(self.position%8 == 0  && [self isOponentPiece:toPosition for:self.color]){
        if(pawnDirection == 8){
            if(self.position + 9 == toPosition){
                [self.board positions][self.position] = [NSNull null];
                [self.board positions][toPosition] = self;
                self.position = toPosition;
                return YES;
            }
            return NO;
        }else{
            if( self.position - 7 == toPosition){
                [self.board positions][self.position] = [NSNull null];
                [self.board positions][toPosition] = self;
                self.position = toPosition;
                return YES;
            }
            return NO;
        }

    }else if(self.position%8 == 7 && [self isOponentPiece:toPosition for:self.color]){
        if(pawnDirection == 8){
            if( self.position + 7 == toPosition){
                [self.board positions][self.position] = [NSNull null];
                [self.board positions][toPosition] = self;
                self.position = toPosition;
                return YES;
            }
            return NO;
        }else{
            if(self.position - 9 == toPosition){
                [self.board positions][self.position] = [NSNull null];
                [self.board positions][toPosition] = self;
                self.position = toPosition;
                return YES;
            }
            return NO;
        }

    }
    return NO;
}

- (BOOL) isEmpty: (int) position{
    if([self.board positions][position] == [NSNull null]){
        return YES;
    }
    return NO;
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
