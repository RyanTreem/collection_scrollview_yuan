//
//  Yuan_Nav.h
//  FTP图影音
//
//  Created by 袁全 on 2020/3/10.
//  Copyright © 2020 袁全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Yuan_Nav : UINavigationController



/*返回到指定的控制器 param:栈内控制器的类名 */
- (void) Yuan_popToViewController:(NSString *)viewControllerClass;

@end

NS_ASSUME_NONNULL_END
