

#import "WaitScreen.h"


@implementation WaitScreen

/* Constructor, initializes the wait view */
- (id)initWithFrame:(CGRect)frame transparency:(float)alphaVal text:(NSString*)txt {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alphaVal];
		
		// Add the spinner
		CGRect sFrame = frame;
		UIActivityIndicatorView *noteSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		sFrame.origin.x = sFrame.size.width / 2 - noteSpinner.frame.size.width / 2;
		sFrame.origin.y = sFrame.size.height / 2 - noteSpinner.frame.size.height / 2;
		sFrame.size.width = noteSpinner.frame.size.width;
		sFrame.size.height = noteSpinner.frame.size.height;
		noteSpinner.frame = sFrame;
		[noteSpinner startAnimating];
		[self addSubview:noteSpinner];
		[noteSpinner release];
		
		if (txt != nil) {
			waitText = [[UILabel alloc] initWithFrame:CGRectMake(0, sFrame.origin.y + sFrame.size.height + 5, frame.size.width, 18)];
			waitText.text = txt;
			waitText.textAlignment =  NSTextAlignmentCenter;
			waitText.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			waitText.font = [UIFont fontWithName:@"Helvetica" size:14.0];
			waitText.textColor = [UIColor whiteColor];
			waitText.backgroundColor = [UIColor clearColor];
			[self addSubview:waitText];			
		}
    }
    return self;
}

/* Destructor */
- (void)dealloc {
	[waitText release];
    [super dealloc];
}

@end
