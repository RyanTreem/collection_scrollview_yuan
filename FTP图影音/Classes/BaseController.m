//
//  BaseController.m
//  FTP图影音
//
//  Created by 袁全 on 2020/2/19.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "BaseController.h"

#import "ChooseController.h"   //选择图片和视频
#import "ScanViewController.h" //进入 扫一扫功能
#import "AppDelegate.h"

#import "NSObject+Yuan_Vessel.h"

#import "Yuan_ScrollForCollection.h"

#import "Yuan_PickerController.h"

#import "Yuan_Array.h"

#import "Yuan_A.h"

#import "Yuan_B.h"

#import "Yuan_C.h"

#import "PCH_Header.h"

#import "MBProgressHUD.h"

@interface BaseController ()

<
ScanDelegate

>

{
    
    MBProgressHUD * HUD;
}


/** 上传图片 */
@property (nonatomic,strong) UIButton * upDataImage;

/** 上传视频 */
@property (nonatomic,strong) UIButton * upDataAudio;

/**  */
@property (nonatomic,strong) UIButton *scan;

/** IP地址 */
@property (nonatomic ,copy)  NSString *address;

/** ftp账号 */
@property (nonatomic ,copy)  NSString *account;

/** ftp密码 */
@property (nonatomic ,copy)  NSString *password;


/** <#注释#> */
@property (nonatomic,strong) Yuan_A *VC_A;

/** <#注释#> */
@property (nonatomic,strong) Yuan_B *VC_B;

/** <#注释#> */
@property (nonatomic,strong) Yuan_C *VC_C;

/** <#注释#> */
@property (nonatomic,strong) UIViewController *Yuan_CurrentController;

@end

@implementation BaseController




-(Yuan_A *)VC_A {
    
    if (!_VC_A) {
        _VC_A = [[Yuan_A alloc] init];
        _VC_A.view.frame = CGRectMake(0, 88 + 100, SCREENWIDTH, SCREENHEIGHT - (88 + 100));
        
        _VC_A.block = ^(id _Nonnull vc) {
//            [wself replaceController:vc newController:wself.VC_B];
            
        };
    }
    return _VC_A;
}




- (Yuan_B *)VC_B {
    
    if (!_VC_B) {
        _VC_B = [[Yuan_B alloc] init];
        _VC_B.view.frame = CGRectMake(0, 88 + 100, SCREENWIDTH, SCREENHEIGHT - (88 + 100));
        
        _VC_B.block = ^(id _Nonnull vc) {
             
//            [wself replaceController:vc newController:wself.VC_C];
        };
    }
    return _VC_B;
}


- (Yuan_C *)VC_C {
    
    if (!_VC_C) {
        _VC_C = [[Yuan_C alloc] init];
        _VC_C.view.frame = CGRectMake(0, 88 + 100, SCREENWIDTH, SCREENHEIGHT - (88 + 100));
        
        _VC_A.block = ^(id _Nonnull vc) {
            
//            [wself replaceController:vc newController:wself.VC_A];
        };
    }
    return _VC_C;
}





