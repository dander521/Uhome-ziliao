//
//  MCzhongJiangRecoredViewController.m
//  TLYL
//
//  Created by MC on 2017/10/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCzhongJiangRecoredViewController.h"
#import "MCUserWinRecordModel.h"
#import "MCMineCellModel.h"
#import "ExceptionView.h"
#import "MCDataTool.h"
#import <MJRefresh/MJRefresh.h>
#import "MCzhongJiangRecoredTableViewCell.h"
#import "MCUserDefinedAPIModel.h"
#import "MCNaviSelectedPopView.h"
#import "MCSignalPickView.h"
#import "MCRecordTool.h"
#import "MCDatePickerView.h"
#import "MCInputView.h"
#import "DatePickerView.h"
#import "MCUserWinRecordModel.h"
#import "MCGameRecordDetailViewController.h"

#define MORENCOUNT 15
@interface MCzhongJiangRecoredViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

typedef void(^Compeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic, strong)MCUserWinRecordModel * userWinRecordModel;

@property(nonatomic, strong)NSMutableArray * dataMarray;

@property(nonatomic, strong)MCNaviSelectedPopView *popView;
@property(nonatomic, weak)MCInputView * viewPop;
@property(nonatomic, weak)DatePickerView *datePicker;
@property(nonatomic, assign)BOOL  isShowPopView;

@property (nonatomic,strong) NSDate *start_minDate;
@property (nonatomic,strong) NSDate *start_maxDate;
@property (nonatomic,strong) NSDate *end_minDate;
@property (nonatomic,strong) NSDate *end_maxDate;


@end

@implementation MCzhongJiangRecoredViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setProperty];
    
    [self setNav];
    
    [self createUI];
    
    [self refreashData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self dismissAllPopView];
}

-(void)dismissAllPopView{
    [self.popView dismiss];
    [self.viewPop hiden];
    [self.datePicker removeFromSuperview];
}


#pragma mark==================setProperty======================
-(void)setProperty{
    _isShowPopView=NO;
    self.view.backgroundColor=RGB(231, 231, 231);
    self.navigationItem.title = @"中奖记录";
    _dataMarray=[[NSMutableArray alloc]init];
    if (!_LotteryCode) {
        _LotteryCode=@"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    _IsHistory=NO;
    _statTime=[NSString stringWithFormat:@"%@ 00:00:00",currentDateStr];
    _endTime=[NSString stringWithFormat:@"%@ 23:59:59",currentDateStr];
    _CurrentPageIndex=@"1";
    _CurrentPageSize=[NSString stringWithFormat:@"%d",MORENCOUNT];
 
    self.start_minDate =[MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-3];
    self.start_maxDate = [NSDate date];
    self.end_minDate = [NSDate date];
    self.end_maxDate = [NSDate date];
}

#pragma mark==================createUI======================
-(void)createUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.layer.cornerRadius=5;
    _tableView.clipsToBounds=YES;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreashData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
    }];
    
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
- (MCNaviSelectedPopView *)popView{
    
    if (_popView == nil) {
        MCNaviSelectedPopView * popView = [[MCNaviSelectedPopView alloc]InitWithType:MCNaviSelectedPopType_ZhuiHao];
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
        datePicker.frame =CGRectMake(0, self.view.frame.size.height  - 200 + 64, self.view.frame.size.width, 200);
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
    NSArray * arr=[MCUserDefinedAPIModel getGameRecordMarr];
    if (_isShowPopView) {
        _isShowPopView=NO;
        [self dismissAllPopView];
        
    }else{
        _isShowPopView=YES;
        
        NSMutableArray *arrTemp = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            [arrTemp addObject:dic[@"name"]];
        }
        typeof(self) weakself = self;
        
        self.popView.block = ^(NSInteger type) {
#pragma mark-彩种选择
            if (type==0) {
                [weakself.datePicker removeFromSuperview];
                
                weakself.viewPop.dataArray = arr;
                weakself.viewPop.cellDidSelectedBlock = ^(NSDictionary * dic) {
                    weakself.popView.label1.text = dic[@"name"];
                    weakself.LotteryCode = dic[@"lotteryId"];
                    [weakself.viewPop hiden];
                };
                [weakself.viewPop show];
                
#pragma mark-记录选择
            }else if (type==1){
                
                [weakself.datePicker removeFromSuperview];
                
                weakself.viewPop.dataArray = @[@"当前记录",@"历史记录"];
                [weakself.viewPop show];
                weakself.viewPop.cellDidSelected = ^(NSInteger i) {
                    
                    [weakself.viewPop hiden];
                    weakself.popView.label2.text = weakself.viewPop.dataArray[i];
                    if (i == 0) {
                        
                        weakself.IsHistory = NO;
                        weakself.start_minDate =[MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-3];
                        weakself.start_maxDate = [NSDate date];
                        weakself.end_minDate = [NSDate date];
                        weakself.end_maxDate = [NSDate date];
                        
                    } else {
                        
                        weakself.IsHistory = YES;

                        weakself.start_minDate = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:-1 day:-3];
                        weakself.start_maxDate = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-4];
                        
                        weakself.end_minDate = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-4];
                        weakself.end_maxDate = [MCRecordTool getLaterDateFromDate:[NSDate date] withYear:0 month:0 day:-4];
                        
                    }
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                    NSString *endDateStr = [dateFormatter stringFromDate:weakself.end_maxDate];
                    
                    weakself.statTime =[NSString stringWithFormat:@"%@ 00:00:00",endDateStr];
                    weakself.endTime = [NSString stringWithFormat:@"%@ 23:59:59",endDateStr];
                    weakself.popView.label3.text = [NSString stringWithFormat:@"%@",endDateStr];
                    weakself.popView.label4.text = [NSString stringWithFormat:@"%@",endDateStr];
//                    weakself.popView.label3.text = [NSString stringWithFormat:@"%@ 00:00:00",endDateStr];
//                    weakself.popView.label4.text = [NSString stringWithFormat:@"%@ 23:59:59",endDateStr];
                };
                
#pragma mark-开始时间
            }else if (type==2){
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
//                    weakself.popView.label3.text = [NSString stringWithFormat:@"%@ 00:00:00",selectDateStr];
                    weakself.statTime = [NSString stringWithFormat:@"%@ 00:00:00",selectDateStr];
                    weakself.end_minDate=[MCRecordTool getDateWithStr:[NSString stringWithFormat:@"%@ 00:00:00",selectDateStr]];
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        [weakself.datePicker removeFromSuperview];
                    }];
                };
                
                
