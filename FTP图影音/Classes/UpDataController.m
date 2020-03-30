//
//  UpDataController.m
//  FTP图影音
//
//  Created by 袁全 on 2020/2/19.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "UpDataController.h"
#import "YuanFTPHandle.h"


@interface UpDataController ()

<UITableViewDelegate ,
UITableViewDataSource>

/** <#注释#> */
@property (nonatomic,strong) NSArray<NSData *> * dataSource;

/** 上传 */
@property (nonatomic,strong) UITableView *tableView;

/** <#注释#> */
@property (nonatomic,strong) YuanFTPHandle * ftp;

@end

@implementation UpDataController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [UITableView tableViewDelegate:self registerClass:[UITableViewCell class] CellReuseIdentifier:@"ID"];
    }
    return _tableView;
}


#pragma mark - init


- (instancetype)initWithFTPUpLoadSelectArray:(NSArray<NSData *> *)dataSource {
    
    if (self = [super init]) {
        _dataSource = dataSource;
    }
    return self;
}



#pragma mark - viewDidLoad


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    
    [self layoutAllSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self FTPUpload];
    
}

- (void) FTPUpload {
    
    NSString * urlBasePath = @"ftp://39.100.60.26";
    NSString * user = @"iostest";
    NSString * password = @"iostest";
    
    _ftp = [[YuanFTPHandle alloc] initWithAddress:urlBasePath User:user PassWord:password];
 
    for (NSData * data in _dataSource) {
        [_ftp startUploadingWithData:data];
    }
    
}




#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%lu",indexPath.row];
    
    return cell;
}



#pragma mark - 屏幕适配

- (void)layoutAllSubViews {
    
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

@end
