//
//  TableViewCellCreator.h
//

#ifndef __TABLEVIEWCELLCREATOR_H__
#define __TABLEVIEWCELLCREATOR_H__

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

enum {
	WEB_CELL_SINGLE_LINE_TEXT = 0,
	WEB_CELL_TWO_LINES_TEXT,
	TEXT_CELL_SINGLE_LINE_TEXT,
	TEXT_CELL_TWO_LINES_TEXT,
	LAYOUT_CELL_SINGLE_LINE_TEXT,
	LAYOUT_CELL_TWO_LINES_TEXT,
	LEAGUE_CELL_WITH_ON_OFF_TEXT
};

static const int kSwitchId = 2323;

@class LayoutElement;

@interface TableViewCellCreator : NSObject {

}

/* Interface access method */
+(UITableViewCell*) createTableViewCellButton:(NSString*)text table:(UITableView*)aTableView;
+(UITableViewCell*) createTableViewCellButton2:(NSString*)text table:(UITableView*)aTableView;

+(UITableViewCell*) createTableViewCellWithInputField:(NSString*)infoText fieldDefault:(NSString*)fieldDef fieldText:(NSString*)fieldText table:(UITableView*)aTableView delle:(id<UITextFieldDelegate>)dele textfieldId:(int)textId secure:(bool)secureEntry;
@end

#endif