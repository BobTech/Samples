//
//  SecondViewController.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/3/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "SecondViewController.h"
#import "ApplicationData.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupData];
}

- (void)setupData
{
    
    partnershipTypesGroupView = [[PartnershipTypeViewGroup alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andPartners:nil andNaviBar:naviBar];
        
    [self.view addSubview:partnershipTypesGroupView];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [ApplicationData sharedApplicationData].parentViewController = self;
    
    //[table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Compose Mail/SMS

// Displays an email composition interface inside the application. Populates all the Mail fields.
-(void)displayMailComposerSheet:(NSMutableArray*)aPersons
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Partnership reminder!"];
	
	
	// Set up recipients
	//NSArray *toRecipients = [NSArray arrayWithObject:aPersons.email ];
    NSMutableArray *toRecipients1 =[[NSMutableArray alloc] init];
    for (int i=0; i< [aPersons count]; i++) {
        PersonData *person = [aPersons objectAtIndex:i];
        [toRecipients1 addObject:person.email];
    }
    NSArray *toRecipients = [NSArray arrayWithArray:toRecipients1 ];

	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
	
	[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];
	//[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
	NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
	NSData *myData = [NSData dataWithContentsOfFile:path];
	[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
	
	// Fill out the email body text
	NSString *emailBody = @"Hello Brethren";
    emailBody = [emailBody stringByAppendingString:@",\n Just to remind you of your ROR partnership for August 2012. God bless you.\n Pastor Kitayo!"];
	
    [picker setMessageBody:emailBody isHTML:NO];
	
    [self presentViewController:picker animated:YES completion:nil];
    
	[picker release];
    picker = nil;
}


// Displays an SMS composition interface inside the application.
-(void)displaySMSComposerSheet:(NSMutableArray*)aPersons
{
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;
    
    NSMutableArray *toRecipients =[[NSMutableArray alloc] init];
    for (int i=0; i< [aPersons count]; i++) {
        PersonData *person = [aPersons objectAtIndex:i];
        [toRecipients addObject:person.mobilePhone];
    }

    [picker setRecipients:toRecipients];
	
    // Fill out the sms body text
	NSString *smsBody = @"Hello Brethren,";
    smsBody = [smsBody stringByAppendingString:@"\n Just to remind you of your ROR partnership for August 2012. God bless you.\n Pastor Kitayo!"];
    
    
	[picker setBody:smsBody];
    [self presentViewController:picker animated:YES completion:nil];
    
	[picker release];
    picker = nil;
    
}


@end
