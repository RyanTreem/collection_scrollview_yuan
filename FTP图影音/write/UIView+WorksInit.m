//
//  UIView+WorksInit.m
//  helloworld
//
//  Created by 袁全 on 2020/2/21.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "UIView+WorksInit.h"

@implementation UIView (WorksInit)


#pragma mark - label init

+ (UILabel *) labelWithTitle:(NSString *)title
                       frame:(CGRect)frame {
    
    
    UILabel * label ;
    
    label = [[UILabel alloc] initWithFrame:frame];
    
    label.text = title;
    
    return label;
}




#pragma mark - button init

+ (UIButton *) buttonWithTitle:(NSString *)title
                    responder :(id) weakSelf
                           SEL:(SEL)target
                         frame:(CGRect)frame {
    
    UIButton * button ;
    
    button = [[UIButton alloc] initWithFrame:frame];
    
    if ([weakSelf respondsToSelector:target]) {
        //如果 weakSelf 实现了target方法
        //防止 闪退
        [button addTarget:weakSelf action:target forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1] forState:UIControlStateNormal];
    
    return button;
}





#pragma mark - imageView init

+ (UIImageView *) imageViewWithImg:(UIImage *)img
                             frame:(CGRect)frame {
    
    
    UIImageView * imageV ;
    
    imageV = [[UIImageView alloc] initWithFrame:frame];
    
    imageV.backgroundColor = [UIColor yellowColor];
    
    imageV.image = img;

    return imageV;
}



+ (UITableView *) tableViewDelegate:(id)delegate
                      registerClass:(Class)registerClass
                CellReuseIdentifier:(NSString *)ID {
    
    
    UITableView * tableView = [[UITableView alloc] init];
    
    
    if ([[delegate class] conformsToProtocol:@protocol(UITableViewDataSource)]&&
        [delegate respondsToSelector:@selector(tableView: numberOfRowsInSection:)] &&
        [delegate respondsToSelector:@selector(tableView: cellForRowAtIndexPath:)]) {
     
        // 判断该类 是否遵循了 UITableViewDataSource 协议
        // 如果该tableview实现类 实现了 DataSource两个元数据方法的话
        // 让这个类做 tableView的代理
        tableView.delegate = delegate;
        tableView.dataSource = delegate;
    }
    
 
    [tableView registerClass:registerClass forCellReuseIdentifier:ID];
    
    
    //  遮挡没有用的线
    
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    return tableView;
}



+ (UICollectionView *) collectionDatasource:(id)delegate
                              registerClass:(Class)registerClass
                        CellReuseIdentifier:(NSString *)ID flowLayout:(UICollectionViewFlowLayout *) flowLayout{
    
    
    UICollectionView * collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    collection.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 11.0, *)) {
        collection.contentInsetAdjustmentBehavior = NO;
    } else {
        // Fallback on earlier versions
    }
    
    collection.showsHorizontalScrollIndicator = NO;
    collection.delegate = delegate;
    collection.dataSource = delegate;
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    
    return collection;
}




@end
