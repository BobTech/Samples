//
//  TableViewCellCreator.m
//
//

#import "LoginData.h"
#import "BaseView.h"
#import "TableViewCellCreator.h"
#import "ModelConstants.h"
#import "Strings.h"

@implementation TableViewCellCreator

+(UITableViewCell*) createTableViewCellButton:(NSString*)text table:(UITableView*)aTableView{
	//float hMulti = [SystemSettings horizontalMultiplier];	
	float vMulti = 1.0;// [SystemSettings verticalMultiplier];
	const float layoutFontSize = 16.0*vMulti;
	
	static NSString *CellIdentifierStd = @"StandardTextButtonCell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:nil];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
		
	//	cell.textLabel.font = [UIFont fontWithName:[[LAFManager instance] listViewContentFontName] size:layoutFontSize];
	//	cell.textLabel.textColor = [[LAFManager instance] listViewContentFontCol];
		cell.textLabel.backgroundColor = [UIColor clearColor];
						
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	} 
	
	cell.textLabel.text = text;
	cell.textLabel.textAlignment = NSTextAlignmentCenter;
	
	return cell;	
}        

+(UITableViewCell*) createTableViewCellButton2:(NSString*)text table:(UITableView*)aTableView{
	//float hMulti = [SystemSettings horizontalMultiplier];
//	float vMulti = 1.0;// [SystemSettings verticalMultiplier];
//	const float layoutFontSize = 16.0*vMulti;
	
//	static NSString *CellIdentifierStd = @"StandardTextButtonCell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:nil];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //	cell.textLabel.font = [UIFont fontWithName:[[LAFManager instance] listViewContentFontName] size:layoutFontSize];
        //	cell.textLabel.textColor = [[LAFManager instance] listViewContentFontCol];
		cell.textLabel.backgroundColor = [UIColor clearColor];
        
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	}
	
	cell.textLabel.text = text;
	cell.textLabel.textAlignment = NSTextAlignmentCenter;
	
	return cell;
}

+(UITableViewCell*) createTableViewCellWithInputField:(NSString*)infoText fieldDefault:(NSString*)fieldDef fieldText:(NSString*)fieldText table:(UITableView*)aTableView delle:(id<UITextFieldDelegate>)dele textfieldId:(int)textId secure:(bool)secureEntry {
	float hMulti = 1.3;// [SystemSettings horizontalMultiplier];
	float vMulti = 1;//[SystemSettings verticalMultiplier];
//	const float layoutFontSize = 16.0*vMulti;
	
//	static NSString *CellIdentifierStd = @"StandardTextInputCellButton";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:nil];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
		
		//cell.textLabel.font = [UIFont fontWithName:[[LAFManager instance] listViewContentFontName] size:layoutFontSize];
		//cell.textLabel.textColor = [[LAFManager instance] listViewContentFontCol];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		
		CGRect rect = CGRectMake(100, 5, 140*hMulti, 25*vMulti);
		UITextField *textField = [[UITextField alloc] initWithFrame:rect];
		textField.delegate = dele;
		textField.placeholder = fieldDef;
		textField.text = fieldText;
		textField.textAlignment = NSTextAlignmentLeft;
		textField.textColor = [UIColor blackColor];
		textField.tag = textId;
       // textField.text = @"Bob";
		textField.secureTextEntry = secureEntry;
		textField.autocorrectionType = UITextAutocorrectionTypeNo;
		textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		textField.backgroundColor = [UIColor clearColor]; //[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
		[cell.contentView addSubview:textField];
				
		
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	} 
	
	cell.textLabel.text = infoText;
	
	return cell;	
}

+(UITableViewCell*) createTableViewCellWithInputField2:(NSString*)infoText fieldDefault:(NSString*)fieldDef fieldText:(NSString*)fieldText table:(UITableView*)aTableView delle:(id<UITextFieldDelegate>)dele textfieldId:(int)textId secure:(bool)secureEntry {
	float hMulti = 1.3;// [SystemSettings horizontalMultiplier];
	float vMulti = 1;//[SystemSettings verticalMultiplier];
    //	const float layoutFontSize = 16.0*vMulti;
	
    //	static NSString *CellIdentifierStd = @"StandardTextInputCellButton";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:nil];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
		
		//cell.textLabel.font = [UIFont fontWithName:[[LAFManager instance] listViewContentFontName] size:layoutFontSize];
		//cell.textLabel.textColor = [[LAFManager instance] listViewContentFontCol];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		
		CGRect rect = CGRectMake(100, 5, 140*hMulti, 25*vMulti);
		UITextField *textField = [[UITextField alloc] initWithFrame:rect];
		textField.delegate = dele;
		textField.placeholder = fieldDef;
		textField.text = fieldText;
		textField.textAlignment = NSTextAlignmentLeft;
		textField.textColor = [UIColor blackColor];
		textField.tag = textId;
        textField.text = @"123456";
		textField.secureTextEntry = secureEntry;
		textField.autocorrectionType = UITextAutocorrectionTypeNo;
		textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		textField.backgroundColor = [UIColor clearColor]; //[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
		[cell.contentView addSubview:textField];
        
		
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	}
	
	cell.textLabel.text = infoText;
	
	return cell;
}

@end
