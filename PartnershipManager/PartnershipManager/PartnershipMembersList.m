//
//  PartnershipMembersList.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/21/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "PartnershipMembersList.h"

@implementation PartnershipMembersList

@synthesize name;
@synthesize partnersList;
@synthesize ammount;


/* Constructor */
-(id) init {
	name = @"";
    partnersList = [[NSMutableArray alloc] init];
    ammount = @"0";

	return self;
}

/* Destructor */
-(void) dealloc {
	
    name = nil;
    [partnersList release];
    ammount = nil;
 
    [super dealloc];
}


@end
