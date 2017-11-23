//
//  MCTeamBViewController.m
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTeamBViewController.h"
#import "MCMMTBmodel.h"
#import "MCNaviButton.h"
#import "DatePickerView.h"
#import "MCMMTBPopView.h"
#import "MCCoverView.h"
#import "MCMMIputView.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "MCRefreshNormalHeader.h"
#import "MCMMTBTableViewCell.h"
#import "MCUserDefinedAPIModel.h"
#import "MCTeamBDetailViewController.h"
#import "MCGameRecordDetailModel.h"

@interface MCTeamBViewController ()<UITableViewDelegate,UITableViewDataSource>
///**isShowPopView*/
@property (nonatomic,assign) BOOL isShowPopView;
///**条件选择*/
@property (nonatomic,weak) MCMMIputView *viewPop;
///**筛选框*/
@property (nonatomic,  weak) MCMMTBPopView *popView;
/**数据源tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewDataArray;
/**tableView*/
@property (nonatomic,weak) UITableView *tableView;
/**listModel 模型*/
@property (nonatomic,strong)  MCMMTBmodel *mmtbModel;
/**导航条的搜索按钮*/
@property (nonatomic,weak) MCNaviButton *btn;
/**datePicker 日期选择器*/
@property (nonatomic,  weak) DatePickerView  *datePicker;
/**datePicker的最小时间*/
@property (nonatomic,strong) NSDate *minDate;
/**datePicker的最大时间*/
@property (nonatomic,strong) NSDate *maxDate;

@property (nonatomic,assign) BOOL IsHistory;

@property (nonatomic,assign) int OrderState;
/**查询当前页*/
@property (nonatomic,assign) int currentPageIndex;
/**类型（1:全部下级 2-直属下级）*/
@property (nonatomic,strong) NSString *LotteryCode;

@end

@implementation MCTeamBViewController

#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"团队投注";
    self.view.backgroundColor = RGB(231, 231, 231);
    [self setUpUI];
    [self addNavRightBtn];
    [self configRequstNormalParmas];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadListData];
}
-(void)loadData{
    [super loadData];
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
#pragma mark - configRequstNormalParmas
- (void)configRequstNormalParmas{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    self.minDate = [NSDate date];
    self.maxDate = [NSDate date];
    self.currentPageIndex = 1;
    self.LotteryCode = @"";
    self.OrderState = -1;
    self.IsHistory = NO;
    
}
#pragma mark --发送请求
-(void)loadListData{
    
    __weak typeof(self) weakself = self;
    MCMMTBmodel *mmtbModel = [[MCMMTBmodel alloc] init];
    self.mmtbModel = mmtbModel;
    mmtbModel.OrderState = self.OrderState;
    mmtbModel.LotteryCode = self.LotteryCode;
    mmtbModel.IsHistory = self.IsHistory;
    mmtbModel.LikeUserName = self.LikeUserName;
    mmtbModel.CurrentPageSize = 15;
    mmtbModel.CurrentPageIndex = 1;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateTemps = [dataFormatter stringFromDate:self.minDate];
    NSString *dateTempe = [dataFormatter stringFromDate:self.maxDate];
    mmtbModel.insertTimeMin = [NSString stringWithFormat:@"%@ 00:00:00",dateTemps];
    mmtbModel.insertTimeMax = [NSString stringWithFormat:@"%@ 23:59:59",dateTempe];
    [mmtbModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    mmtbModel.callBackSuccessBlock = ^(NSDictionary *manager) {
        [weakself tableViewEndRefreshing];
        [BKIndicationView dismiss];
        if ([manager.allKeys containsObject:@"BtInfo"]) {
              weakself.tableViewDataArray = [MCMMTBmodel mj_objectArrayWithKeyValuesArray:manager[@"BtInfo"]];
        }
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
    mmtbModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
          [BKIndicationView dismiss];
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
    self.mmtbModel.CurrentPageIndex = ++self.currentPageIndex;
    __weak typeof(self) weakSelf = self;
    self.mmtbModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf tableViewEndRefreshing];
        NSArray *arr = [MCMMTBmodel mj_objectArrayWithKeyValuesArray:manager[@"BtInfo"]];
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
    self.mmtbModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf tableViewEndRefreshing];
    };
    [BKIndicationView showInView:self.view];
    [self.mmtbModel refreashDataAndShow];
}
- (void)tableViewEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

-(void)setUpUI{
//    self.view
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT  - MC_REALVALUE(26)-49 - 64) style:UITableViewStylePlain];
    [self.view addSubview:tab];
    tab.backgroundColor = RGB(231, 231, 231);
    self.tableView = tab;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakself = self;
    tab.layer.cornerRadius = 6;

    tab.clipsToBounds = YES;
    [tab registerClass:[MCMMTBTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MCRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadListData];
    }];
    
    self.tableView.rowHeight = MC_REALVALUE(66);
    tab.delegate = self;
    tab.dataSource = self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCMMTBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.dataSource = self.tableViewDataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MCMMTBmodel *modelT = self.tableViewDataArray[indexPath.row];
    MCTeamBDetailViewController *vc = [[MCTeamBDetailViewController alloc] init];
    MCGameRecordModel *model = [[MCGameRecordModel alloc] init];
    model.BetTb = [NSString stringWithFormat:@"%d",modelT.BetTb];
    model.InsertTime = modelT.InsertTime;
    model.OrderID = modelT.OrderID;
    model.PlayCode = [NSString stringWithFormat:@"%d",modelT.BetTb];
    vc.dataSource = model;
    vc.navigationItem.title = [NSString stringWithFormat:@"%@",modelT.UserName];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (BOOL)bissextile:(int)year {
    
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}
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
        typeof(self) weakself = self;
         //状态

        self.popView.lotteryBlock = ^{
            [weakself.viewPop show];
            weakself.viewPop.dataArray = @[@"全部",@"购买成功",@"未中奖",@"已派奖",@"已撤单",@"已撤奖"];
            NSArray *arr = @[@"-1",@"64",@"33554432",@"16777216",@"4",@"32768"];
            weakself.viewPop.cellDidSelectedTop = ^(NSInteger i) {
                [weakself.viewPop hiden];
                weakself.popView.stValueLabel.text = weakself.viewPop.dataArray[i];
                weakself.OrderState = [arr[i] intValue];
            };
        };
        // 搜索
        self.popView.searchBtnBlock = ^(NSString *str) {
            _isShowPopView=NO;
             self.LikeUserName = str;
            [weakself loadListData];
        };
         // 彩种
         NSArray * arr=[MCUserDefinedAPIModel getGameRecordMarr];
        self.popView.statusBlock = ^{
            weakself.viewPop.dataArray = arr;
            [weakself.viewPop show];
            weakself.viewPop.cellDidSelectedBlock = ^(NSDictionary *dic) {
                [weakself.viewPop hiden];
                weakself.popView.statusLabDetail.text = dic[@"name"];
                self.LotteryCode = dic[@"lotteryId"];
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

- (MCMMTBPopView *)popView{
    
    if (_popView == nil) {
        MCMMTBPopView * popView = [[MCMMTBPopView alloc] init];
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
@end
