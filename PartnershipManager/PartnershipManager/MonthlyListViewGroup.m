//
//  MonthlyListViewGroup.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/17/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MonthlyListViewGroup.h"
#import "MonthlyPartnershipData.h"
#import "PersonData.h"
#import "MonthPartnerGroupData.h"

@implementation MonthlyListViewGroup

- (id)initWithFrame:(CGRect)frame andPartnershipList:(PartnershipMembersList*)list andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        membersList = list;
        //[self createDummyData];
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    membersInMonth = [[NSMutableArray alloc] init];
    title = @"Monthly - Amount";
    [self initializeNavigationBarWith:title];
    [self setupMembersByMonth];

    return self;
}

/* Destructor */
-(void) dealloc {
	
    [membersInMonth release];    
    [super dealloc];
}

- (void) setupMembersByMonth
{
    for (PersonData *person in membersList.partnersList){
        for (MonthlyPartnershipData* month in person.partnership.monthlyPartnershipDataList){
            for (PartnershipData *partnershipData in month.partnership){
                if ([partnershipData.partnershipName isEqualToString:membersList.name]){ 
                    [self setMonthDataToArray:membersList.name andYear:month.year andMonth:month.name andAmmount:partnershipData.calculateTotalGivings andPerson:person];
                //if (![tmp containsObject:item])
                   // [tmp addObject:item];
                }
            }
        }
    }
}

    
-(void)setMonthDataToArray:(NSString*)aPartnershipName andYear:(NSString*)aYear andMonth:(NSString*)aMonth andAmmount:(NSString*)aAmmount andPerson:(PersonData*)aPerson
 //   -(void) setupMembersInMonth{

{
    BOOL existBefore = false;
    //for (MonthPartnerGroupData *monthData in membersInMonth){
   /* for (int i = 0; i < [membersInMonth count]; i++) {
        if ([[membersInMonth objectAtIndex:i] isKindOfClass:[MonthPartnerGroupData class]]) {

            if ([[[membersInMonth objectAtIndex:i] month] isEqualToString:aMonth] && [[membersInMonth objectAtIndex:i].year isEqualToString:aYear]){
                if (![[membersInMonth objectAtIndex:i].person containsObject:aPerson]){
                    [[membersInMonth objectAtIndex:i].person addObject:aPerson];
                    existBefore = true;
                }
            }  
          }
        }*/
        for (MonthPartnerGroupData *monthData in membersInMonth){
            if ([monthData.month isEqualToString:aMonth] && [monthData.year isEqualToString:aYear]){
                if (![monthData.persons containsObject:aPerson]){
                    [monthData.persons addObject:aPerson];
                    [monthData addToAmmonut:aAmmount];

                    existBefore = true;
                }
            }
        }
        if(existBefore == false){
            MonthPartnerGroupData *monthData = [[[MonthPartnerGroupData alloc] init] autorelease];
            monthData.month = aMonth;
            monthData.year = aYear;
            monthData.partnershipName = aPartnershipName;
            [monthData.persons addObject:aPerson];
            monthData.month = aMonth;
            [monthData addToAmmonut:aAmmount];
            //monthData.ammount = monthData.ammount+ aAmmount;
            
            if (![membersInMonth  containsObject:monthData])
                [membersInMonth addObject:monthData];

        }
}

/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}


/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    NSObject *obj = [membersInMonth objectAtIndex:row];
    
    if ([obj isKindOfClass:[MonthPartnerGroupData class]]) {
        MonthPartnerGroupData *v = (MonthPartnerGroupData*)obj;

       // int total = 5000;
        NSString *temp =v.month ;
        //NSString *string = [NSString stringWithFormat:@"%10.2f", total];
        temp = [[[[temp stringByAppendingString:@" - "] stringByAppendingString:v.year] stringByAppendingString:@"        £"]stringByAppendingString:v.ammount];
        
        return [self createMonthlyPartnershipDataListData:temp];
    }
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [membersInMonth count];
    
}

-(UITableViewCell*) createMonthlyPartnershipDataListData:(NSString*)s {
    //    const float kCellHeight = 60.0;
    static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
       // cell.userInteractionEnabled = NO;

        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(2,2,310.0, 60)] ;
        // desc.font = 12;
        desc.textColor = [UIColor whiteColor];
        desc.backgroundColor = [UIColor clearColor];
        desc.textAlignment = NSTextAlignmentLeft;
        desc.numberOfLines = 1;
        desc.text = s;
        [cell.contentView addSubview:desc];
        [cell.contentView sizeToFit];
    }
    
	return cell;
}

/* Called when user selects a cell */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger row = indexPath.row;
    
    NSObject *obj = [membersInMonth objectAtIndex:row];
    [super createNewSubView:obj];
    
}


@end
