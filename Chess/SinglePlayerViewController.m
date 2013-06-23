//
//  SinglePlayerViewController.m
//  Chess
//
//  Created by Nico Magni on 6/11/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "SinglePlayerViewController.h"
#import "Board.h"
#import "Piece.h"
#import "AppDelegate.h"
#import "UIDevice+IdentifierAddition.h"

@interface SinglePlayerViewController ()

@end

@implementation SinglePlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    Board * board= [[Board alloc] init];
    self.board = [board createNewBoardMyColoris:[self.myColor intValue]];
    self.confirmationNeeded = NO;
    [self loadPiecesFromBoard];
    self.turn = [NSNumber numberWithInt:1] ;
    [self loadTurn];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPiecesFromBoard
{
    for (int i = 0; i < [[self.board positions] count] ; i++) {
        Piece *piece = [self.board positions][i];
        if(![piece isEqual:[NSNull null]]){
            NSString *resource = [piece imageResourceName];
            UIImage * image = [UIImage imageNamed:resource];
            UIButton *button = (UIButton *)[[self view] viewWithTag:i + 100] ;
            [button setBackgroundImage:image forState:UIControlStateNormal];
        }else{
            UIButton *button = (UIButton *)[[self view] viewWithTag:i + 100] ;
            [button setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
}

- (IBAction)pieceSelected:(UIButton *)sender forEvent:(UIEvent *)event {
    int pieceTag = [sender tag] - 100;
//    BOOL myTurn = ([self.turn intValue] % 2 == [self.myColor intValue]);
    int colorTurn = [self.turn intValue] % 2;
    
        if (self.startPiece != nil) {
            //This is the target button
            
            NSLog(@"Setting the destintion");
            
            self.confirmationNeeded = [self.startPiece move:pieceTag];
            
            [self loadPiecesFromBoard];
            if(self.confirmationNeeded){
                self.turn = ([self.turn isEqual:[NSNumber numberWithInt:0]] ? [NSNumber numberWithInt:1]:[NSNumber numberWithInt:0]);
                
                if(self.startPiece.board.check != -1){
                    [self loadCheck: self.startPiece.board.check];
                }else if(self.startPiece.board.checkmate != -1){
                    [self loadCheckmate: self.startPiece.board.checkmate];
                }else{
                 [self loadTurn];
                }
            }
            
             self.startPiece = nil;
            
        }else if(![[self.board positions][pieceTag] isEqual:[NSNull null]]){
            
            self.startPiece = [self.board positions][pieceTag];
            if(self.startPiece.color != colorTurn){
                self.startPiece = nil;
            }
            NSLog(@"Setting the origin");
        }else{
            NSLog(@"Reset the origin");
            self.startPiece = nil;
        }
        


}

- (void)loadTurn{
    if([self.turn intValue] % 2 == kWhite){
        self.playerTurnLabel.text = @"Turno del Blanco";
    }else{
        self.playerTurnLabel.text = @"Turno del Negro";
    }
}

- (void) loadCheck: (int) color{
    if(color == kWhite){
        self.playerTurnLabel.text = @"Jaque al Blanco";
    }else{
        self.playerTurnLabel.text = @"jaque al Negro";
    }
}

- (void) loadCheckmate: (int) color{
    if(color == kWhite){
        self.playerTurnLabel.text = @"Jaque Mate al Blanco";
    }else{
        self.playerTurnLabel.text = @"Jaque Mate al Negro";
    }
}

@end