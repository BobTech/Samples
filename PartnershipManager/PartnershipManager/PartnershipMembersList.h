//
//  PartnershipMembersList.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/21/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartnershipMembersList : NSObject{
	
    NSString *name;
    NSMutableArray* partnersList;
    
    NSString *ammount;
}

/* Property declarations */

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSMutableArray* partnersList;
@property (nonatomic, copy) NSString *ammount;

@end
