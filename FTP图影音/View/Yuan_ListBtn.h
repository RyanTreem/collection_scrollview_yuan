//
//  Yuan_ListBtn.h
//  FTP图影音
//
//  Created by 袁全 on 2020/3/9.
//  Copyright © 2020 袁全. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Yuan_ListBtn;
NS_ASSUME_NONNULL_BEGIN


@protocol Yuan_ListBtnMoveDelegate <NSObject>

- (void) Yuan_ListBtn:(Yuan_ListBtn*)btn
                 Move:(CGPoint)point;

@end

@interface Yuan_ListBtn : UIButton

/** <#注释#> */
@property (nonatomic,weak) id <Yuan_ListBtnMoveDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
