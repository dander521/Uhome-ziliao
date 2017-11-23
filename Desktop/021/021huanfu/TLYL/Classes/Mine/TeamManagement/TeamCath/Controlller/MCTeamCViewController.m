//
//  MCTeamCViewController.m
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTeamCViewController.h"
#import "MCNaviButton.h"
#import <MJRefresh/MJRefresh.h>
#import "MCRefreshNormalHeader.h"
#import "MCTopUpMineFilterView.h"
#import "MCNaviButton.h"
#import "DatePickerView.h"
#import "MJRefresh.h"
#import "MCButton.h"
#import "MCInputView.h"
#import "MCUserDefinedAPIModel.h"
#import "MCMMDetailPopView.h"
#import "MCMMTCTableViewCell.h"
#import "MCTeamCModel.h"
#import "MCTeamVpopView.h"
#import "MCMMIputView.h"
#import "MCGroupPaymentModel.h"
#import "MCRecordTool.h"

@interface MCTeamCViewController ()<UITableViewDelegate,UITableViewDataSource>

/**充值tableView*/
@property (nonatomic,  weak) UITableView *tableView;
/**充值tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewDataArray;
/**datePicker的最小时间*/
@property (nonatomic,strong) NSDate *minDate;
/**datePicker的最大时间*/
@property (nonatomic,strong) NSDate *maxDate;
/**datePicker 日期选择器*/
@property (nonatomic,  weak) DatePickerView  *datePicker;
/**充值的模型*/
@property (nonatomic,strong) MCTeamCModel *teamModel;
/**筛选框*/
@property (nonatomic,  weak) MCTeamVpopView *popView;
/**筛选框按钮*/
@property (nonatomic,  weak) MCNaviButton *btn;
/**查询状态*/
@property (nonatomic,strong) NSString *rechargeStates;
/**查询开始日期*/
@property (nonatomic,strong) NSDate *beginDate;
/**查询结束日期*/
@property (nonatomic,strong) NSDate *endDate;
/**查询当前页*/
@property (nonatomic,assign) int currentPageIndex;
/**查询当前页数量*/
@property (nonatomic,strong) NSString *currentPageSize;

/**查询下一页*/
@property (nonatomic,assign) int index;

@property (nonatomic,strong) NSArray *arrData;

@property (nonatomic,assign) BOOL isShowPopView;
@property (nonatomic,assign) BOOL isHistory;
@property (nonatomic,weak) MCMMIputView *viewPop;

@property (nonatomic,strong) NSString *insertTimeMin;

@property (nonatomic,strong) NSString *insertTimeMax;

@property (nonatomic,weak) UIButton *bottomViewTopBtn;

@property (nonatomic,weak) UIButton *bottomViewDrawBtn;

@property (nonatomic,weak) UIView *bottomView;

@property (nonatomic,weak) MCMMDetailPopView *cloverView;
@property (nonatomic,strong) NSNumber *Source;
@property (nonatomic,strong) MCGroupPaymentModel *paymentModel;


@end

