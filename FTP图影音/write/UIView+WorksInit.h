//
//  UIView+WorksInit.h
//  helloworld
//
//  Created by 袁全 on 2020/2/21.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WorksInit)



+ (UILabel *) labelWithTitle:(NSString *)title
                       frame:(CGRect)frame;




+ (UIButton *) buttonWithTitle:(NSString *)title
                    responder :(id) weakSelf
                           SEL:(SEL)target
                         frame:(CGRect)frame;



+ (UIImageView *) imageViewWithImg:(UIImage *)img
                             frame:(CGRect)frame;




+ (UITableView *) tableViewDelegate:(id)delegate
                      registerClass:(Class)registerClass
                CellReuseIdentifier:(NSString *)ID;



/**
    param : flowLayout : 控制collection的item的大小与流向.
 */
+ (UICollectionView *) collectionDatasource:(id)delegate
                              registerClass:(Class)registerClass
                        CellReuseIdentifier:(NSString *)ID
                                 flowLayout:(UICollectionViewFlowLayout *) flowLayout;

@end

NS_ASSUME_NONNULL_END
