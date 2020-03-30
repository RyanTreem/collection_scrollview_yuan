//
//  Yuan_ViewModel.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/9.
//  Copyright © 2020 袁全. All rights reserved.
//

#import "Yuan_ViewModel.h"

@implementation Yuan_ViewModel

+ (Yuan_ViewModel *)shareInstance {
    
    static Yuan_ViewModel *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}


- (void) countDictWithCollection:(UICollectionView *)collection
                            cell:(UICollectionViewCell *)cell
                       indexPath:(NSIndexPath *) indexPath
                             add:(BOOL)isAdd
                      dictionary:(NSMutableDictionary * )_touchDict { 
    
    
     /*
        数据结构
           @{
              @"tag, NSNumberWithInteger类型" : @[
                                                   // indexpath.row 是NSNumberWithInteger类型
                                                    @"indexpath.row " : {
                                                    @"x" : xx
                                                    @"y" : xx
                                                    }
                                               ]
            }
        */
       
       
       NSNumber * tag = [NSNumber numberWithInteger:collection.tag];
       NSNumber * indexPath_row = [NSNumber numberWithInteger:indexPath.row];
       
       
       if (isAdd) {
           
           
           //        判断两个view的frame是否有重叠
           //        CGRectIntersectsRect(frame1, frame2);
                   
                   /*
                    *  collectionView.tag  由于是for循环创建的collection , 需要为collection标记tag , 用来当collectionItem复用回来后 , 标记颜色
                    *  param indexPath 点击的item的indexpath.row
                    *  param x item相对scrollview的 frame_origin_x
                    *  param y item相对scrollview的 frame_origin_y
                       需要注意的是 y : cell.superview.frame.origin.y
                    
                    *  宽和高不用存 , 因为他们是宏定义的值 -- LengthOfSide
                    */
                   
           
           
           NSDictionary * indexPath_Dict = @{indexPath_row : @{
                      @"x":[NSNumber numberWithFloat:cell.frame.origin.x],
                      @"y":[NSNumber numberWithFloat:cell.superview.frame.origin.y],
                  }};
           
           NSMutableArray * array;
           
           if ([_touchDict.allKeys containsObject:tag]) {
               //说明 tag曾经存入过  从数组取里面取value
               array = _touchDict[tag];
           }else {
               array = [NSMutableArray array];
           }
           
           
           [array addObject:indexPath_Dict];
           
           _touchDict[tag] = array;
           
       }else {
           
           NSMutableArray * array = _touchDict[tag];
           
           __block NSDictionary * dict;
           
           [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
               dict = obj;
               
               if ([[[dict allKeys] lastObject] isEqualToNumber:indexPath_row]) {
                   [array removeObject:obj];
               }
           }];
           
           if (array.count == 0) {
               [_touchDict removeObjectForKey:tag];
           }else {
               _touchDict[tag] = array;
           }
       }
       
    

}



@end
