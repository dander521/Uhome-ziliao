//
//  MCTeamChargeViewController.m
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//
#import "MCTopSelectedView.h"
#import "MCTeamChargeViewController.h"
#import "UIColor+MCColor.h"
#import "UIImage+Extension.h"
#import "MCMMChargeTableViewCell.h"
#import "MCTCReportSubModel.h"
#import <MJRefresh/MJRefresh.h>
#import "MCRefreshNormalHeader.h"
#import "MCMMIputView.h"
#import "MCTeamCTPopView.h"
#import "DatePickerView.h"
#import "MCNaviButton.h"
#import "MCTCReportSelfModel.h"
#import "MCMMChargeAllTabCell.h"

@interface MCTeamChargeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
/**下部滑动根view*/
@property (nonatomic,weak)MCTopSelectedView *topSelectedView;
@property (nonatomic,weak) UIScrollView *baseScrollView;
@property (nonatomic,weak) UIButton *lastBtn;
@property (nonatomic,weak) UIView *topBtnView;
@property (nonatomic,weak) UIView *botView;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UITableView *tableViewself;
@property (nonatomic,weak) UITableView *tableViewAll;
@property (nonatomic,strong) MCTCReportSubModel *reportModel;
@property (nonatomic,strong) MCTCReportSelfModel *reportSelfModel;

@property (nonatomic,assign) int CurrentPageIndex;
@property (nonatomic,strong) NSDate *minDate;
@property (nonatomic,strong) NSDate *maxDate;

@property (nonatomic,assign) BOOL isShowPopView;
///**条件选择*/
@property (nonatomic,weak) MCMMIputView *viewPop;
///**筛选框*/
@property (nonatomic,  weak) MCTeamCTPopView *popView;
/**数据源tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewDataArray;
/**数据源tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewSelfDataArray;
/**数据源tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewAllDataArray;
/**datePicker 日期选择器*/
@property (nonatomic,  weak) DatePickerView  *datePicker;
/**datePicker 日期选择器*/
@property (nonatomic,  weak) UIButton  *btn;

@end

@implementation MCTeamChargeViewController
@synthesize noDataWin = _noDataWin;
@synthesize errDataWin = _errDataWin;
@synthesize errNetWin = _errNetWin;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"团队报表";
    [self setUpSegmentControl];
    [self setUpBaseScorllView];
    [self setUpUI];
    [self configRequstNormalParmas];
   
    [self addNavRightBtn];
}

-(void)loadData{
    [super loadData];
    [self loadListData];
//    [self loadSelfListData:YES];
//    [self loadSelfListData:NO];
}
#pragma mark --添加🔍
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self loadListData];
}
#pragma mark - configRequstNormalParmas
- (void)configRequstNormalParmas{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    self.minDate = [NSDate dateWithTimeIntervalSinceNow:-3600 * 24];
    self.maxDate = [NSDate dateWithTimeIntervalSinceNow:-3600 * 24];
    if (self.userName == nil || [self.userName isEqualToString:@""]) {
        self.userName = @"";
    }
    if (self.userID == nil || [self.userID isEqualToString:@""]) {
         self.userID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
    if (self.GetUserType == 0) {
        self.GetUserType = 0;
    }
    
    self.CurrentPageIndex = 1;
}
- (void)setUpSegmentControl{
    NSArray *arr = nil;

    arr =  @[@"下级统计",@"自身统计",@"团队合计"];
    //条件选择
    UIView *topBtnView = [[UIView alloc] init];
    long count = arr.count;
    [self.view addSubview:topBtnView];
    self.topBtnView = topBtnView;
    topBtnView.frame = CGRectMake(0, 64, G_SCREENWIDTH, MC_REALVALUE(44));
    for (NSInteger i = 0; i<arr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [topBtnView addSubview:btn];
        btn.frame = CGRectMake(G_SCREENWIDTH / count * i, 0, G_SCREENWIDTH / count, MC_REALVALUE(41.5));
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:RGB(144, 8, 215) forState:UIControlStateSelected];
        [btn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14.0f)];
        btn.tag = i + 1000;
        [btn addTarget:self action:@selector(segmentContrlBtnClick:) forControlEvents:UIControlEventTouchDown];
        //默认 第一个
        if (i==0) {
            btn.selected = YES;
            self.lastBtn=btn;
        }
    }
    
    UIView *botView = [[UIView alloc] init];
    self.botView = botView;
    botView.frame = CGRectMake(0, MC_REALVALUE(41.5), G_SCREENWIDTH / count, MC_REALVALUE(2));
    botView.backgroundColor = RGB(144, 8, 215);
    [topBtnView addSubview:botView];
    UIView *botView1 = [[UIView alloc] init];
    botView1.frame = CGRectMake(0, MC_REALVALUE(43.5), G_SCREENWIDTH, 0.5);
    botView1.backgroundColor = RGB(231, 231, 231);
    [topBtnView addSubview:botView1];
    
}

