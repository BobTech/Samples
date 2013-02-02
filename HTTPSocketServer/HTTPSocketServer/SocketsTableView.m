//
//  SocketsTableView.m
//  HTTPSocketServer
//
//  Created by Bob Emmanuel Esebamen on 1/31/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import "SocketsTableView.h"

@implementation SocketsTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.delegate = self;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/* Number of separate sections in table */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


/* Calculates the height of the text (i.e. the amount of lines it takes to fill the text) */
-(float) calculateHeightOfText:(NSString*)txt usingFont:(UIFont*)font boxWidth:(float)width lineBreak:(UILineBreakMode)lineBreakMode {
	CGSize suggestedSize = [txt sizeWithFont:font constrainedToSize:CGSizeMake(width, FLT_MAX) lineBreakMode:lineBreakMode];
	return suggestedSize.height;
}

-(UITableViewCell*) createCellNonInteractable:(NSString*)s {
    
	UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
        cell.userInteractionEnabled = NO;
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(2,2,310.0, 60)] ;
        // desc.font = 12;
        desc.textColor = [UIColor whiteColor];
        desc.backgroundColor = [UIColor clearColor];
        desc.textAlignment = NSTextAlignmentLeft;
        desc.numberOfLines = 1;
        desc.text = s;
        [cell.contentView addSubview:desc];
        // [cell.contentView sizeToFit];
    }
    
	return cell;
}

/* Returns row height */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    const int kStandardRowHeight = 60.0;
    return kStandardRowHeight;
}

/* Sets up background color for a single cell */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor =[UIColor colorWithRed:0.2 green:0.28 blue:0.9 alpha:1.0];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    // [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
 //   [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}




@end
