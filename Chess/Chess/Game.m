//
//  Game.m
//  Chess
//
//  Created by Petit Alejandro on 25/06/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Game.h"
#import "Board.h"

@implementation Game

- (id) initGameWithColor: (int) color{
    if(self = [super init]){
        Board * board= [[Board alloc] init];
        self.myColor = [NSNumber numberWithInt:color];
        self.board = [board createNewBoardMyColoris:color];
        self.turn = [NSNumber numberWithInt:1];
        //    [self loadPiecesFromBoard];
        //    [AppDelegate sharedInstance].socket.delegate = self;

        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:date forKey:@"Date"];
    [aCoder encodeObject:self.board forKey:@"Board"];
    [aCoder encodeObject:self.turn forKey:@"Turn"];
    [aCoder encodeObject:self.myColor forKey:@"MyColor"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super init]){
        self.board = [aDecoder decodeObjectForKey:@"Board"];
        self.turn = [aDecoder decodeObjectForKey:@"Turn"];
        self.myColor = [aDecoder decodeObjectForKey:@"MyColor"];
    }
    return self;
}

@end
