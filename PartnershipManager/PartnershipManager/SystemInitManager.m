//
//  SystemInitManager.m
//
//

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "AppDataManager.h"
#import "SystemInitManager.h"
#import "LoginManager.h"

#import "UserDataManager.h"
#import "Reachability.h"
#import "Strings.h"

#import "MemberDataParser.h"
#import "ModelConstants.h"
#define partnershipXML_URL @"http://partner.jr-dev.com/partner3.xml"


@implementation SystemInitManager


/* Constructor */
-(id) init {
	DebugLog(@"init() called");	
	return self;
}

/* Destructor */
-(void) dealloc {
	DebugLog(@"dealloc() called");
	[lManager release];	
	
	[super dealloc];
}

/* Fetches league data */
-(void) fetchPartnershipData:(AppDataManager*)dataManager {
	MemberDataParser *partnershipParser = [[[MemberDataParser alloc] init] autorelease];
	bool ok = [partnershipParser loadXML:dataManager dataUrl:partnershipXML_URL];
	if (!ok) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:kLoadingErrorDialogHeader message:kLoadingErrorDialogText delegate:self cancelButtonTitle:kLoadingErrorDialogButtonText otherButtonTitles:nil] autorelease];
		[alert show];
	} else {
        
		//[viewChanger changeStartupState:[viewChanger currentStartupState] + 1 errorCode:kErrLoadingOK];
	}
}


/* Sets the new view changer delegate *
-(void) setViewChanger:(id<StartupScreenDelegate>)newViewChanger {
	DebugLog(@"setViewChanger() called");
	viewChanger = newViewChanger;
}
*/
/* Handles error dialog button presses by exiting the application */
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	exit(0);
}

/* Checks that network connection exists */
-(BOOL) checkIsNetworkAvailable {
	DebugLog(@"checkIsNetworkAvailable() called");
	
	Reachability *reachability = [Reachability reachabilityForInternetConnection];
	
	DebugLog(@"Doing network status check");
	
	if([reachability currentReachabilityStatus] == NotReachable) {
		DebugLog(@"Network not available");
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:kNoNetworkDialogHeader message:kNoNetworkDialogText delegate:self cancelButtonTitle:kNoNetworkDialogButtonText otherButtonTitles:nil] autorelease];
		[alert show];
        return NO;
	} else { 				
		/*[viewChanger updateStartupProgress:[viewChanger currentStartupState]*10];
		int nextState = [viewChanger currentStartupState] + 1;
		[viewChanger changeStartupState:nextState errorCode:kErrLoadingOK];		*/
        DebugLog(@"Network IS available");
        return YES;
	}
}

@end
