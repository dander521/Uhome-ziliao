//
//  MCPersonReportViewController.m
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPersonReportViewController.h"
#import "MCPersonReportSlideView.h"
#import "MCNaviSelectedPopView.h"
#import "MCDatePickerView.h"
#import "MCSignalPickView.h"
#import "MCNaviButton.h"
#import "MCNaviSelectedPopView.h"
#import <MJRefresh/MJRefresh.h>
#import "MCRecordTool.h"
#import "MCDatePickerView.h"

#define MORENCOUNT 15

@interface MCPersonReportViewController ()
<
MCSlideDelegate
>

@property (nonatomic,strong)MCPersonReportSlideView *segmentedView;

typedef void(^Compeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic, strong) NSString * statTime;
@property(nonatomic, strong) NSString * endTime;
@property(nonatomic, strong) NSString * CurrentPageIndex;
@property(nonatomic, strong) NSString * CurrentPageSize    ;
@property(nonatomic, assign) BOOL IsHistory;


@property(nonatomic, strong)MCNaviSelectedPopView *popView;
@property(nonatomic, weak)  MCInputView * viewPop;
@property(nonatomic, weak)  DatePickerView *datePicker;
@property(nonatomic, assign) BOOL  isShowPopView;

@property (nonatomic,strong) NSDate *start_minDate;
@property (nonatomic,strong) NSDate *start_maxDate;
@property (nonatomic,strong) NSDate *end_minDate;
@property (nonatomic,strong) NSDate *end_maxDate;

@property (nonatomic,strong) MCGetMyReportModel * getMyReportModel;
//@property (nonatomic,strong) MCGetMyReportDataModel * Rmodel;
@property(nonatomic, strong)NSMutableArray <MCGetMyReportlstModel *>* dataMarray;


@end

@implementation MCPersonReportViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self setNav];
    
    [self createUI];
    
    [self refreashData];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self dismissAllPopView];
}

-(void)dismissAllPopView{
    [self.popView dismiss];
    [self.viewPop hiden];
    [self.datePicker removeFromSuperview];
}

-(void)createUI{
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.clipsToBounds = NO;
    }
    
    self.view.backgroundColor=RGB(231,231,231);
    [self createSlide];
    
}

#pragma mark ================================创建Slide
-(void)createSlide{
    
    self.title = @"个人报表"; 
    NSArray *array = [NSArray arrayWithObjects:@"每日统计",@"汇总统计",nil];
    _segmentedView = [MCPersonReportSlideView segmentControlViewWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT-64)];
    
    _segmentedView.normalColor = RGB(102,102,102);
    _segmentedView.selectedColor = RGB(144,8,215 );
    _segmentedView.SlideSelectedColor=RGB(144,8,215);
    
    _segmentedView.titleArray = array;
    _segmentedView.selectedTitleArray = array;
    _segmentedView.delegate=self;
    [self.view addSubview:_segmentedView];
    
    
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

#pragma mark==================setProperty======================
-(void)setProperty{
    
    _isShowPopView=NO;    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    _IsHistory=NO;
    _statTime=[NSString stringWithFormat:@"%@ 00:00:00",currentDateStr];
    _endTime=[NSString stringWithFormat:@"%@ 23:59:59",currentDateStr];
    _CurrentPageIndex=@"1";
    _CurrentPageSize=[NSString stringWithFormat:@"%d",MORENCOUNT];
    _dataMarray=[[NSMutableArray alloc]init];
    
    self.start_minDate = [NSDate date];
    self.start_maxDate = [NSDate date];
    self.end_minDate = [NSDate date];
    self.end_maxDate = [NSDate date];
    
}

