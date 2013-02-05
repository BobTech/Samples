//
//  PersonData.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/4/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YearlyPartnershipData.h"

@interface PersonData : NSObject{
	NSString *name;
	NSString *surName;
    NSString *mobilePhone;
    NSString *telephone;
	int personID;
	NSString *email;
    NSString *sex;
	NSString *cell;
	NSString *dateOfBirth;
	NSString *address;
    
    YearlyPartnershipData* partnership;
}

/* Property declarations */

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *surName;
@property (nonatomic, copy) NSString *mobilePhone;
@property (nonatomic, copy) NSString *telephone;
@property int personID;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *cell;
@property (nonatomic, copy) NSString *dateOfBirth;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) YearlyPartnershipData* partnership;


@end
