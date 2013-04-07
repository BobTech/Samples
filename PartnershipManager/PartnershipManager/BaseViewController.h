//
//  BaseViewController.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 2/5/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>
#import "LoginScreen.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface BaseViewController : UIViewController<MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>{
    
    NSMutableArray *subViews;

    LoginScreen* loginScren;
   
    UINavigationBar* naviBar;

}

-(void)showMailPicker:(NSMutableArray*)aPersons;
-(void)showSMSPicker:(NSMutableArray*)aPersons;
-(void)displayMailComposerSheet:(NSMutableArray*)aPersons;
-(void)displaySMSComposerSheet:(NSMutableArray*)aPersons;


@property (nonatomic, retain) NSMutableArray *subViews;

//Methods declaration
- (void)disableTabbar ;
- (void)enableTabbar ;

- (void)showLoginView ;
- (void)loginCompleted;
@end
