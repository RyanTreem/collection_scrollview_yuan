//
//  YuanMoveBtn.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/9.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "YuanMoveBtn.h"




@interface YuanMoveBtn ()

/** 按钮的名称 */
@property (nonatomic,strong) UILabel * titleName;

/** 按钮的图片 */
@property (nonatomic,strong) UIImageView *img;

/** <#注释#> */
@property (nonatomic ,assign) BOOL CanMove;

/** 滑动之前的位置 */
@property (nonatomic ,assign) CGPoint before;



@end


@implementation YuanMoveBtn

- (UILabel *)titleName {
    
    if (!_titleName) {
        
        _titleName = [[UILabel alloc] init];
        _titleName.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
        _titleName.font = [UIFont systemFontOfSize:11];
        _titleName.backgroundColor = [UIColor greenColor];
        _titleName.textAlignment = NSTextAlignmentCenter;
    }
    return _titleName;
}

- (UIImageView *)img {
    
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.backgroundColor = [UIColor yellowColor];
    }
    return _img;
}


- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                      canMove:(BOOL)isCanMove {
    
    if (self = [super init]) {
        
        [self addSubview:self.titleName];
        [self addSubview:self.img];
        
//        初始化
        _titleName.text = title;
        _img.image = image;
        _CanMove = isCanMove;
        
        [self layoutAllSubViews];
    }
    return self;
}


#pragma mark - 当滑动事件开始时


-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
        
    if ([self.delegate respondsToSelector:@selector(Yuan_MoveEndReLayoutViews: sender:)]) {
        
        [self.delegate Yuan_MoveEndReLayoutViews:Yuan_BtnMoveBefore sender:self];
    }
    
}



- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    if (_CanMove == NO) {
        //如果是不可移动的 , 直接返回 ,不走下面的方法
        return;
    }
    
    UITouch *touch=[touches anyObject];
    
    CGPoint curP = [touch locationInView:self];
    
    // 滑动实时的点 preP
    CGPoint preP = [touch precisePreviousLocationInView:self];//9.0之后
    CGFloat offsetX = curP.x-preP.x;
    CGFloat offsetY = curP.y-preP.y;
    
    //获取滑动的点与当前位置的偏移量 , 再赋值给当前 , 保存view随着touch的位置b改变而改变
    
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);

    
}


#pragma mark - 当滑动事件结束时



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    if (_CanMove == NO) {
        //如果是不可移动的 , 直接返回 ,不走下面的方法
        return;
    }

    
    // 重新布局
    
    if ([self.delegate respondsToSelector:@selector(Yuan_MoveEndReLayoutViews: sender:)]) {
        
        [self.delegate Yuan_MoveEndReLayoutViews:Yuan_BtnMoveEnd sender:self];
    }
    
}




#pragma mark - 屏幕适配

- (void)layoutAllSubViews {
    
    [_img autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1];
    [_img autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:1];
    [_img autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:1];
    [_img autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:15];
    
    [_titleName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_img withOffset:3];
    [_titleName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_titleName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_titleName autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

@end
