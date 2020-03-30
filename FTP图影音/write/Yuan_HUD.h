//
//  Yuan_HUD.h
//  FTP图影音
//
//  Created by 袁全 on 2020/3/27.
//  Copyright © 2020 袁全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Yuan_HUD : NSObject



+ (Yuan_HUD *) shareInstance;

/* 仅文字展现时使用 , 持续2秒 */
- (void) HUDFullText:(NSString *)text;

/* 在请求或其他延时回调开始时调用 , 并没有自动结束功能 */
- (void) HUDStartText:(NSString *)text;

/* 为延时回调结束时调用 , 菊花转文字 , 两秒后消失 */
- (void) HUDHideText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
