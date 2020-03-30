//
//  Yuan_C.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/26.
//  Copyright © 2020 袁全. All rights reserved.
//

#import "Yuan_C.h"

@interface Yuan_C ()

@end

@implementation Yuan_C

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    UILabel * label = [UIView labelWithTitle:@"我是C" frame:CGRectMake(100, 100, 200, 200)];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    if (_block) {
        
        _block(self);
    }
    
}
@end
