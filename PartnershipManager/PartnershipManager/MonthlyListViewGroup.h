//
//  MonthlyListViewGroup.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/17/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewGroup.h"
#import "PartnershipMembersList.h"

@interface MonthlyListViewGroup : BaseViewGroup {
    PartnershipMembersList * membersList;
    NSMutableArray *membersInMonth;
}
/*Methods declaration*/
- (id)initWithFrame:(CGRect)frame andPartnershipList:(PartnershipMembersList*)list andNaviBar:(UINavigationBar*)bar;

/* UITableViewDelegate methods */

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;



@end
