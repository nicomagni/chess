//
//  Piece.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/5/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Piece.h"
#import "MathUtils.h"
#import "Board.h"
#import "AppDelegate.h"

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

    [self.board positions][self.position] = [NSNull null];
    self.position = toPosition;
    //IF i am eating a piece, remove it from pieces
    if(![[self.board positions][self.position] isEqual:[NSNull null]]){
        [self.board.pieces removeObject:[self.board positions][self.position]];
    }
    [self.board positions][toPosition] = self;
//    [self.board rotateBoard];
    [self.board lookForChecks: (self.color == 0 ? 1: 0)];
  //  [self.board rotateBoard];
    return YES;
}

- (BOOL)couldMoveToPosition:(int)position checkingCheck:(BOOL) checkCheck{
    BOOL isValid = (position >= 0 && position <= 63) && self.position != position;
    if(isValid){
        Piece * endPiece = [self.board positions][position];
        Piece * startPiece = [self.board positions][self.position];
        if([endPiece isEqual:[NSNull null]] || [startPiece isEqual:[NSNull null]]){
            return isValid;
        }else{
            return isValid && [startPiece color] != [endPiece color];
        }

    }else{
        return NO;
    }
    
}

- (BOOL) validateCheck: (int) color piece: (int) position to: (int) toPosition{
    // Looks if my King is checked and validates that my move removes it.
    
    Board * auxBoard = [self.board copyBoard];
    
    Piece * piece = auxBoard.positions[position];
    if([AppDelegate sharedInstance].game.myColor == kBlack){
        [auxBoard rotateBoard];
    }
    [auxBoard positions][position] = [NSNull null];
    piece.position = toPosition;
    if(![[auxBoard positions][piece.position] isEqual:[NSNull null]]){
        [auxBoard.pieces removeObject:[auxBoard positions][piece.position]];
    }
    [auxBoard positions][toPosition] = piece;
    [auxBoard lookForChecks: self.color];
    
    if(auxBoard.check == color || auxBoard.checkmate == color){
        return NO;
    }
    
    return YES;
}

- (Piece *) copyPiece{
    NSAssert(NO, @"You must implement me!");
    return Nil;
}

-(NSMutableArray *)canEat{
    return [NSMutableArray array];
}

- (id) initWithColor:(int)color
{
    NSAssert(NO, @"You must implement me!");
    return Nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.board forKey:@"Board"];
    [aCoder encodeObject:self.imageResourceName forKey:@"ImageResourceName"];
    [aCoder encodeInt:self.position forKey:@"Position"];
    [aCoder encodeInt:self.color forKey:@"Color"];
    [aCoder encodeInt:self.type forKey:@"Type"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        self.mathUtils = [[MathUtils alloc] initWithColumngCount:8 andRowCount:8];
        self.board = [aDecoder decodeObjectForKey:@"Board"];
        self.position = [aDecoder decodeIntForKey:@"Position"];
        self.color = [aDecoder decodeIntForKey:@"Color"];
        self.type = [aDecoder decodeIntForKey:@"Type"];
        self.imageResourceName = [aDecoder decodeObjectForKey:@"ImageResourceName"];
        
    }
    return self;
}

@end
