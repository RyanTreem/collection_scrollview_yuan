//
//  Yuan_GetIAV.m
//  FTP图影音
//
//  Created by 袁全 on 2020/2/25.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "Yuan_GetIAV.h"
@implementation Yuan_GetIAV



+ (NSMutableArray *) GetDataSourceWithYuan_GetIAVType:(Yuan_GetIAVType)type {
    
    
    switch (type) {
        case Yuan_GetIAVType_Image:
            return [Yuan_GetIAV GetImage];
            break;
            
        case Yuan_GetIAVType_Video:
            return [Yuan_GetIAV GetVideo];
            break;
            
        default:
            return [NSMutableArray array];
            break;
    }
    
}


#pragma mark - 获取相册里所有资源

+ (PHFetchResult <PHAsset *> *) assetsFetchResults {
    
    
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    
    // 获取相册中 所有对象 并储存在 assetsFetchResults 中
    PHFetchResult <PHAsset *> *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    return assetsFetchResults;
    
}



// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


// mediaType文件类型
// PHAssetMediaTypeUnknown = 0, 位置类型
// PHAssetMediaTypeImage   = 1, 图片
// PHAssetMediaTypeVideo   = 2, 视频
// PHAssetMediaTypeAudio   = 3, 音频




#pragma mark - 从相册资源里 分离出'图片'类型的对象 , 存入数组并返回

+ (NSMutableArray *) GetImage {
    
    NSMutableArray * imageArray = [NSMutableArray array];

    //遍历相册资源库
    for (PHAsset *asset in [Yuan_GetIAV assetsFetchResults]) {
        
        // 把资源库里所有图片类型的存入数组中
        int fileType = asset.mediaType;
        // 区分文件类型, 取图片文件
        if (fileType == PHAssetMediaTypeImage)
        {
            // 取出图形文件
            NSString *filename = [asset valueForKey:@"filename"];
            
            // 加入数组当中
            [imageArray addObject:asset];
        }
        
    }
    
    return imageArray;
    
}


/*
 [[PHImageManager defaultManager] requestImageForAsset:asset
 targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight)
 contentMode:PHImageContentModeAspectFill
 options:nil
 resultHandler:^(UIImage *result, NSDictionary *info) {
 
 
 [imageArray addObject:result];
 }];
 */

#pragma mark - 从相册资源里 分离出'视频'类型的对象 , 存入数组并返回

+ (NSMutableArray *) GetVideo {
    
    
    NSMutableArray * videoArray = [NSMutableArray array];
    
    for (PHAsset *asset in [Yuan_GetIAV assetsFetchResults]) {
        
        int fileType = asset.mediaType;
        // 区分文件类型, 取视频文件
        if (fileType == PHAssetMediaTypeVideo)
        {
            // 取出视频文件
            [videoArray addObject:asset];
        }
    }
    
    return videoArray;
}


+ (NSMutableArray *) Yuan_GetIAV_ImageArrayWithPHAsetArray:(NSMutableArray <PHAsset*> *)array  {
    
    
    NSMutableArray * imageSourceArray = [NSMutableArray array];
    
    for (PHAsset * asset in array) {
       [imageSourceArray addObject:[Yuan_GetIAV Yuan_GetIAV_PHAssetToImage:asset]];
    }
    
    return imageSourceArray;
}




+ (UIImage *) Yuan_GetIAV_PHAssetToImage:(PHAsset *)asset  {
    
    __block  UIImage * img;
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    /**
     resizeMode：对请求的图像怎样缩放。有三种选择：None，默认加载方式；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
     deliveryMode：图像质量。有三种值：Opportunistic，在速度与质量中均衡；HighQualityFormat，不管花费多长时间，提供高质量图像；FastFormat，以最快速度提供好的质量。
     这个属性只有在 synchronous 为 true 时有效。
     */
    option.resizeMode = PHImageRequestOptionsResizeModeFast ;//控制照片尺寸
    //option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;//控制照片质量
    //option.synchronous = YES;
    option.networkAccessAllowed = YES;
    //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
    
    CGSize size = CGSizeMake(PHImageManagerMaximumSize.width/2, PHImageManagerMaximumSize.height/2);
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        img = image;
    }];
    
    return img;
    
}


+ (void) Yuan_GetIAV_PHAssetToImage:(PHAsset *)asset imageView:(UIImageView *)imageView {
    
    
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    /**
     resizeMode：对请求的图像怎样缩放。有三种选择：None，默认加载方式；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
     deliveryMode：图像质量。有三种值：Opportunistic，在速度与质量中均衡；HighQualityFormat，不管花费多长时间，提供高质量图像；FastFormat，以最快速度提供好的质量。
     这个属性只有在 synchronous 为 true 时有效。
     */
    option.resizeMode = PHImageRequestOptionsResizeModeFast ;//控制照片尺寸
    //option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;//控制照片质量
    //option.synchronous = YES;
    option.networkAccessAllowed = YES;
    //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
    
    CGSize size = CGSizeMake(PHImageManagerMaximumSize.width/2, PHImageManagerMaximumSize.height/2);
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
            imageView.image = image;
    }];
    
    
    
}


+ (NSString *) Yuan_GetIAV_PHAssetToFileURL:(PHAsset *)asset {
    
    NSArray *resourceList = [PHAssetResource assetResourcesForAsset:asset];
    
    __block NSString * dataFilePath ;
    
    [resourceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PHAssetResource *resource = obj;
        
        PHAssetResourceRequestOptions *option = [[PHAssetResourceRequestOptions alloc]init];
        
        option.networkAccessAllowed = YES;
        
        // 首先,需要获取沙盒路径
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        // 拼接图片名为resource.originalFilename的路径
        
        dataFilePath = [path stringByAppendingPathComponent:resource.originalFilename];
        
        dataFilePath = [dataFilePath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}[]|\\<>"].invertedSet];
        
        
    }];
    
    
    
    return dataFilePath;

}


@end
