//
//  FirstViewController_iPad.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 2/5/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MembersListView_iPad.h"
#import "PersonData.h"
#import "LoginScreen.h"
#import "AppDataManager.h"
#import "BaseViewController.h"
#import "MemberDetailsView_iPad.h"


@interface FirstViewController_iPad : BaseViewController{
    MembersListView_iPad *membersView;
    MemberDetailsView_iPad *detailsView;
    
}


- (void)showMembersListView ;
//- (void)updateData;

- (void)gotoMembersDetailsView:(PersonData*)aData ;


@property (retain, nonatomic) IBOutlet UIView *leftView;
@property (retain, nonatomic) IBOutlet UIView *rightView;

@end
