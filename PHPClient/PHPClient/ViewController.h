//
//  ViewController.h
//  PHPClient
//
//  Created by Bob Emmanuel Esebamen on 1/28/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncUdpSocket.h"

@interface ViewController : UIViewController{
	long tag;
	AsyncUdpSocket *udpSocket;
    __weak IBOutlet UITextField *addrField;
    
    IBOutlet UITextField *portField;
    
    IBOutlet UITextField *messageField;
    
    IBOutlet UIButton *sendButton;
    
    IBOutlet UITextView *logView;
    
    NSMutableData *receivedData;

}

@end