- (UIButton *)upDataImage {
    
    if (!_upDataImage) {
        
        _upDataImage = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/2, SCREENWIDTH/5)];
        
        _upDataImage.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/3);
        
        _upDataImage.layer.cornerRadius = 10;
        
        _upDataImage.layer.masksToBounds = YES;
        
        _upDataImage.backgroundColor = [UIColor whiteColor];
        
        [_upDataImage setTitle:@"点击上传图片" forState:UIControlStateNormal];
        
        [_upDataImage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_upDataImage addTarget:self action:@selector(getImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upDataImage;
}


- (UIButton *)upDataAudio {
    
    if (!_upDataAudio) {
        
        _upDataAudio = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/2, SCREENWIDTH/5)];
        
        _upDataAudio.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
        
        _upDataAudio.layer.cornerRadius = 10;
        
        _upDataAudio.layer.masksToBounds = YES;
        
        _upDataAudio.backgroundColor = [UIColor whiteColor];
        
        [_upDataAudio setTitle:@"点击上传视频" forState:UIControlStateNormal];
        
        [_upDataAudio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_upDataAudio addTarget:self action:@selector(getVideo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upDataAudio;
}


- (UIButton *)scan {
    
    if (!_scan) {
        
        _scan = [UIButton buttonWithType:UIButtonTypeCustom];
        _scan.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_scan setTitle:@"扫一扫" forState:UIControlStateNormal];
        _scan.titleLabel.font = [UIFont systemFontOfSize:(14)];
        [_scan setFrame:CGRectMake(0, 0, (44), (44))];
        [_scan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_scan addTarget:self action:@selector(scanClick) forControlEvents:UIControlEventTouchUpInside];
        _scan.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _scan;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        // 192.168.110.35#raceftp#race@2019.
        
        _address = @"192.168.110.35";
        _account = @"raceftp";
        _password = @"race@2019.";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initFTP];
    
//    [self initChildControllers];
//
//    [self threeBtns];
//
//    NSArray * array = @[@"1",@"2",@"3",@"4",@"5",@"6",];
//
//    NSMutableArray * mtArr = [NSMutableArray array];
//
//    for (int i = 0; i < 10 ; i++) {
//        [mtArr addObject:[NSString stringWithFormat:@"%d",i]];
//    }
//
//
//
//    NSString * a = [array objectAtIndex:12];
//
//    NSString * mta = [mtArr objectAtIndex:120];
//
//    NSDictionary * dict = @{@"abc":@"123"};
//
//    NSString * b = dict[@"abcfe"];
//
////    NSLog(@"datawitharray -- %@" , dataWithArray[300]);
//    NSLog(@"a -- %@  b -- %@" , a , b);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
//
//    /*
//
//     typedef NS_ENUM(NSInteger, UIModalPresentationStyle) {
//         UIModalPresentationFullScreen = 0,
//         UIModalPresentationPageSheet
//         UIModalPresentationFormSheet
//         UIModalPresentationCurrentContext
//         UIModalPresentationCustom
//         UIModalPresentationOverFullScreen
//         UIModalPresentationOverCurrentContext
//         UIModalPresentationPopover
//         UIModalPresentationBlurOverFullScreen
//         UIModalPresentationNone
//         UIModalPresentationAutomatic
//     };
//
//
//     */
//
//
//
//    Yuan_A * a = [[Yuan_A alloc] init];
//
//    a.modalPresentationStyle =  UIModalPresentationPageSheet;
//
//    [self presentViewController:a animated:YES completion:nil];
//
    
    
//    [[Yuan_HUD shareInstance] HUDStartText:@"开始了哦"];

    
    Yuan_A * A = [[Yuan_A alloc] init];
    
    [self.navigationController pushViewController:A animated:YES];
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
//    [[Yuan_HUD shareInstance] HUDHideText:@"很遗憾 , 你把我释放了"];
    
    
}


- (void) threeBtns {
    
    
    for (int i = 0; i < 3; i++) {
        UIButton * btn = [UIView buttonWithTitle:[NSString stringWithFormat:@"%d",i] responder:self SEL:@selector(btnClick:) frame:CGRectMake(i * 100 + 50, 100, 70, 40)];
        
        btn.tag = 1000 + i;
        
        [btn setBackgroundColor:[UIColor orangeColor]];
        
        [self.view addSubview:btn];
    }
    
    
}


- (void) btnClick:(UIButton *)btn {
    
    switch (btn.tag) {
        case 1000:  //A
            [self replaceController:_Yuan_CurrentController newController:_VC_A];
            break;
        case 1001:  //B
            [self replaceController:_Yuan_CurrentController newController:_VC_B];
            break;
        case 1002:  //C
            [self replaceController:_Yuan_CurrentController newController:_VC_C];
            break;
            
        default:
            break;
    }
    
    
}


- (void) initChildControllers {
    
    [self addChildViewController:self.VC_A];
    [self addChildViewController:self.VC_B];
    [self addChildViewController:self.VC_C];
    
    [self.view addSubview:_VC_A.view];
    
    self.Yuan_CurrentController = _VC_A;
    
}


//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController
            newController:(UIViewController *)newController
{
 /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController
                      toViewController:newController
                              duration:2.0
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:^(BOOL finished) {
        
       if(finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.Yuan_CurrentController= newController;

       } else {
           self.Yuan_CurrentController= oldController;
       }
        
    }];
}


- (void) initFTP {
    
     AppDelegate * delegate  = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        delegate.allowRotate = NO;
        
        NSLog(@"viewdidload");
        
        self.title = @"欢迎";
        
        UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:self.scan];
        self.navigationItem.rightBarButtonItem = rightBarButton;
        
        self.view.backgroundColor = [UIColor colorWithRed:80/255.0 green:210/255.0 blue:1 alpha:1];
        
        [self.view addSubview:self.upDataImage];
        [self.view addSubview:self.upDataAudio];
        
        
        
        [self layoutAllSubViews];
        
        
}

#pragma mark - 点击调用 collection 获取图片

- (void) getImage {
    
    ChooseController * choose = [[ChooseController alloc] initWithGetType:GetTypePhoto];
    
    [self.navigationController pushViewController:choose animated:YES];
}


#pragma mark - 点击调用 获取视频

- (void) getVideo {
    
    ChooseController * choose = [[ChooseController alloc] initWithGetType:GetTypeVideo];
    
    [self.navigationController pushViewController:choose animated:YES];
}

#pragma mark -  判断 你是否已经扫描过正确的二维码了 , 判断标准为你是否取值了

- (void) didYouHaveScan {
    
    BOOL judge = _address.length > 1 && _account.length > 1 && _password.length > 1;
    
    if (!judge) { //如果不满足三个变量都有值的话
        
        [UIAlert showOkayCancelAlertClassHome:self title:@"请扫描正确的二维码" message:@"地址或账号密码未检测到" cancelBtnTitle:@"好"];
    }
}


#pragma mark - 点击去扫一扫

- (void) scanClick {
    
    [self scanA];
}


- (void) scanB {
    
    Yuan_PickerController * picker = [[Yuan_PickerController alloc] init];
    [self.navigationController pushViewController:picker animated:YES];
}

- (void) scanA {

        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        delegate.allowRotate = YES;
        
        Yuan_ScrollForCollection * yuan = [[Yuan_ScrollForCollection alloc] init];
        
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
        
        [self.navigationController pushViewController:yuan animated:YES];
        
        return;
        
        
        //宏定义，判断是否是 iOS10.0以上
        
        // 可以把界面停留在关于本机
        NSString * urlStr = @"App-Prefs:root=General&path=ACCESSIBILITY";
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) {
           
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }
        }
        
        
        
    //    ScanViewController * scan = [[ScanViewController alloc] init];
    //
    //    [self.navigationController pushViewController:scan animated:YES];
        
    
}


#pragma mark - 扫描二维码的代理方法  , 获取二维码中的 ip地址 , ftp账号密码

- (void)scanWithResultDictionary:(NSDictionary *)dict {
    
    _address = dict[@"address"];
    _account = dict[@"account"];
    _password = dict[@"password"];
}

#pragma mark - 屏幕适配

- (void)layoutAllSubViews {
    
  
}




@end
