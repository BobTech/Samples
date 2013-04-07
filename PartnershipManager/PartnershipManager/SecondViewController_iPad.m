//
//  SecondViewController_iPad.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 2/5/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import "SecondViewController_iPad.h"
#import "ApplicationData.h"
#import <QuartzCore/QuartzCore.h>

@interface SecondViewController_iPad ()

@end

@implementation SecondViewController_iPad


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.rightView.layer setCornerRadius:5];
    self.rightView.layer.masksToBounds = YES;
    self.rightView.layer.borderColor = [UIColor blackColor].CGColor;
    self.rightView.layer.borderWidth = 3.0f;

    [self.leftView1.layer setCornerRadius:5];
    self.leftView1.layer.masksToBounds = YES;
    self.leftView1.layer.borderColor = [UIColor blackColor].CGColor;
    self.leftView1.layer.borderWidth = 3.0f;
    
	// Do any additional setup after loading the view, typically from a nib.
    
    partnershipTypesGroupView = [[PartnershipTypeViewGroup alloc] initWithFrame:CGRectMake(0, 0, self.rightView.frame.size.width, self.rightView.frame.size.height) andPartners:nil andNaviBar:naviBar];
    
    [self.leftView1 addSubview:partnershipTypesGroupView];
    
    NSLog(@"width: %f", self.leftView1.frame.size.width);
    NSLog(@"height: %f", self.rightView.frame.size.height);
    
    [self.rightView addSubview:partnershipTypesGroupView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [ApplicationData sharedApplicationData].parentViewController = self;
    [ApplicationData sharedApplicationData].PartnershipTypeArrays = [[NSMutableArray alloc] init];
    
    
    //[table reloadData];
}*/


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
