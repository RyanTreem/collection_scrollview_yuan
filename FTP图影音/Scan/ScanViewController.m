//
//  ScanViewController.m
//  扫一扫
//
//  Created by 袁全 on 2020/2/20.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "ScanViewController.h"

#import <AVFoundation/AVFoundation.h>   // 摄像头
#import "ScaningView.h"   //扫一扫View

#import "UIAlert.h"   //扫一扫View


#define UserDefaultSet(K,V) [[NSUserDefaults standardUserDefaults] setObject:K forKey:V];[[NSUserDefaults standardUserDefaults] synchronize];

@interface ScanViewController ()
<AVCaptureMetadataOutputObjectsDelegate>

/** 会话对象 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 图层类 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) ScaningView *scanningView;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationItem.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建扫描边框
    self.scanningView = [[ScaningView alloc] initWithFrame:self.view.frame outsideViewLayer:self.view.layer];
    
    [self.view addSubview:self.scanningView];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 二维码扫描
    [self setupScanningQRCode];
}


// 移除定时器
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [self.scanningView removeTimer];
    
}


#pragma mark - - - 二维码扫描
- (void)setupScanningQRCode {
    
    
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、 创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    output.rectOfInterest = CGRectMake(0.15, 0.24, 0.7, 0.52);
    
    // 5、 初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 5.1 添加会话输入
    [_session addInput:input];
    
    // 5.2 添加会话输出
    [_session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 会频繁的扫描，调用代理方法
    // 1. 如果扫描完成，停止会话
    [self.session stopRunning];
    // 2. 删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    // 3. 设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
    
        // 根据字符串判断 如果以 GUID:开头 和 :DZ结尾 则表示扫描了正确的二维码
        
        if ([obj.stringValue hasPrefix:@"GUID:"] && [obj.stringValue hasSuffix:@":DZ"]) {
            
            // 扫描成功了 , 开始做字符串处理
            /*
             *  1. 去掉 GUID: 和 :DZ 两个前后字符串
             *  2. 使用# 分隔字符串变为数组
             *  param0  "1b5ed243935bc48e79c94828252dafb6a"  关联用的ID
             *  param1 和 param2 暂时不用
             *  param3 ftp的IP地址
             *  param4和param5 是ftp的账户密码
             */
            
            // 去掉 开头结尾
            NSString * valueString = [[obj.stringValue stringByReplacingOccurrencesOfString:@"GUID:" withString:@""] stringByReplacingOccurrencesOfString:@":DZ" withString:@""];
            
            NSArray * array =  [valueString componentsSeparatedByString:@"#"];
            
            
            @try {
                
                //取出关联ID
                //NSString * ID = array[0];  暂时没用
                
                //取出IP地址
                NSString * IPAdd = array[3];
                
                //取出账号密码
                NSString * account = array[4];
                NSString * password = array[5];
                
                // 扫描成功 返回上一层控制器
                
                if ([self.delegate respondsToSelector:@selector(scanWithResultDictionary:)]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    [self.delegate scanWithResultDictionary:@{@"address": IPAdd,
                                                              @"account": account,
                                                              @"password": password
                                                              }];
                }
                
                
            } @catch (NSException *exception) {
                
                [UIAlert showAlertClassHome:self title:[NSString stringWithFormat:@"异常-%@",exception.reason] agreeBtnBlock:^(UIAlertAction *action) {
                    [self.session startRunning];  //点击确认后重新扫码
                } agreeBtnTitle:@"重新扫描"];
            }
            
            
            
            
        } else {
            
            // 判断二维码中的字符串 , 如果检测到不是公司二维码 , 则弹出提示 , 重新扫码
            
            [UIAlert showAlertClassHome:self title:@"请扫描正确的二维码" agreeBtnBlock:^(UIAlertAction *action) {
                
            } agreeBtnTitle:@"好"];
        }
    }
}

/*
 GUID:1b5ed243935bc48e79c94828252dafb6a#racehotspot#123456789#192.168.110.35#raceftp#race@2019.:DZ
 
 */


@end