- (MCNaviSelectedPopView *)popView{
    
    if (_popView == nil) {
        MCNaviSelectedPopView * popView = [[MCNaviSelectedPopView alloc]InitWithType:MCNaviSelectedPopType_PersonReport];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [popView addGestureRecognizer:tap];
        [self.navigationController.view addSubview:popView];
        _popView = popView;
    }
    return _popView;
}
- (MCInputView *)viewPop{
    if (_viewPop == nil) {
        
        MCInputView *viewStatus = [[MCInputView alloc] init];
        [self.navigationController.view addSubview:viewStatus];
        _viewPop = viewStatus;
    }
    return _viewPop;
}
- (DatePickerView *)datePicker{
    
    if (_datePicker == nil) {
        DatePickerView *datePicker =[[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:0] lastObject];
        datePicker.frame =CGRectMake(0,self.view.frame.size.height  - 200 + 64, self.view.frame.size.width, 200);
        datePicker.Datetitle =@"日期选择";
        [self.navigationController.view addSubview:datePicker];
        _datePicker = datePicker;
    }
    return _datePicker;
}
- (void)tap{
    _isShowPopView=NO;
    [self dismissAllPopView];
}

-(void)rightBtnAction{
    
    if (_isShowPopView) {
        _isShowPopView=NO;
        [self.popView dismiss];
        
    }else{
        _isShowPopView=YES;
        
        typeof(self) weakself = self;
        
        self.popView.block = ^(NSInteger type) {
            
            if (type==0) {
#pragma mark-记录选择
            }else if (type==1){
                
                [weakself.datePicker removeFromSuperview];
                
                weakself.viewPop.dataArray = @[@"当天记录",@"历史记录"];
                [weakself.viewPop show];
                weakself.viewPop.cellDidSelected = ^(NSInteger i) {
                    
                    [weakself.viewPop hiden];
                    weakself.popView.label2.text = weakself.viewPop.dataArray[i];
                    if (i == 0) {
                        
#pragma mark----------个人报表的每日统计【当前记录】【只能当天】
                        weakself.IsHistory = NO;
                        weakself.start_minDate = [NSDate date];
                        weakself.start_maxDate = [NSDate date];
                        weakself.end_minDate = [NSDate date];
                        weakself.end_maxDate = [NSDate date];
                        
                    } else {
                        
#pragma mark----------个人报表的每日统计【历史记录】【3个月】
                        weakself.IsHistory = YES;
                        weakself.start_minDate = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:-3 day:1];
                        weakself.start_maxDate = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-1];
                        weakself.end_minDate = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-1];
                        weakself.end_maxDate = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-1];
                        
                    }
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                    NSString *endDateStr = [dateFormatter stringFromDate:weakself.end_maxDate];
                    
                    weakself.statTime =[NSString stringWithFormat:@"%@ 00:00:00",endDateStr];
                    weakself.endTime = [NSString stringWithFormat:@"%@ 23:59:59",endDateStr];

                    weakself.popView.label3.text = [NSString stringWithFormat:@"%@",endDateStr];
                    weakself.popView.label4.text = [NSString stringWithFormat:@"%@",endDateStr];
                };
                
            }else if (type==2){
#pragma mark-开始时间
                [weakself.viewPop hiden];
                
                weakself.datePicker.minDate=weakself.start_minDate;
                weakself.datePicker.maxDate=weakself.start_maxDate;
                
                weakself.datePicker.cancelBlock = ^{
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker removeFromSuperview];
                    }];
                };
                
                weakself.datePicker.sureBlock = ^(NSString *selectDateStr) {
                    weakself.popView.label3.text = [NSString stringWithFormat:@"%@",selectDateStr];
                    weakself.statTime = [NSString stringWithFormat:@"%@ 00:00:00",selectDateStr];
                    weakself.end_minDate=[MCRecordTool getDateWithStr:[NSString stringWithFormat:@"%@ 00:00:00",selectDateStr]];
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker removeFromSuperview];
                        
                    }];
                };
                
                
            }else if (type==3){
#pragma mark-结束时间
                [weakself.viewPop hiden];
                
                weakself.datePicker.minDate=weakself.end_minDate;
                weakself.datePicker.maxDate=weakself.end_maxDate;
                
                [weakself.viewPop hiden];
                weakself.datePicker.cancelBlock = ^{
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker removeFromSuperview];
                    }];
                };
                
                weakself.datePicker.sureBlock = ^(NSString *selectDateStr) {
                    weakself.start_maxDate=[MCRecordTool getDateWithStr:[NSString stringWithFormat:@"%@ 00:00:00",selectDateStr]];
                    weakself.popView.label4.text = [NSString stringWithFormat:@"%@",selectDateStr];
                    weakself.endTime = [NSString stringWithFormat:@"%@ 23:59:59",selectDateStr];
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker removeFromSuperview];
                        
                    }];
                };
