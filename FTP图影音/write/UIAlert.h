//
//  UIAlert.h
//  守望者
//
//  Created by Ryan on 17/3/15.
//  Copyright © 2017年 Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIAlert : NSObject


/* 警示框文字提示 , 点击后即关闭 */
+ (void) alertSmallTitle:(NSString *)title;
/* 警示框文字提示 , 需要实现我知道了的block回调 */
+ (void) alertSmallTitle:(NSString *)title
           agreeBtnBlock:(void(^)(UIAlertAction *action))block ;






+ (void)showOkayCancelAlertClassHome:(id)classHome
                               title:(NSString *)title
                             message:(NSString *)message
                      cancelBtnTitle:(NSString *)cancelTitle
                 DEPRECATED_MSG_ATTRIBUTE("已弃用的方法 , 依然可以但不建议使用");






+ (void)showAlertClassHome:(id)classHome title:(NSString *)title
             agreeBtnBlock:(void(^)(UIAlertAction *action))block
             agreeBtnTitle:(NSString *)agreeTitle       DEPRECATED_MSG_ATTRIBUTE("已弃用的方法 , 依然可以但不建议使用");

@end
