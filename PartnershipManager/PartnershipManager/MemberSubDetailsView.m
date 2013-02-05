//
//  MemberSubDetailsView.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MemberSubDetailsView.h"
#import "ApplicationData.h"

@implementation MemberSubDetailsView

- (id)initWithFrame:(CGRect)frame andSubAreaData:(PersonData*)data andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        naviBar = bar;
        personData = data;
        
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    title = [[personData.name stringByAppendingString:@" "] stringByAppendingString:personData.surName];
    [super initializeNavigationBarWith:title];

    return self;
}

/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    
    if (row == 0) {
        return [self createPersonSubviewCell:@"Personal Details"];
    }else if (row == 1) {
        return [self createPersonSubviewCell:@"Partnership"];
    }else if (row == 2) {
        return [self createPersonSubviewCell:@"Send SMS"];
    }else if (row == 3) {
        return [self createPersonSubviewCell:@"Send Email"];
    }
    return nil;
}

/* Called when user selects a cell */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger row = indexPath.row;
    NSMutableArray *toRecipients = [NSMutableArray arrayWithObject:personData ];

    if(row == 0){
        [super createMemberDetailsNewSubView:personData];

    }
    else if(row == 1){
        [super createNewSubView:personData.partnership];
    }else if(row == 2){
        [[ApplicationData sharedApplicationData].parentViewController showSMSPicker:toRecipients];
    }else if(row == 3){
        [[ApplicationData sharedApplicationData].parentViewController showMailPicker:toRecipients];
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
