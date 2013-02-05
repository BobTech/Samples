//
//  YearlyPartnership.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "YearlyPartnershipData.h"

@implementation YearlyPartnershipData

/*@synthesize january;
@synthesize february;
@synthesize march;
@synthesize april;
@synthesize may;
@synthesize june;
@synthesize july;
@synthesize august;
@synthesize september;
@synthesize october;
@synthesize november;
@synthesize december;*/
@synthesize monthlyPartnershipDataList;


/* Constructor */
-(id) init {
    
   /* january = [[MonthlyPartnershipData alloc] init];
    february = [[MonthlyPartnershipData alloc] init];
    march = [[MonthlyPartnershipData alloc] init];
    april = [[MonthlyPartnershipData alloc] init];
    may = [[MonthlyPartnershipData alloc] init];
    june = [[MonthlyPartnershipData alloc] init];
    july = [[MonthlyPartnershipData alloc] init];
    august = [[MonthlyPartnershipData alloc] init];
    september = [[MonthlyPartnershipData alloc] init];
    october = [[MonthlyPartnershipData alloc] init];
    november = [[MonthlyPartnershipData alloc] init];
    december = [[MonthlyPartnershipData alloc] init];*/

    monthlyPartnershipDataList = [[NSMutableArray alloc] init];
  //  [self setupData];
	return self;
}

/* Destructor */
-(void) dealloc {
	
}

/* set up data */
-(void) setupData {
  /*
    for (int i =0; i<12; i++) {
       monthlyPartnershipData* month = [[monthlyPartnershipData alloc] init];
        [monthlyPartnershipDataList addObject:month];
    }*/
    
    MonthlyPartnershipData* month = [[MonthlyPartnershipData alloc] init];
    month.name = @"January";
    [monthlyPartnershipDataList addObject:month];
    MonthlyPartnershipData* month1 = [[MonthlyPartnershipData alloc] init];
    month1.name = @"February";
    [monthlyPartnershipDataList addObject:month1];
    MonthlyPartnershipData* month2 = [[MonthlyPartnershipData alloc] init];
    month2.name = @"March";
    [monthlyPartnershipDataList addObject:month2];
    MonthlyPartnershipData* month3 = [[MonthlyPartnershipData alloc] init];
    month3.name = @"April";
    [monthlyPartnershipDataList addObject:month3];
    MonthlyPartnershipData* month4 = [[MonthlyPartnershipData alloc] init];
    month4.name = @"May";
    [monthlyPartnershipDataList addObject:month4];
    MonthlyPartnershipData* month5 = [[MonthlyPartnershipData alloc] init];
    month5.name = @"June";
    [monthlyPartnershipDataList addObject:month5];
    MonthlyPartnershipData* month6 = [[MonthlyPartnershipData alloc] init];
    month6.name = @"July";
    [monthlyPartnershipDataList addObject:month6];
    MonthlyPartnershipData* month7 = [[MonthlyPartnershipData alloc] init];
    month7.name = @"August";
    [monthlyPartnershipDataList addObject:month7];
    MonthlyPartnershipData* month8 = [[MonthlyPartnershipData alloc] init];
    month8.name = @"September";
    [monthlyPartnershipDataList addObject:month8];
    MonthlyPartnershipData* month9 = [[MonthlyPartnershipData alloc] init];
    month9.name = @"October";
    [monthlyPartnershipDataList addObject:month9];
    
    MonthlyPartnershipData* month10 = [[MonthlyPartnershipData alloc] init];
    month10.name = @"November";
    [monthlyPartnershipDataList addObject:month10];
    MonthlyPartnershipData* month11 = [[MonthlyPartnershipData alloc] init];
    month11.name = @"December";
    [monthlyPartnershipDataList addObject:month11];
}

@end
