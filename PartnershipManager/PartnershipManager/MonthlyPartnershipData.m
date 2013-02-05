//
//  MonthlyPartnershipData.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MonthlyPartnershipData.h"

@implementation MonthlyPartnershipData

@synthesize name;
@synthesize year;

@synthesize partnership;


/* Constructor */
-(id) init {
    name = @"";
    year = @"";
    partnership = [[NSMutableArray alloc] init];

	return self;
}

/* Destructor */
-(void) dealloc {
    name = nil;
    year = nil;
    [partnership release];
    [super dealloc];
}

/* Destructor */
-(NSString*) calculateTotalMonthlyGivings {
    
    float totalValue= 0;
	for (int i=0; i<[partnership count]; i++) {
        float value = [[[partnership objectAtIndex:i] calculateTotalGivings] floatValue];
        totalValue = totalValue + value;
    }
    NSString *string = [NSString stringWithFormat:@"%10.2f", totalValue];
    
    return string;
}

@end
