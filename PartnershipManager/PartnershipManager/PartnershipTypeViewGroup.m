//
//  MemberSubDetailsView.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "PartnershipTypeViewGroup.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ApplicationData.h"
#import "PartnershipMembersList.h"

#import <QuartzCore/QuartzCore.h>

#define REFRESH_HEADER_HEIGHT 52.0f


@implementation PartnershipTypeViewGroup

- (id)initWithFrame:(CGRect)frame andPartners:(NSMutableArray*)aPartners andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
       // partners = aPartners; //TODO: replace with real data form backend
        //partners = itemArrays;
        tableView.delegate = self;
        tableView.dataSource = self;
    }

    title = @"Partnership Arms In Groups";
    [self initializeNavigationBarAndUpdateIcon:title];
    
    isLoading = NO;
    isDragging = NO;
    
    [self setupStrings];
    [self addPullToRefreshHeader];

    return self;
}

/* Destructor */
-(void) dealloc {
    
    [refreshHeaderView release];
    [refreshLabel release];
    [refreshArrow release];
    [refreshSpinner release];
    [textPull release];
    [textRelease release];
    [textLoading release];
    
    [super dealloc];
}


/* Initializes navigation bar */
-(void) initializeNavigationBarWith:(NSString*)aTitle  {
    if (naviBar == nil) {
        [super initializeNavigationBarWith:aTitle];
    }else{        
        naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        naviBar.barStyle = UIBarStyleBlack;
        
        UINavigationItem *navItem = [[[UINavigationItem alloc] initWithTitle:aTitle ] autorelease];
        naviBar.items = [NSArray arrayWithObject:navItem];
        
        [self addSubview:naviBar];
    }
}

/* Initializes navigation bar */
-(void) initializeNavigationBarAndUpdateIcon:(NSString*)aTitle {
    naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    naviBar.barStyle = UIBarStyleBlack;
    
    UINavigationItem *navItem = [[[UINavigationItem alloc] initWithTitle:aTitle ] autorelease];
    
    navItem.leftBarButtonItem = nil;
    navItem.backBarButtonItem = nil;
    navItem.rightBarButtonItem = nil;
    [navItem setHidesBackButton:YES animated:NO];
    
    naviBar.items = [NSArray arrayWithObject:navItem];
        
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    navItem.rightBarButtonItem = anotherButton;
    [anotherButton release];
    
    [self addSubview:naviBar];
}


/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}


/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if([[ApplicationData sharedApplicationData].appData.partnersList count] == row){
        
        NSString *temp =@"Total Partnership so far: £ " ;
        temp = [temp stringByAppendingString:[[ApplicationData sharedApplicationData].appData calculateTotalPartnerships]];
        return [self createPartnershipTypeData2:temp];
    }else{
        NSObject *obj = [[ApplicationData sharedApplicationData].appData.partnersList objectAtIndex:row];
        
        if ([obj isKindOfClass:[PartnershipMembersList class]]) {
            PartnershipMembersList *v = (PartnershipMembersList*)obj;            
            NSString *temp =v.name ;
            return [self createPartnershipTypeData:temp];
        }
    }
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[ApplicationData sharedApplicationData].appData.partnersList count]+1;
}

-(UITableViewCell*) createPartnershipTypeData:(NSString*)s {
    //    const float kCellHeight = 60.0;
   // static NSString *CellIdentifier = @"Cell";
    
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
    //    const float kCellHeight = 60.0;
  //  static NSString *CellIdentifier = @"Cell";
    
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
    
    NSObject *obj = [[ApplicationData sharedApplicationData].appData.partnersList objectAtIndex:row];
    //[super createNewSubViewForGroup:partners];
    [super createNewSubViewForGroup:obj];

}

/*Scroll View implementation*/

- (void)addPullToRefreshHeader {
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    refreshLabel.textColor = [UIColor whiteColor];

    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    refreshSpinner.color = [UIColor whiteColor];
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    [tableView addSubview:refreshHeaderView];
}

- (void)setupStrings{
    textPull = [[NSString alloc] initWithString:@"Pull down to refresh..."];
    textRelease = [[NSString alloc] initWithString:@"Release to refresh..."];
    textLoading = [[NSString alloc] initWithString:@"Loading..."];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            tableView.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            tableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.0 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
                // User is scrolling above the header
                refreshLabel.text = textRelease;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } else {
                // User is scrolling somewhere within the header
                refreshLabel.text = textPull;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.01 animations:^{
        tableView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = textLoading;
        refreshArrow.hidden = YES;
        [refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
  //  isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        tableView.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete {
    // Reset the header
    refreshLabel.text = textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
   
    isLoading = NO;

}

- (void)refresh {
    [[ApplicationData sharedApplicationData] updateData];
    itemArrays = [ApplicationData sharedApplicationData].appData.membersList;
    
    [tableView reloadData];
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
}


@end
