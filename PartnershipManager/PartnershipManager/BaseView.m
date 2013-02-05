//
//  BaseView.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/5/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "BaseView.h"
#import "CECTableView_iPhone.h"
#import "PersonData.h"
#import "PartnershipData.h"
#import "MonthlyListView.h"
#import "MonthlyPartnershipData.h"
#import "YearlyPartnershipData.h"
#import "MemberSubDetailsView.h"
#import "MemberDetailsView.h"
#import "ApplicationData.h"
#import "PartnershipTypeView.h"
#import "PartnershipDetails.h"
#import "PartnershipDetailsViewGroup.h"
#import "WebViewScreen.h"
#include "MembersListView.h"


@implementation BaseView
@synthesize title;
@synthesize backArrowTitle;

//@synthesize naviBarItem;

static const double kChangeViewAnimationLength = 0.3;

- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // Initialization code
       // naviBar = bar;

        background = [[UIImageView alloc] initWithFrame:frame];

        [background setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]];
        [self addSubview:background];
        
        CGRect tableViewFrame = frame;

		tableViewFrame.origin.x = 0;
		tableViewFrame.origin.y = 44;
        tableViewFrame.size.height = tableViewFrame.size.height -44;
        itemArrays = [[NSMutableArray alloc] init];
            
        if (tableView == nil) {
            tableView = [[CECTableView_iPhone alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
		}
        tableView.scrollEnabled = YES;
		tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
		tableView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
		tableView.separatorColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        [self addSubview:tableView];
        
       // [self sizeToFit];
        [tableView reloadData];
        [self scrollViewDidEndDecelerating:tableView];
        
       
        }
    return self;
}

- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar andTableViewFrame:(CGRect)aTableViewFrame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // Initialization code
       // naviBar = bar;
        
        background = [[UIImageView alloc] initWithFrame:frame];
        
        [background setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]];
        [self addSubview:background];
        
        CGRect tableViewFrame = aTableViewFrame;
        
		tableViewFrame.origin.x = 0;
		tableViewFrame.origin.y = tableViewFrame.origin.y + 44;
        tableViewFrame.size.height = tableViewFrame.size.height -44;
        itemArrays = [[NSMutableArray alloc] init];
        
        if (tableView == nil) {
            tableView = [[CECTableView_iPhone alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
		}
        tableView.scrollEnabled = YES;
		tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
		tableView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
		tableView.separatorColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        [self addSubview:tableView];
        
        // [self sizeToFit];
       // [tableView reloadData];
        [self scrollViewDidEndDecelerating:tableView];
        
    }
    return self;
}


/* Destructor */
-(void) dealloc {
    [background release];

    [tableView release];
    [itemArrays release];
    if (naviBar !=nil) {
        [naviBar release];
    }
 
    [super dealloc];
}


