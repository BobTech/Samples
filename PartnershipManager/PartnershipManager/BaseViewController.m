//
//  BaseViewController.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 2/5/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import "BaseViewController.h"
#import "ApplicationData.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize subViews;


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
    self.subViews = [[NSMutableArray alloc] init];

    naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    naviBar.barStyle = UIBarStyleBlack;
        
}

- (void)showLoginView {
    [self disableTabbar];

    loginScren = nil;
    [loginScren release];
    loginScren = [[LoginScreen alloc] initWithFrameLogin:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) parent:self sourceData:nil];
    
    [self.view addSubview:loginScren];
    
    [[ApplicationData sharedApplicationData].parentViewController.subViews addObject:loginScren];
    // [self.subViews addObject:loginScren];
    
}

- (void)loginCompleted
{
    [self enableTabbar];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)disableTabbar {
    
    for(UITabBarItem *item in self.tabBarController.tabBar.items)
        item.enabled = false;
}

- (void)enableTabbar {
    
    for(UITabBarItem *item in self.tabBarController.tabBar.items)
        item.enabled = true;
}

#pragma mark -
#pragma mark Show Mail/SMS picker

-(void)showMailPicker:(NSMutableArray*)aPersons{
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later.
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
	if (mailClass != nil) {
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]) {
			[self displayMailComposerSheet:aPersons];
		}
		else {
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
