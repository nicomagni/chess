//
//  GameViewController.h
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"

@interface GameViewController : UIViewController
@property (nonatomic) Board * board;
@property (nonatomic, strong) IBOutletCollection(UIImageView) NSArray *pieces;

@end
