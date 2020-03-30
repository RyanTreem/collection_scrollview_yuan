//
//  Yuan_ScrollCollection.h
//  FTP图影音
//
//  Created by 袁全 on 2020/3/9.
//  Copyright © 2020 袁全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Yuan_ScrollCollection : UIScrollView

/** 承装scroll内所有collection的数组 */
@property (nonatomic,strong , readonly) NSMutableArray<UICollectionView *> *collectionArray;

@end

NS_ASSUME_NONNULL_END
