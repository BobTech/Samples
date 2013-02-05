
//

#ifndef __WAITSCREEN_H__
#define __WAITSCREEN_H__

#import <UIKit/UIKit.h>

/* Wait screen shown during the video link parsing */
@interface WaitScreen : UIView {
	UILabel *waitText;
}

/* Method declarations */

- (id)initWithFrame:(CGRect)frame transparency:(float)alphaVal text:(NSString*)txt;

@end

#endif	//	__WAITSCREEN_H__