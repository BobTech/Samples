//
//  ViewController.m
//  PHPClient
//
//  Created by Bob Emmanuel Esebamen on 1/28/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *fullURL = @"http://192.168.1.77:8888/reg_form.php";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:webView];
    [webView loadRequest:requestObj];
    
    
    udpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
	
	NSError *error = nil;
	
	if (![udpSocket bindToPort:0 error:&error])
	{
		NSLog(@"Error binding: %@", error);
		return;
	}
	
	[udpSocket receiveWithTimeout:-1 tag:0];
    
    receivedData = [[NSMutableData alloc] init];

	
	NSLog(@"Ready");
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollToBottom
{
/*'	UIScrollView *scrollView = [logView enclosingScrollView];
	CGPoint newScrollOrigin;
	
	if ([[scrollView documentView] isFlipped])
		newScrollOrigin = NSMakePoint(0.0F, NSMaxY([[scrollView documentView] frame]));
	else
		newScrollOrigin = CGPointMake(0.0F, 0.0F);
	
	[[scrollView documentView] scrollPoint:newScrollOrigin];
 */
}

- (void)logError:(NSString *)msg
{
	NSString *paragraph = [NSString stringWithFormat:@"%@\n", msg];
	
	NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:1];
	[attributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
	
	NSAttributedString *as = [[NSAttributedString alloc] initWithString:paragraph attributes:attributes];
	
	[logView setText:as.string];
	[self scrollToBottom];
}

- (void)logInfo:(NSString *)msg
{
	NSString *paragraph = [NSString stringWithFormat:@"%@\n", msg];
	
	NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:1];
	[attributes setObject:[UIColor purpleColor] forKey:NSForegroundColorAttributeName];
	
	NSAttributedString *as = [[NSAttributedString alloc] initWithString:paragraph attributes:attributes];
	
	[logView setText:as.string];
	[self scrollToBottom];
}

- (void)logMessage:(NSString *)msg
{
	NSString *paragraph = [NSString stringWithFormat:@"%@\n", msg];
	
	NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:1];
	[attributes setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
	
	NSAttributedString *as = [[NSAttributedString alloc] initWithString:paragraph attributes:attributes];
	
	[logView setText:as.string];
	[self scrollToBottom];
}

- (IBAction)send:(id)sender
{
	NSString *host = [addrField text];
	if ([host length] == 0)
	{
		[self logError:@"Address required"];
		return;
	}
	
	int port = [portField.text intValue];
	if (port <= 0 || port > 65535)
	{
		[self logError:@"Valid port required"];
		return;
	}
	
	NSString *msg = [messageField text];
	if ([msg length] == 0)
	{
		[self logError:@"Message required"];
		return;
	}
    
    [self signInToService];
	
	//NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
//	[udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
	
//	[self logMessage:FORMAT(@"SENT (%i): %@", (int)tag, msg)];
	
	tag++;
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
	// You could add checks here
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
	// You could add checks here
}

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock
     didReceiveData:(NSData *)data
            withTag:(long)tag
           fromHost:(NSString *)host
               port:(UInt16)port
{
	NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	if (msg)
	{
		//[self logMessage:FORMAT(@"RECV: %@", msg)];
        NSLog(@"Error binding: %@", msg);

	}
	else
	{
		//[self logInfo:FORMAT(@"RECV: Unknown message from: %@:%hu", host, port)];
        NSLog(@"Error binding: %@", host);

	}
	
	[udpSocket receiveWithTimeout:-1 tag:0];
	return YES;
}