@implementation MCTeamCViewController
@synthesize noDataWin = _noDataWin;
@synthesize errDataWin = _errDataWin;
@synthesize errNetWin = _errNetWin;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"团队账变";
    [self addNavRightBtn];
    [self setUpUI];
    [self configRequstNormalParmas];
    [self loadDataAndShow];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDataAndShow];
    
    
}
- (void)configRequstNormalParmas{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    self.beginDate = [NSDate date];
    self.endDate = [NSDate date];
    self.currentPageIndex = 1;
    self.Source = @0;
    self.isHistory = NO;
    self.minDate = [NSDate dateWithTimeIntervalSinceNow:-3*3600*24];
    self.maxDate = [NSDate date];
    
}
- (void)addNavRightBtn {
    
    MCNaviButton *btn = [[MCNaviButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
    self.btn =btn;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)loadData{
    [super loadData];
    [self loadDataAndShow];
}

- (void)setUpUI{
    

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, MC_REALVALUE(40))];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"类型",@"用户",@"金额",@"余额"];
    for (NSInteger i = 0; i<titleArr.count; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(i*G_SCREENWIDTH*0.25, 0, G_SCREENWIDTH*0.25, MC_REALVALUE(40))];
        [topView addSubview:lable];
        lable.text = titleArr[i];
        lable.textColor =RGB(46, 46, 46);
        lable.font = [UIFont systemFontOfSize:12];
        lable.textAlignment = NSTextAlignmentCenter;
    }
    
    for (NSInteger i = 0; i<titleArr.count -1; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake((i+1)*G_SCREENWIDTH*0.25, 40/4, 0.5, MC_REALVALUE(30))];
        [topView addSubview:lable];
        lable.backgroundColor =RGB(136, 136, 136);
        
    }
    //    /**tabView 创建*/
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(50) + 64, G_SCREENWIDTH-26, G_SCREENHEIGHT - 64 - MC_REALVALUE(50) - 49 - MC_REALVALUE(13)) style:UITableViewStylePlain];
    [self.view addSubview:tab];
    tab.delegate = self;
    tab.dataSource = self;
    self.tableView = tab;
    self.tableView.layer.cornerRadius = 6;
    self.tableView.clipsToBounds = YES;
    self.tableView.rowHeight = MC_REALVALUE(50);
    __weak typeof( self) weakSelf = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MCMMTCTableViewCell class] forCellReuseIdentifier:@"MCMMTCTableViewCell"];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataAndShow];
    }];
    self.view.backgroundColor = RGB(231, 231, 231);
    
}

- (void)loadDataAndShow{

    MCGroupPaymentModel *model = [[MCGroupPaymentModel alloc] init];
    self.paymentModel = model;
    [model refreashDataAndShow];
    __weak typeof(self)weakSelf = self;
    model.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        NSArray *arrM =  manager.ResponseRawData[@"allRecType"];
        weakSelf.arrData =arrM;
        
    };
    
    
    __weak typeof(self) weakself = self;
    MCTeamCModel *teamModel = [[MCTeamCModel alloc] init];
    self.teamModel = teamModel;
    teamModel.IsHistory = self.isHistory;
    teamModel.Source = [self.Source intValue];
    teamModel.CurrentPageSize = 15;
    teamModel.CurrentPageIndex = 1;
    teamModel.ThisUserName = self.username;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateTemps = [dataFormatter stringFromDate:self.beginDate];
    NSString *dateTempe = [dataFormatter stringFromDate:self.endDate];
    teamModel.InsertTimeMin = [NSString stringWithFormat:@"%@ 00:00:00",dateTemps];
    teamModel.InsertTimeMax = [NSString stringWithFormat:@"%@ 23:59:59",dateTempe];
    [teamModel refreashDataAndShow];
    [BKIndicationView showInView: self.view];
    teamModel.callBackSuccessBlock = ^(id manager) {
        [weakself tableViewEndRefreshing];
        [BKIndicationView dismiss];
        weakself.tableViewDataArray = [MCTeamCModel mj_objectArrayWithKeyValuesArray:manager[@"UfInfo"]];
        if (weakself.tableViewDataArray.count == 0) {
            [weakself showExDataView];
        }else{
            [weakself hiddenExDataView];
        }
        if (weakself.tableViewDataArray.count==[manager[@"DataCount"] integerValue]) {
            weakself.tableView.mj_footer.hidden=YES;
        }
        [weakself.tableView reloadData];
    };
    teamModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [weakself tableViewEndRefreshing];
         [BKIndicationView dismiss];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [weakself.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [weakself.errNetWin setHidden:NO];
            }
        } else {
                [weakself.errDataWin setHidden:NO];
        }
        
        [SVProgressHUD dismiss];
    };
   

}
- (void)loadMoreData{

    self.tableView.mj_footer.hidden=NO;
    self.teamModel.CurrentPageIndex = ++self.currentPageIndex;
    __weak typeof(self) weakSelf = self;
    self.teamModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf tableViewEndRefreshing];
        NSArray *arr = [MCTeamCModel mj_objectArrayWithKeyValuesArray:manager[@"UfInfo"]];
        [weakSelf.tableViewDataArray addObjectsFromArray:arr];
        if (weakSelf.tableViewDataArray.count == 0) {
            [weakSelf showExDataView];
        }
        [weakSelf.tableView reloadData];
        [weakSelf tableViewEndRefreshing];
        if (weakSelf.tableViewDataArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tableView.mj_footer.hidden=YES;
        }
    };

    self.teamModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf tableViewEndRefreshing];
    };
    [BKIndicationView showInView:self.view];
    [self.teamModel refreashDataAndShow];
}

