//
//  PhotoCollectionViewCell.m
//  FTP图影音
//
//  Created by 袁全 on 2020/2/19.
//  Copyright © 2020 Ryan Treem. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

#define itemWidth 80

@interface PhotoCollectionViewCell ()



@end

@implementation PhotoCollectionViewCell

- (UIImageView *)photoImageView {
    
    if (!_photoImageView) {
        
        _photoImageView = [[UIImageView alloc] init];
        
        _photoImageView.backgroundColor = [UIColor yellowColor];
        
    }
    return _photoImageView;
}

- (UILabel *)selectLabel {
    
    
    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.text = @"未选中";
        _selectLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
        _selectLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _selectLabel;
}

- (UILabel *)AudioOrVideo {
    
    if (!_AudioOrVideo) {
        
        _AudioOrVideo = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 100, 40)];
        
        _AudioOrVideo.text = @"音视频文件";
        
        _AudioOrVideo.textAlignment = NSTextAlignmentLeft;
        
        _AudioOrVideo.font = [UIFont systemFontOfSize:12];
        

    }
    return _AudioOrVideo;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.photoImageView];
        
        [self.contentView addSubview:self.selectLabel];
        
        
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        [self layoutAllSubViews];
        
    }
    return self;
}


// 当视频/音频文件 显示label  无缩略图
- (void) audioOrVideo {
    
    [self.contentView addSubview:self.AudioOrVideo];
    
    [_AudioOrVideo autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    [_AudioOrVideo autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_AudioOrVideo autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_AudioOrVideo autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50];
    
}

#pragma mark - 屏幕适配

- (void)layoutAllSubViews {
    
    [_photoImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:1];
    [_photoImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1];
    [_photoImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:1];
    
    
    
    
    
    [_selectLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:1];
    [_selectLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:1];
    [_selectLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:1];
    [_selectLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_photoImageView withOffset:5];
}

@end
