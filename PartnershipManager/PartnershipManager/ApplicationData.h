//
//  ApplicationData.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstViewController.h"

@interface ApplicationData : NSObject{
    FirstViewController* parentViewController;
    NSMutableArray *subViews;
  
    NSMutableArray *PartnershipTypeArrays;

    AppDataManager* appData;

}


/* Singleton method */
+(ApplicationData*) sharedApplicationData;

@property (nonatomic, retain) FirstViewController* parentViewController;
@property (nonatomic, retain) NSMutableArray *subViews;
@property (nonatomic, retain) NSMutableArray *PartnershipTypeArrays;

@property (nonatomic, retain) AppDataManager* appData;;

-(BOOL) checkIsNetworkAvailable;
-(void) fetchPartnershipData ;
- (void)updateData;

@end
