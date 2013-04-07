//
//  ApplicationData.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#include "AppDataManager.h"
#import <DropboxSDK/DropboxSDK.h>


@interface ApplicationData : NSObject<DBRestClientDelegate>{
    BaseViewController* parentViewController;
    NSMutableArray *subViews;
  
    NSMutableArray *PartnershipTypeArrays;

    AppDataManager* appData;
    
    NSString * csvFilePath;
    
    DBRestClient* restClient;

    NSArray* csvFilesPaths;

    BOOL isDownloadingCSV;
}

/* Singleton method */
+(ApplicationData*) sharedApplicationData;

@property (nonatomic, retain) BaseViewController* parentViewController;
@property (nonatomic, retain) NSMutableArray *subViews;
@property (nonatomic, retain) NSMutableArray *PartnershipTypeArrays;

@property (nonatomic, retain) AppDataManager* appData;
@property (nonatomic, retain) NSString * csvFilePath;
@property (nonatomic, retain) NSString * csvFilePath2;

@property int accessType;


/*Methods */
-(void) setupDropBoxAccount ;
- (void)LinkToDropBox ;

- (void)downloadFromDropBox:(int)aChurch;

-(void) setupFileDirectory ;
    
-(BOOL) checkIsNetworkAvailable;
-(void) fetchPartnershipData ;
- (void)updateData;

@end
