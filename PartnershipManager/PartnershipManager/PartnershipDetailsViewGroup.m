//
//  PartnershipDetailsViewGroup.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/12/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "PartnershipDetailsViewGroup.h"
#import "ApplicationData.h"

@implementation PartnershipDetailsViewGroup


- (id)initWithFrame:(CGRect)frame andPersonsArray:(PartnershipMembersList*)data andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        partnershipList = data;
        
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    title = [@"Details - " stringByAppendingString:partnershipList.name];
    [self initializeNavigationBarWith:title];

    return self;
}

/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    
    if (row == 0) {
        return [self createPersonSubviewCell:@"Monthly Partnership"];
    }else if (row == 1) {
        return [self createPersonSubviewCell:@"View All Partners"];
    }else if (row == 2) {
        return [self createPersonSubviewCell:@"SMS All"];
    }else if (row == 3) {
        return [self createPersonSubviewCell:@"Email All"];
    }else if (row == 4) {
        NSString *temp = @"Total so far:  £";
        temp= [temp stringByAppendingString:partnershipList.ammount];
        return [super createCellNonInteractable:temp];
    }
    return nil;
}

/* Called when user selects a cell */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger row = indexPath.row;
    
    if(row == 0){
        [super createNewSubView:partnershipList];
        
    }else if(row == 1){
        [super createMemberDetailsNewSubView:partnershipList];
        
    }else if(row == 2){
        [[ApplicationData sharedApplicationData].parentViewController showSMSPicker:partnershipList.partnersList ];
    }else if(row == 3){
        [[ApplicationData sharedApplicationData].parentViewController showMailPicker:partnershipList.partnersList ];
    }
}

-(UITableViewCell*) createPersonSubviewCell:(NSString*)s {
    
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

@end
