//
//  CECTableView_iPhone.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/5/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "CECTableView_iPhone.h"

@implementation CECTableView_iPhone

/* Constructor */
-(id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self.backgroundColor = [UIColor blackColor];
    
    return [super initWithFrame:frame style:style];
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    [super setContentOffset:contentOffset animated:animated];
    [self.delegate scrollViewDidEndDecelerating:self];
}

@end
