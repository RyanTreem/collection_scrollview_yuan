//
//  ChoosePickerView.h
//  关心手环
//
//  Created by Ryan on 16/7/18.
//  Copyright © 2016年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoosePickerViewDelegate <NSObject>

@optional
/**
 *  返回请求下来的关于大头针信息的数组
 *
 *  @param array AFN_Success_sign=1
 */
-(void)returnAnnotationMessageToControllerWithArray:(NSArray *)array;

-(void)haveTouchCancleBtn;

@end

@interface ChoosePickerView : UIView
/** 返回大头针信息的代理对象 */
@property (nonatomic,assign) id <ChoosePickerViewDelegate> delegate;

/** 当前Controller是否被释放 */
@property (nonatomic ,assign) BOOL isCrash;

/** manid */
@property (nonatomic,strong) NSString *manid;
-(void)manid:(NSString *)manid;
@end
