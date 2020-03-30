//
//  Yuan_EditingRoomView.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/9.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "Yuan_EditingRoomView.h"
#import "PCH_Header.h"

#import "YuanMoveBtn.h"         // 这个类是继承自UIButton , 实现了拖动


#define BtnWidth 40
#define BtnHeight 1.2 * BtnWidth

#define BtnToLimit 5

@interface Yuan_EditingRoomView ()

<Yuan_MoveDelegate>


#pragma mark - 上半部分的按钮都是可以拖拽的.

/** 组件view头标题       内容为 组件 坐标 x:00 y:00*/
@property (nonatomic,strong) UILabel *module;

/** 机柜 */
@property (nonatomic,strong) YuanMoveBtn *jiGui_module;

/** 列头柜 */
@property (nonatomic,strong) YuanMoveBtn *lieTouGui_module;

/** 配电柜 */
@property (nonatomic,strong) YuanMoveBtn *peidiangui_module;

/** 空调 */
@property (nonatomic,strong) YuanMoveBtn *kongtiao_module;

/** 窗 */
@property (nonatomic,strong) YuanMoveBtn *window_module;

/** 门 */
@property (nonatomic,strong) YuanMoveBtn *door_module;

/** 文字 */
@property (nonatomic,strong) YuanMoveBtn *word_module;


#pragma mark - 下半部分 不可拖拽

/** 操作 */
@property (nonatomic,strong) UILabel *handle;

/** 可移动的 */
@property (nonatomic,strong) YuanMoveBtn *canMove_handle;

/** 微调整 */
@property (nonatomic,strong) YuanMoveBtn *littleAdjust_handle;

/** 设置面积 */
@property (nonatomic,strong) YuanMoveBtn *setArea_handle;

/** 是否显示属性 */
@property (nonatomic,strong) UISwitch *isShowProperty;

@end


@implementation Yuan_EditingRoomView




#pragma mark - 懒加载 -- 抽离方法

- (YuanMoveBtn *) buttonWithImage:(NSString *)imageName
                            title:(NSString *)title
                        isCanMove:(BOOL)canMove{
    
    YuanMoveBtn * btn = [[YuanMoveBtn alloc] initWithImage:[UIImage imageNamed:imageName] title:title canMove:canMove];
    btn.backgroundColor = [UIColor whiteColor];
    btn.delegate = self;
    
    return btn;
}


#pragma mark - 上半view  重写他们的 get方法

- (UILabel *)module {
    
    if (!_module) {
        _module = [UIView labelWithTitle:@"组件  坐标 x:00 y:00" frame:CGRectNull];
        _module.font = [UIFont systemFontOfSize:16];
        _module.backgroundColor = ColorValue_RGB(0xf2f2f2);
    }
    return _module;
}


- (YuanMoveBtn *)jiGui_module {
    
    if (!_jiGui_module) {
        _jiGui_module = [self buttonWithImage:@"" title:@"机柜" isCanMove:YES];
    }
    return _jiGui_module;
}



- (YuanMoveBtn *)lieTouGui_module {
    
    if (!_lieTouGui_module) {
        _lieTouGui_module = [self buttonWithImage:@"" title:@"列头柜" isCanMove:YES];
    }
    return _lieTouGui_module;
}


- (YuanMoveBtn *)peidiangui_module {
    
    if (!_peidiangui_module) {
        _peidiangui_module = [self buttonWithImage:@"" title:@"配电柜" isCanMove:YES];
    }
    return _peidiangui_module;
}

- (YuanMoveBtn *)kongtiao_module{
    
    if (!_kongtiao_module) {
        _kongtiao_module = [self buttonWithImage:@"" title:@"空调" isCanMove:YES];
    }
    return _kongtiao_module;
}

- (YuanMoveBtn *)window_module {
    
    if (!_window_module) {
        _window_module = [self buttonWithImage:@"" title:@"窗户" isCanMove:YES];
    }
    return _window_module;
}

- (YuanMoveBtn *)door_module {
    
    if (!_door_module) {
        _door_module = [self buttonWithImage:@"" title:@"门" isCanMove:YES];
    }
    return _door_module;
}

- (YuanMoveBtn *)word_module {
    
    if (!_word_module) {
        _word_module = [self buttonWithImage:@"" title:@"文字" isCanMove:YES];
    }
    return _word_module;
}


#pragma mark - 下半view 重写他们的get方法
- (UILabel *)handle {
    
    if (!_handle) {
        _handle = [UIView labelWithTitle:@"操作" frame:CGRectNull];
        _handle.font = [UIFont systemFontOfSize:16];
        _handle.backgroundColor = ColorValue_RGB(0xf2f2f2);
    }
    return _handle;
}


