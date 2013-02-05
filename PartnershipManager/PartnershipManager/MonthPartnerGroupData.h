//
//  MonthPartnerGroupData.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/22/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonData.h"

@interface MonthPartnerGroupData : NSObject{
 
    NSString *partnershipName;

    NSString *month;
    NSString *year;
    NSMutableArray * persons;
    NSString* ammount;

    //NSMutableArray* partnersList;
}

/* Property declarations */

@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *ammount;
@property (nonatomic, copy) NSMutableArray *persons;
@property (nonatomic, copy) NSString *partnershipName;



-(void) addToAmmonut:(NSString*)aAmmount ;


@end
