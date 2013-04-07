
#ifndef __USERDATAMANAGER_H__
#define __USERDATAMANAGER_H__

#import <Foundation/Foundation.h>

#define kFavouriteMatchesKey @"faveMatches"
#define kUserNameField @"uname"
#define kPasswordField @"pword"

/* Handles user data */
@interface UserDataManager : NSObject {	
	NSMutableDictionary *dataSet;
	bool userAuthenticated;
	
	NSString *userName;
    NSString *serverToken;
    NSString *apsPushToken;
	NSString *password;
    NSString *userIdHash;
}

/* Property declarations */

@property (nonatomic, retain) NSMutableDictionary *dataSet;
@property bool userAuthenticated;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *userIdHash;
@property (nonatomic, copy) NSString *serverToken;
@property (nonatomic, copy) NSString *apsPushToken;

/* Singleton fetcher */

+(UserDataManager*) instance;

/* Method declarations */

-(NSDictionary*) fetchData;
-(NSString*) getValueForKey:(NSString*)key;
-(void) insertDataWithKey:(NSString*)key obj:(NSString*)value;
-(void) deleteKey:(NSString*)key;
-(void) commit;
-(void) deleteStore;

@end

#endif	//	__USERDATAMANAGER_H__