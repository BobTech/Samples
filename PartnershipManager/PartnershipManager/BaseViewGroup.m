//
//  BaseViewGroup.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/17/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "BaseViewGroup.h"
#import "CECTableView_iPhone.h"
#import "PersonData.h"
#import "PartnershipData.h"
#import "MonthlyListViewGroup.h"
#import "MonthlyPartnershipData.h"
#import "YearlyPartnershipData.h"
#import "MemberSubDetailsView.h"
#import "MemberDetailsView.h"
#import "ApplicationData.h"
#import "PartnershipTypeView.h"
#import "PartnershipDetails.h"
#import "PartnershipMembersList.h"
#import "PartnershipDetailsViewGroup.h"
#import "MonthPartnerGroupData.h"
#import "MembersListGroupView.h"
#import "MembersListView.h"

@implementation BaseViewGroup

//@synthesize naviBarItem;
@synthesize title;
@synthesize backArrowTitle;


static const double kChangeViewAnimationLength = 0.3;

- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) //iPad
        {
            tabbarheight = 44; // TODO: change height to larger value 
        }
        else//iphone
        {
            tabbarheight = 44;
        }

        
        
        background = [[UIImageView alloc] initWithFrame:frame];
        
        [background setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]];
        [self addSubview:background];
        
        CGRect tableViewFrame = frame;
        
		tableViewFrame.origin.x = 0;
		tableViewFrame.origin.y = 44;
        tableViewFrame.size.height = tableViewFrame.size.height - 44;
        itemArrays = [[NSMutableArray alloc] init];
        
        if (tableView == nil) {
            tableView = [[CECTableView_iPhone alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
		}
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 216.0, 0.0);
        tableView.scrollIndicatorInsets = tableView.contentInset;
        
        tableView.scrollEnabled = YES;
		tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
		tableView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
		tableView.separatorColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        [self addSubview:tableView];
        
        [self sizeToFit];
        [tableView reloadData];
        [self scrollViewDidEndDecelerating:tableView];
                
    }
    return self;
}

/* Destructor */
-(void) dealloc {
    [background release];

    [tableView release];
     [itemArrays release];
    
    [naviBarLogoView release];
    [naviBarLogo release];
    [itemArrays release];

    
     [super dealloc];
}

/* set back arrow title */
-(void) setBackArrowTitle {
    if([[ApplicationData sharedApplicationData].parentViewController.subViews count] ==0){
        self.backArrowTitle = @"Groups";
        
    }else if([[ApplicationData sharedApplicationData].parentViewController.subViews count]>0){
        BaseView *subView = [[ApplicationData sharedApplicationData].parentViewController.subViews objectAtIndex:[[ApplicationData sharedApplicationData].parentViewController.subViews count] - 1];
        self.backArrowTitle = [self stringByTruncatingStringWithFont:[UIFont fontWithName:@"CourierNewPSMT" size:12] forWidth:50 lineBreakMode:NSLineBreakByTruncatingTail fromString:subView.title];
    }else
        self.backArrowTitle = @"Back";
}


- (NSString*)stringByTruncatingStringWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(UILineBreakMode)lineBreakMode fromString:(NSString*)string{
    NSMutableString *resultString = [NSMutableString stringWithString:string] ;
    NSRange range = {resultString.length-1, 1};
    
    while ([resultString sizeWithFont:font forWidth:FLT_MAX lineBreakMode:lineBreakMode].width > width) {
        // delete the last character
        [resultString deleteCharactersInRange:range];
        range.location--;
        // replace the last but one character with an ellipsis
        [resultString replaceCharactersInRange:range withString:@"."];
    }
    return resultString;
}


