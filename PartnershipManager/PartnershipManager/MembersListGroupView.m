//
//  MembersListGroupView.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/22/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MembersListGroupView.h"
#import "PersonData.h"

@implementation MembersListGroupView

- (id)initWithFrame:(CGRect)frame andMembersList:(MonthPartnerGroupData*)aData andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    data = aData;
    title = @"Partners - Amount";
    [self initializeNavigationBarWith:title];
    
    [[naviBar.items lastObject] setHidesBackButton:YES];
    
    return self;
}


/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}


/* Called when user selects a cell */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger row = indexPath.row;
    
    NSObject *obj = [data.persons objectAtIndex:row];
    [super createNewSubView:obj];
    
}

/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    
    NSObject *obj = [data.persons objectAtIndex:row];
    if ([obj isKindOfClass:[PersonData class]]) {
        PersonData *v = (PersonData*)obj;
        NSString* ammount = [self getPartnershipGivingFrom:v andPartnershipName:data.partnershipName andMonth:data.month andYear:data.year];
      
        NSString * text = [[[[v.name stringByAppendingString:@" "] stringByAppendingString:v.surName] stringByAppendingString:@" --     £ "] stringByAppendingString:ammount];
        return [self createPersonDataCell:text];
    }
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data.persons count];
}

/* get the partnership ammount for a specific month and year*/
-(NSString*) getPartnershipGivingFrom:(PersonData*)person andPartnershipName:(NSString *)aPartnershipName andMonth:(NSString *)aMonth andYear:(NSString *)aYear{
    
        for (MonthlyPartnershipData* month in person.partnership.monthlyPartnershipDataList){
            if ([month.name isEqualToString:aMonth]){
                for (PartnershipData *partnershipData in month.partnership){
                    if ([partnershipData.partnershipName isEqualToString:aPartnershipName]){
                        return partnershipData.calculateTotalGivings;
                    }
                }
            }
        }
    return nil;
}


-(UITableViewCell*) createPersonDataCell:(NSString*)s {
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
        cell.userInteractionEnabled = NO;
        
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


@end
