//
//  NewGameViewController.h
//  Chess
//
//  Created by Nico Magni on 4/7/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "ViewController.h"

@interface NewGameViewController : ViewController

- (IBAction)confirmationButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmationButton;

@end
