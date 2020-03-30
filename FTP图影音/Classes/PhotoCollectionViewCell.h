//
//  PhotoCollectionViewCell.h
//  FTP图影音
//
//  Created by 袁全 on 2020/2/19.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionViewCell : UICollectionViewCell
/**  */
@property (nonatomic,strong) UIImageView *photoImageView;

/**  */
@property (nonatomic,strong) UILabel *selectLabel;

/** <#注释#> */
@property (nonatomic,strong) UILabel * AudioOrVideo;

- (void) audioOrVideo;

@end

NS_ASSUME_NONNULL_END
