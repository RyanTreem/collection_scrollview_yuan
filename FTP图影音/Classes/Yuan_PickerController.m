//
//  Yuan_PickerController.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/18.
//  Copyright © 2020 袁全. All rights reserved.
//

#import "Yuan_PickerController.h"

#import "Yuan_PickerView.h"


@interface Yuan_PickerController ()

/** picker */
@property (nonatomic,strong) Yuan_PickerView *picker;

@end

@implementation Yuan_PickerController


- (Yuan_PickerView *)picker {
    
    if (!_picker) {
        
        _picker = [[Yuan_PickerView alloc] init];
        
        _picker.selectDateTimestampBlock = ^(NSString * _Nonnull year, NSString * _Nonnull month, NSString * _Nonnull day, NSString * _Nonnull hour, NSString * _Nonnull minute) {
            
            NSLog(@"%@-%@-%@ %@:%@:00",year,month,day,hour,minute);
        };
        
    }
    return _picker;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.picker];
    
    [self layoutAllSubViews];
}



#pragma mark - 屏幕适配

- (void)layoutAllSubViews {
    
    [_picker autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_picker autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_picker autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_picker autoSetDimension:ALDimensionHeight toSize:250];
}


@end
