//
//  MemberSubAreaGroup.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewGroup.h"
#import "PersonData.h"


@interface PartnershipTypeViewGroup : BaseViewGroup {
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

/*Methodds declaration*/
- (id)initWithFrame:(CGRect)frame andPartners:(NSMutableArray*)aPartners andNaviBar:(UINavigationBar*)bar;
- (void)createMemberDetailsNewSubView:(NSObject*)obj ;

/* UITableViewDelegate methods */

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;




@end
