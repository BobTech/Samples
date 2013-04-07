
#import "LoginManager.h"
#import "Strings.h"
#import "HTTPEventSender.h"
#import "ModelConstants.h"
#import "ASIFormDataRequest.h"

#define kSignIn @"http://partner.jr-dev.com/login.php?Action=Login"
//  NSString *str = @"http://192.168.1.77:8888/home/phpsocket.php";

//#define kClientUserAgent @"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) UrhoTVClient"

@implementation LoginManager

/* Constructor */
-(id) init {

    receivedData = [[NSMutableData alloc] init];

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
-(int) signInToServiceWithUsername:(NSString*)uName andPassword:(NSString*)pWord {
    
    NSString* userName = [NSString stringWithString: uName];
    NSString* passWord = [NSString stringWithString: pWord] ;

    NSURL *url = [NSURL URLWithString:[kSignIn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setUseCookiePersistence:YES];
    [request setShouldPresentAuthenticationDialog:NO];
    
    [request setPostValue:userName forKey:@"username"];
    [request setPostValue:passWord forKey:@"password"];
    [request setTimeOutSeconds:120];
    [request startSynchronous];
    NSLog(@"Response String: %d",[request responseStatusCode]);
    
    NSError *error = [request error];
    if (!error) {
        if ([request responseStatusCode] == 200) {
            NSString *responseString = [request responseString];
            NSLog(@"response :%@",responseString);

            NSArray *list = [responseString componentsSeparatedByString:@"|"];
            
            if (list != nil && [list count] == 3 && [[[list objectAtIndex:0] substringToIndex:2] isEqualToString:@"OK"] && [[[list objectAtIndex:1] substringToIndex:1] isEqualToString:@"1"]) {
                return 1;  //church ALL
            }else if (list != nil && [list count] == 3 && [[[list objectAtIndex:0] substringToIndex:2] isEqualToString:@"OK"] && [[[list objectAtIndex:1] substringToIndex:1] isEqualToString:@"2"]) {
                return 2; //Church A
            }else if (list != nil && [list count] == 3 && [[[list objectAtIndex:0] substringToIndex:2] isEqualToString:@"OK"] && [[[list objectAtIndex:1] substringToIndex:1] isEqualToString:@"3"]) {
                return 3;  //Church B
            }
        }

    }
   // return 0;
    return 1; //todo:remove when server login is complete
}
/*
- (void) requestFinished:(ASIHTTPRequest *)request {
    if ([request responseStatusCode] == 200) {
        NSURLResponse *response;
        NSData *data = [NSURLConnection sendSynchronousRequest:(NSMutableURLRequest*)request returningResponse:&response error:nil];
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
}*/



@end
