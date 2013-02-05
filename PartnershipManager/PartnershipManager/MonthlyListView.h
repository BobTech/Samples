//
//  MonthlyListView.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseView.h"
#import "YearlyPartnershipData.h"


@interface MonthlyListView : BaseView {
    YearlyPartnershipData * monthlyList;
}
/*Methods declaration*/
- (id)initWithFrame:(CGRect)frame andPartnershipList:(YearlyPartnershipData*)list andNaviBar:(UINavigationBar*)bar;

/* UITableViewDelegate methods */

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;



@end
