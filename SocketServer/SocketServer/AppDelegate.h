//
//  AppDelegate.h
//  SocketServer
//
//  Created by Bob Emmanuel Esebamen on 1/29/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class GCDAsyncSocket;

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSNetServiceDelegate>
{
	NSNetService *netService;
	GCDAsyncSocket *asyncSocket;
	NSMutableArray *connectedSockets;
	
}


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
