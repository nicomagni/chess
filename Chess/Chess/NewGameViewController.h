//
//  NewGameViewController.h
//  Chess
//
//  Created by Nico Magni on 4/7/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "ViewController.h"

@interface NewGameViewController : ViewController
- (IBAction)blackColorButton:(UIButton *)sender;
- (IBAction)whiteColorButton:(UIButton *)sender;
- (IBAction)confirmationButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *blackButton;
@property (weak, nonatomic) IBOutlet UIButton *whiteButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmationButton;

@end
