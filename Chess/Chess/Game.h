//
//  Game.h
//  Chess
//
//  Created by Petit Alejandro on 25/06/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"
#import "Piece.h"

@interface Game : NSObject <NSCoding>

@property (nonatomic) Board * board;
@property (nonatomic,strong) NSNumber *myColor;
@property (nonatomic,strong) NSNumber *turn;


- (id) initGameWithColor: (int) color;

@end
