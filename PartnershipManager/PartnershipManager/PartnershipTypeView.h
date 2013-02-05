//
//  PartnershipTypeView.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/7/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseView.h"
#import "MonthlyPartnershipData.h"

@interface PartnershipTypeView: BaseView {
    MonthlyPartnershipData* monthlyPartnership;
}
/*Methods declaration*/
- (id)initWithFrame:(CGRect)frame andMonthlyPartnershipData:(MonthlyPartnershipData*)list andNaviBar:(UINavigationBar*)bar;

/* UITableViewDelegate methods */

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;



@end
