//
//  ApplicationData.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "ApplicationData.h"
#import "Strings.h"
#import "Reachability.h"
#import "MemberDataParser.h"


#define partnershipXML_URL @"http://partner.jr-dev.com/partner3.xml"

@implementation ApplicationData

@synthesize parentViewController;
@synthesize subViews;
@synthesize PartnershipTypeArrays;
@synthesize appData;

//SYNTHESIZE_SINGLETON_FOR_CLASS(ApplicationData);

+ (ApplicationData*) sharedApplicationData {
    static ApplicationData* _one = nil;
    
    @synchronized( self ) {
        if( _one == nil ) {
            _one = [[ ApplicationData alloc ] init ];
            
        }
    }
    
    return _one;
}



/* Fetches league data */
-(void) fetchPartnershipData {
	MemberDataParser *partnershipParser = [[[MemberDataParser alloc] init] autorelease];
	bool ok = [partnershipParser loadXML:appData dataUrl:partnershipXML_URL];
	if (!ok) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:kLoadingErrorDialogHeader message:kLoadingErrorDialogText delegate:self cancelButtonTitle:kLoadingErrorDialogButtonText otherButtonTitles:nil] autorelease];
		[alert show];
	} else {
    }
}

/* Checks that network connection exists */
-(BOOL) checkIsNetworkAvailable {
	//DebugLog(@"checkIsNetworkAvailable() called");
	
	Reachability *reachability = [Reachability reachabilityForInternetConnection];
	
	//DebugLog(@"Doing network status check");
	
	if([reachability currentReachabilityStatus] == NotReachable) {
		//DebugLog(@"Network not available");
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:kNoNetworkDialogHeader message:kNoNetworkDialogText delegate:self cancelButtonTitle:kNoNetworkDialogButtonText otherButtonTitles:nil] autorelease];
		[alert show];
        return NO;
	} else {
        //DebugLog(@"Network IS available");
        return YES;
	}
}

- (void)updateData
{
    if ([self checkIsNetworkAvailable]) {
      //  [appData release];
         appData = nil;
         appData = [[AppDataManager alloc] init] ;
        
        [self fetchPartnershipData];
        [appData setupData];
        
        
    }else {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:kNoNetworkDialogHeader message:kNoNetworkDialogText2 delegate:self cancelButtonTitle:kNoNetworkDialogButtonText otherButtonTitles:nil] autorelease];
		[alert show];
    }
    
}

@end
