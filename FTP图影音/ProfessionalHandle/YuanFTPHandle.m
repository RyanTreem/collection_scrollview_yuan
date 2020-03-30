//
//  YuanFTPHandle.m
//  FTP图影音
//
//  Created by 袁全 on 2020/2/25.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//


#import "YuanFTPHandle.h"
#import "FTPManager.h"


@interface YuanFTPHandle () <FTPManagerDelegate>

/** IP地址 */
@property (nonatomic ,copy)  NSString *IPAddress;

/** 账号 */
@property (nonatomic ,copy)  NSString *account;

/** 密码 */
@property (nonatomic ,copy)  NSString *password;

/** 创建连接对象 */
@property (nonatomic,strong) FMServer *server;

/** 获取FTP操作类 */
@property (nonatomic,strong) FTPManager *manager;

@end


@implementation YuanFTPHandle




- (instancetype)initWithAddress:(NSString *)address
                           User:(NSString *)user
                       PassWord:(NSString *)password {
    
    self = [super init];
    if (self) {
        
        _server = [FMServer serverWithDestination:address username:user password:password];
        _server.port = 21;
        NSLog(@"tostring %@" , _server.description);
    }
    return self;
}


- (void) startUploadingWithData:(NSData *)data {
    
    
    // GCD做线程通信传值 , 长时间操作在子线程中操作 , 拿到值后回传给主线程使用.
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        self->_manager = [[FTPManager alloc] init];
        self->_manager.delegate = self;
        
        
        NSString * fileName = [NSString stringWithFormat:@"%d.png",arc4random() % 100000 + 10000];
        [self->_manager uploadData:data withFileName:fileName toServer:self->_server];
        
    });
    
}


- (void) releaseFTP {
    
    _server = nil;
    _manager = nil;
}




- (void)ftpManagerUploadProgressDidChange:(NSDictionary *)processInfo {
    
    
    NSLog(@"ftpManagerUploadProgressDidChange ---   %@" , processInfo);
    
    NSLog(@"走了回调方法了");
    
    
}

@end
