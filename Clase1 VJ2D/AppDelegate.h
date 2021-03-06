//
//  AppDelegate.h
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/5/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SocketRocket/SRWebSocket.h>
#import "Game.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SRWebSocket* socket;
@property (strong, nonatomic) NSNumber* playerMode;
@property (strong, nonatomic) Game* game;

+ (AppDelegate*) sharedInstance;

@end
