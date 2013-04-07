

#import <Foundation/Foundation.h>

#ifndef __APPDATAMANAGER_H__
#define __APPDATAMANAGER_H__

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