/* Initializes navigation bar */
-(void) initializeNavigationBarWith:(NSString*)aTitle {
    [self setBackArrowTitle];
    
    naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tabbarheight)];
    naviBar.barStyle = UIBarStyleBlack;
    
    UINavigationItem *navItem = [[[UINavigationItem alloc] initWithTitle:aTitle ] autorelease];
    
    navItem.leftBarButtonItem = nil;
    navItem.backBarButtonItem = nil;
    navItem.rightBarButtonItem = nil;
    [navItem setHidesBackButton:YES animated:NO];
    
    naviBar.items = [NSArray arrayWithObject:navItem];
    
    UIButton *leftNaviButton = [UIButton buttonWithType:101];
    
    CGRect naviFrame = leftNaviButton.frame;
	naviFrame.origin.x = naviBar.frame.origin.x + 5;
	naviFrame.origin.y = (naviBar.frame.size.height-naviFrame.size.height)/2 + naviBar.frame.origin.y;
    //naviFrame.size.width = 60;
	leftNaviButton.frame = naviFrame;
    [leftNaviButton setTitle:self.backArrowTitle forState:UIControlStateNormal];
    [leftNaviButton setBackgroundImage:[[UIImage imageNamed:@"backbutton_blue.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:0] forState:UIControlStateNormal];
    [leftNaviButton addTarget:self action:@selector(dismissSubview:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftNaviButton] autorelease];
    backBarButtonItem.width = 60;
    [navItem setLeftBarButtonItem:backBarButtonItem animated:YES];
    
    [self addSubview:naviBar];
}


/* Number of separate sections in table */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/* Calculates the height of the text (i.e. the amount of lines it takes to fill the text) */
-(float) calculateHeightOfText:(NSString*)txt usingFont:(UIFont*)font boxWidth:(float)width lineBreak:(UILineBreakMode)lineBreakMode {
	CGSize suggestedSize = [txt sizeWithFont:font constrainedToSize:CGSizeMake(width, FLT_MAX) lineBreakMode:lineBreakMode];
	return suggestedSize.height;
}


/* Generates navi bar content for the view */
-(void) generateNaviBarContent {
    if (naviBarLogo != nil) {
        if (naviBarLogoView == nil) {
            naviBarLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(naviBar.frame.size.width/2 - naviBarLogo.size.width/2,
                                                                            naviBar.frame.size.height/2 - naviBarLogo.size.height/2,
                                                                            naviBarLogo.size.width, naviBarLogo.size.height)];
            naviBarLogoView.image = naviBarLogo;
        }
    } else {
        if (naviBarText == nil) {
            NSString *tabTitle = @"Title";//[self tabBarTitle];
            
            UILabel *desc = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, naviBar.frame.size.width, naviBar.frame.size.height)] autorelease];
            desc.backgroundColor = [UIColor clearColor];
            desc.textColor = [UIColor whiteColor];
            desc.text = tabTitle;
            desc.textAlignment = NSTextAlignmentCenter;
            desc.numberOfLines = 1;
            desc.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            
            naviBarText = desc;
        }
    }
}

/* Called when view is going to be brought back to front */
-(void) aboutToAppear {
    if (naviBarLogoView == nil && naviBarText == nil) {
        [self generateNaviBarContent];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(loadVisibleThumbnails) userInfo:nil repeats:NO];
    
    if ([[ApplicationData sharedApplicationData].parentViewController.subViews count] == 0) {
        UINavigationItem *navItem = [[[UINavigationItem alloc] init] autorelease];
        naviBar.items = [NSArray arrayWithObject:navItem];
        UIBarButtonItem *backBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(showFilterDialog:)] autorelease];
        [navItem setRightBarButtonItem:backBarButtonItem animated:YES];
        
        if (naviBarLogoView != nil) {
            naviBarLogoView.alpha = 0.0;
            [naviBar addSubview:naviBarLogoView];
            [UIView animateWithDuration:kChangeViewAnimationLength delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                naviBarLogoView.alpha = 1.0;
            } completion:^(BOOL finished) {
            }];
        } else if (naviBarText != nil) {
            naviBarText.alpha = 0.0;
            [naviBar addSubview:naviBarText];
            [UIView animateWithDuration:kChangeViewAnimationLength delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                naviBarText.alpha = 1.0;
            } completion:^(BOOL finished) {
            }];
        }
    } else {
        BaseView *subView = [[ApplicationData sharedApplicationData].parentViewController.subViews objectAtIndex:([[ApplicationData sharedApplicationData].parentViewController.subViews count] - 1)];
        subView.naviBarItem.alpha = 0.0;
        [naviBar addSubview:subView.naviBarItem];
        [UIView animateWithDuration:kChangeViewAnimationLength delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            subView.naviBarItem.alpha = 1.0;
        } completion:^(BOOL finished) {
            UINavigationItem *navItem = [[[UINavigationItem alloc] init] autorelease];
            naviBar.items = [NSArray arrayWithObject:navItem];
            unichar backArrowCode = 0x25C0;
            NSString *backArrowString = [NSString stringWithCharacters:&backArrowCode length:1];
            
            UIBarButtonItem *backBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_button_arrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissSubview:)] autorelease];
            
            [navItem setLeftBarButtonItem:backBarButtonItem animated:YES];
        }];
    }
}

