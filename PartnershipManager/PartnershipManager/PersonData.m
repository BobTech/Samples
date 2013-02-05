//
//  PersonData.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/4/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "PersonData.h"

@implementation PersonData
@synthesize name;
@synthesize surName;
@synthesize mobilePhone;
@synthesize telephone;
@synthesize personID;
@synthesize email;
@synthesize cell;
@synthesize dateOfBirth;
@synthesize address;
@synthesize partnership;
@synthesize sex;


/* Constructor */
-(id) init {
	name = @"";
	surName = @"";
	mobilePhone = @"";
	telephone = @"";
	personID = 0;
	email = @"";
	cell = @"";
	dateOfBirth = @"";
    address = @"";
    sex = @"";
    partnership = [[YearlyPartnershipData alloc] init];
    
	return self;
}

/* Destructor */
-(void) dealloc {
	
    name = nil;
	surName = nil;
	mobilePhone = nil;
	telephone = nil;
	personID = 0;
	email = nil;
	cell = nil;
	dateOfBirth = nil;
    address = nil;
    partnership = nil;
    sex = nil;

	[super dealloc];
}


@end
