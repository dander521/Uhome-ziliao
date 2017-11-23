//
//  MCMemberMViewController.m
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMemberMViewController.h"
#import "MCMMTableViewCell.h"
#import "MCMMlistModel.h"
#import "MCNaviButton.h"
#import "DatePickerView.h"
#import "MCMMPopView.h"
#import "MCCoverView.h"
#import "MCMMIputView.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "MCRefreshNormalHeader.h"
#import"MCPersonInfViewController.h"
#import "MCGameRecordViewController.h"
#import "MCMMForwordController.h"
#import "MCMMSetingViewController.h"
#import "MCTeamBViewController.h"
#import "MCTeamCViewController.h"
#import "MCZhangBianRecordViewController.h"
#import "MCGameRecordViewController.h"
#import "MCHasPayPwdModel.h"
static NSString *_searchName;
@interface MCMemberMViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)MCTopSelectedView *topSelectedView;

@property (nonatomic,assign) BOOL isShowPopView;
///**条件选择*/
@property (nonatomic,weak) MCMMIputView *viewPop;
///**筛选框*/
@property (nonatomic,  weak) MCMMPopView *popView;
/**数据源tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewDataArray;
/**tableView*/
@property (nonatomic,weak) UITableView *tableView;
/**listModel 模型*/
@property (nonatomic,strong) MCMMlistModel *listModel;
/**导航条的搜索按钮*/
@property (nonatomic,weak) MCNaviButton *btn;
/**查询当前页*/
@property (nonatomic,strong) NSString *currentPageIndex;
/**查询当前页数量*/
@property (nonatomic,strong) NSString *currentPageSize;


/**datePicker 日期选择器*/
@property (nonatomic,  weak) DatePickerView  *datePicker;
/**datePicker的最小时间*/
@property (nonatomic,strong) NSDate *minDate;
/**datePicker的最大时间*/
@property (nonatomic,strong) NSDate *maxDate;

@property (nonatomic,assign) int index;



@end

