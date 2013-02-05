//
//  MoreInfoView.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/31/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MoreInfoView.h"

@implementation MoreInfoView

- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    title = @"Space for more";
    [self initializeNavigationBarWith:title];
    
    return self;
}

/* Initializes navigation bar */
-(void) initializeNavigationBarWith:(NSString*)aTitle {
    naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    naviBar.barStyle = UIBarStyleBlack;
    
    UINavigationItem *navItem = [[[UINavigationItem alloc] initWithTitle:aTitle ] autorelease];
    
    navItem.leftBarButtonItem = nil;
    navItem.backBarButtonItem = nil;
    navItem.rightBarButtonItem = nil;
    [navItem setHidesBackButton:YES animated:NO];
    
    naviBar.items = [NSArray arrayWithObject:navItem];
    
    [self addSubview:naviBar];
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
        return [self createPersonSubviewCell:@"Links to Cell groups "];
    }else if (row == 1) {
        return [self createPersonSubviewCell:@"First timers"];
    }else if (row == 2) {
        return [self createPersonSubviewCell:@"Links to other Department"];
    }else if (row == 3) {
        return [self createPersonSubviewCell:@"CEC Manchester 1 News"];
    }else if (row == 4) {
        return [self createPersonSubviewCell:@"Videos"];
    }
    return nil;
}

/* Called when user selects a cell */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger row = indexPath.row;
    
 /*   if(row == 0){
        [super createNewSubView:partnershipList];
        
    }else if(row == 1){
        [super createMemberDetailsNewSubView:partnershipList];
        
    }else if(row == 2){
        [[ApplicationData sharedApplicationData].parentViewController showSMSPicker:partnershipList.partnersList ];
    }else if(row == 3){
        [[ApplicationData sharedApplicationData].parentViewController showMailPicker:partnershipList.partnersList ];
    }
  */
}

-(UITableViewCell*) createPersonSubviewCell:(NSString*)s {
    
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

@end
