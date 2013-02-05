//
//  SecondViewController_iPad.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 2/5/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PartnershipTypeViewGroup.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#include "BaseViewController.h"

@interface SecondViewController_iPad : BaseViewController <MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate> {
    PartnershipTypeViewGroup *partnershipTypesGroupView;
    
}


@property (retain, nonatomic) IBOutlet UIView *leftView;
@property (retain, nonatomic) IBOutlet UIView *rightView;

@end
