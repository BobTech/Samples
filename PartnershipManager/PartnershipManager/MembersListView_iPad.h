//
//  MembersListView_iPad.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 2/5/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDataManager.h"

@interface MembersListView_iPad : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    UITableView *tableView;
    NSMutableArray *itemArrays;
    UIImageView *background;
    UINavigationBar *naviBar;
    
    UIView *naviBarItem;
    NSString *title;
    NSString *backArrowTitle;

    
    
    UIView *refreshHeaderView;
    UILabel *refreshLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    
    BOOL isLoading;
    BOOL isDragging;
    
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
}

- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar andApplicationData:(AppDataManager*)data;
//- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar andGroupMembersData:(PartnershipMembersList*)data;
- (void)refresh ;

/* UITableViewDelegate methods */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)selectFirstItem ;

@end

