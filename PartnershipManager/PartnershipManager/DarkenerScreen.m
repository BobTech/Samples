

#import <UIKit/UIKit.h>
#import "DarkenerScreen.h"


@implementation DarkenerScreen

/* Constructor */
- (id)initWithFrame:(CGRect)frame fieldDel:(id<UITextFieldDelegate>)dele textF:(UITextField*)tf {
    if ((self = [super initWithFrame:frame])) {
		textFieldDelegate = dele;
		textField = tf;
    }
    return self;
}

/* Destructor */
- (void)dealloc {
    [super dealloc];
}

/* If the user presses this component during the text field editing, it is interpreted as the text editing should end action */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[textFieldDelegate textFieldShouldReturn:textField];
}


@end
