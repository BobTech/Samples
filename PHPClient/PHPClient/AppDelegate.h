//
//  AppDelegate.h
//  PHPClient
//
//  Created by Bob Emmanuel Esebamen on 1/28/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Cocoa/Cocoa.h>


@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

/*
//@property (assign) IBOutlet NSWindow *window;

@property  IBOutlet UITextField * addrField;
@property  IBOutlet UITextField * portField;
@property  IBOutlet UITextField * messageField;
@property  IBOutlet UIButton    * sendButton;
@property  IBOutlet UITextView  * logView;
*/

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