#pragma mark-BaseScorllView
- (void)setUpBaseScorllView{
    self.view.backgroundColor = RGB(231, 231, 231);
    UIScrollView *baseScrollView = [[UIScrollView alloc] init];
    baseScrollView.backgroundColor = RGB(231, 231, 231);
    [self.view addSubview:baseScrollView];
    self.baseScrollView = baseScrollView;

    [baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBtnView.mas_bottom).offset(MC_REALVALUE(0));
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
    baseScrollView.scrollEnabled = NO;
    baseScrollView.contentSize = CGSizeMake(G_SCREENWIDTH * 3, baseScrollView.heiht);
    baseScrollView.pagingEnabled = YES;
    baseScrollView.bounces = NO;
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    self.baseScrollView = baseScrollView;
    self.baseScrollView.delegate = self;
}
- (void)segmentContrlBtnClick:(UIButton *)btn{
    [self hiddenExDataView];
    self.lastBtn.selected = NO;
    btn.selected = YES;
    self.lastBtn = btn;
    [UIView animateWithDuration:0.25 animations:^{
        long index = btn.tag - 1000;
        self.botView.frame = CGRectMake(index * G_SCREENWIDTH / 3 , MC_REALVALUE(41.5), G_SCREENWIDTH / 3, MC_REALVALUE(2));
    }];
    if (btn.tag == 1000) {
        [self loadListData];
    } else if(btn.tag == 1001){
        [self loadSelfListData];
    }else{
        [self loadAllListData];
    }
    long index = btn.tag - 1000;
    [self.baseScrollView setContentOffset:CGPointMake(index * G_SCREENWIDTH, 0) animated:NO];
}

+ (void)load{
    
    _gTCTopArray = [NSMutableArray array];
}

-(void)setUpUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT - MC_REALVALUE(54) - 64 - 49) style:UITableViewStylePlain];
    [self.baseScrollView addSubview:tab];
    self.tableView = tab;
    __weak typeof(self) weakself = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MCRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadAllListData];
        [weakself loadSelfListData];
        [weakself loadListData];
    }];
    tab.rowHeight = MC_REALVALUE(215);
    [tab registerClass:[MCMMChargeTableViewCell class] forCellReuseIdentifier:@"cell"];
    tab.delegate = self;
    tab.dataSource = self;
    tab.backgroundColor = RGB(231, 231, 231);
    
    
    //---------------------------/
    UITableView *tabself = [[UITableView alloc] initWithFrame:CGRectMake(G_SCREENWIDTH, 0, G_SCREENWIDTH, G_SCREENHEIGHT - MC_REALVALUE(54) - 64 - 49) style:UITableViewStylePlain];
    [self.baseScrollView addSubview:tabself];
    self.tableViewself = tabself;
    self.tableViewself.mj_header = [MCRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadAllListData];
        [weakself loadSelfListData];
        [weakself loadListData];
    }];
    tabself.rowHeight = MC_REALVALUE(215);
    [tabself registerClass:[MCMMChargeAllTabCell class] forCellReuseIdentifier:@"cellself"];
    tabself.delegate = self;
    tabself.dataSource = self;
    tabself.backgroundColor = RGB(231, 231, 231);
        //---------------------------/
    UITableView *tabAll = [[UITableView alloc] initWithFrame:CGRectMake(2*G_SCREENWIDTH, 0, G_SCREENWIDTH, G_SCREENHEIGHT - MC_REALVALUE(54) - 64 - 49) style:UITableViewStylePlain];
    [self.baseScrollView addSubview:tabAll];
    self.tableViewAll = tabAll;
   
    self.tableViewAll.mj_header = [MCRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadAllListData];
        [weakself loadSelfListData];
        [weakself loadListData];
    }];
    tabAll.rowHeight = MC_REALVALUE(215);
    [tabAll registerClass:[MCMMChargeAllTabCell class] forCellReuseIdentifier:@"cellall"];
    tabAll.delegate = self;
    tabAll.dataSource = self;
    tabAll.backgroundColor = RGB(231, 231, 231);
    
    if (!self.firstSubViewController) {
        MCTopSelectedView *topView = [[MCTopSelectedView alloc] initWithFrame:CGRectMake(0, 64 + MC_REALVALUE(44), G_SCREENWIDTH, MC_REALVALUE(40))];
        
        [self.view addSubview:topView];
        __weak typeof(self) weakself = self;
        topView.dataSource = _gTCTopArray;
        topView.topSectedBlock = ^(NSInteger index) {
            NSMutableArray *arr = [NSMutableArray array];
            NSMutableArray *arrTitle = [NSMutableArray array];
            NSArray *vca = [weakself.navigationController viewControllers];
            for (NSInteger i = 0; i<=index +1; i++) {
                [arr addObject:vca[i]];
                if (i < index + 1) {
                    [arrTitle addObject:_gTCTopArray[i]];
                }
            }
            _gTCTopArray = arrTitle;
            [weakself.navigationController setViewControllers:arr animated:YES];
        };
        self.topSelectedView = topView;
        [self.baseScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topBtnView.mas_bottom).offset(MC_REALVALUE(40));
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-49);
        }];
    }
}

