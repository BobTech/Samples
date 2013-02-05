//
//  PartnershipDetailsViewGroup.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/12/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewGroup.h"
#import "PartnershipMembersList.h"

@interface PartnershipDetailsViewGroup : BaseViewGroup {
    PartnershipMembersList* partnershipList;
}

/*Methodds declaration*/
- (id)initWithFrame:(CGRect)frame andPersonsArray:(PartnershipMembersList*)data andNaviBar:(UINavigationBar*)bar;
- (void)createMemberDetailsNewSubView:(NSObject*)obj ;

/* UITableViewDelegate methods */

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;





@end
