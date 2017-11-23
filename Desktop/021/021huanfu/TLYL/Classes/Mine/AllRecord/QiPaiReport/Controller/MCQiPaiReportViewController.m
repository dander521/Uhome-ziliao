//
//  MCQiPaiReportViewController.m
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQiPaiReportViewController.h"
#import "MCQiPaiPersonSlideView.h"
#import "MCQiPaiTeamSlideView.h"
#import "MCQiPaiReportFooterView.h"
#import "MCNaviSelectedPopView.h"
#import "MCDatePickerView.h"
#import "MCSignalPickView.h"
#import "MCGetMyReportModel.h"
#import "MCNaviButton.h"
#import "MCQiPaiReportFooterView.h"
#import "MCRecordTool.h"
#define MORENCOUNT 15
@interface MCQiPaiReportViewController ()

@property (nonatomic,strong)MCQiPaiReportFooterView * footerView;
//个人
@property (nonatomic,strong)MCQiPaiPersonSlideView *segmentedView1;
//团队
@property (nonatomic,strong)MCQiPaiTeamSlideView *segmentedView2;

/************************个人报表***************************/
@property(nonatomic, strong)MCNaviSelectedPopView *popView1;
@property(nonatomic, weak)  MCInputView * viewPop1;
@property(nonatomic, weak)  DatePickerView *datePicker1;
@property(nonatomic, assign)BOOL  isShowPopView1;

@property (nonatomic,strong) NSDate *start_minDate1;
@property (nonatomic,strong) NSDate *start_maxDate1;
@property (nonatomic,strong) NSDate *end_minDate1;
@property (nonatomic,strong) NSDate *end_maxDate1;

@property(nonatomic, strong) NSString * statTime1;
@property(nonatomic, strong) NSString * endTime1;
@property(nonatomic, strong) NSString * CurrentPageIndex1;
@property(nonatomic, strong) NSString * CurrentPageSize1;
@property(nonatomic, assign) BOOL IsHistory1;

/************************团队报表***************************/
@property(nonatomic, strong)MCNaviSelectedPopView *popView2;
@property(nonatomic, weak)  MCInputView * viewPop2;
@property(nonatomic, weak)  DatePickerView *datePicker2;
@property(nonatomic, assign)BOOL  isShowPopView2;

@property (nonatomic,strong) NSDate *start_minDate2;
@property (nonatomic,strong) NSDate *start_maxDate2;
@property (nonatomic,strong) NSDate *end_minDate2;
@property (nonatomic,strong) NSDate *end_maxDate2;

@property(nonatomic, strong) NSString * statTime2;
@property(nonatomic, strong) NSString * endTime2;
@property(nonatomic, strong) NSString * CurrentPageIndex2;
@property(nonatomic, strong) NSString * CurrentPageSize2;
@property(nonatomic, assign) BOOL IsHistory2;
@property(nonatomic, strong) NSString * GetUserType;//下级类型（0：全部，1：会员，2：代理）
@property(nonatomic, strong) NSString * UserName;//默认传空串，当搜索用户名时传所搜用户名
@end

@implementation MCQiPaiReportViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self setNav];
    
    [self createUI];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self dismissAllPopView1];
    [self dismissAllPopView2];
    
}
#pragma mark ================================setProperty
-(void)setProperty{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.clipsToBounds = NO;
    }
    
    self.view.backgroundColor=RGB(231,231,231);
    [self setProperty1];
    [self setProperty2];
}
#pragma mark ================================createUI
-(void)createUI{
    
    [self createSlide];
    
    [self createFooter];
    
}

#pragma mark ================================创建Slide
-(void)createSlide{
    
    self.title = @"棋牌个人报表";
    
    NSArray *array1 = [NSArray arrayWithObjects:@"每日统计",@"汇总统计",nil];
    _segmentedView1 = [MCQiPaiPersonSlideView segmentControlViewWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT-64-48)];
    _segmentedView1.normalColor = RGB(102,102,102);
    _segmentedView1.selectedColor = RGB(144,8,215 );
    _segmentedView1.SlideSelectedColor=RGB(144,8,215);
    _segmentedView1.titleArray = array1;
    _segmentedView1.selectedTitleArray = array1;
    [self.view addSubview:_segmentedView1];
    _segmentedView1.hidden=NO;

    
    NSArray *array2 = [NSArray arrayWithObjects:@"下级统计",@"自身统计",@"团队合计",nil];
    _segmentedView2 = [MCQiPaiTeamSlideView segmentControlViewWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT-64-48)];
    _segmentedView2.normalColor = RGB(102,102,102);
    _segmentedView2.selectedColor = RGB(144,8,215 );
    _segmentedView2.SlideSelectedColor=RGB(144,8,215);
    _segmentedView2.titleArray = array2;
    _segmentedView2.selectedTitleArray = array2;
    [self.view addSubview:_segmentedView2];
    _segmentedView2.hidden=YES;

}


