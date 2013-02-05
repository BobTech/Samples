#import <Foundation/Foundation.h>

/* Login data structure */
@interface LoginData : NSObject {
	NSString *loginId;
	NSString *headerText;
}

/* Property declarations */

@property (nonatomic, copy) NSString *loginId;
@property (nonatomic, copy) NSString *headerText;

@end
