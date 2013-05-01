//
//  NewGameViewController.m
//  Chess
//
//  Created by Nico Magni on 4/7/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "NewGameViewController.h"
#import <GameKit/GameKit.h>
#import "AppDelegate.h"
#import "UIDevice+IdentifierAddition.h"

@interface NewGameViewController ()
@property (nonatomic) BOOL connected;
@end

@implementation NewGameViewController
@synthesize connected = _connected;

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
    [AppDelegate sharedInstance].socket.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSError* error;
    NSDictionary* messageJSON = [NSJSONSerialization JSONObjectWithData:[(NSString*)message dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    NSString* messageId = [messageJSON valueForKey:@"Command"];
    
    if ([messageId isEqualToString:@"Connected"]) {
        self.connected = YES;
        NSLog(@"Conected");
    } else if ([messageId isEqualToString:@"StartMatch"]) {
        NSLog(@"Start match");
        [self.confirmationButton setEnabled:YES];
    }
}


- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"socket closed");
}


- (IBAction)blackColorButton:(UIButton *)sender {
    [[self whiteButton] setEnabled:NO];
    [self sendStartMathcWithColor:@"Balck"];
}

- (IBAction)whiteColorButton:(UIButton *)sender {
    [[self blackButton] setEnabled:NO];
    [self sendStartMathcWithColor:@"White"];
}

- (IBAction)confirmationButton:(UIButton *)sender {
    //Start Match
}

- (void)sendStartMathcWithColor:(NSString *)color {
    SRWebSocket* socket = [AppDelegate sharedInstance].socket;
    NSLog(@"Find Match");
    NSString * uniqueIdentifier = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
    
    NSDictionary* connectDict = [NSDictionary dictionaryWithObjectsAndKeys:@"FindMatch", @"Command", uniqueIdentifier, @"Id", nil];
    
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:connectDict options:0 error:&error];
    
    [socket send:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}
@end
