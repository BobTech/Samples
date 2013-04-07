

#import <CommonCrypto/CommonDigest.h>
#import "UserDataManager.h"
//#import "ModelConstants.h"

static UserDataManager *userDataInstance = nil;

#define kDataFilename @"bob.dat"

@implementation UserDataManager

@synthesize dataSet, userAuthenticated;
@synthesize userName, password;
@synthesize userIdHash;
@synthesize serverToken, apsPushToken;

/* Calculate MD5 hash of UDID */
NSString* md5() {
	const char *cStr = [[[UIDevice currentDevice] uniqueIdentifier] UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
			];
} 

/* Constructor */
-(id) init {
	[self fetchData];
	if (dataSet == nil) {
		dataSet = [[NSMutableDictionary alloc] init];
	}
    
    self.userIdHash = md5();
    self.serverToken = nil;
    self.apsPushToken = nil;
	
	return self;
}

/* Destructor *
-(void) dealloc {
	self.userIdHash = nil;
    self.serverToken = nil;
    self.apsPushToken = nil;
    
    [dataSet release];
    
	[super dealloc];
}

/* Singleton fetcher */
+(UserDataManager*) instance {
	if (userDataInstance == nil) {
		userDataInstance = [[UserDataManager alloc] init];		
	}
	
	return userDataInstance;
}

/* Returns data file path */
-(NSString*) dataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:kDataFilename];
//	DebugLog(@"Data file path: %@", path);
	return path;
}

/* Returns the data from fetcher */
-(NSDictionary*) fetchData {
	NSString *path = [self dataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
	//[dataSet release];
		dataSet = nil;
		dataSet = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		return dataSet;		
	} else {
		return nil;
	}
}

/* Returns value for a key */
-(NSString*) getValueForKey:(NSString*)key {		
	return [dataSet valueForKey:key];						 
}

/* Inserts data with the key value */
-(void) insertDataWithKey:(NSString*)key obj:(NSString*)value {
	if (value != nil && key != nil) {
		[dataSet setObject:value forKey:key];
	}
}

/* Deletes key */
-(void) deleteKey:(NSString*)key {
	[dataSet removeObjectForKey:key];
}

/* Commits the changes to the file */
-(void) commit {
	NSString *path = [self dataFilePath];
	[dataSet writeToFile:path atomically:YES];
}

/* Deletes the store */
-(void) deleteStore {
	[[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:nil];
	//[dataSet release];
	dataSet = nil;
	dataSet = [[NSMutableDictionary alloc] init];
}

@end
