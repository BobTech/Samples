//
//  MembersListGroupView.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/22/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewGroup.h"
#import "MonthPartnerGroupData.h"

@interface MembersListGroupView : BaseViewGroup {
    MonthPartnerGroupData *data;
    
}
- (id)initWithFrame:(CGRect)frame andMembersList:(MonthPartnerGroupData*)list andNaviBar:(UINavigationBar*)bar;

/* UITableViewDelegate methods */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;



@end
