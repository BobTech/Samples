

#import "LoginData.h"


@implementation LoginData

@synthesize loginId;
@synthesize headerText;

/* Constructor */
-(id) init {
	loginId = nil;
	headerText = nil;
	
	return self;
}

/* Destructor */
-(void) dealloc {
/*	[loginId release];
	[headerText release];
	*/
	[super dealloc];

}

@end
