//
//  MonthPartnerGroupData.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/22/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MonthPartnerGroupData.h"

@implementation MonthPartnerGroupData

@synthesize persons;
@synthesize partnershipName;
@synthesize month;
@synthesize year;
@synthesize ammount;

/* Constructor */
-(id) init {
	persons = [[NSMutableArray alloc] init];
    partnershipName = @"";
	month = @"";
	year = @"";
	ammount = @"0";
    
	return self;
}

/* Destructor */
-(void) dealloc {
	
    partnershipName = nil;
    [persons release];
    month = nil;
    year = nil;
    ammount = nil;

    [super dealloc];
}

/*
-(NSString*) calculateTotalGivings {
    
    int totalValue= 0;
	for (int i=0; i<[totalGivings count]; i++) {
        int value = [[totalGivings objectAtIndex:i] floatValue];
        totalValue = totalValue + value;
    }
    NSString *string = [NSString stringWithFormat:@"%10.2f", totalValue];
    
    return string;
}
 */

-(void) addToAmmonut:(NSString*)aAmmount {
    
    float totalValue= [ammount floatValue];
    float value = [aAmmount floatValue];
    totalValue = totalValue + value;
    self.ammount = [NSString stringWithFormat:@"%10.2f", totalValue];

}


@end

