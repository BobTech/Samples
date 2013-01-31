//
//  ViewController.h
//  HTTPSocketServer
//
//  Created by Bob Emmanuel Esebamen on 1/31/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//
#import <UIKit/UIKit.h>
@class GCDAsyncSocket;


@interface ViewController : UIViewController
{
	dispatch_queue_t socketQueue;
	
	GCDAsyncSocket *listenSocket;
	NSMutableArray *connectedSockets;
	
	BOOL isRunning;
    IBOutlet UILabel *ipAddress;
	
    IBOutlet UITextView *logView;
    IBOutlet UIButton *startStopButton;
}


@property (strong, nonatomic) IBOutlet UIButton *StartButton;


@property (strong, nonatomic) IBOutlet UITextField *port;

@property (strong, nonatomic) IBOutlet UITableView *connectedDevicesView;



@end