- (YuanMoveBtn *)canMove_handle {
    
    if (!_canMove_handle) {
        _canMove_handle = [self buttonWithImage:@"" title:@"可移动" isCanMove:NO];
    }
    return _canMove_handle;
}


- (YuanMoveBtn *)littleAdjust_handle {
    
    if (!_littleAdjust_handle) {
        _littleAdjust_handle = [self buttonWithImage:@"" title:@"微调整" isCanMove:NO];
    }
    return _littleAdjust_handle;
}


- (YuanMoveBtn *)setArea_handle {
    
    if (!_setArea_handle) {
        _setArea_handle = [self buttonWithImage:@"" title:@"面积" isCanMove:NO];
    }
    return _setArea_handle;
}




#pragma mark - 构造方法

- (instancetype) init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray * ObjArray = @[self.module,self.jiGui_module,
                               self.lieTouGui_module,self.peidiangui_module,
                               self.kongtiao_module,self.window_module,
                               self.door_module,self.word_module,
                               self.handle,self.canMove_handle,
                               self.littleAdjust_handle,self.setArea_handle];
        
        for (UIView * view in ObjArray) {
            [self addSubview:view];
        }
        
        [self layoutAllSubViews];
        
    }
    return self;
}


#pragma mark - Yuan_MoveDelegate

// 当按钮滑动停止后 , 回到原位 , 重新屏幕适配就行
- (void)Yuan_MoveEndReLayoutViews:(Yuan_BtnMove)move
                           sender:(YuanMoveBtn *)btn {
        static CGPoint before;
    
        switch (move) {
        
        case Yuan_BtnMoveBefore:  // 开始
            {
                
                before.x = btn.frame.origin.x;
                before.y = btn.frame.origin.y;
            }
            break;
        
        case Yuan_BtnMoveEnd:  // 结束
            
            {
                CGRect frame = btn.frame;
                 
                frame.origin.x = before.x;
                 
                frame.origin.y = before.y;
                 
                btn.frame = frame;
                
            }
            break;
            
        default:
            break;
    }
    
}




#pragma mark - 屏幕适配

- (void)layoutAllSubViews {
    
    [_module autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1];
    [_module autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_module autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_module autoSetDimension:ALDimensionHeight toSize:15];
    
    [_jiGui_module autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_module withOffset:15];
    [_jiGui_module autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:BtnToLimit];
    
    [_lieTouGui_module autoConstrainAttribute:ALAttributeHorizontal toAttribute:ALAttributeHorizontal ofView:_jiGui_module withMultiplier:1.0];
    
    [_lieTouGui_module autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:self withMultiplier:1.0];
    
    [_peidiangui_module autoConstrainAttribute:ALAttributeHorizontal toAttribute:ALAttributeHorizontal ofView:_jiGui_module withMultiplier:1.0];
    
    [_peidiangui_module autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:BtnToLimit];
    
    
    [_kongtiao_module autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jiGui_module withOffset:10];
    
    [_kongtiao_module autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:_jiGui_module withMultiplier:1.0];
    
    
    [_window_module autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lieTouGui_module withOffset:10];
       
    [_window_module autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:_lieTouGui_module withMultiplier:1.0];
    
    
    [_door_module autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_peidiangui_module withOffset:10];
          
    [_door_module autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:_peidiangui_module withMultiplier:1.0];
    
    [_word_module autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_kongtiao_module withOffset:10];
           
    [_word_module autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:_kongtiao_module withMultiplier:1.0];
    
    
    [_handle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_word_module withOffset:10];
    [_handle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_handle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_handle autoSetDimension:ALDimensionHeight toSize:15];
    
    
    
    [_canMove_handle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_handle withOffset:10];
    
    [_canMove_handle autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:_jiGui_module withMultiplier:1.0];
    
    
    [_littleAdjust_handle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_handle withOffset:10];
       
    [_littleAdjust_handle autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:_lieTouGui_module withMultiplier:1.0];
    
    
    [_setArea_handle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_handle withOffset:10];
          
    [_setArea_handle autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:_peidiangui_module withMultiplier:1.0];
    
    
    
    
    
    
    
    
    
    NSArray * frameArray = @[_jiGui_module , _lieTouGui_module , _peidiangui_module,_kongtiao_module,_window_module,_door_module,_word_module,_canMove_handle,_littleAdjust_handle,_setArea_handle];
    
    for (UIView * view in frameArray) {
        [view autoSetDimensionsToSize:CGSizeMake(BtnWidth, BtnHeight)];
    }
    
}

@end
