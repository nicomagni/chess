//
//  GameViewController.h
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "Piece.h"
#import "Game.h"

@interface GameViewController : UIViewController

@property (nonatomic) Game * game;
@property (nonatomic) BOOL confirmationNeeded;
@property (nonatomic) Piece * startPiece;


@property (strong, nonatomic) IBOutlet UILabel *playerTurnLabel;
- (IBAction)pieceSelected:(UIButton *)sender forEvent:(UIEvent *)event;

@end
