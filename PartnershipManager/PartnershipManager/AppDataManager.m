//  AppDataManager.m
//

#import "AppDataManager.h"
#import "PersonData.h"
#import "PartnershipMembersList.h"

@implementation AppDataManager

@synthesize membersList;
@synthesize partnersList;


/* Constructor */
-(id) init {
	membersList = [[NSMutableArray alloc] init];
    partnersList = [[NSMutableArray alloc] init];
		
	return self;
}

/* Destructor */
-(void) dealloc {
	//DebugLog(@"dealloc() called");
	
	[membersList release];
    [partnersList release];

	[super dealloc];
}

- (NSMutableArray*) arrayByDroppingDuplicatesFromArray:(NSMutableArray*) arrayList
{
    NSMutableArray *tmp = [NSMutableArray array];
    for (id item in arrayList)
        if (![tmp containsObject:item])
            [tmp addObject:item];
    return tmp;
}


/* Searches for an item based on the partnership name */
-(NSMutableArray*) findPartnersByPartnershipNAme:(NSString*)name fromArrayList:(NSMutableArray*)originalArrayList{
	
    NSMutableArray* sortedArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < [originalArrayList count]; i++) {
		PersonData *item = [originalArrayList objectAtIndex:i];
        for (int j = 0; j < [item.partnership.monthlyPartnershipDataList count]; j++) {
            MonthlyPartnershipData* monthlyData = [item.partnership.monthlyPartnershipDataList objectAtIndex:j];
            
            for (int k = 0; k < [monthlyData.partnership count]; k++) {
                PartnershipData* partnershipData = [monthlyData.partnership objectAtIndex:k];
                if ([partnershipData.partnershipName isEqualToString:name]){
                    if (![sortedArray containsObject:item]){
                        [sortedArray addObject:item];
                        
                    }
                }
            }
        }
        [item release];
        item = nil;
	}
    return sortedArray;
}    

/* Searches for an item based on the partnership name */
-(NSString*) getTotalPartnershipAmmount:(NSString*)name fromArrayList:(NSMutableArray*)originalArrayList{
	NSString *totalAmmount = @"";
    float totAmmount=0;
	for (int i = 0; i < [originalArrayList count]; i++) {
		PersonData *item = [originalArrayList objectAtIndex:i];
        for (int j = 0; j < [item.partnership.monthlyPartnershipDataList count]; j++) {
            MonthlyPartnershipData* monthlyData = [item.partnership.monthlyPartnershipDataList objectAtIndex:j];
            
            for (int k = 0; k < [monthlyData.partnership count]; k++) {
                PartnershipData* partnershipData = [monthlyData.partnership objectAtIndex:k];
                if ([partnershipData.partnershipName isEqualToString:name]){
                        float value = [partnershipData.calculateTotalGivings floatValue];
                        totAmmount = totAmmount + value;
                }
            }
        }
        [item release];
        item = nil;
	}
    totalAmmount = [NSString stringWithFormat:@"%10.2f", totAmmount];

    return totalAmmount;
}


/* Searches for all partners based on  partnership name */
-(NSMutableArray*) findPartnershipNamesFromMembersList:(NSMutableArray*)originalArrayList{
	
    NSMutableArray* sortedArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < [originalArrayList count]; i++) {
		PersonData *item = [originalArrayList objectAtIndex:i];
        for (int j = 0; j < [item.partnership.monthlyPartnershipDataList count]; j++) {
            MonthlyPartnershipData* monthlyData = [item.partnership.monthlyPartnershipDataList objectAtIndex:j];
            
            for (int k = 0; k < [monthlyData.partnership count]; k++) {
                PartnershipData* partnershipData = [monthlyData.partnership objectAtIndex:k];
                NSString* name = partnershipData.partnershipName;
                if (![sortedArray containsObject:name])
                    [sortedArray addObject:name];
            }
        }
	}
    return sortedArray;
}

- (void) setupData
{
    partnershipNamesList = [self findPartnershipNamesFromMembersList:membersList];
    
    for (int i=0; i< [partnershipNamesList count]; i++) {
        
        PartnershipMembersList *tempData1 =  [[PartnershipMembersList alloc] init];
        NSString * name = [partnershipNamesList objectAtIndex:i];
        tempData1.name = name;
        tempData1.partnersList = [self findPartnersByPartnershipNAme:tempData1.name fromArrayList:membersList ];
        tempData1.ammount = [self getTotalPartnershipAmmount:tempData1.name fromArrayList:tempData1.partnersList ];

        [partnersList addObject:tempData1];
        [tempData1 release];
        tempData1 = nil;
    }

}


-(NSString*) calculateTotalPartnerships {
    
    float totalValue= 0;
	for (int i=0; i<[partnersList count]; i++) {
        PartnershipMembersList *tempData1 = [partnersList objectAtIndex:i];
        float value = [tempData1.ammount floatValue];
        totalValue = totalValue + value;
    }
    NSString *string = [NSString stringWithFormat:@"%10.2f", totalValue];
    
    return string;
}



@end
