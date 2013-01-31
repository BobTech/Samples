//
//  AppDelegate.h
//  SocketServer
//
//  Created by Bob Emmanuel Esebamen on 1/29/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>

<<<<<<< HEAD
@class ViewController;
=======
@class MainViewController;
>>>>>>> Example HTTP Sockets Server and Client
@class GCDAsyncSocket;

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSNetServiceDelegate>
{
	NSNetService *netService;
	GCDAsyncSocket *asyncSocket;
	NSMutableArray *connectedSockets;
	
}


@property (strong, nonatomic) UIWindow *window;

<<<<<<< HEAD
@property (strong, nonatomic) ViewController *viewController;
=======
@property (strong, nonatomic) MainViewController *viewController;
>>>>>>> Example HTTP Sockets Server and Client

@end