-(void)createFooter{
    
    __weak __typeof__ (self) wself = self;

    _footerView=[[MCQiPaiReportFooterView alloc]init];
    [self.view addSubview:_footerView];
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(48);
    }];
    _footerView.block = ^(NSInteger t) {
        if (t==1) {
            wself.segmentedView1.hidden=NO;
            wself.segmentedView2.hidden=YES;
            wself.title = @"棋牌个人报表";
        }else{
            wself.segmentedView1.hidden=YES;
            wself.segmentedView2.hidden=NO;
            wself.title = @"棋牌团队报表";
        }
    };
    
}
#pragma mark ====================设置导航栏========================
-(void)setNav{
    
    MCNaviButton *rightBtn = [[MCNaviButton alloc] init];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)rightBtnAction{

    if (self.segmentedView1.hidden==NO) {
        [self rightBtnAction1];
    }else{
        [self rightBtnAction2];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark===============================================================
#pragma mark==================setProperty1======================
-(void)setProperty1{
    
    _isShowPopView1=NO;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    _IsHistory1=NO;
    _statTime1=[NSString stringWithFormat:@"%@ 00:00:00",currentDateStr];
    _endTime1=[NSString stringWithFormat:@"%@ 23:59:59",currentDateStr];
    _CurrentPageIndex1=@"1";
    _CurrentPageSize1=[NSString stringWithFormat:@"%d",MORENCOUNT];
    
    self.start_minDate1 = [NSDate date];
    self.start_maxDate1 = [NSDate date];
    self.end_minDate1 = [NSDate date];
    self.end_maxDate1 = [NSDate date];
    
    [self setQiPaiPersonProperty1];
}

- (MCNaviSelectedPopView *)popView1{
    
    if (_popView1 == nil) {
        MCNaviSelectedPopView * popView1 = [[MCNaviSelectedPopView alloc]InitWithType:MCNaviSelectedPopType_PersonReport];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        [popView1 addGestureRecognizer:tap1];
        [self.navigationController.view addSubview:popView1];
        _popView1 = popView1;
    }
    return _popView1;
}

- (MCInputView *)viewPop1{
    if (_viewPop1 == nil) {
        
        MCInputView *viewStatus = [[MCInputView alloc] init];
        [self.navigationController.view addSubview:viewStatus];
        _viewPop1 = viewStatus;
    }
    return _viewPop1;
}
- (DatePickerView *)datePicker1{
    
    if (_datePicker1 == nil) {
        DatePickerView *datePicker1 =[[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:0] lastObject];
        datePicker1.frame =CGRectMake(0,self.view.frame.size.height  - 200 + 64, self.view.frame.size.width, 200);
        datePicker1.Datetitle =@"日期选择";
        [self.navigationController.view addSubview:datePicker1];
        _datePicker1 = datePicker1;
    }
    return _datePicker1;
}
- (void)tap1{
    _isShowPopView1=NO;
    [self dismissAllPopView1];
    _isShowPopView2=NO;
    [self dismissAllPopView2];
}
-(void)dismissAllPopView1{
    [self.popView1 dismiss];
    [self.viewPop1 hiden];
    [self.datePicker1 removeFromSuperview];
}


-(void)rightBtnAction1{
    
    if (_isShowPopView1) {
        _isShowPopView1=NO;
        [self.popView1 dismiss];
        
    }else{
        _isShowPopView1=YES;
        
        
        typeof(self) weakself = self;
        
        self.popView1.block = ^(NSInteger type) {
            
            if (type==0) {
#pragma mark-记录选择
            }else if (type==1){
                
                [weakself.datePicker1 removeFromSuperview];
                
                weakself.viewPop1.dataArray = @[@"当天记录",@"历史记录"];
                [weakself.viewPop1 show];
                weakself.viewPop1.cellDidSelected = ^(NSInteger i) {
                    
                    [weakself.viewPop1 hiden];
                    weakself.popView1.label2.text = weakself.viewPop1.dataArray[i];
                    if (i == 0) {
                        
#pragma mark----------个人报表的每日统计【当前记录】【只能当天】
                        weakself.IsHistory1 = NO;
                        weakself.start_minDate1 = [NSDate date];
                        weakself.start_maxDate1 = [NSDate date];
                        weakself.end_minDate1 = [NSDate date];
                        weakself.end_maxDate1 = [NSDate date];
                        
                    } else {
                        
#pragma mark----------个人报表的每日统计【历史记录】【3个月】
                        weakself.IsHistory1 = YES;
                        weakself.start_minDate1 = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:-3 day:1];
                        weakself.start_maxDate1 = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-1];
                        weakself.end_minDate1 = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-1];
                        weakself.end_maxDate1 = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-1];
                        
                    }
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                    NSString *endDateStr = [dateFormatter stringFromDate:weakself.end_maxDate1];
                    
                    weakself.statTime1 =[NSString stringWithFormat:@"%@ 00:00:00",endDateStr];
                    weakself.endTime1 = [NSString stringWithFormat:@"%@ 23:59:59",endDateStr];
                    weakself.popView1.label3.text = [NSString stringWithFormat:@"%@",endDateStr];
                    weakself.popView1.label4.text = [NSString stringWithFormat:@"%@",endDateStr];
                };
                
            }else if (type==2){
#pragma mark-开始时间
                [weakself.viewPop1 hiden];
                
                weakself.datePicker1.minDate=weakself.start_minDate1;
                weakself.datePicker1.maxDate=weakself.start_maxDate1;
                
                weakself.datePicker1.cancelBlock = ^{
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker1 removeFromSuperview];
                    }];
                };
                
                weakself.datePicker1.sureBlock = ^(NSString *selectDateStr) {
                    
                    weakself.popView1.label3.text = [NSString stringWithFormat:@"%@",selectDateStr];
                    weakself.statTime1 = [NSString stringWithFormat:@"%@ 00:00:00",selectDateStr];
                    weakself.end_minDate1=[MCRecordTool getDateWithStr:[NSString stringWithFormat:@"%@ 00:00:00",selectDateStr]];
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker1 removeFromSuperview];
                        
                    }];
                };
                
                
            }else if (type==3){
#pragma mark-结束时间
                [weakself.viewPop1 hiden];
                
                weakself.datePicker1.minDate=weakself.end_minDate1;
                weakself.datePicker1.maxDate=weakself.end_maxDate1;
                
                [weakself.viewPop1 hiden];
                weakself.datePicker1.cancelBlock = ^{
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker1 removeFromSuperview];
                    }];
                };
                
                weakself.datePicker1.sureBlock = ^(NSString *selectDateStr) {
                    weakself.start_maxDate1=[MCRecordTool getDateWithStr:[NSString stringWithFormat:@"%@ 00:00:00",selectDateStr]];
                    weakself.popView1.label4.text = [NSString stringWithFormat:@"%@",selectDateStr];
                    weakself.endTime1 = [NSString stringWithFormat:@"%@ 23:59:59",selectDateStr];
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker1 removeFromSuperview];
                        
                    }];
                };
