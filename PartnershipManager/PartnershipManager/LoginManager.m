

#import "LoginManager.h"
#import "Strings.h"
#import "HTTPEventSender.h"
#import "ModelConstants.h"
#import "ASIFormDataRequest.h"

//#define kSignIn @"http://aaaproxy.thirdpresence.com/?Action=signin&cuid=urhotv&deviceid=%@&account=%@&passwd=%@"
#define kSignIn @"http://partner.jr-dev.com/login.php/?Action=Login@&username=%@&password=%@"

#define kClientUserAgent @"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) UrhoTVClient"

@implementation LoginManager

/* Constructor */
-(id) init {

    receivedData = [[NSMutableData alloc] init];

	return self;
}


/* Constructor *
-(id) init:(AppDataManager*)dataMgr {
	appData = dataMgr;
	return self;
}

/* Destructor */
-(void) dealloc {
	
	[super dealloc];
}

/* Checks if login cached */
-(bool)isUserLoginCached {	
	return NO;
}

/* Sign in to the service */
-(bool) signInToServiceWithUsernameOLD:(NSString*)uName andPassword:(NSString*)pWord {
//	UserDataManager *userDataMgr = [UserDataManager instance];

//	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kSignIn, userDataMgr.userIdHash, [uName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [pWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kSignIn, [uName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [pWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

    
	NSLog(@"Signin url check: %@", url);

	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];	//originally 10	
	[request setValue:kClientUserAgent forHTTPHeaderField:@"User-Agent"];					
	NSURLResponse *response;  		
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	NSString *subscribeString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];		
	
	NSLog(@"Signin return: %@", subscribeString);
    
	NSArray *list = [subscribeString componentsSeparatedByString:@"|"];	
	
	if (list != nil && [list count] == 3 && [[[list objectAtIndex:0] substringToIndex:2] isEqualToString:@"OK"] && [[[list objectAtIndex:1] substringToIndex:1] isEqualToString:@"1"]) {
		UserDataManager *userDataManager = [UserDataManager instance];
		userDataManager.userAuthenticated = YES;
        userDataManager.thirdPresenceServerToken = [[list objectAtIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (userDataManager.thirdPresenceServerToken != nil && userDataManager.apsPushToken != nil) {
            [[HTTPEventSender sharedHTTPEventSender] sendEvent:[NSString stringWithFormat:@"http://urhotvclient.thirdpresence.com/xml/front?Action=subscribePushService&username=%@&id=%@",userDataManager.thirdPresenceServerToken, userDataManager.apsPushToken]];
        }
		
		DebugLog(@"Login to UrhoTV succeeded");
		return YES;
	} else {
		DebugLog(@"Login to UrhoTV failed");
		return NO;
	}
}

/* Sign in to the service */
-(bool) signInToServiceWithUsernameOLDD {
  
    NSString *url =[NSString stringWithFormat:@""];

    DebugLog(@"%@",url);
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


/* Sign in to the service */
-(bool) signInToServiceWithUsername:(NSString*)uName andPassword:(NSString*)pWord {
    
    NSString* userName = [NSString stringWithString: uName];
    NSString* passWord = [NSString stringWithString: pWord] ;

    //NSString *str = @"http://partner.jr-dev.com/login.php?Action=Login@username=userName&password=passWord";
    NSString *str = @"http://partner.jr-dev.com/login.php?Action=Login";
    
 //   NSString *str = @"http://192.168.1.77:8888/login.php?Action=Login@username=userName&password=passWord";
  //  NSString *str = @"http://192.168.1.77:8888/home/phpsocket.php";

    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setUseCookiePersistence:YES];
    [request setShouldPresentAuthenticationDialog:NO];
    
    [request setPostValue:userName forKey:@"username"];
    [request setPostValue:passWord forKey:@"password"];
    [request setTimeOutSeconds:120];
    //[request setDelegate:self];
    [request startSynchronous];
 //   NSLog(@"Response String: %@",[request responseString]);
    NSLog(@"Response String: %d",[request responseStatusCode]);
    
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(@"response :%@",response);

    }
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
    
  /*
	NSString *subscribeString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSLog(@"Signin return: %@", subscribeString);
    
	NSArray *list = [subscribeString componentsSeparatedByString:@"|"];
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


}

/* Sign in to the service *
-(bool) signInToServiceWithUsernameOld:(NSString*)uName andPassword:(NSString*)pWord {
    //	UserDataManager *userDataMgr = [UserDataManager instance];
    
    //	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kSignIn, userDataMgr.userIdHash, [uName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [pWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kSignIn, [uName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [pWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    
	DebugLog(@"Signin url check: %@", url);
    
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];	//originally 10
	[request setValue:kClientUserAgent forHTTPHeaderField:@"User-Agent"];
	NSURLResponse *response;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	NSString *subscribeString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
	
	DebugLog(@"Signin return: %@", subscribeString);
    
	NSArray *list = [subscribeString componentsSeparatedByString:@"|"];
	
	if (list != nil && [list count] == 3 && [[[list objectAtIndex:0] substringToIndex:2] isEqualToString:@"OK"] && [[[list objectAtIndex:1] substringToIndex:1] isEqualToString:@"1"]) {
		UserDataManager *userDataManager = [UserDataManager instance];
		userDataManager.userAuthenticated = YES;
        userDataManager.thirdPresenceServerToken = [[list objectAtIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (userDataManager.thirdPresenceServerToken != nil && userDataManager.apsPushToken != nil) {
            [[HTTPEventSender sharedHTTPEventSender] sendEvent:[NSString stringWithFormat:@"http://urhotvclient.thirdpresence.com/xml/front?Action=subscribePushService&username=%@&id=%@",userDataManager.thirdPresenceServerToken, userDataManager.apsPushToken]];
        }
		
		DebugLog(@"Login to UrhoTV succeeded");
		return YES;
	} else {
		DebugLog(@"Login to UrhoTV failed");
		return NO;
	}
}
 */

@end
