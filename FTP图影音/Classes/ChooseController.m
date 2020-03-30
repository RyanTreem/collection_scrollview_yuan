//
//  ChooseController.m
//  FTP图影音
//
//  Created by 袁全 on 2020/2/19.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "ChooseController.h"
#import "UpDataController.h"    //最终上传的控制器


#import "PhotoCollectionViewCell.h"
#import<Photos/Photos.h>   //相册类

#import "Yuan_GetIAV.h"

#define itemWidth 80





@interface ChooseController ()

<
UICollectionViewDelegate ,
UICollectionViewDataSource ,
UICollectionViewDelegateFlowLayout
>

/** <#注释#> */
@property (nonatomic,strong) NSMutableArray *dataArray;

/** <#注释#> */
@property (nonatomic,strong) NSMutableDictionary *selectData;

/** <#注释#> */
@property (nonatomic,strong) UICollectionView *collection;

/** <#注释#> */
@property (nonatomic ,assign) GetType type;

@end

@implementation ChooseController

- (UICollectionView *)collection {
    
    if (!_collection) {
        
        
        // 创建FlowLayout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 垂直方向滑动
        
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth / 0.65);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 10;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 10;
        //设置UICollectionView的滑动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置UICollectionView的间距
        
        
        // 创建collectionView
        CGRect frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        _collection = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        // 设置代理
        _collection.delegate = self;
        _collection.dataSource = self;
        // 其他属性
        _collection.backgroundColor = [UIColor clearColor];
        _collection.showsVerticalScrollIndicator = NO;          // 隐藏垂直方向滚动条
        // 注册cell
        [_collection registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoCell"];

    }
    
    return _collection;
}



- (instancetype) initWithGetType:(GetType)type {
    
    if (self = [super init]) {
        _type = type;
        _dataArray = [NSMutableArray array];    //图库数组
        _selectData = [NSMutableDictionary dictionary];  //选择的数组
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    RightBarButton(@"上传");
    
    self.title = @"选择";
    
    self.view.backgroundColor = [UIColor colorWithRed:80/255.0 green:210/255.0 blue:1 alpha:1];
    
    [self.view addSubview:self.collection];
    
    [self userAuthorize];
    
}



#pragma mark - 用户授权 与 用户元数据选择

- (void) userAuthorize {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        if (status == PHAuthorizationStatusAuthorized) {
            
            //用户允许授权相册
            
            switch (self->_type) {
                    
                case GetTypePhoto:      //获取图片
                    [self getImages];
                    break;
                    
                    
                case GetTypeVideo:      //获取视频
                    [self getVideo];
                    break;
                    
                    
                case GetTypeAudio:      //获取音频
                    
                    break;
                    
                default:                //获取错误文件 返回
                    [UIAlert showAlertClassHome:self title:@"您选择了一个无效的文件传输形式" agreeBtnBlock:^(UIAlertAction *action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    } agreeBtnTitle:@"返回"];
                    break;
            }
            
            
        }else {
            
            [UIAlert showAlertClassHome:self title:@"用户拒绝授权" agreeBtnBlock:^(UIAlertAction *action) {
                
                [self.navigationController popViewControllerAnimated:YES];
            } agreeBtnTitle:@"返回"];
        }
    }];
    
}


#pragma mark - 获取图片

- (void) getImages {
    
    __typeof(self)wself = self;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        wself.dataArray = [Yuan_GetIAV GetDataSourceWithYuan_GetIAVType:Yuan_GetIAVType_Image];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [wself.collection reloadData];
        });
    
    });
    
}


#pragma mark - 获取视频

- (void) getVideo {
    
    __typeof(self)wself = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        wself.dataArray = [Yuan_GetIAV GetDataSourceWithYuan_GetIAVType:Yuan_GetIAVType_Video];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.collection reloadData];
        });
        
    });
    
}



#pragma mark - UICollectionViewDelegate

//单元格个数

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

//单元格内容

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *string=@"photoCell";
    
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView
                                     dequeueReusableCellWithReuseIdentifier:string forIndexPath:indexPath];
    
    // 给图片赋值
    cell.photoImageView.image = [Yuan_GetIAV Yuan_GetIAV_PHAssetToImage:_dataArray[indexPath.row]];
    
    
    // 已经选了这个item了
    if ([_selectData.allKeys containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
        
        cell.selectLabel.text = @"选中";
        cell.selectLabel.textColor = [UIColor redColor];
    }else {
        
        cell.selectLabel.text = @"未选择";
        cell.selectLabel.textColor = [UIColor greenColor];
    }
    
    return cell;
    
}

//点击单元格触发事件

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
    UIImage * image = [Yuan_GetIAV Yuan_GetIAV_PHAssetToImage:_dataArray[indexPath.row]];
    
    NSData * data = UIImagePNGRepresentation(image);
    
    
    
    PhotoCollectionViewCell *cell=(PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    // 保证不大于12张
    if (_selectData.allKeys.count > 11) {
        [self alert];
    }
    else{
        
        // 判断 如果 选中可变字典中 不存在了这个key为 indexpath.row的键值对 , 就认为他没有选中过
        
        if (![_selectData.allKeys containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
            
            cell.selectLabel.text = @"选中";
            
            cell.selectLabel.textColor = [UIColor redColor];
            
            // 给可变键值对赋值
            _selectData[[NSNumber numberWithInteger:indexPath.row]] = data;
            
        }else{
            
            cell.selectLabel.text = @"未选择";
            
            cell.selectLabel.textColor = [UIColor greenColor];
            
            [_selectData removeObjectForKey:[NSNumber numberWithInteger:indexPath.row]];
            
        }
        
        NSLog(@"%lu",(unsigned long)_selectData.allKeys.count);
        
        NSLog(@"%@",_selectData);
        
        
        // _selectData.allValues  1--
        // UIImagePNGRepresentation(image); image 转 data并上传 2--
        
    }
    
    
}



#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(itemWidth, itemWidth / 0.65 + 20);
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (void) alert {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"照片不能超过12张" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:confirmAction];
    
    [self presentViewController:alert animated:YES completion:^{
        return ;
    }];
    
}



#pragma mark - 右侧按钮

- (void) rightAction {
    
    if (_selectData.allKeys.count < 1) {
        [UIAlert showOkayCancelAlertClassHome:self title:@"至少选择一个上传" message:@"" cancelBtnTitle:@"好"];
        return;
    }
    
    UpDataController * upData = [[UpDataController alloc] initWithFTPUpLoadSelectArray:_selectData.allValues];
    
    [self.navigationController pushViewController:upData animated:YES];
    
}


@end