#pragma mark --发送请求
-(void)loadListData{
    
    __weak typeof(self) weakself = self;
    MCTCReportSubModel *reportModel = [[MCTCReportSubModel alloc] init];
    self.reportModel = reportModel;
    reportModel.User_Name = self.userName;
    reportModel.User_ID = self.userID;//[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    reportModel.RebateType = 1;
    reportModel.GetUserType = self.GetUserType;
    reportModel.CurrentPageIndex = 1;
    reportModel.CurrentPageSize = 15;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateTemps = [dataFormatter stringFromDate:self.minDate];
    NSString *dateTempe = [dataFormatter stringFromDate:self.maxDate];
    reportModel.BeginTime = [NSString stringWithFormat:@"%@ 00:00:00",dateTemps];
    reportModel.EndTime = [NSString stringWithFormat:@"%@ 23:59:59",dateTempe];
    [reportModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    reportModel.callBackSuccessBlock = ^(id manager) {
        [weakself tableViewEndRefreshing];
        
        weakself.tableViewDataArray = [MCTCReportSubModel mj_objectArrayWithKeyValuesArray:manager[@"ReportComm"]];
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
    reportModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [weakself tableViewEndRefreshing];
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
    self.reportModel.CurrentPageIndex = ++self.CurrentPageIndex;
    __weak typeof(self) weakSelf = self;
    self.reportModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf tableViewEndRefreshing];
        NSArray *arr = [MCTCReportSubModel mj_objectArrayWithKeyValuesArray:manager[@"ReportComm"]];
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
    self.reportModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf tableViewEndRefreshing];
    };
    [BKIndicationView showInView:self.view];
    [self.reportModel refreashDataAndShow];
}
- (void)loadSelfListData{
    __weak typeof(self) weakself = self;
    [self.tableViewSelfDataArray removeAllObjects];
    MCTCReportSelfModel *reportSelfModel = [[MCTCReportSelfModel alloc] init];
    reportSelfModel.allTeam = YES;
    self.reportSelfModel = reportSelfModel;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateTemps = [dataFormatter stringFromDate:self.minDate];
    NSString *dateTempe = [dataFormatter stringFromDate:self.maxDate];
    reportSelfModel.BeginTime = [NSString stringWithFormat:@"%@ 00:00:00",dateTemps];
    reportSelfModel.EndTime = [NSString stringWithFormat:@"%@ 23:59:59",dateTempe];
    [reportSelfModel refreashDataAndShow];
   
    reportSelfModel.callBackSuccessBlock = ^(id manager) {
        [weakself tableViewEndRefreshing];
        [SVProgressHUD dismiss];
        MCTCReportSelfModel *reportSelfModel = [MCTCReportSelfModel mj_objectWithKeyValues:manager];
        if (reportSelfModel != nil) {
            [weakself.tableViewSelfDataArray addObject:reportSelfModel];
        }
        if (weakself.tableViewSelfDataArray.count == 0) {
            [weakself showExDataView];
        }else{
            [weakself hiddenExDataView];
        }
        [weakself.tableViewself reloadData];
    };
    reportSelfModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [weakself tableViewEndRefreshing];
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

- (void)loadAllListData{
    __weak typeof(self) weakself = self;
    [self.tableViewAllDataArray removeAllObjects];
    MCTCReportSelfModel *reportSelfModel = [[MCTCReportSelfModel alloc] init];
    reportSelfModel.allTeam = NO;
    self.reportSelfModel = reportSelfModel;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateTemps = [dataFormatter stringFromDate:self.minDate];
    NSString *dateTempe = [dataFormatter stringFromDate:self.maxDate];
    reportSelfModel.BeginTime = [NSString stringWithFormat:@"%@ 00:00:00",dateTemps];
    reportSelfModel.EndTime = [NSString stringWithFormat:@"%@ 23:59:59",dateTempe];
    [reportSelfModel refreashDataAndShow];
    [SVProgressHUD showWithStatus:@"请稍后.."];
    reportSelfModel.callBackSuccessBlock = ^(id manager) {
        [weakself tableViewEndRefreshing];
        [SVProgressHUD dismiss];
        MCTCReportSelfModel *model= [MCTCReportSelfModel mj_objectWithKeyValues:manager];
        if (model != nil) {
            [weakself.tableViewAllDataArray addObject:model];
        }
        if (weakself.tableViewAllDataArray.count == 0) {
            [weakself showExDataView];
        }else{
            [weakself hiddenExDataView];
        }
        [weakself.tableViewAll reloadData];

    };
    reportSelfModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [weakself tableViewEndRefreshing];
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


- (void)tableViewEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    [self.tableViewself.mj_footer endRefreshing];
    [self.tableViewself.mj_header endRefreshing];
    [self.tableViewAll.mj_footer endRefreshing];
    [self.tableViewAll.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
         return self.tableViewDataArray.count;
    } else if (tableView == self.tableViewself){
         return self.tableViewSelfDataArray.count;
    }else{
        return self.tableViewAllDataArray.count;
    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (tableView == self.tableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        MCMMChargeTableViewCell *cellT = (MCMMChargeTableViewCell *)cell;
         cellT.dataSource = self.tableViewDataArray[indexPath.row];
    } else if (tableView == self.tableViewself){
       cell = [tableView dequeueReusableCellWithIdentifier:@"cellself"];
        MCMMChargeAllTabCell *cellT = (MCMMChargeAllTabCell *)cell;
         cellT.dataSource = self.tableViewSelfDataArray[indexPath.row];
    }else{
      cell = [tableView dequeueReusableCellWithIdentifier:@"cellall"];
        MCMMChargeAllTabCell *cellT = (MCMMChargeAllTabCell *)cell;
         cellT.dataSource = self.tableViewAllDataArray[indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    MCTCReportSubModel *model = self.tableViewDataArray[indexPath.row];
    MCTeamChargeViewController *vc = [[MCTeamChargeViewController alloc] init];
    vc.GetUserType = self.self.GetUserType;
    vc.userID = [NSString stringWithFormat:@"%d",model.UserID];
    NSString *str = ((model.Category & 64) == 64) ? @"会员" : @"代理";
    if (self.firstSubViewController) {
        [_gTCTopArray removeAllObjects];
    }
    if ([str isEqualToString:@"会员"]) {
        
    } else {
        vc.firstSubViewController = NO;
        [_gTCTopArray addObject:model.UserName];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)allBtnClick:(UIButton *)btn{
    if (_isShowPopView) {
        _isShowPopView=NO;
        [self.popView hidePopView];
    }else{
        _isShowPopView=YES;
        typeof(self) weakself = self;
        self.popView.lotteryBlock = ^{
            weakself.viewPop.dataArray = @[@"当天记录",@"历史记录"];
            weakself.viewPop.cellDidSelected = ^(NSInteger i) {
                weakself.popView.stValueLabel.text = weakself.viewPop.dataArray[i];
                [weakself.viewPop hiden];
                [weakself recordBtnClick:i];
            };
            [weakself.viewPop show];
        };
        self.popView.searchBtnBlock = ^(NSString *str) {
            self.userName = str;
            _isShowPopView=NO;
            [weakself loadAllListData];
            [weakself loadSelfListData];
            [weakself loadListData];
        };
        self.popView.statusBlock = ^{
            weakself.viewPop.dataArray = @[@"全部",@"会员",@"代理"];
            [weakself.viewPop show];
            weakself.viewPop.cellDidSelectedTop = ^(NSInteger i) {
                [weakself.viewPop hiden];
                weakself.popView.statusLabDetail.text = weakself.viewPop.dataArray[i];
                self.GetUserType = (int)i;
            };
        };
        [weakself datePickerCallBack];
        [self.popView showPopView];
    }
}
- (void)datePickerCallBack{
    typeof(self) weakself = self;
    self.popView.startDateBlock = ^{
        weakself.datePicker.cancelBlock = ^{
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
            }];
        };
        weakself.datePicker.sureBlock = ^(NSString *selectDateStr) {
            weakself.popView.startDateLabDetail.text = selectDateStr;
            NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
            [dataFormatter setDateFormat:@"yyyy-MM-dd"];
            weakself.minDate = [dataFormatter dateFromString:selectDateStr];
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
                
            }];
        };
        
    };
    
    self.popView.endDateBlock = ^{
        [weakself.viewPop hiden];
        weakself.datePicker.cancelBlock = ^{
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
            }];
        };
        weakself.datePicker.sureBlock = ^(NSString *selectDateStr) {
            weakself.popView.endDateLabDetail.text = selectDateStr;
            NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
            [dataFormatter setDateFormat:@"yyyy-MM-dd"];
            weakself.maxDate = [dataFormatter dateFromString:selectDateStr];
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
            }];
        };
        
    };
    
}

