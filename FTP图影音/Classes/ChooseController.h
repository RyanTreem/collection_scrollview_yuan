//
//  ChooseController.h
//  FTP图影音
//
//  Created by 袁全 on 2020/2/19.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GetType) {
    GetTypePhoto = 0,   //图片
    GetTypeVideo = 1,   //视频
    GetTypeAudio = 2    //音频
};


@interface ChooseController : UIViewController

- ( instancetype ) initWithGetType:(GetType)type;

@end

NS_ASSUME_NONNULL_END
