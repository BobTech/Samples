
#import "LoginManager.h"
#import "Strings.h"
#import "HTTPEventSender.h"
#import "ModelConstants.h"
#import "ASIFormDataRequest.h"

#define kSignIn @"http://partner.jr-dev.com/login.php?Action=Login"

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


@end