- (void)tap{
    self.isShowPopView=NO;
    self.popView.hidden = YES;
    [self.viewPop hiden];
}

- (NSMutableArray *)tableViewDataArray{
    
    if (_tableViewDataArray == nil) {
        _tableViewDataArray = [NSMutableArray array];
    }
    return _tableViewDataArray;
}
- (NSMutableArray *)tableViewSelfDataArray{
    
    if (_tableViewSelfDataArray == nil) {
        _tableViewSelfDataArray = [NSMutableArray array];
    }
    return _tableViewSelfDataArray;
}
- (NSMutableArray *)tableViewAllDataArray{
    
    if (_tableViewAllDataArray == nil) {
        _tableViewAllDataArray = [NSMutableArray array];
    }
    return _tableViewAllDataArray;
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
        self.minDate = [NSDate date];
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
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    self.popView.startDateLabDetail.text = [dataFormatter stringFromDate:self.minDate];
    self.popView.endDateLabDetail.text = [dataFormatter stringFromDate:self.maxDate];
}

- (DatePickerView *)datePicker{
    
    if (_datePicker == nil) {
        DatePickerView *datePicker =[[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:0] lastObject];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = nil;
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:[NSDate dateWithTimeIntervalSinceNow:-24*3600]];
        NSDate *localDate = [[NSDate dateWithTimeIntervalSinceNow:-24*3600] dateByAddingTimeInterval: interval];
        comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:localDate];
        [comps setMonth:comps.month -3];
        datePicker.minDate = [calendar dateFromComponents:comps];
        datePicker.maxDate = [NSDate date];
        datePicker.frame =CGRectMake(0, self.view.frame.size.height  - 200 -49 , self.view.frame.size.width, 200);
        datePicker.Datetitle =@"日期选择";
        [self.popView addSubview:datePicker];
        _datePicker = datePicker;
    }
    return _datePicker;
}

