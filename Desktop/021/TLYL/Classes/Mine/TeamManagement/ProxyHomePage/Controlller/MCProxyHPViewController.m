//
//  MCProxyHPViewController.m
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCProxyHPViewController.h"
#import "MCTopTotalView.h"
#import "MCButtonView.h"
#import "DatePickerView.h"
#import "MCChartView.h"
#import "MCOVerViewModel.h"
#import "MCChartModel.h"

@interface MCProxyHPViewController ()
//总览
@property (nonatomic,strong) MCOVerViewModel *overViewModel;
//图表
@property (nonatomic,strong) MCChartModel *chartModel;
//时间选择其
@property (nonatomic,weak) DatePickerView *datePicker;

@property (nonatomic,strong) NSDate *minDate;

@property (nonatomic,strong) NSDate *maxDate;

@property (nonatomic,assign) int DataType;
//总览view
@property (nonatomic,weak) MCTopTotalView *topView;
//图表view
@property (nonatomic,strong) MCChartView *chartView;
@property (nonatomic,weak) UIView *coverView;

@end

@implementation MCProxyHPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"代理首页";
    [self setUpUI];
    [self setNormalConfig];
    [self laodData];
}
- (void)laodData{
    MCOVerViewModel *overModel = [[MCOVerViewModel alloc] init];
    self.overViewModel = overModel;
    overModel._UserID = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    [overModel refreashDataAndShow];
     __weak typeof(self) weakself = self;
    overModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        weakself.topView.dataSource = [MCOVerViewModel mj_objectWithKeyValues:manager];
    };
    overModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
    };
    [self loadChartData];
}
- (void)loadChartData{
     __weak typeof(self) weakself = self;
    MCChartModel *charModel = [[MCChartModel alloc] init];
    self.chartModel = charModel;
    charModel.UserID = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    charModel.DataType = self.DataType;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateTemps = [dataFormatter stringFromDate:self.minDate];
    NSString *dateTempe = [dataFormatter stringFromDate:self.maxDate];
    charModel.BeginTime = [NSString stringWithFormat:@"%@ 00:00:00",dateTemps];
    charModel.EndTime = [NSString stringWithFormat:@"%@ 23:59:59",dateTempe];
    [charModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    charModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
       
        weakself.chartView.dataSource = [MCChartModel mj_objectArrayWithKeyValuesArray:manager];
    };
    charModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
    };
}
- (void)setNormalConfig{
    self.DataType = 0;
    self.minDate = [NSDate dateWithTimeIntervalSinceNow:-7*24*3600];
    self.maxDate = [NSDate dateWithTimeIntervalSinceNow:-24*3600];

}
- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
    [self.view addSubview:sc];
