//
//  MonthlyListView.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MonthlyListView.h"
#import "MonthlyPartnershipData.h"

@implementation MonthlyListView

- (id)initWithFrame:(CGRect)frame andPartnershipList:(YearlyPartnershipData*)list andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        monthlyList = list;
        //[self createDummyData];
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    self.title = @"Monthly Total Givings";
    [super initializeNavigationBarWith:self.title];

    return self;
}


/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;// @"Monthly List";
}


/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    NSObject *obj = [monthlyList.monthlyPartnershipDataList objectAtIndex:row];
   
    if ([obj isKindOfClass:[MonthlyPartnershipData class]]) {
        MonthlyPartnershipData *v = (MonthlyPartnershipData*)obj;
        NSString* temp = v.name;
        temp = [[temp stringByAppendingString:@"   "] stringByAppendingString:v.year];

        return [self createMonthlyPartnershipDataListData:temp];
    }
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
         
    return [monthlyList.monthlyPartnershipDataList count];
    
}

-(UITableViewCell*) createMonthlyPartnershipDataListData:(NSString*)s {
    //    const float kCellHeight = 60.0;
   // static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        
        UILabel *desc = [[[UILabel alloc] initWithFrame:CGRectMake(2,2,310.0, 60)] autorelease] ;
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
    
    NSObject *obj = [monthlyList.monthlyPartnershipDataList objectAtIndex:row];
    [super createNewSubView:obj];
    
}


@end
