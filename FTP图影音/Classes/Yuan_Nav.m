//
//  Yuan_Nav.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/10.
//  Copyright © 2020 袁全. All rights reserved.
//

#import "Yuan_Nav.h"

@implementation Yuan_Nav

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:animated];
    
    viewController.title = NSStringFromClass(viewController.class);
    
}




- (void) Yuan_popToViewController:(NSString *)viewControllerClass {
     
    // 获取当前栈内的全部控制器
    NSArray * viewControllers = self.viewControllers ;
    
    // 遍历控制器
    for (UIViewController *controller in viewControllers) {

        if ([controller isKindOfClass:[viewControllerClass class]]) {

            [self.navigationController popToViewController:controller animated:YES];
        }
    }


    
}


@end
