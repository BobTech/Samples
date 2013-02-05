//
//  MonthlyPartnershipData.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartnershipData.h"

@interface MonthlyPartnershipData : NSObject{
   
    NSString* name;
    NSString* year;
    NSMutableArray *partnership;

}

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* year;
@property (nonatomic, copy) NSMutableArray *partnership;

-(NSString*) calculateTotalMonthlyGivings ;
@end
