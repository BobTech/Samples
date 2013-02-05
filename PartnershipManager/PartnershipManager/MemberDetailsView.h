//
//  MemberDetailsView.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "PersonData.h"

@interface MemberDetailsView :  BaseView {
    PersonData* personData;

}
/*Member details view*/
- (id)initWithFrame:(CGRect)frame andPersonData:(PersonData*)data andNaviBar:(UINavigationBar*)bar;

/* UITableViewDelegate methods */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;



@end
