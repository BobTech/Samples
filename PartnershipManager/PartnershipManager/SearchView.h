//
//  SearchView.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/24/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "BaseView.h"

@interface SearchView : BaseView <UISearchBarDelegate>{

    UISearchBar *searchBar;
    NSString *searchTerm;
    
    NSMutableArray* partnersWithName;
    NSMutableArray* partnersWithSurName;
    NSMutableArray* partnersWithCell;

}

@property (nonatomic, retain) UISearchBar *searchBar;
@property bool searchComplete;

- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar;

@end
