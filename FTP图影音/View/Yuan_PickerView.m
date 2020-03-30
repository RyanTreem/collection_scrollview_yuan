//
//  Yuan_PickerView.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/18.
//  Copyright © 2020 袁全. All rights reserved.
//

#import "Yuan_PickerView.h"

#import "Yuan_PickerDataSource.h"

#import "NSObject+Yuan_Vessel.h"

@interface Yuan_PickerView ()

<
    UIPickerViewDelegate ,
    UIPickerViewDataSource
>


{
    
    NSTimer * timer;
}
/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;

/** 确认按钮 */
@property (nonatomic,strong) UIButton *enterButton;

/** 数据源 */
@property (nonatomic,strong) Yuan_PickerDataSource * dataSourece;

@end

@implementation Yuan_PickerView

- (UIPickerView *)pickerView {
    
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate   = self;
        _pickerView.dataSource = self;
        
        _dataSourece = [[Yuan_PickerDataSource alloc] init];
        
        __block UIPickerView * picker = _pickerView;
        
        __typeof(self)wself = self;
        
        _dataSourece.reloadPickerDataSourceBlock = ^{
                
            [picker reloadAllComponents];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [wself selectDateTimestamp];
            });
        };
        
        // 年月日
        [_pickerView selectRow:_dataSourece.year.count - 1 inComponent:0 animated:YES];
        [_pickerView selectRow:_dataSourece.month.count - 1 inComponent:1 animated:YES];
        [_pickerView selectRow:_dataSourece.day.count - 1 inComponent:2 animated:YES];
        
        //时分
        [_pickerView selectRow:_dataSourece.hour.count - 1 inComponent:3 animated:YES];
        [_pickerView selectRow:_dataSourece.minute.count - 1 inComponent:4 animated:YES];
        
        
        
        
    }
    return _pickerView;
}


- (UIButton *)enterButton {
    
    if (!_enterButton) {
        _enterButton = [UIView buttonWithTitle:@"确定" responder:self SEL:@selector(enterBtnClick) frame:CGRectNull];
        _enterButton.layer.cornerRadius = 5;
        _enterButton.layer.masksToBounds = YES;
        _enterButton.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
        [_enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _enterButton;
}


#pragma mark - 构造方法

- (instancetype) init
{
    self = [super init];
    if (self) {
        [self addSubview:self.pickerView];
        [self addSubview:self.enterButton];
        
        [self layoutAllSubViews];
        self.backgroundColor = [UIColor whiteColor];
        
        

    }
    return self;
}


#pragma mark - 给外部做回调 ,

- (void)selectDateTimestamp {
    
    
    NSString * year = _dataSourece.year[[_pickerView selectedRowInComponent:0]];;
    NSString * month = _dataSourece.month[[_pickerView selectedRowInComponent:1]];
    NSString * day = _dataSourece.day[[_pickerView selectedRowInComponent:2]];
    NSString * hour = _dataSourece.hour[[_pickerView selectedRowInComponent:3]];
    NSString * minute = _dataSourece.minute[[_pickerView selectedRowInComponent:4]];
    
    self.selectDateTimestampBlock(year, month, day, hour, minute);
}

#pragma mark - >>>>>>>>>>>>  UIPickerViewDelegate & UIPickerViewDataSource <<<<<<<<<<<<

// returns the number of 'columns' to display.
// MARK: 一共有多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 5;
}


// MARK: 每组各有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger count = 0;
    
    switch (component) {
        case 0:
            count = [_dataSourece year].count;
            break;
        case 1:
            count = [_dataSourece month].count;
            break;
        case 2:
            count = [_dataSourece day].count;
            break;
        case 3:
            count = [_dataSourece hour].count;
            break;
        case 4:
            count = [_dataSourece minute].count;
        break;
            
        default:
            break;
    }
    
    return count;
}


// MARK: 每一行显示的内容都是什么 ?
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    NSString * titleStr;
    
    switch (component) {
        case 0:
            //年
            titleStr = [_dataSourece year][row];
            titleStr = [titleStr stringByAppendingFormat:@"年"];
            break;
        case 1:
            //月
            titleStr = [_dataSourece month][row];
            titleStr = [titleStr stringByAppendingFormat:@"月"];
            break;
        case 2:
            //日
            titleStr = [_dataSourece day][row];
            titleStr = [titleStr stringByAppendingFormat:@"日"];
            break;
        case 3:
            //时
            titleStr = [_dataSourece hour][row];
            titleStr = [titleStr stringByAppendingFormat:@"点"];
            break;
        case 4:
            //分
            titleStr = [_dataSourece minute][row];
            titleStr = [titleStr stringByAppendingFormat:@"分"];
            break;
            
        default:
            break;
    }
        
    return titleStr;
}


//每行的高度和宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{

    return  (100)/3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 60;
    
}


// MARK: 每次滑动 都会走这个回调接口
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    
    int selectYear = 0 ;
    int selectMonth = 0;
    int selectDay = 0;
    
    switch (component) {
        case 0:
            selectYear = (int)[[_dataSourece year][row] intValue];
            break;
         case 1:
            selectMonth = (int)[[_dataSourece month][row] intValue];
            break;
        case 2:
            selectDay = (int)[[_dataSourece day][row] intValue];
            break;
        default:
            break;
    }
    
    
    // 去刷新数据源喽
    [_dataSourece reloadDateYear:selectYear
                           Month:selectMonth
                             Day:selectDay];
    
    
    
}





//给picker上的文字字体做一些微调
-(UIView *)pickerView:(UIPickerView *)pickerView
           viewForRow:(NSInteger)row
         forComponent:(NSInteger)component
          reusingView:(UIView *)view {
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}


#pragma mark - 事件

// 确认按钮的点击事件
- (void) enterBtnClick {
    
    
    
}


#pragma mark - 屏幕适配

- (void)layoutAllSubViews {
    
    [_pickerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_pickerView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_pickerView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_pickerView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    
    
    [_enterButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:-10];
    [_enterButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_enterButton autoSetDimensionsToSize:CGSizeMake(60, 30)];
    
}


- (void)dealloc {
    
    [timer invalidate];
    
}
@end
