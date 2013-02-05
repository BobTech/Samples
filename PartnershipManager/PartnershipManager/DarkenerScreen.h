
#import <UIKit/UIKit.h>

/* Darkener screen displayed when the text editing is on */
@interface DarkenerScreen : UIView {
	id<UITextFieldDelegate> textFieldDelegate;
	UITextField *textField;
}

/* Method declarations */

- (id)initWithFrame:(CGRect)frame fieldDel:(id<UITextFieldDelegate>)dele textF:(UITextField*)tf;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
