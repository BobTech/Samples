//
//  FirstViewController.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/3/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "FirstViewController.h"
#import "ApplicationData.h"
#import "Strings.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([[ApplicationData sharedApplicationData] checkIsNetworkAvailable]) {

        [self showLoginView];

    }else
        [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (void)initializeView {
        
    [ApplicationData sharedApplicationData].parentViewController = self;
    [ApplicationData sharedApplicationData].PartnershipTypeArrays = [[NSMutableArray alloc] init];
    [ApplicationData sharedApplicationData].appData = [[AppDataManager alloc] init] ;

    [[ApplicationData sharedApplicationData] fetchPartnershipData];
    [[ApplicationData sharedApplicationData].appData setupData];

    [self showMembersListView];
    
}

- (void)loginCompleted
{
    [super loginCompleted];
    [self initializeView];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [ApplicationData sharedApplicationData].parentViewController = nil;
    [ApplicationData sharedApplicationData].PartnershipTypeArrays = nil;
    
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [ApplicationData sharedApplicationData].parentViewController = self;
    [ApplicationData sharedApplicationData].PartnershipTypeArrays = [[NSMutableArray alloc] init];
    
}

- (void)showMembersListView {
    
    membersView = nil;
    [membersView release];
    membersView = [[MembersListView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andNaviBar:naviBar andApplicationData:[ApplicationData sharedApplicationData].appData ] ;
    
    [self.view addSubview:membersView];
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
    NSString* name = @"";
    NSString* title = @"";

	// Set up recipients
	//NSArray *toRecipients = [NSArray arrayWithObject:aPersons.email ];
    NSMutableArray *toRecipients1 =[[NSMutableArray alloc] init];
    for (int i=0; i< [aPersons count]; i++) {
        PersonData *person = [aPersons objectAtIndex:i];
        [toRecipients1 addObject:person.email];
        name = person.name;
        if ([person.sex isEqualToString:@"male"]) {
            title = @"Brother ";
        }else if ([person.sex isEqualToString:@"female"]) {
            title = @"Sister ";
        }
    }
   // NSArray *toRecipients = [NSArray arrayWithArray:toRecipients1 ];
    
	NSArray *ccRecipients = [NSArray arrayWithArray:toRecipients1];
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
	
	//[picker setToRecipients:toRecipients];
	[picker setCcRecipients:ccRecipients];
	//[picker setBccRecipients:bccRecipients];
    
   	
	// Attach an image to the email
	NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
	NSData *myData = [NSData dataWithContentsOfFile:path];
	[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
	
	// Fill out the email body text
	NSString *emailBody = @"Hello ";
    emailBody = [[emailBody stringByAppendingString:title] stringByAppendingString:name];
    emailBody = [emailBody stringByAppendingString:@",\n Just to remind you of your partnership.\n God bless you.\n Pastor Kitayo!"];
	
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
    
    NSString* name = @"";
    NSString* title = @"";
    
    //NSArray *toRecipients = [NSArray arrayWithObject:aPersons.email ];
    NSMutableArray *toRecipients1 =[[NSMutableArray alloc] init];
    for (int i=0; i< [aPersons count]; i++) {
        PersonData *person = [aPersons objectAtIndex:i];
        [toRecipients1 addObject:person.mobilePhone];
        name = person.name;
        if ([person.sex isEqualToString:@"male"]) {
            title = @"Brother ";
        }else if ([person.sex isEqualToString:@"female"]) {
            title = @"Sister ";
        }

    }
    NSArray *toRecipients = [NSArray arrayWithArray:toRecipients1 ];
    
    [picker setRecipients:toRecipients];
	
    // Fill out the sms body text
	NSString *smsBody = @"Hello ";
    smsBody = [[smsBody stringByAppendingString:title] stringByAppendingString:name];
    smsBody = [smsBody stringByAppendingString:@",\n Just to remind you of your partnership.\n God bless you.\n Pastor Kitayo!"];

    
	[picker setBody:smsBody];
    [self presentViewController:picker animated:YES completion:nil];

	[picker release];
    picker = nil;

}


@end
