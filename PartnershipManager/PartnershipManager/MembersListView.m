//
//  MembersListView.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/5/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MembersListView.h"
#import "PersonData.h"
#import "ApplicationData.h"
#import "SearchView.h"
#import <QuartzCore/QuartzCore.h>

#define REFRESH_HEADER_HEIGHT 52.0f

@implementation MembersListView


- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar andApplicationData:(AppDataManager*)data
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        tableView.delegate = self;
        tableView.dataSource = self;
        
    }
    naviBar = bar;
    itemArrays = data.membersList;
    title = @"Members";

    [self initializeNavigationBarAndSearchIcon:title];

    [[naviBar.items lastObject] setHidesBackButton:YES];

    isLoading = NO;
    isDragging = NO;
    
    [self setupStrings];
    [self addPullToRefreshHeader];

   return self;
}

/* Destructor */
-(void) dealloc {
    naviBar = nil;
    [refreshHeaderView release];
    [refreshLabel release];
    [refreshArrow release];
    [refreshSpinner release];
    [textPull release];
    [textRelease release];
    [textLoading release];
     
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar andGroupMembersData:(PartnershipMembersList*)data
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        tableView.delegate = self;
        tableView.dataSource = self;
    }
   // naviBar = bar;

    itemArrays = data.partnersList;
    
    title = @"Partners: ";
    title = [title stringByAppendingString:data.name];
    [super initializeNavigationBarWith:title];
    
    [[naviBar.items lastObject] setHidesBackButton:YES];
    
    return self;
}

/* Initializes navigation bar */
-(void) initializeNavigationBarAndSearchIcon:(NSString*)aTitle {
    naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    naviBar.barStyle = UIBarStyleBlack;
    
    UINavigationItem *navItem = [[[UINavigationItem alloc] initWithTitle:aTitle ] autorelease];
    
    navItem.leftBarButtonItem = nil;
    navItem.backBarButtonItem = nil;
    navItem.rightBarButtonItem = nil;
    [navItem setHidesBackButton:YES animated:NO];
    
    naviBar.items = [NSArray arrayWithObject:navItem];
        
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(goToSearchView)];
    [searchButton setTitle:@"Search"];
   // UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(goToSearchView)];
    
    navItem.rightBarButtonItem = searchButton;
    [searchButton release];
            
    [self addSubview:naviBar];
}

- (void)goToSearchView {

    SearchView *v = [[[SearchView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andNaviBar:naviBar] autorelease];
    
    //   [self aboutToDisappear];
    v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
    [[self superview] addSubview:v];
    // [self addSubview:v];
    [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
    //    [self aboutToAppear];
    [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
}

/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}


/* Called when user selects a cell */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger row = indexPath.row;
    
    NSObject *obj = [itemArrays objectAtIndex:row];
    [super createNewSubView:obj];

}

/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    
    NSObject *obj = [itemArrays objectAtIndex:row];
    if ([obj isKindOfClass:[PersonData class]]) {
        PersonData *v = (PersonData*)obj;
        return [self createPersonDataCell:v];
    }
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemArrays count];
    
}

-(UITableViewCell*) createPersonDataCell:(PersonData*)s {
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(2,2,310.0, 60)] ;
        desc.textColor = [UIColor whiteColor];
        desc.backgroundColor = [UIColor clearColor];
        desc.textAlignment = NSTextAlignmentLeft;
        desc.numberOfLines = 1;
        desc.text = [[s.name stringByAppendingString:@" "] stringByAppendingString:s.surName];
        [cell.contentView addSubview:desc];
        [cell.contentView sizeToFit];
    }
    
	return cell;
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
    [UIView animateWithDuration:0.0 animations:^{
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
