//
//  MemberDetailsView_iPad.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 2/5/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MemberDetailsView_iPad.h"
#import "ApplicationData.h"


@implementation MemberDetailsView_iPad


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
    [self initializeNavigationBarWith:title];
    
    return self;
}

/* Initializes navigation bar */
-(void) initializeNavigationBarWith:(NSString*)aTitle {
    /* if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
     {
     realFrame.size.width = 360;
     realFrame.size.height = 520;
     }*/
    
    [self setBackArrowTitle];
    
    naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    naviBar.barStyle = UIBarStyleBlack;
    
    UINavigationItem *navItem = [[[UINavigationItem alloc] initWithTitle:aTitle] autorelease];
    
    navItem.leftBarButtonItem = nil;
    navItem.backBarButtonItem = nil;
    navItem.rightBarButtonItem = nil;
    [navItem setHidesBackButton:YES animated:NO];
    
    naviBar.items = [NSArray arrayWithObject:navItem];
    
  /*  UIButton *leftNaviButton = [UIButton buttonWithType:101];
    
    CGRect naviFrame = leftNaviButton.frame;
	naviFrame.origin.x = naviBar.frame.origin.x + 5;
	naviFrame.origin.y = (naviBar.frame.size.height-naviFrame.size.height)/2 + naviBar.frame.origin.y;
	leftNaviButton.frame = naviFrame;
    [leftNaviButton setTitle:self.backArrowTitle forState:UIControlStateNormal];
    [leftNaviButton setBackgroundImage:[UIImage imageNamed:@"backbutton_blue.png"] forState:UIControlStateNormal];
    [leftNaviButton addTarget:self action:@selector(dismissSubview:) forControlEvents:UIControlEventTouchUpInside];
    //[leftNaviButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    
    UIBarButtonItem *backBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftNaviButton] autorelease];
    // backBarButtonItem.width = 60;
    
    [navItem setLeftBarButtonItem:backBarButtonItem animated:YES];
   */ 
    [self addSubview:naviBar];
}


-(void) setPersonsData:(PersonData*)aData {

    personData = aData;
    [tableView reloadData];
}


/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (personData == nil) {
        return 0;
    }
    if (section == 0) {
        return 9;
    }else if (section ==1){
        return 3;
    }
    return 0;
}

/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;

    if (section == 0) {
        
        if(row==0){
            NSString *temp =@"Name:  " ;
            temp = [temp stringByAppendingString:personData.name];
            return [self createPersonDetailsCellData:temp];
        }else if(row==1){
            NSString *temp =@"Surname:  " ;
            temp = [temp stringByAppendingString:personData.surName];
            return [self createPersonDetailsCellData:temp ];
    }else if(row==2){
        NSString *temp =@"Date of Birth:  " ;
        temp = [temp stringByAppendingString:personData.dateOfBirth];
        return [self createPersonDetailsCellData:temp];
    }else if(row==3){
        NSString *temp =@"Sex:  " ;
        temp = [temp stringByAppendingString:personData.sex];
        return [self createPersonDetailsCellData:temp];
    }else if(row==4){
        NSString *temp =@"Mobile Phone:  " ;
        temp = [temp stringByAppendingString:personData.mobilePhone];
        return [self createPersonDetailsCellData:temp];
    }else if(row==5){
        NSString *temp =@"Telephone:  " ;
        temp = [temp stringByAppendingString:personData.telephone];
        return [self createPersonDetailsCellData:temp];
    }else if(row==6){
        NSString *temp =@"Email:  " ;
        temp = [temp stringByAppendingString:personData.email];
        return [self createPersonDetailsCellData:temp];
    }else if(row==7){
        NSString *temp =@"Cell:  " ;
        temp = [temp stringByAppendingString:personData.cell];
        return [self createPersonDetailsCellData:temp];
    }else if(row==8){
        NSString *temp =@"Address:  " ;
        temp = [temp stringByAppendingString:personData.address];
        return [self createPersonDetailsCellData:temp];
    }
    } else if (section == 1) {
    
        if (row == 0) {
            return [self createPersonSubviewCell:@"Partnership"];
        }else if (row == 1) {
            return [self createPersonSubviewCell:@"Send SMS"];
        }else if (row == 2) {
            return [self createPersonSubviewCell:@"Send Email"];
        }

    }
    
        return nil;
}

-(UITableViewCell*) createPersonDetailsCellData:(NSString*)s {
    //    const float kCellHeight = 60.0;
    static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
        //  cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
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
    NSMutableArray *toRecipients = [NSMutableArray arrayWithObject:personData ];
    
    if(row == 0){
        [super createNewSubView:personData.partnership];
    }else if(row == 1){
        [[ApplicationData sharedApplicationData].parentViewController showSMSPicker:toRecipients];
    }else if(row == 2){
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

/* Number of separate sections in table */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}


@end