@implementation MCMemberMViewController
@synthesize noDataWin = _noDataWin;
@synthesize errDataWin = _errDataWin;
@synthesize errNetWin = _errNetWin;
#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会员管理";
    self.view.backgroundColor = RGB(231, 231, 231);
    [self setUpUI];
    [self addNavRightBtn];
    [self configRequstNormalParmas];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadListData];

    
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
#pragma mark -- setUpUI
-(void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, MC_REALVALUE(13) + 40 + 64 , G_SCREENWIDTH, G_SCREENHEIGHT - 40) style:UITableViewStylePlain];
    [self.view addSubview:tab];
    tab.backgroundColor = RGB(231, 231, 231);
    self.tableView = tab;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakself = self;
    [tab registerClass:[MCMMTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MCRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadListData];
    }];

    self.tableView.rowHeight = MC_REALVALUE(245);
    tab.delegate = self;
    tab.dataSource = self;
    if (!self.firstSubViewController) {
        MCTopSelectedView *topView = [[MCTopSelectedView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, 40)];
        [self.view addSubview:topView];
        __weak typeof(self) weakself = self;
        topView.dataSource = _gTopArray;
        topView.topSectedBlock = ^(NSInteger index) {
            NSMutableArray *arr = [NSMutableArray array];
            NSMutableArray *arrTitle = [NSMutableArray array];
            NSArray *vca = [weakself.navigationController viewControllers];
            for (NSInteger i = 0; i<=index +1; i++) {
                [arr addObject:vca[i]];
                if (i < index + 1) {
                     [arrTitle addObject:_gTopArray[i]];
                }
            }
            _gTopArray = arrTitle;
            [weakself.navigationController setViewControllers:arr animated:YES];
        };
        self.topSelectedView = topView;
    }else{
        tab.frame = CGRectMake(0, MC_REALVALUE(13) + 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64 - 49 );
    }
  
}
#pragma mark --设置初始化请求数据
- (void)configRequstNormalParmas{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    if (self.firstSubViewController) {
        self.minDate = [NSDate dateWithTimeIntervalSinceNow:-3600 * 24*365*10];
        self.maxDate = [NSDate date];
       
    }
    self.index = 1;
    self.currentPageIndex = @"1";
    if (self.subUserID == nil || [self.subUserID isEqualToString:@""]) {
        self.subUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
    if (self.LikeUserName != nil && ![self.LikeUserName isEqualToString:@""]) {
        
    }
    if (self.TreeType == 0) {
        self.TreeType = 1;
    }
}
#pragma mark --发送请求
-(void)loadListData{
    __weak typeof(self) weakself = self;
    MCMMlistModel *listModel = [[MCMMlistModel alloc] init];
    self.listModel = listModel;
    listModel.TreeType = self.TreeType;
    listModel.CurrentPageIndex = @"1";
    listModel.CurrentPageSize = @"15";
    if ([_searchName isEqualToString:@""] || _searchName == nil) {
       listModel.LikeUserName = self.LikeUserName;
    } else {
        listModel.LikeUserName = _searchName;
    }
    
    listModel.subUserID = self.subUserID;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateTemps = [dataFormatter stringFromDate:self.minDate];
    NSString *dateTempe = [dataFormatter stringFromDate:self.maxDate];
    listModel.BeginDate = [NSString stringWithFormat:@"%@ 00:00:00",dateTemps];
    listModel.EndDate = [NSString stringWithFormat:@"%@ 23:59:59",dateTempe];
    [listModel refreashDataAndShow];
    
    [BKIndicationView showInView:self.view];
    
    listModel.callBackSuccessBlock = ^(id manager) {
        [weakself tableViewEndRefreshing];
       
        weakself.tableViewDataArray = [MCMMlistModel mj_objectArrayWithKeyValuesArray:manager[@"MyteamList"]];
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
    listModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
         [weakself tableViewEndRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {// 超时
                [weakself.errDataWin setHidden:NO];
            } else if (err.code == -1009){//没有网络
                [weakself.errNetWin setHidden:NO];
            }
        } else {
            [weakself.errDataWin setHidden:NO];
        }
      
    
    };
    
}
- (void)loadMoreData{

    self.tableView.mj_footer.hidden=NO;
    self.listModel.CurrentPageIndex = [NSString stringWithFormat:@"%d",++self.index];
    __weak typeof(self) weakSelf = self;
    self.listModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf tableViewEndRefreshing];
        NSArray *arr = [MCMMlistModel mj_objectArrayWithKeyValuesArray:manager[@"ModelList"]];
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
    self.listModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf tableViewEndRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [weakSelf.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [weakSelf.errNetWin setHidden:NO];
            }
        } else {
            [weakSelf.errDataWin setHidden:NO];
        }
        
        [SVProgressHUD dismiss];
    };
    [BKIndicationView showInView:self.view];
    [self.listModel refreashDataAndShow];
}
-(void)loadData{
    [super loadData];
    [self loadListData];
}
- (void)tableViewEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark -- tableView delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCMMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.dataSource = self.tableViewDataArray[indexPath.row];
    MCMMlistModel * model3 = self.tableViewDataArray[indexPath.row];
    if (model3.ParentID == [[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] intValue]) {
        cell.fandianBtn.backgroundColor = RGB(255, 168, 0);
        cell.fandianBtn.enabled = YES;
        cell.bgViewFandian.backgroundColor= RGB(255, 168, 0);
    } else {
        cell.fandianBtn.enabled = NO;
        cell.fandianBtn.backgroundColor = RGB(181, 181, 181);
        cell.bgViewFandian.backgroundColor= RGB(181, 181, 181);
    }
    __weak MCMMTableViewCell *weakcell = cell;
    __weak typeof(self) weakself = self;
    cell.btnClickBlock = ^(NSInteger index) {
         UIViewController *vc = nil;
        switch (index) {
               
            case 101://个人资料
            {
                vc = [[MCPersonInfViewController alloc] init];
               MCPersonInfViewController *pvc = (MCPersonInfViewController *)vc;
                pvc.dataSource = weakcell.dataSource;
            }
                break;
            case 102://投注记录
            {
                vc = [[MCGameRecordViewController alloc] init];
                MCGameRecordViewController *pvc = (MCGameRecordViewController *)vc;
                pvc.subUserName = weakcell.dataSource.UserName;
                pvc.subUserID = [NSString stringWithFormat:@"%d",weakcell.dataSource.UserID];
                pvc.mmViewContoller = YES;
              
            }
                break;
            case 103://帐变记录
            {
                vc = [[MCZhangBianRecordViewController alloc] init];
                MCZhangBianRecordViewController *pvc = (MCZhangBianRecordViewController *)vc;
                pvc.subUserName = weakcell.dataSource.UserName;
                pvc.subUserID =  [NSString stringWithFormat:@"%d",weakcell.dataSource.UserID];
                pvc.mmViewContoller = YES;
            }
                break;
            case 104://转账充值
            {

                MCHasPayPwdModel *payModel = [MCHasPayPwdModel sharedMCHasPayPwdModel];
                if([payModel.PayOutPassWord isEqualToString:@"0"]){
                    [SVProgressHUD showInfoWithStatus:@"请完善资金密码!"];
                }else{
                    vc = [[MCMMForwordController alloc] init];
                    MCMMForwordController *pvc = (MCMMForwordController *)vc;
                    pvc.dataSource = weakcell.dataSource;
                }
            
            }
                break;
            case 105://返点设置
            {
    
                    vc = [[MCMMSetingViewController alloc] init];
                    MCMMSetingViewController *pvc = (MCMMSetingViewController *)vc;
                    pvc.dataSource = weakcell.dataSource;
              
                
                
            }
                break;
            default:
                break;
        }
           [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MCMMlistModel *model = self.tableViewDataArray[indexPath.row];
    MCMemberMViewController *vc = [[MCMemberMViewController alloc] init];
    vc.subUserID = [NSString stringWithFormat:@"%d",model.UserID];
    vc.minDate = self.minDate;
    vc.maxDate = self.maxDate;
    vc.TreeType = self.TreeType;
    vc.LikeUserName = self.LikeUserName;
    NSString *str = ((model.Category & 64) == 64) ? @"会员" : @"代理";
    if (self.firstSubViewController) {
        [_gTopArray removeAllObjects];
    }
    if ([str isEqualToString:@"会员"]) {
        
    } else {
        vc.firstSubViewController = NO;
        [_gTopArray addObject:model.UserName];
        [self.navigationController pushViewController:vc animated:YES];
    }
  
  
}
#pragma  mark -- touch event
- (void)tap{
    self.isShowPopView=NO;
    self.popView.hidden = YES;
    [self.viewPop hiden];
}
- (void)allBtnClick:(UIButton *)btn{
    if (_isShowPopView) {
        _isShowPopView=NO;
        [self.popView hidePopView];
    }else{
        _isShowPopView=YES;
            self.popView.titleLab.text = @"会员名称";
//        if (![_searchName isEqualToString:@""] || _searchName != nil) {
//            self.popView.tf.text = _searchName;
//        } 
            typeof(self) weakself = self;
            self.popView.lotteryBlock = ^{
                [weakself.viewPop show];
            };
            self.popView.searchBtnBlock = ^(NSString *str) {
                self.LikeUserName = str;
                _isShowPopView=NO;
                if (self.firstSubViewController == NO) {
                    _searchName = str;
                    
                   [self.navigationController popToRootViewControllerAnimated:NO];
                }else{
                    _searchName = @"";
                  [weakself loadListData];
                }

            };
            self.popView.statusBlock = ^{
                weakself.viewPop.dataArray = @[@"全部下级",@"直属下级"];
                [weakself.viewPop show];
                weakself.viewPop.cellDidSelected = ^(NSInteger i) {
                    [weakself.viewPop hiden];
                    weakself.popView.statusLabDetail.text = weakself.viewPop.dataArray[i];
                    weakself.TreeType = (int)i + 1;
                };
            };
            [weakself datePickerCallBack];
            [self.popView showPopView];
    
    }
}
- (void)dealloc{
    NSLog(@"----MCMemberMViewController --dealloc");
}
#pragma mark -- event callback
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
            [dataFormatter setDateFormat:@"yyyy/MM/dd"];
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
            [dataFormatter setDateFormat:@"yyyy/MM/dd"];
            weakself.maxDate = [dataFormatter dateFromString:selectDateStr];
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
            }];
        };
        
    };
    
}
#pragma mark -- getter and setter
- (NSMutableArray *)tableViewDataArray{
    
    if (_tableViewDataArray == nil) {
        _tableViewDataArray = [NSMutableArray array];
    }
    return _tableViewDataArray;
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
        [comps setYear:comps.year -10];
        datePicker.minDate = [calendar dateFromComponents:comps];
        datePicker.maxDate = [NSDate date];
        datePicker.frame =CGRectMake(0, self.view.frame.size.height  - 200 -49 , self.view.frame.size.width, 200);
        datePicker.Datetitle =@"日期选择";
        [self.popView addSubview:datePicker];
        _datePicker = datePicker;
    }
    return _datePicker;
}

