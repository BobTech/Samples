//
//  PartnershipDetails.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/7/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "PartnershipDetails.h"

@implementation PartnershipDetails

- (id)initWithFrame:(CGRect)frame andMonthlyPartnershipData:(PartnershipData*)aData andNaviBar:(UINavigationBar*)bar {
    
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        data = aData;
        //[self createDummyData];
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    self.title = @"Installments";
    [super initializeNavigationBarWith:self.title];

    return self;
}


/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;// @"Installments";
}


/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;

    if([data.totalGivings count] == row){
        NSString *temp =@"Total:  £ " ;
       // NSString *string = [NSString stringWithFormat:@"%10.2f", data.calculateTotalGivings];

        temp = [temp stringByAppendingString:data.calculateTotalGivings];
        return [self createPartnershipTypeData:temp];
    }else{
    NSObject *obj = [data.totalGivings objectAtIndex:row];
    
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *v = (NSString*)obj;
        NSString *temp =@"£ " ;
        temp = [temp stringByAppendingString:v];

        return [self createPartnershipTypeData:temp];
    }
        }
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //  return [[ApplicationData sharedApplicationData].PartnershipTypeArrays count];
    return [data.totalGivings count] + 1;
    
}

-(UITableViewCell*) createPartnershipTypeData:(NSString*)s {
    //    const float kCellHeight = 60.0;
    static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
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
    
    NSObject *obj = [data.totalGivings objectAtIndex:row];
    [super createNewSubView:obj];
    
}


@end
