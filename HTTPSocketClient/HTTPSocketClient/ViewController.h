//
//  ViewController.h
//  HTTPSocketClient
//
//  Created by Bob Emmanuel Esebamen on 1/30/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCDAsyncSocket;


@interface ViewController : UIViewController{
		
    GCDAsyncSocket *asyncSocket;

    BOOL clientConnected;
    dispatch_queue_t socketQueue;

}

@property (retain, nonatomic) IBOutlet UITextField *ipAddress;

@property (retain, nonatomic) IBOutlet UITextField *host;
@property (retain, nonatomic) IBOutlet UITextField *messageView;

@property (retain, nonatomic) IBOutlet UITextView *chatView;

@end
