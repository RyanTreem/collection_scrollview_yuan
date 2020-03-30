//
//  ChoosePickerView.m
//  关心手环
//
//  Created by Ryan on 16/7/18.
//  Copyright © 2016年 Ryan. All rights reserved.
//

#import "ChoosePickerView.h"
#import "SportsTrajectoryViewModel.h"


#define BaseNavColor [UIColor yellowColor]

@interface ChoosePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

/** viewModel */
@property (nonatomic,strong) SportsTrajectoryViewModel *viewModel;

/** 选择时间 */
@property (nonatomic,strong) UILabel *txt_ChooseTime;

/** picker */
@property (nonatomic,strong) UIPickerView *picker;
/** 确定按钮 */
@property (nonatomic,strong) UIButton *enterBtn;
/** 取消按钮 */
@property (nonatomic,strong) UIButton *cancleBtn;

/** 年 */
@property (nonatomic,strong) NSMutableArray *yearArray;
/** 月 */
@property (nonatomic,strong) NSMutableArray *monthArray;
/** 日 */
@property (nonatomic,strong) NSMutableArray *dayArray;
/** 时 */
@property (nonatomic,strong) NSMutableArray *hourArray;

/** 选中的是哪个月份 */
@property (nonatomic,assign) NSInteger month;

/** 当前选中的是哪年 */
@property (nonatomic,strong) NSString *yearSelect;
/** 当前选中的是哪月 */
@property (nonatomic,strong) NSString *monthSelect;
/** 选中的是哪天 */
@property (nonatomic,strong) NSString *daySelect;
/** 时间 */
@property (nonatomic,strong) NSString *timeSelect;
/** 日期随月份的改变 */
@property (nonatomic,strong) NSMutableArray *dayMutableFromMonth;


/** post的开始时间 */
@property (nonatomic,strong) NSString *startDT ;
/** post的结束时间 */
@property (nonatomic,strong) NSString *endDT;

@end

@implementation ChoosePickerView

#pragma mark - >>>>>>>>>>>>  Lazy Load  <<<<<<<<<<<<
-(UILabel *)txt_ChooseTime{
    if (!_txt_ChooseTime) {
        _txt_ChooseTime      = [[UILabel alloc] init];
        _txt_ChooseTime.text = @"选择时间";
    }
    return _txt_ChooseTime;
}


-(UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc] init];
        _picker.delegate   = self;
        _picker.dataSource = self;
        if (_yearSelect.length > 0 && _monthSelect.length > 0 && _daySelect.length > 0 && _timeSelect.length > 0 ) {
            NSInteger count = _yearArray.count;
            //通过ViewModel初始化年月日字符串后 , 再把字符串上显示的值与picker默认初始化选中的值对应
            [_picker selectRow:(count-1) inComponent:0 animated:YES];
            [_picker selectRow:([_monthSelect intValue] -1) inComponent:1 animated:YES];
            [_picker selectRow:([_daySelect intValue] -1) inComponent:2 animated:YES];
            [_picker selectRow:([_timeSelect intValue] ) inComponent:3 animated:YES];
            
            //因为_timeSelect在ViewModel初始化时只截取到了小时 , 所以把分钟补全.
            _timeSelect = [NSString stringWithFormat:@"%@:00",_timeSelect];
            
            
            //初始化如果用户并没有滚动picker时也要有的startDT 和 endDT
            _startDT = [_viewModel returnPickerSelectedStringWithYear:_yearSelect Month:_monthSelect day:_daySelect time:_timeSelect];
            _endDT   = [_viewModel returnEndDTArrayWithStarTime:nil];
        }
    }
    return _picker;
}


-(UIButton *)enterBtn{
    if (!_enterBtn) {
        _enterBtn = [self buttonWithObj:_enterBtn Title:@"确定" SEL:@selector(enterBtnClick)];
        
    }
    return _enterBtn;
}

-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [self buttonWithObj:_cancleBtn Title:@"取消" SEL:@selector(cancleBtnClick)];
    }
    return _cancleBtn;
}


#pragma mark - >>>>>>>>>>>>  BtnConfig  <<<<<<<<<<<<

-(UIButton *)buttonWithObj:(UIButton *)btn
                     Title:(NSString *)title
                       SEL:(SEL)btnClick{
    
    btn = [[UIButton alloc] init];
    [btn addTarget:self action:btnClick forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:BaseNavColor forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [BaseNavColor CGColor];
    return btn;
}


#pragma mark - 按钮点击事件

-(void)enterBtnClick{

//    CFNetWork * net = [CFNetWork sharedInstance];
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"startDT"]           = _startDT.length < 17 ?  [_startDT stringByAppendingString:@":00"] : [_startDT stringByAppendingString:@""];
    dict[@"endDT"]             = _endDT.length < 17 ?  [_endDT stringByAppendingString:@":59"] : [_endDT stringByAppendingString:@""];
    dict[@"manID"]             = _manid.length > 0 ? _manid : @"";
    
//    [net netWorkWithURL:PositionList parameters:dict success:^(id requestDict) {
//        DLog(@"成功");
//        if ([requestDict[@"sign"] intValue] == 1) {
//            NSArray * array = requestDict[@"result"];
//
//            if (_isCrash == NO) {
//                [self.delegate returnAnnotationMessageToControllerWithArray:array];
//            }
//        }
//
//    } failure:^(NSError *error) {
//        DLog(@"失败");
//    }];
//
}

