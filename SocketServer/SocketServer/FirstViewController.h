//
//  ViewController.h
//  SocketServer
//
//  Created by Bob Emmanuel Esebamen on 1/29/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCDAsyncSocket;


@interface FirstViewController : UIViewController
{
	NSNetService *netService;
	GCDAsyncSocket *asyncSocket;
	NSMutableArray *connectedSockets;
	
}



@end
