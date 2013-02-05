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
@synthesize subViews;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UINavigationBar* naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    naviBar.barStyle = UIBarStyleBlack;
	// Do any additional setup after loading the view, typically from a nib.
 
    partnershipTypesGroupView = [[PartnershipTypeViewGroup alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andPartners:nil andNaviBar:naviBar];

    //   [self aboutToDisappear];
   // v.center = CGPointMake(self.center.x + self.frame.size.width, v.center.y);
  
    subViews = [[NSMutableArray alloc] init];

    [self.view addSubview:partnershipTypesGroupView];

}

- (void)disableTabbar {
    
    for(UITabBarItem *item in self.tabBarController.tabBar.items)
        item.enabled = false;
}

- (void)enableTabbar {
    
    for(UITabBarItem *item in self.tabBarController.tabBar.items)
        item.enabled = true;
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [ApplicationData sharedApplicationData].parentViewController = (FirstViewController*)self;
   // [ApplicationData sharedApplicationData].subViews = [[NSMutableArray alloc] init];
    [ApplicationData sharedApplicationData].PartnershipTypeArrays = [[NSMutableArray alloc] init];
    
    
    //[table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Show Mail/SMS picker

-(void)showMailPicker:(NSMutableArray*)aPersons{
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later.
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
	if (mailClass != nil) {
        //[self displayMailComposerSheet];
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]) {
			[self displayMailComposerSheet:aPersons];
		}
		else {
			//feedbackMsg.hidden = NO;
			//feedbackMsg.text = @"Device not configured to send mail.";
		}
	}
	else	{
		//feedbackMsg.hidden = NO;
		//feedbackMsg.text = @"Device not configured to send mail.";
	}
}


-(void)showSMSPicker:(NSMutableArray*)aPersons {
    //	The MFMessageComposeViewController class is only available in iPhone OS 4.0 or later.
    //	So, we must verify the existence of the above class and log an error message for devices
    //		running earlier versions of the iPhone OS. Set feedbackMsg if device doesn't support
    //		MFMessageComposeViewController API.
	Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
	
	if (messageClass != nil) {
		// Check whether the current device is configured for sending SMS messages
		if ([messageClass canSendText]) {
			[self displaySMSComposerSheet:aPersons];
		}
		else {
			//feedbackMsg.hidden = NO;
			//feedbackMsg.text = @"Device not configured to send SMS.";
            
		}
	}
	else {
		//feedbackMsg.hidden = NO;
		//feedbackMsg.text = @"Device not configured to send SMS.";
	}
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


#pragma mark -
#pragma mark Dismiss Mail/SMS view controller

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the
// message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
	//feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//feedbackMsg.text = @"Result: Mail sending canceled";
			break;
		case MFMailComposeResultSaved:
			//feedbackMsg.text = @"Result: Mail saved";
			break;
		case MFMailComposeResultSent:
			//feedbackMsg.text = @"Result: Mail sent";
			break;
		case MFMailComposeResultFailed:
			//feedbackMsg.text = @"Result: Mail sending failed";
			break;
		default:
			//feedbackMsg.text = @"Result: Mail not sent";
			break;
	}
	//[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}


// Dismisses the message composition interface when users tap Cancel or Send. Proceeds to update the
// feedback message field with the result of the operation.
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
	
    //	feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MessageComposeResultCancelled:
			//feedbackMsg.text = @"Result: SMS sending canceled";
			break;
		case MessageComposeResultSent:
			//feedbackMsg.text = @"Result: SMS sent";
			break;
		case MessageComposeResultFailed:
			//feedbackMsg.text = @"Result: SMS sending failed";
			break;
		default:
			//feedbackMsg.text = @"Result: SMS not sent";
			break;
	}
	//[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

@end
