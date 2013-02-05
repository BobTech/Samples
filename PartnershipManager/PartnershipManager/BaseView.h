//
//  BaseView.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/5/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
       
    UITableView *tableView;
    NSMutableArray *itemArrays;
    UIImageView *background;
    UINavigationBar *naviBar;
    
    UIView *naviBarItem;
    NSString *title;
    NSString *backArrowTitle;

}
/* Methods declarations */
- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar andTableViewFrame:(CGRect)aTableViewFrame;

-(id) initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar;
- (void)createMemberDetailsNewSubView:(NSObject*)obj ;
-(void) setBackArrowTitle ;
- (void)createNewSubView:(NSObject*)obj ;


- (void)createNewSubViewForGroup:(NSObject*)obj ;
-(void) initializeNavigationBarWith:(NSString*)aTitle ;
-(UITableViewCell*) createCellNonInteractable:(NSString*)s ;
-(void) dismissSubview:(id)sender ;

/* Property declarations */
@property (nonatomic, assign, readonly) UIView *naviBarItem;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *backArrowTitle;


/* UITableViewDataSource methods */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/* UITableViewDelegate methods */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

/* UIScrollViewDelegate methods */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;


    
@end
