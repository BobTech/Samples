//
//  FirstViewController_iPad.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 2/5/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MembersListView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "PersonData.h"
#import "LoginScreen.h"
#import "AppDataManager.h"


@interface FirstViewController_iPad : UIViewController <MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate> {
    
    MembersListView *membersView;
    NSMutableArray *subViews;
    
    LoginScreen* loginScren;
    
    UINavigationBar* naviBar;
    
}

@property (nonatomic, retain) NSMutableArray *subViews;

-(void)showMailPicker:(NSMutableArray*)aPersons;
-(void)showSMSPicker:(NSMutableArray*)aPersons;
-(void)displayMailComposerSheet:(NSMutableArray*)aPersons;
-(void)displaySMSComposerSheet:(NSMutableArray*)aPersons;

- (void)showMembersListView ;
//- (void)updateData;

- (void)enableTabbar ;


@property (retain, nonatomic) IBOutlet UIView *leftView;

@property (retain, nonatomic) IBOutlet UIView *rightView;

@end
