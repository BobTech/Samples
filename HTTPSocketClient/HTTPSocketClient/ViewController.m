//
//  ViewController.m
//  HTTPSocketClient
//
//  Created by Bob Emmanuel Esebamen on 1/30/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "DispatchQueueLogFormatter.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

#define USE_SECURE_CONNECTION    0
#define VALIDATE_SSL_CERTIFICATE 1

#define READ_HEADER_LINE_BY_LINE 0



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    clientConnected = NO;
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    DispatchQueueLogFormatter *formatter = [[DispatchQueueLogFormatter alloc] init];
	[formatter setReplacementString:@"socket" forQueueLabel:GCDAsyncSocketQueueName];
	[formatter setReplacementString:@"socket-cf" forQueueLabel:GCDAsyncSocketThreadName];
	
	[[DDTTYLogger sharedInstance] setLogFormatter:formatter];

    socketQueue = dispatch_queue_create("socketQueue", NULL);

    
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
   // asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:socketQueue];

    
    [self connect];

}
- (void)connect
{
    NSError *error = nil;
//	NSString *host = HOST;
    
    NSLog(@"port number: %@", [_host text] );
    uint16_t port = [[_host text] intValue];
	NSString *ipAddress = [_ipAddress text];
    NSLog(@"server IP address: %@", ipAddress );

  //  if(![asyncSocket isDisconnected]){
        if (![asyncSocket connectToHost:ipAddress onPort:port error:&error])
        {
            DDLogError(@"Unable to connect to due to invalid configuration: %@", error);
        }
        else
        {
            DDLogVerbose(@"Connecting to \"%@\" on port %hu...", ipAddress, port);
          //  [asyncSocket startTLS:nil];

        }
 //   }
}
- (IBAction)sendMessage:(id)sender {
 //   BOOL connected = [asyncSocket isDisconnected];
 //   if(!clientConnected){

        [self connect];
  //  }
    [self sendMessageFromView];


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
/*    [_ipAddress release];
    [_host release];
    [_messageView release];
    [_chatView release];
    [super dealloc];*/
}
- (IBAction)connectToServer:(id)sender {
    [self connect];
}

- (void)sendMessageFromView
{
    [self.view endEditing:YES];

   // NSString *requestStrFrmt = @"HEAD / HTTP/1.0\r\nHost: %@\r\n\r\n";
    NSString *requestStrFrmt = @"Bob: %@\r\n\r\n";

	//NSString *requestStr = [NSString stringWithFormat:requestStrFrmt, HOST];
    NSString *requestStr = [NSString stringWithFormat:requestStrFrmt, [_messageView text]];

	NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
	
	[asyncSocket writeData:requestData withTimeout:-1.0 tag:0];
	
	DDLogVerbose(@"Sending HTTP Request:\n%@", requestStr);
    
    NSString *text = [[_chatView text] stringByAppendingString:requestStr];
    [_chatView setText:text];

/*
    
#if READ_HEADER_LINE_BY_LINE
	
	// Now we tell the socket to read the first line of the http response header.
	// As per the http protocol, we know each header line is terminated with a CRLF (carriage return, line feed).
	
	[asyncSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1.0 tag:0];
	
#else
	
	// Now we tell the socket to read the full header for the http response.
	// As per the http protocol, we know the header is terminated with two CRLF's (carriage return, line feed).
	
	NSData *responseTerminatorData = [@"\r\n\r\n" dataUsingEncoding:NSASCIIStringEncoding];
	
	[asyncSocket readDataToData:responseTerminatorData withTimeout:-1.0 tag:0];
	
#endif
     */

}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
	DDLogVerbose(@"socket:didConnectToHost:%@ port:%hu", host, port);
    clientConnected = YES;
    
	// HTTP is a really simple protocol.
	//
	// If you don't already know all about it, this is one of the best resources I know (short and sweet):
	// http://www.jmarshall.com/easy/http/
	//
	// We're just going to tell the server to send us the metadata (essentially) about a particular resource.
	// The server will send an http response, and then immediately close the connection.
	
/*	NSString *requestStrFrmt = @"HEAD / HTTP/1.0\r\nHost: %@\r\n\r\n";
	
	NSString *requestStr = [NSString stringWithFormat:requestStrFrmt, HOST];
	NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
	
	[asyncSocket writeData:requestData withTimeout:-1.0 tag:0];
	
	DDLogVerbose(@"Sending HTTP Request:\n%@", requestStr);
	
	// Side Note:
	//
	// The AsyncSocket family supports queued reads and writes.
	//
	// This means that you don't have to wait for the socket to connect before issuing your read or write commands.
	// If you do so before the socket is connected, it will simply queue the requests,
	// and process them after the socket is connected.
	// Also, you can issue multiple write commands (or read commands) at a time.
	// You don't have to wait for one write operation to complete before sending another write command.
	//
	// The whole point is to make YOUR code easier to write, easier to read, and easier to maintain.
	// Do networking stuff when it is easiest for you, or when it makes the most sense for you.
	// AsyncSocket adapts to your schedule, not the other way around.
	
#if READ_HEADER_LINE_BY_LINE
	
	// Now we tell the socket to read the first line of the http response header.
	// As per the http protocol, we know each header line is terminated with a CRLF (carriage return, line feed).
	
	[asyncSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1.0 tag:0];
	
#else
	
	// Now we tell the socket to read the full header for the http response.
	// As per the http protocol, we know the header is terminated with two CRLF's (carriage return, line feed).
	
	NSData *responseTerminatorData = [@"\r\n\r\n" dataUsingEncoding:NSASCIIStringEncoding];
	
	[asyncSocket readDataToData:responseTerminatorData withTimeout:-1.0 tag:0];
	
#endif
 
    
*/
    [asyncSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1.0 tag:0];

}

- (void)socketDidSecure:(GCDAsyncSocket *)sock
{
	// This method will be called if USE_SECURE_CONNECTION is set
	
	DDLogVerbose(@"socketDidSecure:");
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	DDLogVerbose(@"socket:didWriteDataWithTag:");
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	DDLogVerbose(@"socket:didReadData:withTag:");
	
	NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
#if READ_HEADER_LINE_BY_LINE
	
	DDLogInfo(@"Line httpResponse: %@", httpResponse);
	
	// As per the http protocol, we know the header is terminated with two CRLF's.
	// In other words, an empty line.
	
	if ([data length] == 2) // 2 bytes = CRLF
	{
		DDLogInfo(@"<done>");
	}
	else
	{
		// Read the next line of the header
		[asyncSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1.0 tag:0];
	}
	
#else
	
	DDLogInfo(@"Full HTTP Response:\n%@", httpResponse);
    NSLog(@"Full HTTP Response:\n%@", httpResponse);
    
    NSString *text = [[[_chatView text] stringByAppendingString:@"\r\nServer: "] stringByAppendingString:httpResponse];
    [_chatView setText:text];
    
#endif
	
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
	// Since we requested HTTP/1.0, we expect the server to close the connection as soon as it has sent the response.
	
	DDLogVerbose(@"socketDidDisconnect:withError: \"%@\"", err);
    clientConnected = NO;

}


@end