#pragma mark-结束时间
            }else if (type==3){
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
//                    weakself.popView.label4.text = [NSString stringWithFormat:@"%@ 23:59:59",selectDateStr];
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


#pragma mark-下拉刷新
- (void)refreashData{
    self.tableView.mj_footer.hidden=NO;
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    
    [BKIndicationView showInView:self.view];
    __weak __typeof__ (self) wself = self;
    _CurrentPageIndex=@"1";
    
    [self loadData:^(BOOL result, NSDictionary *data) {
        [wself.tableView.mj_footer endRefreshing];
        [wself.tableView.mj_header endRefreshing];
        if (result) {
            [wself.dataMarray removeAllObjects];
            [wself setData:data];
            
        }else{
            wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
            ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                [wself.exceptionView dismiss];
                wself.exceptionView = nil;
                [wself refreashData];
            }];
            [wself.exceptionView addAction:action];
            [wself.exceptionView showInView:wself.view];
        }
    }];
    
}


-(void)loadMoreData{
    
    _CurrentPageIndex=[NSString stringWithFormat:@"%d",[_CurrentPageIndex intValue]+1];
    [BKIndicationView showInView:self.view];
    __weak __typeof__ (self) wself = self;
    [self loadData:^(BOOL result, NSDictionary *data) {
        [wself.tableView.mj_footer endRefreshing];
        [wself.tableView.mj_header endRefreshing];
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

    NSDictionary * dic=@{
                         @"LotteryCode":_LotteryCode,
                         @"IsHistory":[NSNumber numberWithBool:_IsHistory],
                         @"OrderState":@"16777216",
                         @"insertTimeMin":_statTime,
                         @"insertTimeMax":_endTime,
                         @"CurrentPageIndex":_CurrentPageIndex,
                         @"CurrentPageSize":_CurrentPageSize
                         };
    
    
    MCUserWinRecordModel * userWinRecordModel = [[MCUserWinRecordModel alloc]initWithDic:dic];
    [userWinRecordModel refreashDataAndShow];
    self.userWinRecordModel = userWinRecordModel;
    
    userWinRecordModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
        compeletion(NO,nil);
        
    };
    
    userWinRecordModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
    
}

-(void)setData:(NSDictionary *)dic{
    
    NSArray * arr=dic[@"BtInfo"];

    if (arr.count<1) {
        //无数据
        self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
        [self.exceptionView showInView:self.view];
        return;
    }

    if (arr.count%MORENCOUNT!=0) {
        self.tableView.mj_footer.hidden=YES;
    }
    for (NSDictionary * temp in arr) {
        MCUserWinRecordDetailDataModel * model = [MCUserWinRecordDetailDataModel mj_objectWithKeyValues:temp];
        [_dataMarray addObject:model];
    }
    [self.tableView reloadData];
    
}

#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataMarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MCzhongJiangRecoredTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCzhongJiangRecoredTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCzhongJiangRecoredTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCzhongJiangRecoredTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.dataSource=self.dataMarray[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    MCGameRecordDetailViewController *vc = [[MCGameRecordDetailViewController alloc] init];
    
    MCUserWinRecordDetailDataModel * model =self.dataMarray[indexPath.row];
    MCGameRecordModel *dataSource = [[MCGameRecordModel alloc]init];
    dataSource.AwardMoney=model.AwardMoney;
    dataSource.BetContent=model.BetContent;
    dataSource.BetInfo_ID=model.BetInfo_ID;
    dataSource.BetMode=model.BetMode;
    dataSource.BetMoney=model.BetMoney;
    dataSource.BetMultiple=model.BetMultiple;
    dataSource.BetTb=model.BetTb;
    dataSource.CdrawTime=model.CdrawTime;
    dataSource.ChaseOrderID=model.ChaseOrderID;//订单号
    dataSource.DrawTime=model.DrawTime;
    dataSource.InsertTime=model.InsertTime;
    dataSource.OrderID=model.OrderID;//流水号
    dataSource.OrderState=model.OrderState;
    dataSource.PlayCode=model.PlayCode;
    dataSource.UserName=model.UserName;
    dataSource.User_ID=model.User_ID;
    dataSource.IssueNumber=model.IssueNumber;
    vc.dataSource =dataSource;
    vc.isHistory = _IsHistory;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end





















