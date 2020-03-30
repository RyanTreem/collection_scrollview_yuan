//
//  UserInformation.h
//  FTP图影音
//
//  Created by 袁全 on 2020/2/20.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInformation : NSObject


/*
 *  获取设备名称
 */
+ (NSString *) getDeviceName;


/*
    获取设备型号  6s plus
 */
+ (NSString *) getDeviceType;


/*
 *  获取设备地方型号
 */
+ (NSString *) getLocalizedModel;


/*
 *  获取系统版本号
 */
+ (NSString *) getSystemVersion;


/*
 *  获取设备UUID
 */
+ (NSString *) getUUID;


/*
 *  获取设备MAC地址
 */
+ (NSString *) getMacAddress;


/*
 *  获取本机号码
 */
+ (NSString *) getPhoneNumber;



@end


NS_ASSUME_NONNULL_END
