//
//  MemberDetailsView_iPad.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 2/5/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "BaseView.h"
#import "PersonData.h"


@interface MemberDetailsView_iPad : BaseView {
    PersonData* personData;
    
    UINavigationItem *navItem;
}

/*Methods declaration*/
- (id)initWithFrame:(CGRect)frame andSubAreaData:(PersonData*)data andNaviBar:(UINavigationBar*)bar;
- (void)createMemberDetailsNewSubView:(NSObject*)obj ;
-(void) setPersonsData:(PersonData*)aData ;


/* UITableViewDelegate methods */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
