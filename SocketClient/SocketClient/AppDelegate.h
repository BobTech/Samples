//
//  AppDelegate.h
//  SocketClient
//
//  Created by Bob Emmanuel Esebamen on 1/29/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class GCDAsyncSocket;


@interface AppDelegate : UIResponder <UIApplicationDelegate, NSNetServiceBrowserDelegate, NSNetServiceDelegate>
{
	NSNetServiceBrowser *netServiceBrowser;
	NSNetService *serverService;
	NSMutableArray *serverAddresses;
	GCDAsyncSocket *asyncSocket;
	BOOL connected;
	
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
