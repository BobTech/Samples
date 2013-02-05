//
//  SecondViewController.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/3/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnershipTypeViewGroup.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#include "BaseViewController.h"


@interface SecondViewController : BaseViewController <MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate> {
    PartnershipTypeViewGroup *partnershipTypesGroupView;
  //  NSMutableArray *subViews;

}
//@property (nonatomic, retain) NSMutableArray *subViews;


@end
