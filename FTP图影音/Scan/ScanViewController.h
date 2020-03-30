//
//  ScanViewController.h
//  扫一扫
//
//  Created by 袁全 on 2020/2/20.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ScanDelegate <NSObject>

- (void) scanWithResultDictionary : (NSDictionary *)dict;

@end



@interface ScanViewController : UIViewController

/** delegate */
@property (nonatomic,weak) id <ScanDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
