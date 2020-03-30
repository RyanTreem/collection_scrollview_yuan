//
//  Yuan_ViewModel.h
//  FTP图影音
//
//  Created by 袁全 on 2020/3/9.
//  Copyright © 2020 袁全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Yuan_ViewModel : NSObject


+ (Yuan_ViewModel *)shareInstance;


// 点击
- (void) countDictWithCollection:(UICollectionView *)collection
                            cell:(UICollectionViewCell *)cell
                       indexPath:(NSIndexPath *) indexPath
                             add:(BOOL)isAdd
                      dictionary:(NSMutableDictionary * )_touchDict;

@end

NS_ASSUME_NONNULL_END
