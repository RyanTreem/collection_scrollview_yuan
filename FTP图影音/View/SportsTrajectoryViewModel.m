//
//  SportsTrajectoryViewModel.m
//  关心手环
//
//  Created by Ryan on 16/7/15.
//  Copyright © 2016年 Ryan. All rights reserved.
//

#import "SportsTrajectoryViewModel.h"

@interface SportsTrajectoryViewModel ()
/** 截取time */
@property (nonatomic,strong) NSString *endHour;
/** 年 */
@property (nonatomic,strong) NSString *endYear;
/** 月 */
@property (nonatomic,strong) NSString *endMonth;
/** 日 */
@property (nonatomic,strong) NSString *endDay;


/** currentDate */
@property (nonatomic,strong) NSString *currentDate;
@end


@implementation SportsTrajectoryViewModel

+(SportsTrajectoryViewModel *)shareInstance{
    
    static SportsTrajectoryViewModel *shareViewModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareViewModel = [[self alloc] init];
    });
    return shareViewModel;
}

-(instancetype)init{
    if (self = [super init]) {
        NSDate * date = [NSDate date];
        _currentDate = [self currentDateFromYear_Month_DayToString:date];
    }
    return self;
}

/**
 *  返回当前Picker应定位的year
 */
-(NSString *)yearSelectInitFromCurrentYear{
    NSString * str;
    // 2016-07-21 17:15  16位
    str = [_currentDate substringToIndex:4];
    return str;
}

/**
 *  返回当前Picker应定位的month
 */
-(NSString *)monthSelectInitFromCurrentMonth{
    NSString * str;
    str = [_currentDate substringWithRange:NSMakeRange(5, 2)];
    return str;
}

/**
 *  返回当前Picker应定位的day
 */
-(NSString *)daySelectInitFromCurrentDay{
    NSString * str;
    str = [_currentDate substringWithRange:NSMakeRange(8, 2)];
    
    return str;
}

/**
 *  返回当前Picker应定位的time
 */
-(NSString *)timeSelectInitFromCurrentTime{
    NSString * str;
    str = [_currentDate substringWithRange:NSMakeRange(11, 2)];
    return str;
}


- (NSString * )currentDateFromYear_Month_DayToString:(NSDate *)date{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: date];
    return currentDateStr;
}





- (int )dateFromYear_Month_DayToString:(NSDate *)date{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *currentDateStr = [dateFormatter stringFromDate: date];
    return [currentDateStr intValue];
}

-(NSMutableArray *)yearArray{
    NSDate * date = [NSDate date];
    int  currentYear = [self dateFromYear_Month_DayToString:date];
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 1900; i< currentYear + 1; i++) {
        [arr addObject:[NSString stringWithFormat:@"%d年",i]];
    }
    return arr;
}

-(NSMutableArray *)monthArray{
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 1; i<13; i++) {
        [arr addObject:[NSString stringWithFormat:@"%.2d月",i]];
    }
    return arr;
}

-(NSMutableArray *)dayArray{
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 1; i<32; i++) {
        [arr addObject:[NSString stringWithFormat:@"%.2d日",i]];
    }
    return arr;
}

-(NSMutableArray *)timeArray{
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i<24; i++) {
        [arr addObject:[NSString stringWithFormat:@"%.2d:00",i]];
    }
    return arr;
}


-(NSMutableArray *)dayMutableFromYear:(NSInteger)year
                                Month:(NSInteger)monthRow
                             dayArray:(NSMutableArray *)dayArray{
    NSMutableArray * arr = [NSMutableArray arrayWithArray:dayArray];
    
    
    switch (monthRow) {
        case 1:
            if (year % 4 == 0) {
                [arr removeLastObject];
                [arr removeLastObject];
            }else{
                [arr removeLastObject];
                [arr removeLastObject];
                [arr removeLastObject];
            }
            break;
        case 3:
            [arr removeLastObject];
            break;
        case 5:
            [arr removeLastObject];
            break;
        case 8:
            [arr removeLastObject];
            break;
        case 10:
            [arr removeLastObject];
            break;
        default:
            break;
    }
    
    return arr;
}



-(NSString *)returnEndDTArrayWithStarTime:(NSString *)startDT{

    return [self returnPickerSelectedStringWithYear:_endYear Month:_endMonth day:_endDay time:_endHour];
}



-(NSString *)returnPickerSelectedStringWithYear:(NSString *)year
                                          Month:(NSString *)month
                                            day:(NSString *)day
                                           time:(NSString *)time{
    _endYear = year; _endMonth = month; _endDay = day;
    _endHour = [[time substringToIndex:[time length]-2] stringByAppendingString:@"59"];
    NSString * str = [NSString stringWithFormat:@"%@-%@-%@_%@",year,month,day,time];
    return str;

}



@end