/* Sign in to the service *
-(bool) signInToServiceWithUsernameOld:(NSString*)uName andPassword:(NSString*)pWord {
    //	UserDataManager *userDataMgr = [UserDataManager instance];
    
    NSString *kSignIn = @"http://192.168.1.77:8888/httpstreaming.php";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kSignIn, [uName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [pWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    
	NSLog(@"Signin url check: %@", url);
    
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];	//originally 10
	[request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0) Gecko/20100101 Firefox/13.0.1" forHTTPHeaderField:@"User-Agent"];
	NSURLResponse *response;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	NSString *subscribeString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
	
	NSLog(@"Signin return: %@", subscribeString);
    
	NSArray *list = [subscribeString componentsSeparatedByString:@"|"];
	
    [logView setText:subscribeString];

	if (list != nil && [list count] == 3 && [[[list objectAtIndex:0] substringToIndex:2] isEqualToString:@"OK"] && [[[list objectAtIndex:1] substringToIndex:1] isEqualToString:@"1"]) {

		//NSLog(@"Login to UrhoTV succeeded");
		return YES;
	} else {
		//NSLog(@"Login to UrhoTV failed");
		return NO;
	}
}*/


/* Sign in to the service */
-(bool) signInToService {
    
    NSString *url =[NSString stringWithFormat:@"http://192.168.1.77:8888/httpstreaming.php"];
    
    NSLog(@"%@",url);
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    
    // [req setUserAgentString:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0) Gecko/20100101 Firefox/13.0.1"];
    [req setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0) Gecko/20100101 Firefox/13.0.1" forHTTPHeaderField:@"User-Agent"];
    
    //  [req setValue:pWord forHTTPHeaderField:@"password"];
    
    //    [req setHTTPMethod:@"GET"]; // This might be redundant, I'm pretty sure GET is the default value
    NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:req delegate:self] autorelease];
    [connection start];
    NSString *subscribeString =  [connection description];
    
    return YES;
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
    NSInteger statusCode = [HTTPResponse statusCode];
    
    if (404 == statusCode || 500 == statusCode) {
        //[self.controller setTitle:@"Error Getting Parking Spot ....."];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
        NSLog(@"GOT A 'FAILED' STATUS CODE");
        
        [connection cancel];
        NSLog(@"Server Error - %@", [NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
    } else if (200 == statusCode) {
        NSLog(@"GOT A 'OK' RESPONSE CODE");
        
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [receivedData appendData:data];
    NSLog(@"Receiving data... Length: %d", [receivedData length]);
    

    
     NSString *subscribeString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
     NSLog(@"Signin return: %@", subscribeString);
    
    
  /*   NSArray *list = [subscribeString componentsSeparatedByString:@"|"];
     if ([[[list objectAtIndex:0] substringToIndex:0] isEqualToString:@"OK"]){
     DebugLog([[list objectAtIndex:0] substringToIndex:0]);
     DebugLog(@"Login to UrhoTV succeeded");
     
     } else if (list != nil && [list count] == 3 && [[[list objectAtIndex:0] substringToIndex:2] isEqualToString:@"OK"] && [[[list objectAtIndex:1] substringToIndex:1] isEqualToString:@"1"]) {
     UserDataManager *userDataManager = [UserDataManager instance];
     userDataManager.userAuthenticated = YES;
     userDataManager.thirdPresenceServerToken = [[list objectAtIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
     
     if (userDataManager.thirdPresenceServerToken != nil && userDataManager.apsPushToken != nil) {
     [[HTTPEventSender sharedHTTPEventSender] sendEvent:[NSString stringWithFormat:@"http://urhotvclient.thirdpresence.com/xml/front?Action=subscribePushService&username=%@&id=%@",userDataManager.thirdPresenceServerToken, userDataManager.apsPushToken]];
     }
     
     DebugLog(@"Login to UrhoTV succeeded");
     //	return YES;
     } else {
     DebugLog(@"Login to UrhoTV failed");
     //	return NO;
     }
     */
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Hide Network Indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    // Display data length
    NSLog(@"Total received data: %d", [receivedData length]);
    
    // Convert data into string and display it
    NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"Received string: %@", responseString);
    //NSLog(@"Cookies: %@", [[NSHTTPCookieStorage sharedHTTPCookieStorage] description]);
    
    [logView setText:responseString];

    
}


@end
