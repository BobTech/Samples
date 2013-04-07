
#import <Foundation/Foundation.h>

//#import "AppDataManager.h"
#import "UserDataManager.h"

/* Login manager to handle URHOtv system login*/
@interface LoginManager : NSObject {
	//AppDataManager *appData;
    
    NSMutableData *receivedData;

}

/* Method declarations */

//-(id) init:(AppDataManager*)appDataManager;
-(bool) isUserLoginCached;
-(int) signInToServiceWithUsername:(NSString*)uName andPassword:(NSString*)pWord;

@end
