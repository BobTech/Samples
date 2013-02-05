//
//  WebViewScreen.m
//  UrhoTV
//
//  Created by Lassi Maksimainen on 19.7.2010.
//  Copyright 2010 ThirdPresence. All rights reserved.
//

#import "BaseView.h"
#import "WebViewScreen.h"

@implementation WebViewScreen

@synthesize webView;
@synthesize noteSpinner;

/* Initializer, creates the web view and spinner that is shown while the page loads *
-(id) initWithFrameWeb:(CGRect)frame parent:(BaseView*)aParentView sourceData:(WebData*)aData {
	CGRect realFrame = frame;
	realFrame.origin.x = 0;
	realFrame.origin.y = 0;
    
	if ((self = [super initWithFrame:realFrame])) {
		// Add the browser component
		data = aData;
		self.parentView = aParentView;
		self.title = data.headerText;
		self.titleImage = data.headerImage;
		self.webView = [[UIWebView alloc] initWithFrame:realFrame];
		self.webView.delegate = self;
		self.webView.multipleTouchEnabled = YES;
		self.webView.scalesPageToFit = YES;
		NSURL *url = [NSURL URLWithString:data.webURL];
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		[self.webView loadRequest:requestObj];		
		[self addSubview:webView];
		
		// Add the spinner
		CGRect frame = realFrame;
		noteSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		frame.origin.x = realFrame.size.width / 2 - noteSpinner.frame.size.width / 2;
		frame.origin.y = realFrame.size.height / 2 - noteSpinner.frame.size.height / 2;
		frame.size.width = noteSpinner.frame.size.width;
		frame.size.height = noteSpinner.frame.size.height;
		noteSpinner.frame = frame;
		[noteSpinner startAnimating];
		[self addSubview:noteSpinner];		
	}
    return self;
}

/* Initializer, creates the web view and spinner that is shown while the page loads */
- (id)initWithFrame:(CGRect)frame andNaviBar:(UINavigationBar*)bar{
	CGRect realFrame = frame;
	realFrame.origin.x = 0;
	realFrame.origin.y = 0;
    
	if ((self = [super initWithFrame:realFrame andNaviBar:bar])) {
		// Add the browser component
	//	self.title = data.headerText;
		self.webView = [[UIWebView alloc] initWithFrame:realFrame];
		self.webView.delegate = self;
		self.webView.multipleTouchEnabled = YES;
		self.webView.scalesPageToFit = YES;
		NSURL *url = [NSURL URLWithString:@"http://partner.jr-dev.com/register.php"];
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		[self.webView loadRequest:requestObj];
		[self addSubview:webView];
		
		// Add the spinner
		CGRect frame = realFrame;
		noteSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		frame.origin.x = realFrame.size.width / 2 - noteSpinner.frame.size.width / 2;
		frame.origin.y = realFrame.size.height / 2 - noteSpinner.frame.size.height / 2;
		frame.size.width = noteSpinner.frame.size.width;
		frame.size.height = noteSpinner.frame.size.height;
		noteSpinner.frame = frame;
		[noteSpinner startAnimating];
		[self addSubview:noteSpinner];
        
        title = @"Sign up here";

        [self initializeNavigationBarWith:title];
	}
    return self;
}
/* Stop spinner when the first web page is fully loaded */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[noteSpinner stopAnimating];
	[noteSpinner removeFromSuperview];
	[noteSpinner release];
	noteSpinner = nil;
}

/* Stop spinner also in the case of failure */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[noteSpinner stopAnimating];
	[noteSpinner removeFromSuperview];
	[noteSpinner release];
	noteSpinner = nil;	
}

/* From UIWebViewDelegate, called when user presses back button on the right hand corner */
-(void) backOnWeb:(id)sender {
	[webView goBack];
}

/* Destructor */
- (void)dealloc {
	[webView release];
	[noteSpinner release];
    [super dealloc];
}

@end
