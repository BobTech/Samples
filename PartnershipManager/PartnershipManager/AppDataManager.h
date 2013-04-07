

#import <Foundation/Foundation.h>

#ifndef __APPDATAMANAGER_H__
#define __APPDATAMANAGER_H__

//#define kClientUserAgent @"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) UrhoTVClient"

/* Data manager object, holds all the data */
@interface AppDataManager : NSObject {
	NSMutableArray *membersList;
    NSMutableArray *partnersList;
    NSMutableArray *partnershipNamesList;

}

/* Property declarations */

@property (nonatomic, retain) NSMutableArray *membersList;
@property (nonatomic, retain) NSMutableArray *partnersList;

/* Method declarations */
- (void) setupData;
-(NSString*) calculateTotalPartnerships;


@end

#endif	//	__APPDATAMANAGER_H__
