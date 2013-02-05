

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BaseView.h"
#import "TableViewCellCreator.h"
#import "DarkenerScreen.h"
#import "UserDataManager.h"
#import "LoginData.h"
#import "LoginScreen.h"
//#import "WaitScreen.h"
#import "LoginManager.h"
#import "Strings.h"
#import "ModelConstants.h"
#import "BaseViewController.h"

enum {
	kUsername = 1000,
	kPassword,
	kDarkener
};

@implementation LoginScreen

@synthesize informationText;
@synthesize userNameText;
@synthesize passWText;
@synthesize parentView;

/* Constructor */
- (id)initWithFrameLogin:(CGRect)frame parent:(BaseViewController*)aParentView sourceData:(LoginData*)loginData {
		
    if ((self = [super initWithFrame:frame andNaviBar:nil])) {
        
        CGRect realFrame = frame;
        realFrame.origin.x = 0;
        realFrame.origin.y = 0;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
          /*  realFrame.origin.x = 100;
            realFrame.origin.y = 100;
            realFrame.size = self.center;*/
            realFrame.size.width = 360;
            realFrame.size.height = 520;
        }

        
		UserDataManager *dataManager = [UserDataManager instance];
		self.userNameText = [dataManager getValueForKey:kUserNameField];
		self.passWText = [dataManager getValueForKey:kPasswordField];
		
		self.title = loginData.headerText;		
		self.parentView = aParentView;
		
		CAGradientLayer *gradient = [CAGradientLayer layer];
		gradient.frame = self.bounds;						
		
	/*	gradient.colors = [NSArray arrayWithObjects:
						   (id)[[[LAFManager instance] backgroundGradientStart] CGColor], 
						   (id)[[[LAFManager instance] backgroundGradientEnd] CGColor], 
						   nil]; */
		
		[self.layer insertSublayer:gradient atIndex:0];
		
		informationText = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,100)];
		informationText.backgroundColor = [UIColor clearColor];
		informationText.textAlignment = NSTextAlignmentCenter;
		informationText.text = kLoginScreenInfoText;
		informationText.numberOfLines = 6;
			
        self.backgroundColor = [UIColor blackColor];
		tableView = [[UITableView alloc] initWithFrame:realFrame style:UITableViewStyleGrouped];
        tableView.center = self.center;
		tableView.delegate = self;
		tableView.dataSource = self;
		tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
		tableView.backgroundColor = [UIColor clearColor];
		tableView.sectionFooterHeight = 10;
		tableView.sectionHeaderHeight = 10;
		tableView.tableHeaderView = informationText;
		[self addSubview:tableView];
        
        title = @"Login";

    }
    return self;
}

/* Destructor *
- (void)dealloc {
	[informationText release];
	[userNameText release];
	[passWText release];
    
    [loginWaitScreen removeFromSuperview];
    [loginWaitScreen release];
    loginWaitScreen = nil;
	
    [super dealloc];
}

* Two sections, one for entering data and the other one for login it in */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

/* Returns the row count per section */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) { return 1; }
    else if (section == 1) { return 2; }
	else if (section == 2) { return 1; }
	else { return 0; }
}

/* No title */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"";
	
}

/* Creates the table view cells */
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
		return [TableViewCellCreator createTableViewCellButton2:@"Go to Sign up Page" table:tableView];
	}
    else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			UITableViewCell *cell = [TableViewCellCreator createTableViewCellWithInputField:kLoginUserName fieldDefault:kLoginUserNameNeeded fieldText:userNameText table:tableView delle:self textfieldId:kUsername secure:NO];
			userName = (UITextField*)[cell.contentView viewWithTag:kUsername];
           // userName.text = [[UserDataManager instance] getValueForKey:kUserNameField];
            userName.text = @"Bob5";
			return cell;
		} else if (indexPath.row == 1) {
			UITableViewCell* cell = [TableViewCellCreator createTableViewCellWithInputField:kLoginPassword fieldDefault:kLoginPasswordNeeded fieldText:passWText table:tableView delle:self textfieldId:kPassword secure:YES];
			password = (UITextField*)[cell.contentView viewWithTag:kPassword];
            password.text = @"5555";
			return cell;
		}
	} else if (indexPath.section == 2) {
		return [TableViewCellCreator createTableViewCellButton:kLoginButton table:tableView];
	} 
	
	return nil;
}

