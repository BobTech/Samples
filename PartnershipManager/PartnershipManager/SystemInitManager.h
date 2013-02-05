//
//  SystemInitManager.h
//
//

#import <Foundation/Foundation.h>
//#import "StartupScreenDelegate.h"

@class AppDataManager;
@class LoginManager;
@class MemberDataParser;

@interface SystemInitManager : NSObject {
    //id<StartupScreenDelegate> viewChanger;
	LoginManager *lManager;
 //   TBNoteParser *noteParser;
}

/* Method declarations */

//-(void) setViewChanger:(id<StartupScreenDelegate>)newViewChanger;
-(BOOL) checkIsNetworkAvailable;
-(void) fetchPartnershipData:(AppDataManager*)dataManager ;


@end