/* Called when view is going to be removed */
-(void) aboutToDisappear {
    if ([[ApplicationData sharedApplicationData].parentViewController.subViews count] == 0) {
        if (naviBarLogoView != nil) {
            [UIView animateWithDuration:kChangeViewAnimationLength delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                naviBarLogoView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [naviBarLogoView removeFromSuperview];
            }];
        } else if (naviBarText != nil) {
            [UIView animateWithDuration:kChangeViewAnimationLength delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                naviBarText.alpha = 0.0;
            } completion:^(BOOL finished) {
                [naviBarText removeFromSuperview];
            }];
        }
    } else {
        naviBar.items = nil;
        BaseView *subView = [[ApplicationData sharedApplicationData].parentViewController.subViews objectAtIndex:([[ApplicationData sharedApplicationData].parentViewController.subViews count] - 1)];
        [UIView animateWithDuration:kChangeViewAnimationLength delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            subView.naviBarItem.alpha = 0.0;
        } completion:^(BOOL finished) {
            [subView.naviBarItem removeFromSuperview];
        }];
    }
}

-(void) dismissSubview:(id)sender {
    if ([[ApplicationData sharedApplicationData].parentViewController.subViews count] > 0) {
        [UIView animateWithDuration:kChangeViewAnimationLength animations:^{
            BaseView *subView = [[ApplicationData sharedApplicationData].parentViewController.subViews objectAtIndex:[[ApplicationData sharedApplicationData].parentViewController.subViews count] - 1];
         //   subView.center = CGPointMake(self.center.x - self.frame.size.width, subView.center.y);
            subView.center = CGPointMake(self.frame.size.width + self.center.x, subView.center.y);

        } completion:^(BOOL finished) {
            BaseView *subView = [[ApplicationData sharedApplicationData].parentViewController.subViews objectAtIndex:[[ApplicationData sharedApplicationData].parentViewController.subViews count] - 1];
            [subView.naviBarItem removeFromSuperview];
            [subView removeFromSuperview];
            [[ApplicationData sharedApplicationData].parentViewController.subViews removeLastObject];
            naviBar.items = nil;
            [self aboutToAppear];
        }];
    }
}


- (void)createNewSubView:(NSObject*)obj {
    if ([obj isKindOfClass:[PersonData class]]) {
        MemberSubDetailsView *v = [[MemberSubDetailsView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andSubAreaData:(PersonData*)obj andNaviBar:naviBar];
        
        //   [self aboutToDisappear];
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        //    [self aboutToAppear];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }else if ([obj isKindOfClass:[PartnershipMembersList class]]) {
        MonthlyListViewGroup *v = [[MonthlyListViewGroup alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andPartnershipList:(PartnershipMembersList*)obj andNaviBar:naviBar];
        
        //   [self aboutToDisappear];
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        //    [self aboutToAppear];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }else if ([obj isKindOfClass:[MonthPartnerGroupData class]]) {
        MembersListGroupView *v = [[MembersListGroupView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andMembersList:(MonthPartnerGroupData*) obj andNaviBar:naviBar];
        
        //   [self aboutToDisappear];
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        //    [self aboutToAppear];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }else if ([obj isKindOfClass:[PartnershipData class]]) {
        PartnershipDetails *v = [[PartnershipDetails alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andMonthlyPartnershipData:(PartnershipData*)obj andNaviBar:naviBar];
        
        //   [self aboutToDisappear];
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        //    [self aboutToAppear];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }
}


- (void)createNewSubViewForGroup:(NSObject*)obj {
   if([obj isKindOfClass:[PartnershipMembersList class]]) {
        PartnershipDetailsViewGroup *v = [[PartnershipDetailsViewGroup alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andPersonsArray:(PartnershipMembersList*)obj andNaviBar:naviBar];
        
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }

}

- (void)createMemberDetailsNewSubView:(NSObject*)obj {
   if ([obj isKindOfClass:[PartnershipMembersList class]]) {
        MembersListView *v = [[MembersListView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andNaviBar:naviBar andGroupMembersData:(PartnershipMembersList*) obj ] ;
        
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }else if ([obj isKindOfClass:[NSMutableArray class]]) {
        MembersListView* v = [[MembersListView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andNaviBar:nil  ] ;
        
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }
   
}

-(UITableViewCell*) createCellNonInteractable:(NSString*)s {
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease] ;
        cell.userInteractionEnabled = NO;
        
        UILabel *desc = [[[UILabel alloc] initWithFrame:CGRectMake(2,2,310.0, 60)]autorelease] ;
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

/* Returns row height */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    const int kStandardRowHeight = 60.0;
    return kStandardRowHeight;
}

/* Sets up background color for a single cell */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor =[UIColor colorWithRed:0.2 green:0.28 blue:0.9 alpha:1.0];
}

/* Called when user selects a cell */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //  DebugLog(@"This method should be overloaded");
}

- (void) drawAllVisibleCells {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:tableView];
    }
}

- (void)loadVisibleThumbnails {
    // DebugLog(@"loadVisibleThumbnails!");
    [self scrollViewDidEndDecelerating:tableView];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
  //  [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}


@end
