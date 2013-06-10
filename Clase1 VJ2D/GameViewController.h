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

@interface GameViewController : UIViewController
@property (nonatomic) Board * board;
@property (nonatomic) Piece * startPiece;
@property (nonatomic,strong) NSNumber *myColor;
@property (nonatomic,strong) NSNumber *turn;
@property (nonatomic) BOOL confirmationNeeded;

- (IBAction)pieceSelected:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)cancelButton:(UIButton *)sender;
- (IBAction)confirmButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end