#pragma mark-搜索
            }else if (type==8){
                weakself.isShowPopView=NO;
                [weakself dismissAllPopView];
                [weakself refreashData];
            }
        };
        
        self.popView.frame= CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT);
        [self.popView showPopView];
    }
    
}

- (void)refreashData{
    
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    
    self.segmentedView.dailyCell.tableView.mj_footer.hidden=NO;

    [_dataMarray removeAllObjects];
    
    [BKIndicationView showInView:self.view];
    __weak __typeof__ (self) wself = self;
    _CurrentPageIndex=@"1";
    
    [self loadData:^(BOOL result, NSDictionary *data) {
        
        [_segmentedView.dailyCell.tableView.mj_footer endRefreshing];
        [_segmentedView.dailyCell.tableView.mj_header endRefreshing];
        
        [_segmentedView.summaryCell.tableView.mj_footer endRefreshing];
        [_segmentedView.summaryCell.tableView.mj_header endRefreshing];
        
        if (result) {
            
            [wself setData:data];
            
        }else{
            wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
            ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                [wself.exceptionView dismiss];
                wself.exceptionView = nil;
                [wself refreashData];
            }];
            [wself.exceptionView addAction:action];
            [wself.exceptionView showInView:self.view];
        }
    }];
    
}

-(void)loadMoreData{
    
    _CurrentPageIndex=[NSString stringWithFormat:@"%d",[_CurrentPageIndex intValue]+1];
    [BKIndicationView showInView:self.view];
    __weak __typeof__ (self) wself = self;
    [self loadData:^(BOOL result, NSDictionary *data) {
        
        [_segmentedView.dailyCell.tableView.mj_footer endRefreshing];
        [_segmentedView.dailyCell.tableView.mj_header endRefreshing];
        
        [_segmentedView.summaryCell.tableView.mj_footer endRefreshing];
        [_segmentedView.summaryCell.tableView.mj_header endRefreshing];
        
        if (result) {
            [wself setData:data];
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            wself.CurrentPageIndex=[NSString stringWithFormat:@"%d",[_CurrentPageIndex intValue]-1];
        }
    }];
    
}

#pragma mark==================loadData======================
-(void)loadData:(Compeletion)compeletion{
    //UserID    是    Int    固定值：-1
    //BeginTime    是    String    开始查询时间
    //EndTime    是    String    结束查询时间
    //CurrentPageIndex    是    String    当前页下标
    //CurrentPageSize    是    String    当前页请求条目数
    NSDictionary * dic=@{
//                         @"UserID":@"-1",
                         @"UserID":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                         @"BeginTime":_statTime,
                         @"EndTime":_endTime,
                         @"CurrentPageIndex":_CurrentPageIndex,
                         @"CurrentPageSize":_CurrentPageSize
                         };
    
    MCGetMyReportModel * getMyReportModel = [[MCGetMyReportModel alloc]initWithDic:dic];
    [getMyReportModel refreashDataAndShow];
    self.getMyReportModel = getMyReportModel;
    
    getMyReportModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        compeletion(NO,nil);
        
    };
    
    getMyReportModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
    
}

-(void)setData:(NSDictionary *)dic{
    
    _Rmodel=[MCGetMyReportDataModel mj_objectWithKeyValues:dic];
    _segmentedView.summaryCell.Rmodel=_Rmodel;
    [_segmentedView.summaryCell.tableView reloadData];
    
    if (_Rmodel.Reportlst.count<1) {
        if (_dataMarray.count<1) {
            //无数据
            self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
            [self.exceptionView showInView:_segmentedView.dailyCell.tableView];
            return;
        }else{
            _segmentedView.dailyCell.tableView.mj_footer.hidden=YES;
        }
        
    }
    
    [_dataMarray addObjectsFromArray:_Rmodel.Reportlst];
    
    if (_dataMarray.count%MORENCOUNT!=0) {
        _segmentedView.dailyCell.tableView.mj_footer.hidden=YES;
    }
    
    
    
    _segmentedView.dailyCell.dataMarray=_dataMarray;
    [_segmentedView.dailyCell.tableView reloadData];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end














