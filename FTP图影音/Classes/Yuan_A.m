//
//  Yuan_A.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/26.
//  Copyright © 2020 袁全. All rights reserved.
//

#import "Yuan_A.h"
#import "Yuan_Array.h"
#import "NSObject+Yuan_Vessel.h"
@interface Yuan_A ()

@end

@implementation Yuan_A

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel * label = [UIView labelWithTitle:@"我是A" frame:CGRectMake(100, 100, 200, 200)];
    
    label.backgroundColor = [UIColor yellowColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.view.alpha = 0.8;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    [UIAlert alertSmallTitle:@"你好呀"];
    
    [UIAlert showAlertClassHome:self title:@"" agreeBtnBlock:^(UIAlertAction *action) {
        
    } agreeBtnTitle:@""];
    
    
}



@end
