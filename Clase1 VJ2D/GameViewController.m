//
//  GameViewController.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "GameViewController.h"
#import "Board.h"
#import "Piece.h"

@interface GameViewController ()


@end

@implementation GameViewController

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
    self.board = [board createNewBoard];
     
    [self loadPiecesFromBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPiecesFromBoard
{
    /*
    NSLog(@"Tamaño %d", [self.pieces count]);
    for (id imageView in self.pieces) {
        NSLog(@"Image View %d", [imageView tag]);
    }
    */
    for (int i = 0; i < [[self.board positions] count] ; i++) {
        Piece *piece = [self.board positions][i];
        if(![piece isEqual:[NSNull null]]){
            NSString *resource = [piece imageResourceName];
            UIImage * image = [UIImage imageNamed:resource];
            UIButton *button = (UIButton *)[[self view] viewWithTag:i + 100] ;
            [button setBackgroundImage:image forState:UIControlStateNormal];
        }
    }
}

@end
