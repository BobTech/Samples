//
//  BaseViewGroup.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/17/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewGroup : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    UITableView *tableView;
    NSMutableArray *itemArrays;
    UIImageView *background;
    UINavigationBar *naviBar;
    UIImage *naviBarLogo;
    UILabel *naviBarText;
    UIImageView *naviBarLogoView;

    UIView *naviBarItem;
    
    NSString *title;
    NSString *backArrowTitle;
    
    int tabbarheight ;

}
/* Property declarations */
@property (nonatomic, retain) UIImage *naviBarLogo;
@property (nonatomic, assign, readonly) UIView *naviBarItem;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *backArrowTitle;

-(id) initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar;
-(void) generateNaviBarContent;
- (void)createMemberDetailsNewSubView:(NSObject*)obj ;
- (void)createNewSubViewForGroup:(NSObject*)obj ;
-(void) initializeNavigationBarWith:(NSString*)aTitle ;
-(UITableViewCell*) createCellNonInteractable:(NSString*)s ;


/* UITableViewDataSource methods */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/* UITableViewDelegate methods */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/* UIScrollViewDelegate methods */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)loadVisibleThumbnails;


- (void)createNewSubView:(NSObject*)obj ;



@end
