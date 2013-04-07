//
//  AppDelegate.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/3/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemInitManager.h"
#import "LoginScreen.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
	SystemInitManager * initManager;
    
    LoginScreen* loginScren;

    //UIWindow *window;
}


@property (strong, nonatomic) UIWindow *window;


@end
