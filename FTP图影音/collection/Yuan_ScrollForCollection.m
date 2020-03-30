//
//  Yuan_ScrollForCollection.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/6.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "Yuan_ScrollForCollection.h"

#import "Yuan_ScrollCollection.h"       // scrollView
#import "Yuan_EditingRoomView.h"        // 操作台view

#import "Yuan_ViewModel.h"              // 逻辑处理

#import "AppDelegate.h"

#import "PCH_Header.h"

static int collectionCount;

#define RotateScreenHeight [UIScreen mainScreen].bounds.size.width
#define RotateScreenWidth [UIScreen mainScreen].bounds.size.height

#define SCROLL_WIDTH 500
#define SCROLL_OFFSET_XY SCROLL_WIDTH * 3

#define kLineSpacing 1
#define kItemSpacing 1
#define LengthOfSide 30



@interface Yuan_ScrollForCollection ()
<
    UIScrollViewDelegate,
    UIGestureRecognizerDelegate              //用来禁用右滑pop手势的

>


{
    
    AppDelegate * delegate;
    
}

/**  */
@property (nonatomic,strong) Yuan_ScrollCollection *scroll;


/* 操作台 */
@property (nonatomic,strong) Yuan_EditingRoomView *editRoom;

@end

@implementation Yuan_ScrollForCollection

#pragma mark - 懒加载

- (Yuan_EditingRoomView *)editRoom {
    
    if (!_editRoom) {
        _editRoom = [[Yuan_EditingRoomView alloc] init];
    }
    return _editRoom;
}


- (Yuan_ScrollCollection *)scroll {
    
    if (!_scroll) {
        if (!_scroll) {
            _scroll = [[Yuan_ScrollCollection alloc] init];
            _scroll.scrollEnabled = YES;
            _scroll.delegate = self;
            _scroll.backgroundColor = [UIColor whiteColor];
            _scroll.showsVerticalScrollIndicator = NO;
            _scroll.bounces = NO;
            _scroll.contentSize = CGSizeMake(SCROLL_OFFSET_XY, SCROLL_OFFSET_XY);
        }
        return _scroll;
    }
    return _scroll;
}


#pragma mark - 当类加载时

+ (void)load {
    
    // 用总高度 / (collectionView + 线宽) 得出需要创建多少个collection 自上而下
    int aCollectionHeight = LengthOfSide + kLineSpacing; // 边长 + 1 线宽
    //scrollview里需要多少个collection
    collectionCount = SCROLL_OFFSET_XY / aCollectionHeight;
}

#pragma mark - 初始化

- (instancetype) init {
    
    if (self = [super init]) {

        delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}



#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scroll];
    [self.view addSubview:self.editRoom];
    [self layoutAllSubViews];

//    LeftBarButton(@"< 返回");
    
}





- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    
    
    delegate.allowRotate = NO;
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationPortrait] forKey:@"orientation"];
    
}


#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if (scrollView == _scroll) {
        return;
    }
    
    for (UICollectionView * collection in _scroll.collectionArray) {
        
        // 当scrollView滑动时 , 把偏移量赋值给collection们 , 但只要x方向的 ,y方向的由tableview自己去控制 , 达到滑动一个collection 所有的collec都跟着动起来.
        
        // 所有才 scrollView == _scroll return , 保证只有collection自己动的时候 ,才会进入这个方法.
        [collection setContentOffset:scrollView.contentOffset];
    }
}


#pragma mark - 屏幕适配

- (void)layoutAllSubViews {
    
    [_editRoom autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [_editRoom autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    [_editRoom autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_editRoom autoSetDimension:ALDimensionWidth toSize:180];
    
    [_scroll autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    [_scroll autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_scroll autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_scroll autoSetDimension:ALDimensionWidth toSize:SCREENWIDTH - 180 - 30];
    
}


#pragma mark - 禁用右滑手势

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

// 给该控制器添加协议 <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return gestureRecognizer != self.navigationController.interactivePopGestureRecognizer;
}



- (void) back {
    
    [self.navigationController popViewControllerAnimated:YES];

    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    delegate.allowRotate = NO;
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationPortrait] forKey:@"orientation"];
    
    
}

@end
