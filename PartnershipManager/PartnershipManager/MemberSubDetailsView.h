//
//  MemberSubDetailsView.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseView.h"
#import "PersonData.h"


@interface MemberSubDetailsView : BaseView {
    PersonData* personData;
}

/*Methodds declaration*/
- (id)initWithFrame:(CGRect)frame andSubAreaData:(PersonData*)data andNaviBar:(UINavigationBar*)bar;
- (void)createMemberDetailsNewSubView:(NSObject*)obj ;

/* UITableViewDelegate methods */

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;




@end
