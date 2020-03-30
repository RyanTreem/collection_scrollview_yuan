//
//  AppDelegate.m
//  FTP图影音
//
//  Created by 袁全 on 2020/2/19.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseController.h"
#import "ChooseController.h"

#import "Yuan_Nav.h"
@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"appdelegate");
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    BaseController * base = [[BaseController alloc] init];
    
    Yuan_Nav * nav = [[Yuan_Nav alloc] initWithRootViewController:base];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}



- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {

    
    if (_allowRotate) {
        // 允许向右切换横屏
        return UIInterfaceOrientationMaskAll;
    } else {
        
        // 关闭横屏
        return UIInterfaceOrientationMaskPortrait;
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
    
    Yuan_Nav * nav = (Yuan_Nav *)application.keyWindow.rootViewController;
    
    NSLog(@"%@ --- applicationWillEnterForeground",nav.viewControllers);
    
    NSArray<UIViewController *> * array = nav.viewControllers;
    
    UIViewController * vc = [array lastObject];
    
    NSString * class = NSStringFromClass(vc.class);
    
    AppDelegate * delegate = (AppDelegate *)application.delegate;
    
    
    
    if ([class isEqualToString:@"Yuan_ScrollForCollection"]) {
            
        delegate.allowRotate = YES;
        
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
        
    }else {
        
        delegate.allowRotate = NO;
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationPortrait] forKey:@"orientation"];
    }
    
}




- (UIViewController *)parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
