#import "HTTPEventSender.h"
//#import "SynthesizeSingleton.h"
#import "ModelConstants.h"
//#import "AppDataManager.h"

@implementation HTTPEventSender

SYNTHESIZE_SINGLETON_FOR_CLASS(HTTPEventSender*);

/* Constructor */
-(id) init {
    urlList = [[NSMutableArray alloc] init];
    return self;
}

/* Destructor *
-(void) dealloc {
    [urlList release];
    [super dealloc];
}

/* Starts sending an event */
-(void) startNewDownload:(NSString*)url {  
    NSString* escapedKeyword = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DebugLog(@"Sending URL tracking event to: %@", escapedKeyword);
	NSURL* realUrl = [NSURL URLWithString:escapedKeyword];
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:realUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3.0];
    [request setValue:kClientUserAgent forHTTPHeaderField:@"User-Agent"];
//	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
	NSURLResponse *response;  		
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	NSString *subscribeString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    DebugLog(@"RESPONSE: %@", subscribeString);
}

/* Sends a tracking event */
-(void) sendEvent:(NSString *)url {
    if (connection != nil) {
        [urlList addObject:url];
    } else {
        [self startNewDownload:url];
    }
}

/* Called when data is received from the net */
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
}

/* Called when all the data has been loaded */
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    DebugLog(@"Ad URL tracking event sent successfully");
    
	//[connection release];
	connection = nil;
    
    if ([urlList count] > 0) {
        [self startNewDownload:[urlList objectAtIndex:0]];
        [urlList removeObjectAtIndex:0];
    }
}

/* Epic fail - continue nonetheless, everything will be fetched from the server */
- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
    DebugLog(@"Ad URL tracking event failed");
    DebugLog(@"Code: %d Domain: %@", [error code], [error domain]);
    
//	[connection release];
	connection = nil;
    
    if ([urlList count] > 0) {
        [self startNewDownload:[urlList objectAtIndex:0]];
        [urlList removeObjectAtIndex:0];
    }
}

@end
