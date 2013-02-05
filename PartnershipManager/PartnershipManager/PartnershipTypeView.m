//
//  PartnershipTypeView.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/7/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "PartnershipTypeView.h"
#import "ApplicationData.h"

@implementation PartnershipTypeView

- (id)initWithFrame:(CGRect)frame andMonthlyPartnershipData:(MonthlyPartnershipData*)list andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        monthlyPartnership = list;
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    self.title = @"Partnership Monthly Total";
    [super initializeNavigationBarWith:self.title];

    return self;
}


/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}


/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    if([monthlyPartnership.partnership count] == row){
        NSString *temp =@"" ;
        temp = [[temp stringByAppendingString:@"Total Partnership:   £"] stringByAppendingString:[monthlyPartnership calculateTotalMonthlyGivings]];
        return [self createPartnershipTypeData2:temp];
    }else{
    
    NSObject *obj = [monthlyPartnership.partnership objectAtIndex:row];

    if ([obj isKindOfClass:[PartnershipData class]]) {
        PartnershipData *v = (PartnershipData*)obj;
      
        NSString *temp =v.partnershipName ;
        temp = [[temp stringByAppendingString:@"      £"] stringByAppendingString:v.calculateTotalGivings];
        return [self createPartnershipTypeData:temp];
    }
        }
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [monthlyPartnership.partnership count]+1;

}

-(UITableViewCell*) createPartnershipTypeData:(NSString*)s {    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        
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

-(UITableViewCell*) createPartnershipTypeData2:(NSString*)s {
    
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

/* Called when user selects a cell */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger row = indexPath.row;
    
    NSObject *obj = [monthlyPartnership.partnership objectAtIndex:row];
    [super createNewSubView:obj];
    
}

@end