//    sc.contentSize = CGSizeMake(G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT - 64 - 49 + 60);
    self.view.backgroundColor = RGB(231, 231, 231);
    MCTopTotalView *topView = [[MCTopTotalView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(10) + 64, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(205))];
    self.topView = topView;
    topView.layer.cornerRadius = 6;
    topView.backgroundColor = [UIColor whiteColor];
    topView.clipsToBounds = YES;
    [sc addSubview:topView];
    MCButtonView *btnView = [[MCButtonView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(10) + 64 + MC_REALVALUE(205), G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(50))];
    __weak typeof(self) weakself = self;
    __weak MCButtonView *weakbtnView = btnView;
    btnView.dateBtnBlock = ^(NSInteger index) {
       
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
        [dataFormatter setDateFormat:@"yyyy/MM/dd"];
     
        switch (index) {
            case 101://7
            {
                self.minDate = [NSDate dateWithTimeIntervalSinceNow:-7*24*3600];
                self.maxDate = [NSDate dateWithTimeIntervalSinceNow:-24*3600];
            }
                break;
            case 102://15
            {
                self.minDate = [NSDate dateWithTimeIntervalSinceNow:-16*24*3600];
                self.maxDate = [NSDate dateWithTimeIntervalSinceNow:-24*3600];
            }
                break;
            case 103://30
            {
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                NSDateComponents *comps = nil;
                NSTimeZone *zone = [NSTimeZone systemTimeZone];
                NSInteger interval = [zone secondsFromGMTForDate:[NSDate dateWithTimeIntervalSinceNow:-24*3600]];
                NSDate *localDate = [[NSDate dateWithTimeIntervalSinceNow:-24*3600] dateByAddingTimeInterval: interval];
                comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:localDate];
                [comps setDay:comps.day];
                [comps setYear:comps.year];
                [comps setMonth:comps.month -1];
                self.minDate = [calendar dateFromComponents:comps];
                self.maxDate = [NSDate dateWithTimeIntervalSinceNow:-24*3600];
            }
                break;
            default:
                break;
        }
        [weakself loadChartData];
    };
    btnView.datePickerBlock = ^(NSDate *dateS, NSDate *dateE) {
        weakself.coverView.hidden = NO;
        weakself.datePicker.hidden = NO;
        weakself.datePicker.minDate = dateS;
        weakself.datePicker.maxDate = dateE;
        weakself.datePicker.cancelBlock = ^{
            weakself.coverView.hidden = YES;
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
            }];
        };
        weakself.datePicker.sureBlock = ^(NSString *selectDateStr) {
            weakself.coverView.hidden = YES;
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
                 NSString *str = [selectDateStr stringByReplacingOccurrencesOfString:@"/" withString:@""];
                [weakbtnView.beiginDateBtn setTitle:str forState:UIControlStateNormal];
                NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
                [dataFormatter setDateFormat:@"yyyyMMdd"];
                weakself.minDate = [dataFormatter dateFromString:str];

            }];
        };
    };
    
    btnView.datePickerBlockEnd = ^(NSDate *dateS, NSDate *dateE) {
        weakself.datePicker.hidden = NO;
        weakself.coverView.hidden = NO;
        weakself.datePicker.minDate = weakself.minDate;
        weakself.datePicker.maxDate = dateE;
        weakself.datePicker.cancelBlock = ^{
            weakself.coverView.hidden = YES;
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
            }];
        };
        weakself.datePicker.sureBlock = ^(NSString *selectDateStr) {
            weakself.coverView.hidden = YES;
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
                NSString *str = [selectDateStr stringByReplacingOccurrencesOfString:@"/" withString:@""];
                [weakbtnView.endDateBtn setTitle:str forState:UIControlStateNormal];
                NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
                [dataFormatter setDateFormat:@"yyyyMMdd"];
                weakself.maxDate = [dataFormatter dateFromString:selectDateStr];
            }];
        };
    };
    __weak MCButtonView *btnviews = btnView;
    btnView.searchBtnBlock = ^{
        //取消其它按钮状态
     btnviews.lastBtn.selected = NO;
     [weakself loadChartData];
    };
    btnView.backgroundColor = RGB(231, 231, 231);
    [sc addSubview:btnView];

    MCChartView *chartView = [[MCChartView alloc] init];
    chartView.layer.cornerRadius = 6;
    chartView.clipsToBounds = YES;
    self.chartView = chartView;
    [sc addSubview:chartView];
    chartView.dateTypeBtnBlock = ^(NSInteger index) {
        weakself.DataType = (int)index;
        NSLog(@"%d",weakself.DataType);
        [weakself loadChartData];
    };
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(topView);
        make.top.equalTo(btnView.mas_bottom).offset(MC_REALVALUE(0));
        make.bottom.equalTo(sc).offset(MC_REALVALUE(-17) - 49);
        make.height.equalTo(@(MC_REALVALUE(326)));
    }];
    
}
- (void)tap{
    self.datePicker.hidden = YES;
    self.coverView.hidden = YES;
}
- (DatePickerView *)datePicker{
    
    if (_datePicker == nil) {
        DatePickerView *datePicker =[[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:0] lastObject];
        datePicker.frame =CGRectMake(0, G_SCREENHEIGHT  - 200 - 49 , G_SCREENWIDTH, 200);
        datePicker.Datetitle =@"日期选择";
        [self.view addSubview:datePicker];
        _datePicker = datePicker;
    }
    return _datePicker;
}
- (UIView *)coverView{
    if (_coverView == nil) {
        UIView *cover = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:cover belowSubview:self.datePicker];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)] ];
        cover.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
        _coverView = cover;
    }
    return _coverView;
}
@end