#pragma mark-搜索
            }else if (type==8){
                weakself.isShowPopView1=NO;
                [weakself dismissAllPopView1];
                //                [weakself refreashData];
                [weakself setQiPaiPersonProperty1];
                [weakself.segmentedView1.dailyCell refreashQiPaiPersonProperty];
                [weakself.segmentedView1.dailyCell refreashData];

                [weakself.segmentedView1.summaryCell refreashQiPaiPersonProperty];
                [weakself.segmentedView1.summaryCell refreashData];
            }
        };
        
        self.popView1.frame= CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT);
        [self.popView1 showPopView];
    }
    
}

-(void)setQiPaiPersonProperty1{
    MCQiPaiPersonProperty * PersonProperty = [MCQiPaiPersonProperty sharedMCQiPaiPersonProperty];
    PersonProperty.statTime=self.statTime1;
    PersonProperty.endTime=self.endTime1;
    PersonProperty.CurrentPageIndex=self.CurrentPageIndex1;
    PersonProperty.CurrentPageSize=self.CurrentPageSize1;
}

#pragma mark===============================================================
#pragma mark==================setProperty2======================
-(void)setProperty2{

    _isShowPopView2=NO;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    _IsHistory2=NO;
    _statTime2=[NSString stringWithFormat:@"%@ 00:00:00",currentDateStr];
    _endTime2=[NSString stringWithFormat:@"%@ 23:59:59",currentDateStr];
    _CurrentPageIndex2=@"1";
    _CurrentPageSize2=[NSString stringWithFormat:@"%d",MORENCOUNT];
    _GetUserType = @"0";
    _UserName = @"";
    
    self.start_minDate2 = [NSDate date];
    self.start_maxDate2 = [NSDate date];
    self.end_minDate2 = [NSDate date];
    self.end_maxDate2 = [NSDate date];
    
    [self setQiPaiTeamProperty2];
}

