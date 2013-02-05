//
//  PartnershipData.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "PartnershipData.h"

@implementation PartnershipData

@synthesize partnershipName;
@synthesize totalAmmonut;
@synthesize totalGivings;


/* Constructor */
-(id) init {
    partnershipName=@"";
     totalAmmonut=0;
    totalGivings = [[NSMutableArray alloc] init];
    
  /*  NSString * first = @"50";
    [totalGivings addObject:first];
    NSString * sec = @"130";
    [totalGivings addObject:sec];
    NSString * third = @"220";
    [totalGivings addObject:third];*/

	return self;
}

/* Destructor */
-(void) dealloc {
	
    partnershipName=nil;
    totalAmmonut=0;
    [totalGivings release];
    [super dealloc];
}

-(NSString*) calculateTotalGivings {

    float totalValue= 0;
	for (int i=0; i<[totalGivings count]; i++) {
        float value = [[totalGivings objectAtIndex:i] floatValue];
        totalValue = totalValue + value;
    }
    NSString *string = [NSString stringWithFormat:@"%10.2f", totalValue];

    return string;
}


@end
