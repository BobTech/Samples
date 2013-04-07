//
//  ViewController.h
//  ChatServer
//
//  Created by Bob Emmanuel Esebamen on 2/6/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSStreamDelegate>{

    UIView			*joinView;
    UIView			*chatView;
    NSInputStream	*inputStream;
    NSOutputStream	*outputStream;
    UITextField		*inputNameField;
    UITextField		*inputMessageField;
    UITableView		*tView;
    NSMutableArray	*messages;

    int socketFDy;

}


@end
