//
//  YuanFTPHandle.h
//  FTP图影音
//
//  Created by 袁全 on 2020/2/25.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuanFTPHandle : NSObject

- (instancetype)initWithAddress:(NSString *)address
                           User:(NSString *)user
                       PassWord:(NSString *)password;



/*
    根据data上传文件
 */
- (void) startUploadingWithData:(NSData *)data ;

@end

NS_ASSUME_NONNULL_END
