//
//  Yuan_GetIAV.h
//  FTP图影音
//
//  Created by 袁全 on 2020/2/25.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import<Photos/Photos.h>   //相册类

typedef NS_ENUM(NSUInteger, Yuan_GetIAVType) {
    Yuan_GetIAVType_Image = 0,
    Yuan_GetIAVType_Video = 1
};

NS_ASSUME_NONNULL_BEGIN

@interface Yuan_GetIAV : NSObject

// 根据枚举类型 返回对应的 源数据
+ (NSMutableArray *) GetDataSourceWithYuan_GetIAVType:(Yuan_GetIAVType)type;



+ (UIImage *) Yuan_GetIAV_PHAssetToImage:(PHAsset *)asset;

+ (void) Yuan_GetIAV_PHAssetToImage:(PHAsset *)asset imageView:(UIImageView *)imageView;


+ (NSString *) Yuan_GetIAV_PHAssetToFileURL:(PHAsset *)asset;


+ (NSMutableArray *) Yuan_GetIAV_ImageArrayWithPHAsetArray:(NSMutableArray <PHAsset*> *)array ;


@end

NS_ASSUME_NONNULL_END
