//
//  SportsTrajectoryViewModel.h
//  关心手环
//
//  Created by Ryan on 16/7/15.
//  Copyright © 2016年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SportsTrajectoryViewModel : NSObject

/**
 *  初始化
 */
+(SportsTrajectoryViewModel *)shareInstance;

/**
 *  返回当前Picker应定位的year
 */
-(NSString *)yearSelectInitFromCurrentYear;

/**
 *  返回当前Picker应定位的month
 */
-(NSString *)monthSelectInitFromCurrentMonth;

/**
 *  返回当前Picker应定位的day
 */
-(NSString *)daySelectInitFromCurrentDay;

/**
 *  返回当前Picker应定位的time
 */
-(NSString *)timeSelectInitFromCurrentTime;


/**
 *  给年数组赋值
 *
 *  @return 复制后的数组
 */
-(NSMutableArray *)yearArray;

/**
 *  给月数组赋值
 *
 *  @return 复制后的数组
 */
-(NSMutableArray *)monthArray;

/**
 *  给日数组赋值
 *
 *  @return 复制后的数组
 */
-(NSMutableArray *)dayArray;

/**
 *  给时间数组赋值
 *
 *  @return 复制后的数组
 */
-(NSMutableArray *)timeArray;


//日期岁月份的改变而改变
-(NSMutableArray *)dayMutableFromYear:(NSInteger)year
                                Month:(NSInteger)monthRow
                             dayArray:(NSMutableArray *)dayArray;

/**
 *  通过开始时间导出结束时间
 *
 *  @param startDT 开始时间
 *
 *  @return 结束时间
 */
-(NSString *)returnEndDTArrayWithStarTime:(NSString *)startDT;


/**
 *  通过picker选择上的日期时间转为服务器要的字符串
 *
 *  @param year  年
 *  @param month 月
 *  @param day   日
 *  @param time  时间
 *
 *  @return 开始时间
 */
-(NSString *)returnPickerSelectedStringWithYear:(NSString *)year
                                          Month:(NSString *)month
                                            day:(NSString *)day
                                           time:(NSString *)time;

@end
