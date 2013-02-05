

#ifndef __LOGINSCREEN_H__
#define __LOGINSCREEN_H__

#import <UIKit/UIKit.h>
//#import "FirstViewController.h"
#import "BaseView.h"

@class LoginData;
@class BaseViewController;


/* Login screen to enter the URHOtv credentials */
@interface LoginScreen : BaseView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {

	UILabel *informationText;
	UITextField *userName;
	UITextField *password;
	NSString *userNameText;
	NSString *passWText;
    bool loginOK;
    
  //  WaitScreen *loginWaitScreen;
    
    BaseViewController * parentView ;
}

/* Property declarations */

@property (nonatomic, retain) UILabel *informationText;
@property (nonatomic, copy) NSString *userNameText;
@property (nonatomic, copy) NSString *passWText;
@property (nonatomic, retain) BaseViewController * parentView;

/* Method declarations */

- (id)initWithFrameLogin:(CGRect)frame parent:(BaseViewController*)aParentView sourceData:(LoginData*)loginData;
- (void)launchLoginWithUserName:(NSObject*)obj ;


/* UITableViewDataSource methods */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/* UITableViewDelegate methods */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/* UITextFieldDelegate methods */

- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end

#endif