/* set back arrow title */
-(void) setBackArrowTitle {
    if([[ApplicationData sharedApplicationData].parentViewController.subViews count] ==0){
        self.backArrowTitle = @"Members";

    }else if([[ApplicationData sharedApplicationData].parentViewController.subViews count]>0){
        BaseView *subView = [[ApplicationData sharedApplicationData].parentViewController.subViews objectAtIndex:[[ApplicationData sharedApplicationData].parentViewController.subViews count] - 1];
        self.backArrowTitle = [self stringByTruncatingStringWithFont:[UIFont fontWithName:@"Helvetica" size:12] forWidth:50 lineBreakMode:NSLineBreakByTruncatingTail fromString:subView.title];
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
        
    UIButton *leftNaviButton = [UIButton buttonWithType:101];

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


-(void) dismissSubview:(id)sender {
    if ([[ApplicationData sharedApplicationData].parentViewController.subViews count] > 0) {
        [UIView animateWithDuration:kChangeViewAnimationLength
                        animations:^{
                            
            BaseView *subView = [[ApplicationData sharedApplicationData].parentViewController.subViews objectAtIndex:[[ApplicationData sharedApplicationData].parentViewController.subViews count] - 1];
          //  subView.center = CGPointMake(self.center.x - self.frame.size.width,subView.center.y);
            subView.center = CGPointMake(self.frame.size.width + self.center.x, subView.center.y);

        } completion:^(BOOL finished) {
            BaseView *subView = [[ApplicationData sharedApplicationData].parentViewController.subViews objectAtIndex:[[ApplicationData sharedApplicationData].parentViewController.subViews count] - 1];
            [subView.naviBarItem removeFromSuperview];
            [subView removeFromSuperview];
            [[ApplicationData sharedApplicationData].parentViewController.subViews removeLastObject];
            naviBar.items = nil;
        //    [self aboutToAppear];
        }];
    }
}


- (void)createNewSubView:(NSObject*)obj {
    if ([obj isKindOfClass:[PersonData class]]) {
        MemberSubDetailsView *v = [[[MemberSubDetailsView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andSubAreaData:(PersonData*)obj andNaviBar:naviBar] autorelease];

     //   [self aboutToDisappear];
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
       // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
    //    [self aboutToAppear];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }else if ([obj isKindOfClass:[YearlyPartnershipData class]]) {
        MonthlyListView *v = [[[MonthlyListView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andPartnershipList:(YearlyPartnershipData*)obj andNaviBar:naviBar] autorelease];
        
        //   [self aboutToDisappear];
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
             [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        //    [self aboutToAppear];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }else if ([obj isKindOfClass:[MonthlyPartnershipData class]]) {
        PartnershipTypeView *v = [[[PartnershipTypeView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andMonthlyPartnershipData:(MonthlyPartnershipData*)obj andNaviBar:naviBar] autorelease];
        
        //   [self aboutToDisappear];
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        //    [self aboutToAppear];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }else if ([obj isKindOfClass:[PartnershipData class]]) {
        PartnershipDetails *v = [[[PartnershipDetails alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andMonthlyPartnershipData:(PartnershipData*)obj andNaviBar:naviBar] autorelease];
        
        //   [self aboutToDisappear];
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }else if ([obj isKindOfClass:[NSURL class]]) {
        WebViewScreen *v = [[[WebViewScreen alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andNaviBar:naviBar] autorelease];
        
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        //    [self aboutToAppear];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }

}


- (void)createMemberDetailsNewSubView:(NSObject*)obj {
    if ([obj isKindOfClass:[PersonData class]]) {
        MemberDetailsView *v = [[[MemberDetailsView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andPersonData:(PersonData*)obj andNaviBar:naviBar] autorelease];
        
        //   [self aboutToDisappear];
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        //    [self aboutToAppear];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }else if ([obj isKindOfClass:[NSMutableArray class]]) {
       MembersListView* v = [[[MembersListView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andNaviBar:nil ] autorelease] ;
        
        //   [self aboutToDisappear];
        v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
        [[self superview] addSubview:v];
        // [self addSubview:v];
        [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:v];
        //    [self aboutToAppear];
        [UIView animateWithDuration:.25 animations:^{ v.center = CGPointMake(self.center.x, v.center.y); } completion:^(BOOL finished) {}];
    }
    
}

-(UITableViewCell*) createCellNonInteractable:(NSString*)s {
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease] ;
        cell.userInteractionEnabled = NO;
        
        UILabel *desc = [[[UILabel alloc] initWithFrame:CGRectMake(2,2,310.0, 60)] autorelease] ;
        // desc.font = 12;
        desc.textColor = [UIColor whiteColor];
        desc.backgroundColor = [UIColor clearColor];
        desc.textAlignment = NSTextAlignmentLeft;
        desc.numberOfLines = 1;
        desc.text = s;
        [cell.contentView addSubview:desc];
       // [cell.contentView sizeToFit];
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
    
  //  if (scrollView.contentOffset.y > 0)
    //    [tableView reloadData ];
}

- (void)loadVisibleThumbnails {
    [self scrollViewDidEndDecelerating:tableView];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
   // [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}


@end
