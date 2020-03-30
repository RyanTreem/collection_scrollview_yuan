//
//  ScaningView.h
//  扫一扫
//
//  Created by 袁全 on 2020/2/20.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScaningView : UIView
- (instancetype)initWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideViewLayer;




/** 移除定时器(切记：一定要在Controller视图消失的时候，停止定时器) */
- (void)removeTimer;

@end

NS_ASSUME_NONNULL_END
