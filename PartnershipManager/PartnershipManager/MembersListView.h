//
//  MembersListView.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/5/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseView.h"
#import "AppDataManager.h"
#import "PartnershipMembersList.h"

@interface MembersListView : BaseView{
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
- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar andGroupMembersData:(PartnershipMembersList*)data;
- (void)refresh ;

/* UITableViewDelegate methods */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
