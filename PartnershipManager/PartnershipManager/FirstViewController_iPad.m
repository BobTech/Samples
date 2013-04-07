//
//  FirstViewController_iPad.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 2/5/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import "FirstViewController_iPad.h"
#import "ApplicationData.h"
#import "Strings.h"
#import <QuartzCore/QuartzCore.h>


@interface FirstViewController_iPad ()

@end

@implementation FirstViewController_iPad

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
    
    if ([[ApplicationData sharedApplicationData] checkIsNetworkAvailable]) {
        [self showLoginView];
    }else
        [self dismissViewControllerAnimated:NO completion:nil];

}

- (void)loginCompleted
{
    [super loginCompleted];
    
    [self initializeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_leftView release];
    [_rightView release];
    [super dealloc];
}

- (void)initializeView {
    [self.rightView.layer setCornerRadius:5];
    self.rightView.layer.masksToBounds = YES;
    self.rightView.layer.borderColor = [UIColor blackColor].CGColor;
    self.rightView.layer.borderWidth = 3.0f;
    
    [self.leftView.layer setCornerRadius:5];
    self.leftView.layer.masksToBounds = YES;
    self.leftView.layer.borderColor = [UIColor blackColor].CGColor;
    self.leftView.layer.borderWidth = 3.0f;

    
    self.view.backgroundColor = [UIColor blackColor];
    
    [ApplicationData sharedApplicationData].parentViewController = self;
    [ApplicationData sharedApplicationData].PartnershipTypeArrays = [[NSMutableArray alloc] init];
    [ApplicationData sharedApplicationData].appData = [[AppDataManager alloc] init] ;
    
    [[ApplicationData sharedApplicationData] fetchPartnershipData];
    [[ApplicationData sharedApplicationData].appData setupData];
    
    [self showMembersListView];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
  //  [ApplicationData sharedApplicationData].parentViewController = (BaseViewController*)self;
    
}

- (void)showMembersListView {
    
    membersView = nil;
    [membersView release];
    membersView = [[MembersListView_iPad alloc] initWithFrame:CGRectMake(0, 0, self.leftView.frame.size.width, self.leftView.frame.size.height) andNaviBar:naviBar andApplicationData:[ApplicationData sharedApplicationData].appData ] ;
    
    [self.leftView addSubview:membersView];
    
    detailsView = nil;
    [detailsView release];
    detailsView = [[MemberDetailsView_iPad alloc] initWithFrame:CGRectMake(0, 0, self.rightView.frame.size.width, self.rightView.frame.size.height) andSubAreaData:nil andNaviBar:naviBar] ;
    
    [self.rightView addSubview:detailsView];
    
    [membersView selectFirstItem];
    
}


- (void)gotoMembersDetailsView:(PersonData*)aData {
    [detailsView setPersonsData:aData];

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