/* UITableViewDelegate methods */

/* Set table view cell height */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//	return kSmallListCellHeight;
    return 40.0;
}

/* Background color */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	//cell.backgroundColor = [[LAFManager instance] listViewContentBackground];
}

- (void)loginCompleted {
   // [loginWaitScreen removeFromSuperview];
    //[loginWaitScreen release];
   // loginWaitScreen = nil;
    
    //if login is successfull save username and password locally
    if (loginOK) {
        [[UserDataManager instance] insertDataWithKey:kUserNameField obj:userNameText];
        [[UserDataManager instance] insertDataWithKey:kPasswordField obj:passWText];

        [[UserDataManager instance] commit];
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:kLoginSuccessDialogHeader message:kLoginSuccessDialogText delegate:nil cancelButtonTitle:kLoginSuccessDialogButtonText otherButtonTitles:nil];
		[alertView show];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) //iPad
        {
             [self removeFromSuperview];
        }
        else//iphone
        {
             [super dismissSubview:nil];

        }

      //  [super dismissSubview:nil];
        [self removeFromSuperview];
        [parentView enableTabbar];
        [parentView showMembersListView];
        
    } else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:kLoginFailedDialogHeader message:kLoginFailedDialogText delegate:nil cancelButtonTitle:kLoginFailedDialogButtonText otherButtonTitles:nil];
		[alertView show];
    }
}


- (void)launchLogin:(NSObject*)obj {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    LoginManager *loginMgr = [[LoginManager alloc] init];
    
    self.userNameText = userName.text;
    self.passWText = password.text;

    
    DebugLog(@"Username: %@ Password: %@", userNameText, passWText);

    loginOK = [loginMgr signInToServiceWithUsername:userNameText andPassword:passWText];
    
    //[loginMgr release];
    loginMgr = nil;   
    
    [self performSelectorOnMainThread:@selector(loginCompleted) withObject:nil waitUntilDone:YES];
    
    [pool release];
}
- (void)launchLoginWithUserName:(NSObject*)obj {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    LoginManager *loginMgr = [[LoginManager alloc] init]; 
    
    
    DebugLog(@"launchLoginWithUserName Username: %@ Password: %@", userNameText, passWText);
    
    loginOK = [loginMgr signInToServiceWithUsername:userNameText andPassword:passWText];
    
    [loginMgr release];
    loginMgr = nil;   
    
    [self performSelectorOnMainThread:@selector(loginCompleted) withObject:nil waitUntilDone:YES];
    
    [pool release];
}


/* Row selection management */
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {		
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.section == 0) {
        NSURL *url = [[[NSURL alloc] initWithString:@""] autorelease];
        [super createNewSubView:url];
    }else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			[userName becomeFirstResponder];
		} else if (indexPath.row == 1) {
			[password becomeFirstResponder];
		}
	} else if (indexPath.section == 2) {
	/*	loginWaitScreen = [[WaitScreen alloc] initWithFrame:self.frame transparency:0.7 text:kLoginWaitForSuccess];
        [self addSubview:loginWaitScreen];
        [NSThread detachNewThreadSelector:@selector(launchLogin:) toTarget:self withObject:self];		*/
        [self launchLogin:self];
    }	
}

/* UITextFieldDelegate methods */

/* Called when the text field editing starts, adds screen darkener */
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	DarkenerScreen* view = [[DarkenerScreen alloc] initWithFrame:self.frame fieldDel:self textF:textField];
	view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
	view.tag = kDarkener;
	[self addSubview:view];
	[view release];
}

/* Called when the editing mode is dismissed */
- (void)textFieldDidEndEditing:(UITextField *)textField {
	UIView* view = [self viewWithTag:kDarkener];
	[view removeFromSuperview];	
}

/* Stores the password */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if (textField.tag == kUsername) {
		self.userNameText = textField.text;
	} else if (textField.tag == kPassword) {
		self.passWText = textField.text;
	}
	
	[textField resignFirstResponder];
	
    return YES;
}


@end