- (MCMMPopView *)popView{
    
    if (_popView == nil) {
        MCMMPopView * popView = [[MCMMPopView alloc] init];
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

+ (void)load{
    
    _gTopArray = [NSMutableArray array];
}
- (MCNoDataWindow *)noDataWin{
    if (_noDataWin == nil) {
        MCNoDataWindow *win = [[MCNoDataWindow alloc] alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49)];
        if (self.firstSubViewController == NO) {
            win.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + MC_REALVALUE(40), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49 - MC_REALVALUE(40));
        }
        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _noDataWin = win;
    }
    return _noDataWin;
    
}

- (MCErrorWindow *)errDataWin{
    if (_errDataWin == nil) {
        MCErrorWindow *win = [[MCErrorWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 , G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49)];
        if (self.firstSubViewController == NO) {
            win.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + MC_REALVALUE(40), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49 - MC_REALVALUE(40));
        }
        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _errDataWin = win;
    }
    return _errDataWin;
    
}
- (MCNONetWindow *)errNetWin{
    if (_errNetWin == nil) {
        MCNONetWindow *win = [[MCNONetWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49)];
        if (self.firstSubViewController == NO) {
            win.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + MC_REALVALUE(40), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49 - MC_REALVALUE(40));
        }
        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _errNetWin = win;
    }
    return _errNetWin;
    
}
@end