-(void)cancleBtnClick{
    
    if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(haveTouchCancleBtn)]) {
        
        [self.delegate haveTouchCancleBtn];
        
    }

}



#pragma mark - >>>>>>>>>>>>  Init  <<<<<<<<<<<<

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _viewModel           = [SportsTrajectoryViewModel shareInstance];
        _yearArray           = [NSMutableArray array];
        _monthArray          = [NSMutableArray array];
        _dayArray            = [NSMutableArray array];
        _hourArray           = [NSMutableArray array];
        _dayMutableFromMonth = [NSMutableArray array];
        
        _isCrash = NO;
        [self configArray];
        [self currentTimeInit];
        
        [self addSubview:self.txt_ChooseTime];
        [self addSubview:self.picker];
        [self addSubview:self.enterBtn];
        [self addSubview:self.cancleBtn];
        [self layoutAllSubViews];
        
    }
    
    return self;
}

-(void)manid:(NSString *)manid{

    _manid = manid;
}

/**
 *  初始化年月日字符串
 */
-(void)currentTimeInit{
    _yearSelect  = [_viewModel yearSelectInitFromCurrentYear];
    _monthSelect = [_viewModel monthSelectInitFromCurrentMonth];
    _daySelect   = [_viewModel daySelectInitFromCurrentDay];
    _timeSelect  = [_viewModel timeSelectInitFromCurrentTime];
    
}

/**
 *  初始化picker的四个component的数据源 分别是年月日时  年是用NSDate写的 , 月日时是写死的. 月份和日期的变化在滚动picker时调整
 */
-(void)configArray{
    _yearArray  = [_viewModel yearArray];
    _monthArray = [_viewModel monthArray];
    _dayArray   = [_viewModel dayArray];
    _hourArray  = [_viewModel timeArray];
}


#pragma mark - >>>>>>>>>>>>  UIPickerViewDelegate & UIPickerViewDataSource <<<<<<<<<<<<

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger count ;
    switch (component) {
        case 0:
        //年
            count = _yearArray.count;
            break;
        case 1:
        //月
            count = _monthArray.count;
            break;
        case 2:
        //日
            count = _dayMutableFromMonth.count > 0 ? _dayMutableFromMonth.count : _dayArray.count;
            break;
        case 3:
        //时
            count = _hourArray.count;
            break;
            
        default:
            break;
    }
    return count;
}

//picker的数据源  当给picker的四个滚轮赋值
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    NSString * titleStr;
    switch (component) {
        case 0:
            //年
            titleStr = _yearArray[row];
            break;
        case 1:
            //月
            titleStr = _monthArray[row];
            break;
        case 2:
            //日
            titleStr = _dayArray[row];
            break;
        case 3:
            //时
            titleStr = _hourArray[row];
            break;
            
        default:
            break;
    }
    return titleStr;
}

//每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{

    return  (100)/3;
}

//每当滑动任意一行的滚轮时都会进入这个回调
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    NSString * str;
    switch (component) {
        case 0:
            str = _yearArray[row];
            _yearSelect =  [str substringToIndex:[str length]-1];
            break;
        case 1:
            _month = row;
            _monthSelect = [NSString stringWithFormat:@"%.2ld",(long)row + 1];
            break;
        case 2:
            _daySelect = [NSString stringWithFormat:@"%.2ld",(long)row + 1];
            break;
        case 3:
            str = _hourArray[row];
            _timeSelect = str.length >0 ? str : @"00:00";
            break;
        default:
            break;
    }
    
    [_dayMutableFromMonth removeAllObjects];
    _dayMutableFromMonth = [_viewModel dayMutableFromYear:[_yearSelect integerValue] Month:_month dayArray:_dayArray];
    [_picker reloadAllComponents];
    _startDT =  [_viewModel returnPickerSelectedStringWithYear:_yearSelect Month:_monthSelect day:_daySelect time:_timeSelect];
    _endDT = [_viewModel returnEndDTArrayWithStarTime:nil];
    _startDT = [_startDT stringByAppendingString:@":00"];
    _endDT = [_endDT stringByAppendingString:@":59"];
    NSLog(@"开始时间:%@   结束时间:%@",_startDT,_endDT);
    
    
}

//给picker上的文字字体做一些微调
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - >>>>>>>>>>>>  PureLayout  <<<<<<<<<<<<

-(void)layoutAllSubViews{
    // autoConstrainAttribute : ALAttributeHorizontal
    // autoSetDimension       : ALDimensionHeight
    //     _     _  CF_Plus
    //     _     _  CF_Plus ALEdgeTop ALEdgeBottom ALEdgeLeft ALEdgeRight
    [_txt_ChooseTime autoPinEdgeToSuperviewEdge:ALEdgeTop withInset: (10)];
    [_txt_ChooseTime autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:  (150)];
    
    [_picker autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_txt_ChooseTime withOffset: (10)];
    [_picker autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:  (0)];
    [_picker autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:  (0)];
    [_picker autoSetDimension:ALDimensionHeight toSize: (100)];
    
    [_cancleBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:  (25)];
    [_cancleBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_picker withOffset: (15)];
    [_cancleBtn autoSetDimension:ALDimensionWidth toSize:  (150)];
    
    [_enterBtn autoConstrainAttribute:ALAttributeHorizontal toAttribute:ALAttributeHorizontal ofView:_cancleBtn withMultiplier:1.0];
    [_enterBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_cancleBtn withOffset:SCREENWIDTH -   (350)];
    [_enterBtn autoSetDimension:ALDimensionWidth toSize:  (150)];
    
}

@end




