

#import <Foundation/Foundation.h>


/* HTTP tracker event sender */
@interface HTTPEventSender : NSObject {
    NSURLConnection *connection;
    NSMutableArray *urlList;    
}

/* Singleton initializer */

+(HTTPEventSender*) sharedHTTPEventSender;

/* Sends a tracking event */

-(void) sendEvent:(NSString *)url;


@end
