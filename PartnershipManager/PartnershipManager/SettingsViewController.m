//
//  SettingsViewController.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/31/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    [self.view setBackgroundColor:[UIColor colorWithRed:0.2 green:0.28 blue:0.9 alpha:1.0]];

    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(2,2,310.0, 460)] ;
    // desc.font = 12;
    desc.textColor = [UIColor whiteColor];
    desc.backgroundColor = [UIColor clearColor];
    desc.textAlignment =  NSTextAlignmentLeft;
    desc.numberOfLines = 20;
    desc.text = @"Links to Cell groups \r\nLinks to Departments(eg new first timers) \r\nSpace for CEC Manchester 1 News \r\nVideos for everyone to watch";
    
    //[self.view addSubview:desc];
 //   [self initializeNavigationBarWith:@"Space for more"];
  
    infoView = [[MoreInfoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andNaviBar:nil];
    
    [self.view addSubview:infoView];

}

/* Initializes navigation bar */
-(void) initializeNavigationBarWith:(NSString*)aTitle {
    UINavigationBar* naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    naviBar.barStyle = UIBarStyleBlack;
    
    UINavigationItem *navItem = [[[UINavigationItem alloc] initWithTitle:aTitle ] autorelease];
    
    navItem.leftBarButtonItem = nil;
    navItem.backBarButtonItem = nil;
    navItem.rightBarButtonItem = nil;
    [navItem setHidesBackButton:YES animated:NO];
    
    naviBar.items = [NSArray arrayWithObject:navItem];    
        
    [self.view addSubview:naviBar];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