- (BOOL)bissextile:(int)year {
    
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}

#pragma mark - touch event
- (void)recordBtnClick:(NSInteger)i{
    [self.viewPop hiden];
    if (i == 0) {
        self.minDate = [NSDate dateWithTimeIntervalSinceNow:-3 * 3600 * 24];
        self.maxDate = [NSDate date];
    } else {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = nil;
        comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        NSArray *arrMouth = nil;
        if ([self bissextile:(int)[comps year]]) {
            arrMouth = @[@31,@29,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31];
        } else {
            arrMouth = @[@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31];
        }
        NSNumber * mo = arrMouth[comps.month - 1];
        self.minDate = [NSDate dateWithTimeIntervalSinceNow:- ([mo intValue ]+ 3) * 3600 * 24];
        self.maxDate = [NSDate dateWithTimeIntervalSinceNow:-4 * 3600 * 24];
        
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *endDateStr = [dateFormatter stringFromDate:self.maxDate];
    self.beginDate = self.maxDate;
    self.endDate = self.maxDate;
    self.popView.endDateLabDetail.text = endDateStr;
    self.popView.startDateLabDetail.text = endDateStr;
}



- (void)allBtnClick:(UIButton *)btn{
    
  
    if (_isShowPopView) {
        _isShowPopView=NO;
        [self.popView hidePopView];
        
    }else{
        _isShowPopView=YES;
  
        typeof(self) weakself = self;
        //记录选择
        self.popView.lotteryBlock = ^{
            weakself.viewPop.dataArray = @[@"当前记录",@"历史记录"];
            weakself.viewPop.cellDidSelected = ^(NSInteger i) {
                weakself.popView.stValueLabel.text = weakself.viewPop.dataArray[i];
                weakself.isHistory = i;
                [weakself.viewPop hiden];
                [weakself recordBtnClick:i];
            };
            [weakself.viewPop show];
            };
        // 张变类型
      NSArray *arr = [MCRecordTool getSourceCodeArray];
      NSDictionary *dic = [MCRecordTool getSourceCodeDic];
       
            self.popView.statusBlock = ^{
                
                weakself.viewPop.dataArray = arr;
                [weakself.viewPop show];
                weakself.viewPop.cellDidSelectedTop = ^(NSInteger i) {
                    [weakself.viewPop hiden];
                    weakself.popView.statusLabDetail.text = weakself.viewPop.dataArray[i];
                    NSString *str = weakself.viewPop.dataArray[i];
                    NSString *strN = dic[str];
                    weakself.Source = [NSNumber numberWithInt:[strN intValue]];
                };
            };
            
            [weakself datePickerCallBack];
        self.popView.searchBtnBlock = ^(NSString *str) {
            weakself.username = str;
            _isShowPopView=NO;
            [weakself loadDataAndShow];
        };
            [self.popView showPopView];
    }
}

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.tableViewDataArray.count;
                
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;

        cell = [tableView dequeueReusableCellWithIdentifier:@"MCMMTCTableViewCell"];
        MCMMTCTableViewCell *cellT = (MCMMTCTableViewCell *)cell;
        cellT.dataSource = self.tableViewDataArray[indexPath.row];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        self.cloverView.arrData = self.arrData;
        self.cloverView.dataSource = self.tableViewDataArray[indexPath.row];
        [self.cloverView show];
   
}

- (void)tableViewEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

