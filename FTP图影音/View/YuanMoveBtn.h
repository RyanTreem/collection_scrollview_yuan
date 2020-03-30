//
//  YuanMoveBtn.h
//  FTP图影音
//
//  Created by 袁全 on 2020/3/9.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YuanMoveBtn;
NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, Yuan_BtnMove) {
    
    Yuan_BtnMoveBefore = 0,
    Yuan_BtnMoveEnd = 1
    
};




@protocol Yuan_MoveDelegate <NSObject>

/*
    param move 枚举 , 代表开始移动 还是 停止移动
    param btn 移动按钮的对象 , 通过它去获取frame , 并控制他回到原来的位置
 */

- (void) Yuan_MoveEndReLayoutViews:(Yuan_BtnMove)move
                            sender:(YuanMoveBtn *)btn;

@end



@interface YuanMoveBtn : UIButton


- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                      canMove:(BOOL)isCanMove;

/** delegate */
@property (nonatomic,weak) id <Yuan_MoveDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
