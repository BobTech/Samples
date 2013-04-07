//
//  ViewController.m
//  ChatServer
//
//  Created by Bob Emmanuel Esebamen on 2/6/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import "ViewController.h"
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>

#import <arpa/inet.h>
#import <fcntl.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <netinet/in.h>
#import <net/if.h>
#import <sys/socket.h>
#import <sys/types.h>
#import <sys/ioctl.h>
#import <sys/poll.h>
#import <sys/uio.h>
#import <unistd.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // self.ipAddress setText:@"192.168.1.70"];
   // [self.port setText:@"57362"];
	//inputNameField.text = @"Bob1";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

- (void)setupConnection {
    
	[self initNetworkCommunication];
	
	messages = [[NSMutableArray alloc] init];
	
//	self.tView.delegate = self;
//	self.tView.dataSource = self;
	
}
- (IBAction)goBack:(id)sender {
    [self.view bringSubviewToFront:joinView];
    
}


- (void) initNetworkCommunication {
   /* NSString *ipAdd =self.ipAddress.text;
    int *mPort =[self.port.text intValue];
    
    NSLog(@"I address: %@", ipAdd);
 */   
	CFReadStreamRef readStream;
	CFWriteStreamRef writeStream;
	CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)"192.168.1.70", 57362, &readStream, &writeStream);
	
	inputStream = (NSInputStream *)readStream;
	outputStream = (NSOutputStream *)writeStream;
	[inputStream setDelegate:self];
	[outputStream setDelegate:self];
	[inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[inputStream open];
	[outputStream open];
    
    
    int(^createSocket)(int, NSData*) = ^int (int domain, NSData *interfaceAddr) {
        
        int socketFD = socket(domain, SOCK_STREAM, 0);
        
        /*   if (socketFD == SOCKET_NULL)
         {
         NSString *reason = @"Error in socket() function";
         //err = [self errnoErrorWithReason:reason];
         
         return nil;//SOCKET_NULL;
         }*/
        
        int status;
        
        // Set socket options
        
        status = fcntl(socketFD, F_SETFL, O_NONBLOCK);
        if (status == -1)
        {
            NSString *reason = @"Error enabling non-blocking IO on socket (fcntl)";
            //err = [self errnoErrorWithReason:reason];
            
            //LogVerbose(@"close(socketFD)");
            close(socketFD);
            return nil;// SOCKET_NULL;
        }
        
        int reuseOn = 1;
        status = setsockopt(socketFD, SOL_SOCKET, SO_REUSEADDR, &reuseOn, sizeof(reuseOn));
        if (status == -1)
        {
            NSString *reason = @"Error enabling address reuse (setsockopt)";
            //err = [self errnoErrorWithReason:reason];
            
            // LogVerbose(@"close(socketFD)");
            close(socketFD);
            return nil;//SOCKET_NULL;
        }
        
        // Bind socket
        
        status = bind(socketFD, (const struct sockaddr *)[interfaceAddr bytes], (socklen_t)[interfaceAddr length]);
        if (status == -1)
        {
            NSString *reason = @"Error in bind() function";
            // err = [self errnoErrorWithReason:reason];
            
            // LogVerbose(@"close(socketFD)");
            close(socketFD);
          //  return nil;//SOCKET_NULL;
        }
        
        // Listen
        
        status = listen(socketFD, 1024);
        if (status == -1)
        {
            NSString *reason = @"Error in listen() function";
            //   err = [self errnoErrorWithReason:reason];
            
            //  LogVerbose(@"close(socketFD)");
            close(socketFD);
            return nil;// SOCKET_NULL;
        }
        socketFDy = socketFD;
       // return socketFD;
    };

    // Set socket options
    
    int status = fcntl(socketFDy, F_SETFL, O_NONBLOCK);
    if (status == -1)
    {
        NSString *reason = @"Error enabling non-blocking IO on socket (fcntl)";
      //  err = [self errnoErrorWithReason:reason];
        
       // LogVerbose(@"close(socketFD)");
        close(socketFDy);
        //return SOCKET_NULL;
    }
    
    int reuseOn = 1;
    status = setsockopt(socketFDy, SOL_SOCKET, SO_REUSEADDR, &reuseOn, sizeof(reuseOn));
    if (status == -1)
    {
        NSString *reason = @"Error enabling address reuse (setsockopt)";
       // err = [self errnoErrorWithReason:reason];
        
       // LogVerbose(@"close(socketFD)");
        close(socketFDy);
       // return nil;// SOCKET_NULL;
    }
    
    // Bind socket
    
    status = bind(socketFDy, (const struct sockaddr *)[interfaceAddr bytes], (socklen_t)[interfaceAddr length]);
    if (status == -1)
    {
        NSString *reason = @"Error in bind() function";
        //err = [self errnoErrorWithReason:reason];
        
       // LogVerbose(@"close(socketFD)");
        close(socketFDy);
        //return nil;//SOCKET_NULL;
    }
    
    // Listen
    
    status = listen(socketFDy, 1024);
    if (status == -1)
    {
        NSString *reason = @"Error in listen() function";
   //     err = [self errnoErrorWithReason:reason];
        
     //   LogVerbose(@"close(socketFD)");
        close(socketFDy);
       // return nil;// SOCKET_NULL;
    }
    
   // return socketFDy;
	
}



- (IBAction) joinChat {
    [self setupConnection];
    
    
	[self.view bringSubviewToFront:chatView];
	NSString *response  = [NSString stringWithFormat:@"iam:%@", inputNameField.text];
	NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
	[outputStream write:[data bytes] maxLength:[data length]];
	
}


- (IBAction) sendMessage {
	
	NSString *response  = [NSString stringWithFormat:@"msg:%@", inputMessageField.text];
	NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
	[outputStream write:[data bytes] maxLength:[data length]];
	inputMessageField.text = @"";
	
}


- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
	NSLog(@"stream event %i", streamEvent);
	
	switch (streamEvent) {
			
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
			break;
		case NSStreamEventHasBytesAvailable:
            
			if (theStream == inputStream) {
				
				uint8_t buffer[1024];
				int len;
				
				while ([inputStream hasBytesAvailable]) {
					len = [inputStream read:buffer maxLength:sizeof(buffer)];
					if (len > 0) {
						
						NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
						
						if (nil != output) {
                            
							NSLog(@"server said: %@", output);
							[self messageReceived:output];
							
						}
					}
				}
			}
			break;
            
			
		case NSStreamEventErrorOccurred:
			
			NSLog(@"Can not connect to the host!");
			break;
			
		case NSStreamEventEndEncountered:
            
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            [theStream release];
            theStream = nil;
			
			break;
		default:
			NSLog(@"Unknown event");
	}
    
}

- (void) messageReceived:(NSString *)message {
	
/*	[self.messages addObject:message];
	[self.tView reloadData];
	NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:messages.count-1
												   inSection:0];
	[self.tView scrollToRowAtIndexPath:topIndexPath
					  atScrollPosition:UITableViewScrollPositionMiddle
							  animated:YES];
    */
}

#pragma mark -
#pragma mark Table delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *s = (NSString *) [messages objectAtIndex:indexPath.row];
	
    static NSString *CellIdentifier = @"ChatCellIdentifier";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text = s;
	
	return cell;
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return messages.count;
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
	[joinView release];
	[chatView release];
	[inputStream release];
	[outputStream release];
	[inputNameField release];
	[inputMessageField release];
	[tView release];
 //   [_ipAddress release];
 //   [_port release];
    [super dealloc];
	
}

@end
