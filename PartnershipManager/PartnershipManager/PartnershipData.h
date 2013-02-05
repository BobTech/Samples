//
//  PartnershipData.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartnershipData : NSObject{
	NSString *partnershipName;
	int totalAmmonut;
    NSMutableArray *totalGivings;

}

/*Member declaration*/
-(NSString*) calculateTotalGivings ;

/* Property declarations */

@property (nonatomic, copy) NSString *partnershipName;
@property int totalAmmonut;
@property (nonatomic, copy) NSMutableArray *totalGivings;

@end