- (MCTeamCTPopView *)popView{
    
    if (_popView == nil) {
        MCTeamCTPopView * popView = [[MCTeamCTPopView alloc] init];
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
        MCNoDataWindow *win = [[MCNoDataWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + MC_REALVALUE(40), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49 - MC_REALVALUE(40))];
        if (self.firstSubViewController == NO) {
            win.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + MC_REALVALUE(80), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49 - MC_REALVALUE(80));
           
            
        }
        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        self.noDataWin = win;
    }
    return _noDataWin;
}

- (MCErrorWindow *)errDataWin{
    if (_errDataWin == nil) {
        MCErrorWindow *win = [[MCErrorWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + MC_REALVALUE(40), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49 - MC_REALVALUE(40))];
        if (self.firstSubViewController == NO) {
            win.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + MC_REALVALUE(80), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49 - MC_REALVALUE(80));
        }
        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        self.errDataWin = win;
    }
    return _errDataWin;
    
}
- (MCNONetWindow *)errNetWin{
    if (_errNetWin == nil) {
        MCNONetWindow *win = [[MCNONetWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + MC_REALVALUE(40), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49 - MC_REALVALUE(40))];
        if (self.firstSubViewController == NO) {
            win.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + MC_REALVALUE(80), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49 - MC_REALVALUE(80));
        }
        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        self.errNetWin = win;
    }
    return _errNetWin;
    
}
@end