- (void)datePickerCallBack{
    __weak typeof(self) weakself = self;
    self.popView.startDateBlock = ^{
        self.datePicker.cancelBlock = ^{
            [UIView animateWithDuration:0.25 animations:^{
                [self.datePicker removeFromSuperview];
            }];
        };
        
        self.datePicker.sureBlock = ^(NSString *selectDateStr) {
            weakself.popView.startDateLabDetail.text = selectDateStr;
            NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
            [dataFormatter setDateFormat:@"yyyy/MM/dd"];
//            weakself.minDate = [dataFormatter dateFromString:selectDateStr];
            weakself.beginDate = [dataFormatter dateFromString:selectDateStr];
            [UIView animateWithDuration:0.25 animations:^{
                [self.datePicker removeFromSuperview];
                
            }];
        };
        
    };
    
    self.popView.endDateBlock = ^{
        [self.viewPop hiden];
        self.datePicker.cancelBlock = ^{
            [UIView animateWithDuration:0.25 animations:^{
                [self.datePicker removeFromSuperview];
            }];
        };
        self.datePicker.sureBlock = ^(NSString *selectDateStr) {
            
            weakself.popView.endDateLabDetail.text = selectDateStr;
            NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
            [dataFormatter setDateFormat:@"yyyy/MM/dd"];
//            weakself.maxDate = [dataFormatter dateFromString:selectDateStr];
            weakself.endDate = [dataFormatter dateFromString:selectDateStr];
            
            [UIView animateWithDuration:0.25 animations:^{
                [self.datePicker removeFromSuperview];
            }];
        };
        
    };
    
}

#pragma mark - getter and setter

- (void)tap{
    _isShowPopView=NO;
    self.popView.hidden = YES;
    [self.viewPop hiden];
}
- (MCMMDetailPopView *)cloverView{
    if (_cloverView == nil) {
        MCMMDetailPopView *cloverView = [[MCMMDetailPopView alloc] init];
        __weak typeof(self) weakself = self;
        [self.view addSubview:cloverView];
        _cloverView = cloverView;
        __weak MCMMDetailPopView *weakClo = cloverView;
        cloverView.cancelBtnBlock  = ^{
            [weakClo hidden];
            [weakself.tableView reloadData];

        };
        
    }
    return _cloverView;
    
    
}
- (NSMutableArray *)tableViewDataArray{
    
    if (_tableViewDataArray == nil) {
        _tableViewDataArray = [NSMutableArray array];
    }
    return _tableViewDataArray;
}

- (DatePickerView *)datePicker{
    
    if (_datePicker == nil) {
        DatePickerView *datePicker =[[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:0] lastObject];
        datePicker.minDate = self.minDate;
        datePicker.maxDate = self.maxDate;
        datePicker.frame =CGRectMake(0, self.view.frame.size.height  - 200 , self.view.frame.size.width, 200);
        datePicker.Datetitle =@"日期选择";
        [self.popView addSubview:datePicker];
        _datePicker = datePicker;
    }
    return _datePicker;
}

- (MCTeamCModel *)teamModel{
    
    if (_teamModel == nil) {
        MCTeamCModel *model = [[MCTeamCModel alloc] init];
        _teamModel = model;
    }
    return _teamModel;
}

- (MCTeamVpopView *)popView{
    
    if (_popView == nil) {
        MCTeamVpopView * popView = [[MCTeamVpopView alloc] init];
        [self.view addSubview:popView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [popView addGestureRecognizer:tap];
        _popView = popView;
    }
    return _popView;
}



- (MCMMIputView *)viewPop{
    if (_viewPop == nil) {
        
        MCMMIputView *viewStatus = [[MCMMIputView alloc] init];
        [self.navigationController.view addSubview:viewStatus];
        _viewPop = viewStatus;
    }
    return _viewPop;
}
- (MCNoDataWindow *)noDataWin{
    if (_noDataWin == nil) {
        MCNoDataWindow *win = [[MCNoDataWindow alloc] alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + MC_REALVALUE(40), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(66) - 64 -49)];

        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _noDataWin = win;
    }
    return _noDataWin;
    
}

- (MCErrorWindow *)errDataWin{
    if (_errDataWin == nil) {
        MCErrorWindow *win = [[MCErrorWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64+ MC_REALVALUE(40) , G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(66) - 64 -49)];

        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _errDataWin = win;
    }
    return _errDataWin;
    
}
- (MCNONetWindow *)errNetWin{
    if (_errNetWin == nil) {
        MCNONetWindow *win = [[MCNONetWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64+ MC_REALVALUE(40), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(66) - 64 -49)];
   
        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _errNetWin = win;
    }
    return _errNetWin;
    
}

@end
