//
//  Yuan_ListBtn.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/9.
//  Copyright © 2020 袁全. All rights reserved.
//

#import "Yuan_ListBtn.h"

@implementation Yuan_ListBtn



#pragma mark - 构造方法

- (instancetype) init {
    
    if (self = [super init]) {
        [self setTitle:@"谢广坤" forState:UIControlStateNormal];
    }
    return self;
}


- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"谢广坤" forState:UIControlStateNormal];
    }
    return self;
}



#pragma mark - UITouch


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}



- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch=[touches anyObject];
    
    CGPoint curP = [touch locationInView:self];
    
    // 滑动实时的点 preP
    CGPoint preP = [touch precisePreviousLocationInView:self];//9.0之后
    CGFloat offsetX = curP.x-preP.x;
    CGFloat offsetY = curP.y-preP.y;
    
    //获取滑动的点与当前位置的偏移量 , 再赋值给当前 , 保存view随着touch的位置b改变而改变

    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    
    if ([self.delegate respondsToSelector:@selector(Yuan_ListBtn:Move:)]) {
        
        [self.delegate Yuan_ListBtn:self Move:preP];
    }
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    
}


@end
