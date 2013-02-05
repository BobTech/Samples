//
//  SearchView.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/24/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "SearchView.h"
#import "PersonData.h"
#import "ApplicationData.h"

#import <QuartzCore/QuartzCore.h>

#define REFRESH_HEADER_HEIGHT 52.0f
const int kSearchBarPosX = 0;
const int kSearchBarPosY = 44;
const int kSearchBarWidth = 320;
const int kSearchBarHeight = 44;

@implementation SearchView
@synthesize searchBar;


/* Destructor */
-(void) dealloc {
	
    [partnersWithName release];
    partnersWithName = nil;
    [partnersWithSurName release];
    partnersWithSurName = nil;
    
    [partnersWithCell release];
    partnersWithCell = nil;
    
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar
{
    CGRect tableViewFrame = frame;
	tableViewFrame.origin.x = 0;
	tableViewFrame.origin.y = kSearchBarHeight;
	tableViewFrame.size.height = tableViewFrame.size.height - kSearchBarHeight;
    
    self = [super initWithFrame:frame andNaviBar:bar andTableViewFrame:tableViewFrame];
    if (self) {
        tableView.delegate = self;
        tableView.dataSource = self;

        // Create search bar
		searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(kSearchBarPosX, kSearchBarPosY, kSearchBarWidth, kSearchBarHeight)];
		searchBar.placeholder = @"Search Name, Surname or Cell";
		searchBar.tintColor = [UIColor blackColor];
		searchBar.delegate = self;
		searchBar.backgroundColor = [UIColor blueColor];
		[self addSubview:searchBar];
		
		[self insertSubview:tableView atIndex:1];
    }
    self.title = @"Search Members";
    [super initializeNavigationBarWith:self.title];
    
    return self;
}
/*
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}
*/

/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if((section == 0) && ([partnersWithName count]>0))
        return @"Name ";
    else if((section == 1) && ([partnersWithSurName count]>0))
        return @"Surname ";
    else if((section == 2) && ([partnersWithCell count]>0))
        return @"Cell ";

    return nil;
}

/* Number of separate sections in table */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //  return [itemArrays count];
    return 3;
}


/* Called when user selects a cell */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
        
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    NSObject *obj = nil;
    if(section == 0)
        obj = [partnersWithName objectAtIndex:row];
    else if(section == 1)
        obj = [partnersWithSurName objectAtIndex:row];
    else if(section == 2)
        obj = [partnersWithCell objectAtIndex:row];
    
    [super createNewSubView:obj];
    
}

/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    NSObject *obj = nil;
    if(section == 0)
         obj = [partnersWithName objectAtIndex:row];
    else if(section == 1)
        obj = [partnersWithSurName objectAtIndex:row];
    else if(section == 2)
        obj = [partnersWithCell objectAtIndex:row];

   // NSObject *obj = [itemArrays objectAtIndex:row];
    if ([obj isKindOfClass:[PersonData class]]) {
        PersonData *v = (PersonData*)obj;
        return [self createPersonDataCell:v];
    }
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return [partnersWithName count];
    else if(section == 1)
        return [partnersWithSurName count];
    else if(section == 2)
        return [partnersWithCell count];
    return nil;
}

-(UITableViewCell*) createPersonDataCell:(PersonData*)s {
    
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
        desc.text = [[s.name stringByAppendingString:@" "] stringByAppendingString:s.surName];
        [cell.contentView addSubview:desc];
        [cell.contentView sizeToFit];
    }
    
	return cell;
}


/* Starts search editing */
 - (BOOL)searchBarShouldBeginEditing:(UISearchBar *)aSearchBar {
 /*SearchOverlayScreen *view = [[SearchOverlayScreen alloc] initWithFrame:tableView.frame fieldDel:self searchB:searchBar];
 view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
 view.tag = kOverlay;
 [self addSubview:view];
 [view release];
 */
 return YES;
 }
 
 /* Editing ends editing */
 - (BOOL)searchBarShouldEndEditing:(UISearchBar *)aSearchBar {
 /*UIView* view = [self viewWithTag:kOverlay];
 [view removeFromSuperview];*/
 
 [searchBar resignFirstResponder];
 return YES;
 }
 
 /* The text on search bar changes */
 - (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
 }
 
 /* Search button clicked, close the keyboard */
 - (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar {
     searchTerm = [[NSString alloc] initWithString:aSearchBar.text];
     [self startSearch:searchTerm];
     [self searchBarShouldEndEditing:searchBar];
 }

/* Number of rows per section */
-(void) startSearch:(NSString *)name {
    [partnersWithName release];
    partnersWithName = nil;
    [partnersWithSurName release];
    partnersWithSurName = nil;
    [partnersWithCell release];
    partnersWithCell = nil;
    
    partnersWithName = [[NSMutableArray alloc] init];
    partnersWithSurName = [[NSMutableArray alloc] init];
    partnersWithCell = [[NSMutableArray alloc] init];
    
    for (PersonData *person in [ApplicationData sharedApplicationData].appData.membersList) {
        if ([person.name rangeOfString:name options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch].location != NSNotFound) {
            if (![partnersWithName containsObject:person]){
			     [partnersWithName addObject:person];
            }
		}else if ([person.surName rangeOfString:name options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch].location != NSNotFound) {
            if (![partnersWithSurName containsObject:person]){
                [partnersWithSurName addObject:person];
            }
		}else if ([person.cell isEqualToString:name]) {
            if (![partnersWithCell containsObject:person]){
                [partnersWithCell addObject:person];
            }
		}

	}
    
    [tableView reloadData];
    
}

@end
