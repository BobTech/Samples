//

#import <UIKit/UIKit.h>

@class BaseView;

/* Web view screen, shows the browser inside a container */
@interface WebViewScreen : BaseView<UIWebViewDelegate> {
	UIWebView *webView;
	UIActivityIndicatorView *noteSpinner;
}

/* Property declarations */

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIActivityIndicatorView *noteSpinner;

/* Method delcarations */

//- (id) initWithFrameWeb:(CGRect)frame parent:(BaseView*)aParentView sourceData:(WebData*)aData;

- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar;

- (void) backOnWeb:(id)sender;

@end
