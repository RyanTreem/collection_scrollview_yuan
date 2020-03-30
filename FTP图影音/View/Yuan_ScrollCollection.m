//
//  Yuan_ScrollCollection.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/9.
//  Copyright © 2020 袁全. All rights reserved.
//

#import "Yuan_ScrollCollection.h"
#import "Yuan_ViewModel.h"

#import "Yuan_ListBtn.h"

static int collectionCount;

#define RotateScreenHeight [UIScreen mainScreen].bounds.size.width
#define RotateScreenWidth [UIScreen mainScreen].bounds.size.height

#define SCROLL_WIDTH 500
#define SCROLL_OFFSET_XY SCROLL_WIDTH * 3

#define kLineSpacing 1
#define kItemSpacing 1
#define LengthOfSide 30


@interface Yuan_ScrollCollection ()
<
    UICollectionViewDelegate ,
    UICollectionViewDataSource ,
    UICollectionViewDelegateFlowLayout,

    Yuan_ListBtnMoveDelegate            //scroll上滑动按钮的滑动事件
>

/** 把collection中哪些item点亮了 ? 点亮意味着滑动按钮时 , 不能触碰到他们 */
@property (nonatomic,strong) NSMutableDictionary *touchDict;


@end

@implementation Yuan_ScrollCollection


- (instancetype) init {
    
    if (self = [super init]) {
        
        
        self.canCancelContentTouches = YES;
        self.delaysContentTouches = NO;
        
        _touchDict = [NSMutableDictionary dictionary];
        
        // 用总高度 / (collectionView + 线宽) 得出需要创建多少个collection 自上而下
        int aCollectionHeight = LengthOfSide + kLineSpacing; // 边长 + 1 线宽
        //scrollview里需要多少个collection
        collectionCount = SCROLL_OFFSET_XY / aCollectionHeight;
        
        
        //scrollview里需要多少个collection
        for (int i = 0; i < collectionCount ; i++) {
            UICollectionView * collection = [self collection:i];
            [self addSubview:collection];
            [_collectionArray addObject:collection];
            collection.scrollEnabled = NO;
        }
        
        [self addScroll];
        
    }
    return self;
}



- (void) addScroll {
    
    Yuan_ListBtn * btn = [[Yuan_ListBtn alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
//    [btn setTitle:@"啦啦啦啦" forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor blueColor]];
    btn.delegate = self;
    
    [self addSubview:btn];
    [self bringSubviewToFront:btn];
}




#pragma mark - collection Init

- (UICollectionView *) collection :(int) i {
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    
    // 设置item的间距
    flowLayout.minimumLineSpacing      = 1;
    flowLayout.minimumInteritemSpacing = 1;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView * collection = [[UICollectionView alloc] initWithFrame:CGRectMake(2, 1 + (LengthOfSide + kItemSpacing) * i, SCROLL_OFFSET_XY - 4, LengthOfSide + kItemSpacing) collectionViewLayout:flowLayout];
    
    collection.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 11.0, *)) {
        collection.contentInsetAdjustmentBehavior = NO;
    } else {
        // Fallback on earlier versions
    }
    
    collection.showsHorizontalScrollIndicator = NO;
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
    collection.bounces = NO;
    collection.tag = 10000 + i;
    
    return collection;
}




#pragma mark - CollectionDelegate & DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 90;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    NSNumber * tag = [NSNumber numberWithInteger:collectionView.tag];
    NSNumber * indexpath_row = [NSNumber numberWithInteger:indexPath.row];
    
    // 判断如果字典的Key数组中有 当前
    if ([_touchDict.allKeys containsObject:[NSNumber numberWithInteger:collectionView.tag]]) {
        
        NSArray * array = [_touchDict objectForKey:tag];
        
        for (NSDictionary * dict in array) {
            if ([dict.allKeys containsObject:indexpath_row]) {
                cell.backgroundColor = [UIColor redColor];
            }
        }
    }
    
    return cell;
}


#pragma mark - Collection didSelectItemAtIndexPath

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
 
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell.backgroundColor isEqual:[UIColor redColor]]) {
        cell.backgroundColor = [UIColor lightGrayColor];
        // 根据collection.tag 移除这个选中项
        
        [self countDictWithCollection:collectionView cell:cell indexPath:indexPath add:NO];
        
    }else {
        cell.backgroundColor = [UIColor redColor];
        [self countDictWithCollection:collectionView cell:cell indexPath:indexPath add:YES];
    }
}



-(BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(LengthOfSide, LengthOfSide);
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - collection点击后颜色变化 , 当滑出屏幕后 , 划回来后一样可以上色

- (void) countDictWithCollection:(UICollectionView *)collection
                            cell:(UICollectionViewCell *)cell
                       indexPath:(NSIndexPath *) indexPath
                             add:(BOOL)isAdd{
    
    [[Yuan_ViewModel shareInstance] countDictWithCollection:collection
                                                       cell:cell
                                                  indexPath:indexPath
                                                        add:isAdd
                                                 dictionary:_touchDict];
    
    
   
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
}




#pragma mark - Yuan_ListBtnMoveDelegate

-(void)Yuan_ListBtn:(Yuan_ListBtn *)btn Move:(CGPoint)point {
    
    
    CGRect currentFrame = btn.frame;
    CGRect scrollFrame = self.frame;
    
    
    if (currentFrame.origin.x < 1) {
        currentFrame.origin.x = 1;
    }
    
    if (currentFrame.origin.y < 1) {
        currentFrame.origin.y = 1;
    }
    
    
    float currentPointx_Max = currentFrame.origin.x + currentFrame.size.width;
    
    if (currentPointx_Max > self.contentSize.width) {
        
        currentFrame.origin.x = self.contentSize.width - currentFrame.size.width - 1;
        
    }
    
    
    float currentPointy_max = currentFrame.origin.y + currentFrame.size.height;
    
    if (currentPointy_max > self.contentSize.height) {
        
        currentFrame.origin.y = self.contentSize.height - currentFrame.size.height -1 ;
        
    }
    
    
    btn.frame = currentFrame;
    
}


@end
