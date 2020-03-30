//
//  Yuan_HUD.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/27.
//  Copyright © 2020 袁全. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Yuan_HUD.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"



@implementation Yuan_HUD {
    
    MBProgressHUD * HUD;
    
    AppDelegate * delegate;
    
}



+ (Yuan_HUD *) shareInstance {
    
    static Yuan_HUD *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}


- (void) HUDFullText:(NSString *)text {
    
    
    HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow
                               animated:YES];
        
    HUD.label.text = text;
    
    //纯文本HUD枚举
    HUD.mode = MBProgressHUDModeText;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->HUD removeFromSuperview];
    });
}


- (void) HUDStartText:(NSString *)text {
    
    HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow
                               animated:YES];
        
    HUD.label.text = text;
    
    //纯文本HUD枚举
    HUD.mode = MBProgressHUDModeIndeterminate;
}


- (void) HUDHideText:(NSString *)text {
    
    HUD.mode = MBProgressHUDModeText ;
    
    HUD.label.text = text;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->HUD removeFromSuperview];
    });
    
}






@end