- (MCNaviSelectedPopView *)popView2{

    if (_popView2 == nil) {
        MCNaviSelectedPopView * popView2 = [[MCNaviSelectedPopView alloc]InitWithType:MCNaviSelectedPopType_QiPaiXiaJiReport];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
        [popView2 addGestureRecognizer:tap2];
        [self.navigationController.view addSubview:popView2];
        _popView2 = popView2;
    }
    return _popView2;
}

- (MCInputView *)viewPop2{
    if (_viewPop2 == nil) {
        
        MCInputView *viewStatus = [[MCInputView alloc] init];
        [self.navigationController.view addSubview:viewStatus];
        _viewPop2 = viewStatus;
    }
    return _viewPop2;
}
- (DatePickerView *)datePicker2{
    
    if (_datePicker2 == nil) {
        DatePickerView *datePicker2 =[[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:0] lastObject];
        datePicker2.frame =CGRectMake(0,self.view.frame.size.height  - 200 + 64, self.view.frame.size.width, 200);
        datePicker2.Datetitle =@"日期选择";
        [self.navigationController.view addSubview:datePicker2];
        _datePicker2 = datePicker2;
    }
    return _datePicker2;
}
- (void)tap2{
    _isShowPopView1=NO;
    [self dismissAllPopView1];
    _isShowPopView2=NO;
    [self dismissAllPopView2];
}
-(void)dismissAllPopView2{
    [self.popView2 dismiss];
    [self.viewPop2 hiden];
    [self.datePicker2 removeFromSuperview];
}


