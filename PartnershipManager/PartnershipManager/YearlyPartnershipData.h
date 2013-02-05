//
//  YearlyPartnershipData.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MonthlyPartnershipData.h"

@interface YearlyPartnershipData : NSObject{

   /* MonthlyPartnershipData * january;
    MonthlyPartnershipData * february;
    MonthlyPartnershipData * march;
    MonthlyPartnershipData * april;
    MonthlyPartnershipData * may;
    MonthlyPartnershipData * june;
    MonthlyPartnershipData * july;
    MonthlyPartnershipData * august;
    MonthlyPartnershipData * september;
    MonthlyPartnershipData * october;
    MonthlyPartnershipData * november;
    MonthlyPartnershipData * december;*/
    
    NSMutableArray *monthlyPartnershipDataList;


}

/*@property (nonatomic, copy)  MonthlyPartnershipData * january;
@property (nonatomic, copy)  MonthlyPartnershipData * february;
@property (nonatomic, copy)  MonthlyPartnershipData * march;
@property (nonatomic, copy)  MonthlyPartnershipData * april;
@property (nonatomic, copy)  MonthlyPartnershipData * may;
@property (nonatomic, copy)  MonthlyPartnershipData * june;
@property (nonatomic, copy)  MonthlyPartnershipData * july;
@property (nonatomic, copy)  MonthlyPartnershipData * august;
@property (nonatomic, copy)  MonthlyPartnershipData * september;
@property (nonatomic, copy)  MonthlyPartnershipData * october;
@property (nonatomic, copy)  MonthlyPartnershipData * november;
@property (nonatomic, copy)  MonthlyPartnershipData * december;*/

@property (nonatomic, copy)  NSMutableArray * monthlyPartnershipDataList;



@end
