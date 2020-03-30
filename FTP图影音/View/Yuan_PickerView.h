//
//  Yuan_PickerView.h
//  FTP图影音
//
//  Created by 袁全 on 2020/3/18.
//  Copyright © 2020 袁全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface Yuan_PickerView : UIView


/*
 *  获取picker当前选中的时间  格式 : YYYY-mm-DD HH:MM
 */

@property (nonatomic ,copy) void(^selectDateTimestampBlock)(NSString * year,
                                                            NSString * month,
                                                            NSString * day,
                                                            NSString * hour,
                                                            NSString * minute);


@end

NS_ASSUME_NONNULL_END