-(void)rightBtnAction2{
    
    if (_isShowPopView2) {
        _isShowPopView2=NO;
        [self.popView2 dismiss];
        
    }else{
        _isShowPopView2=YES;
        
        
        typeof(self) weakself = self;
        
        self.popView2.block = ^(NSInteger type) {
            
            if (type==0) {
                
#pragma mark-下级类型
            }else if(type==1){
                [weakself.datePicker2 removeFromSuperview];
                
                weakself.viewPop2.dataArray = @[@"全部",@"会员",@"代理"];
                [weakself.viewPop2 show];
                weakself.viewPop2.cellDidSelectedTop = ^(NSInteger i) {

                    [weakself.viewPop2 hiden];
                    weakself.popView2.xiajiType.text = weakself.viewPop2.dataArray[i];
                    if (i == 0) {
                        weakself.GetUserType=@"0";
                    }else if(i == 1){
                        weakself.GetUserType=@"1";
                    }else if(i == 2){
                        weakself.GetUserType=@"2";
                    }
                };
     
#pragma mark-记录选择
            }else if (type==2){
                
                [weakself.datePicker2 removeFromSuperview];
                
                weakself.viewPop2.dataArray = @[@"当天记录",@"历史记录"];
                [weakself.viewPop2 show];
                weakself.viewPop2.cellDidSelected = ^(NSInteger i) {
                    
                    [weakself.viewPop2 hiden];
                    weakself.popView2.label2.text = weakself.viewPop2.dataArray[i];
                    if (i == 0) {
                        
#pragma mark----------个人报表的每日统计【当前记录】【只能当天】
                        weakself.IsHistory2 = NO;
                        weakself.start_minDate2 = [NSDate date];
                        weakself.start_maxDate2 = [NSDate date];
                        weakself.end_minDate2 = [NSDate date];
                        weakself.end_maxDate2 = [NSDate date];
                        
                    } else {
                        
#pragma mark----------个人报表的每日统计【历史记录】【3个月】
                        weakself.IsHistory2 = YES;
                        weakself.start_minDate2 = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:-3 day:1];
                        weakself.start_maxDate2 = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-1];
                        weakself.end_minDate2 = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-1];
                        weakself.end_maxDate2 = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-1];
                        
                    }
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                    NSString *endDateStr = [dateFormatter stringFromDate:weakself.end_maxDate2];
                    
                    weakself.statTime2 =[NSString stringWithFormat:@"%@ 00:00:00",endDateStr];
                    weakself.endTime2 = [NSString stringWithFormat:@"%@ 23:59:59",endDateStr];
                    weakself.popView2.label3.text = [NSString stringWithFormat:@"%@",endDateStr];
                    weakself.popView2.label4.text = [NSString stringWithFormat:@"%@",endDateStr];
                };
                
            }else if (type==3){
#pragma mark-开始时间
                [weakself.viewPop2 hiden];
                
                weakself.datePicker2.minDate=weakself.start_minDate2;
                weakself.datePicker2.maxDate=weakself.start_maxDate2;
                
                weakself.datePicker2.cancelBlock = ^{
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker2 removeFromSuperview];
                    }];
                };
                
                weakself.datePicker2.sureBlock = ^(NSString *selectDateStr) {
                    
                    weakself.popView2.label3.text = [NSString stringWithFormat:@"%@",selectDateStr];
                    weakself.statTime2 = [NSString stringWithFormat:@"%@ 00:00:00",selectDateStr];
                    weakself.end_minDate2=[MCRecordTool getDateWithStr:[NSString stringWithFormat:@"%@ 00:00:00",selectDateStr]];
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker2 removeFromSuperview];
                        
                    }];
                };
                
                
            }else if (type==4){
#pragma mark-结束时间
                [weakself.viewPop2 hiden];
                
                weakself.datePicker2.minDate=weakself.end_minDate2;
                weakself.datePicker2.maxDate=weakself.end_maxDate2;
                
                [weakself.viewPop2 hiden];
                weakself.datePicker2.cancelBlock = ^{
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker2 removeFromSuperview];
                    }];
                };
                
                weakself.datePicker2.sureBlock = ^(NSString *selectDateStr) {
                    weakself.start_maxDate2=[MCRecordTool getDateWithStr:[NSString stringWithFormat:@"%@ 00:00:00",selectDateStr]];
                    weakself.popView2.label4.text = [NSString stringWithFormat:@"%@",selectDateStr];
                    weakself.endTime2 = [NSString stringWithFormat:@"%@ 23:59:59",selectDateStr];
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker2 removeFromSuperview];
                        
                    }];
                };
#pragma mark-搜索
            }else if (type==8){
                weakself.isShowPopView2=NO;
                [weakself dismissAllPopView2];
                
                [weakself setQiPaiTeamProperty2];

                [weakself.segmentedView2.xiaJiCell refreashQiPaiPersonProperty];
                [weakself.segmentedView2.xiaJiCell refreashData];
                
                [weakself.segmentedView2.myselfCell refreashQiPaiPersonProperty];
                [weakself.segmentedView2.myselfCell refreashData];
                
                [weakself.segmentedView2.teamCell refreashQiPaiPersonProperty];
                [weakself.segmentedView2.teamCell refreashData];
            }
        };
        
        self.popView2.frame= CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT);
        [self.popView2 showPopView];
    }
    
}


-(void)setQiPaiTeamProperty2{
    if (self.popView2.tf1.text.length>0) {
        _UserName=self.popView2.tf1.text;
    }
    
    MCQiPaiTeamProperty * TeamProperty = [MCQiPaiTeamProperty sharedMCQiPaiTeamProperty];
    TeamProperty.statTime=self.statTime2;
    TeamProperty.endTime=self.endTime2;
    TeamProperty.CurrentPageIndex=self.CurrentPageIndex2;
    TeamProperty.CurrentPageSize=self.CurrentPageSize2;
    TeamProperty.UserName=self.UserName;
    TeamProperty.GetUserType=self.GetUserType;
    
}
@end















