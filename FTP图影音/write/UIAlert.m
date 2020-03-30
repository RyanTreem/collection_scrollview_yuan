//
//  UIAlert.m
//  守望者
//
//  Created by Ryan on 17/3/15.
//  Copyright © 2017年 Yuan. All rights reserved.
//

#import "UIAlert.h"
#import <UIKit/UIKit.h>



@implementation UIAlert


+ (void) alertSmallTitle:(NSString *)title {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}



+ (void) alertSmallTitle:(NSString *)title
           agreeBtnBlock:(void(^)(UIAlertAction *action))block  {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.
    UIAlertAction *IKnowAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // 把点击事件回调给调用的界面
        if (block) {
            block(action);
        }
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //什么也不做
    }];
    
    
    // Add the actions.
    [alertController addAction:IKnowAction];
    [alertController addAction:cancelAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    
    
    
}




+ (void)showOkayCancelAlertClassHome:(id)classHome title:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    
    

    // Add the actions.
    [alertController addAction:cancelAction];
    
    
    
    [classHome presentViewController:alertController animated:YES completion:nil];
}



+ (void)showAlertClassHome:(id)classHome title:(NSString *)title
             agreeBtnBlock:(void(^)(UIAlertAction *action))block
             agreeBtnTitle:(NSString *)agreeTitle {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.
    UIAlertAction *agreeAction = [UIAlertAction actionWithTitle:agreeTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        block(action);
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];


    [alertController addAction:agreeAction];
    [alertController addAction:cancelAction];
    [classHome presentViewController:alertController animated:YES completion:nil];
    
    
    
}






@end
