//
//  ViewController.m
//  RestfuliOS
//
//  Created by Bob Emmanuel Esebamen on 2/1/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import "ViewController.h"
#import "ASIFormDataRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loginToURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginToURL
{
    NSString *url =[NSString stringWithFormat:@"http://192.168.1.77:8888/home/index.php"];

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setPostValue:@"7772" forKey:@"rw_app_id"];
    [request setPostValue:@"7773" forKey:@"code"];
    [request setPostValue:@"7774" forKey:@"device_id"];
    
  //  NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
   // [connection start];

    [request setDelegate:self];
    [request startAsynchronous ];
   // [request startSynchronous ];

    //   NSLog(@"Response String: %@",[request responseString]);
    NSLog(@"Response String: %d",[request responseStatusCode]);
    
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(@"response :%@",response);
        
    }


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
    
    NSLog(@"Receiving data... Length: %d", [data length]);
        
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Hide Network Indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}


@end
