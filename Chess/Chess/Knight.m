//
//  Knight.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Knight.h"

@implementation Knight

- (void) printPosition{
    NSLog(@"Knight: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
    return (self.color == 1 ? @"Black-Knight" : @"White-Knight");
}

@end
