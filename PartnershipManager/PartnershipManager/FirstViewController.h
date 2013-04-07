//
//  FirstViewController.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/3/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MembersListView.h"
#import "PersonData.h"
#import "AppDataManager.h"
#import "SystemInitManager.h"
#include "BaseViewController.h"


@interface FirstViewController : BaseViewController{
   
    MembersListView *membersView;    
    
}

- (void)showMembersListView ;
//- (void)updateData;


@end
