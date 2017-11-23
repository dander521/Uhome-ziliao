//
//  MCWithdrawRecordViewController.m
//  TLYL
//
//  Created by miaocai on 2017/7/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCWithdrawRecordViewController.h"
#import "MCTopUpRecDetailViewController.h"
#import "MCWithdrawDetailViewController.h"
#import "MCWithdrawTableViewCell.h"
#import "MCTopUpMineFilterView.h"
#import "DatePickerView.h"
#import "MCNaviButton.h"
#import "MCWithdrawModel.h"
#import "MCNaviPopView.h"
#import "MJRefresh.h"
#import "MCNoDataWindow.h"
#import "MCNONetWindow.h"
#import "MCErrorWindow.h"

@interface MCWithdrawRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableViewDataArray;
@property (nonatomic,weak) DatePickerView  *datePicker;
@property (nonatomic,strong) MCWithdrawModel *withdrawModel;
@property (nonatomic,weak) MCNaviPopView *popView;
@property (nonatomic,weak) MCNaviButton *btn;
@property (nonatomic,strong) NSString *rechargeStates;
@property (nonatomic,strong) NSString *beginDate;
@property (nonatomic,strong) NSString *endDate;
@property (nonatomic,strong) NSString *currentPageIndex;
@property (nonatomic,strong) NSString *currentPageSize;
@property (nonatomic,weak) MCNaviPopView *recordPopView;
@property (nonatomic,assign) int index;
@property (nonatomic,strong) NSDate *minDate;
@property (nonatomic,strong) NSDate *maxDate;
@property (nonatomic,weak) MCTopUpMineFilterView *filterView;
@property (nonatomic,assign) BOOL isShowPopView;
@property (nonatomic,assign) BOOL isShowrecordPopView;
@property(nonatomic, strong)ExceptionView * exceptionView;
@end

@implementation MCWithdrawRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提款记录";
    [self addNavRightBtn];
    [self setUpUI];
    self.index = 1;
    [self configRequstNormalParmas];
    [self loadDataAndShow];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataAndShow) name:@"MCErrorWindow_Retry" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataAndShow) name:@"MCNONetWindow_Retry" object:nil];
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePop:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:singleTapGesture];
    [self.exceptionView addGestureRecognizer:singleTapGesture];
}

#pragma mark - gesture actions
- (void)closePop:(UITapGestureRecognizer *)recognizer {
    _isShowPopView=NO;
    _isShowrecordPopView=NO;
    [self.popView hidePopView];
    [self.recordPopView hidePopView];
    
}


- (void)configRequstNormalParmas{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    self.minDate = [NSDate dateWithTimeIntervalSinceNow:-3 * 3600 * 24];
    self.maxDate = [NSDate date];
    self.rechargeStates = @"";
    self.beginDate = currentDateStr;
    self.endDate = currentDateStr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    _isShowPopView=NO;
    _isShowrecordPopView=NO;
    [self.popView hidePopView];
    [self.recordPopView hidePopView];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.popView hidePopView];
    [self.recordPopView hidePopView];
//    [[MCNONetWindow alertInstance] hideModelWindow];
//    [[MCErrorWindow alertInstance] hideModelWindow];
}
- (void)addNavRightBtn {
    
    MCNaviButton *btn = [[MCNaviButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"tab_Title_drop_dpwn"] forState:UIControlStateNormal];
    [btn setTitle:@"全部" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    btn.frame = CGRectMake(0, 0, MC_REALVALUE(100), MC_REALVALUE(44));
    [btn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (BOOL)bissextile:(int)year {
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}
- (void)setUpUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    MCTopUpMineFilterView *filterView = [[MCTopUpMineFilterView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, 64)];
    self.filterView = filterView;
    __weak typeof(self) weakself = self;
    __weak MCTopUpMineFilterView *weakFilter = filterView;
    
    filterView.recordBtnBlock = ^{
        if (_isShowrecordPopView) {
            _isShowrecordPopView=NO;
            [self.recordPopView hidePopView];
            
        }else{
            _isShowrecordPopView=YES;
            self.recordPopView.dataSourceArray = @[@"当前记录",@"历史记录"];
            self.recordPopView.frame= CGRectMake(0, 108, G_SCREENWIDTH/3, HEIGHTNaviPopCELL*2);
            [self.recordPopView showPopView];
        }
        
        
    };
    self.recordPopView.recordSelectedBlock = ^(NSInteger i) {
        
        [filterView.recordBtn setTitle:self.recordPopView.dataSourceArray[i] forState:UIControlStateNormal];
        
        if (i == 0) {
            
            weakself.minDate = [NSDate dateWithTimeIntervalSinceNow:-3 * 3600 * 24];
            weakself.maxDate = [NSDate date];
  
            
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
            weakself.minDate = [NSDate dateWithTimeIntervalSinceNow:- ([mo intValue ]+ 3) * 3600 * 24];
            weakself.maxDate = [NSDate dateWithTimeIntervalSinceNow:-4 * 3600 * 24];
        
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *endDateStr = [dateFormatter stringFromDate:weakself.maxDate];
        [filterView.startTimeBtn setTitle:endDateStr forState:UIControlStateNormal];
        [filterView.endTimeBtn setTitle:endDateStr forState:UIControlStateNormal];
        self.beginDate = endDateStr;
        self.endDate = endDateStr;
        [self loadDataAndShow];
    };
    
    

    filterView.startDateBlock = ^{
        
        weakself.datePicker.cancelBlock = ^{
            
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
            }];
        };
        weakself.datePicker.sureBlock = ^(NSString *selectDateStr) {
            
            [weakFilter.startTimeBtn setTitle:selectDateStr forState:UIControlStateNormal];
            self.beginDate = selectDateStr;
            [self loadDataAndShow];
            [UIView animateWithDuration:0.25 animations:^{
                
                [weakself.datePicker removeFromSuperview];
                
            }];
        };
        
        
    };
    filterView.endDateBlock = ^{
        
        weakself.datePicker.cancelBlock = ^{
            
            [UIView animateWithDuration:0.25 animations:^{
                [weakself.datePicker removeFromSuperview];
            }];
        };
        weakself.datePicker.sureBlock = ^(NSString *selectDateStr) {
            
            [weakFilter.endTimeBtn setTitle:selectDateStr forState:UIControlStateNormal];
            self.endDate = selectDateStr;
            [self loadDataAndShow];
            [UIView animateWithDuration:0.25 animations:^{
                
                [weakself.datePicker removeFromSuperview];
            }];
        };
    };
    
    [self.view addSubview:filterView];
    self.view.backgroundColor = RGB(239,246,253);
    /**tabView 创建*/
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 128) style:UITableViewStylePlain];
    [self.view addSubview:tab];
    tab.delegate = self;
    tab.dataSource = self;
    self.tableView = tab;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=RGB(239,246,253);
    self.tableView.estimatedRowHeight = MC_REALVALUE(90);
    self.tableView.rowHeight = MC_REALVALUE(78);
    [self.tableView registerClass:[MCWithdrawTableViewCell class] forCellReuseIdentifier:@"MCWithdrawTableViewCell"];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataAndShow];
    }];
    
}
- (void)allBtnClick:(UIButton *)btn{
    
    if (_isShowPopView) {
        _isShowPopView=NO;
        [self.popView hidePopView];
        
    }else{
        _isShowPopView=YES;
        
        //交易状态（0：未处理；1：交易中；2：拒绝；3：交易成功；4：交易失败）
        self.popView.dataSourceArray = @[@"全部",@"未处理",@"交易中",@"拒绝",@"交易成功",@"交易失败"];
        self.popView.frame = CGRectMake(G_SCREENWIDTH - MC_REALVALUE(90), 64, MC_REALVALUE(90), 6*HEIGHTNaviPopCELL);
        [self.popView showPopView];
        self.popView.recordSelectedBlock = ^(NSInteger i) {
            NSString *str = @"";
            if (i == 0) {
            } else if(i == 1){
                str = @"0";
            }else{
                str = [NSString stringWithFormat:@"%ld",i-1];
            }
            [self.btn setTitle:self.popView.dataSourceArray[i] forState:UIControlStateNormal];
            self.rechargeStates = str;
            [self loadDataAndShow];
        };
    }
    
    
}

- (void)loadMoreData{
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    self.tableView.mj_footer.hidden=NO;
    self.withdrawModel->_currentPageIndex = [NSString stringWithFormat:@"%d",++self.index];
    __weak typeof(self) weakSelf = self;
    self.withdrawModel.callBackSuccessBlock = ^(id manager) {
        
        NSArray *arr = [MCTopUpRecordModel mj_objectArrayWithKeyValuesArray:manager[@"ModelList"]];
        [weakSelf.tableViewDataArray addObjectsFromArray:arr];

        if (weakSelf.tableViewDataArray.count == 0) {
             [weakSelf.exceptionView showInView:weakSelf.view];
        }
        weakSelf.filterView.totalLabel.text = [NSString stringWithFormat:@"记录总数：%@条",manager[@"DataCount"]];
        if (weakSelf.tableViewDataArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tableView.mj_footer.hidden=YES;
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
    };
    self.withdrawModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
    };
    [BKIndicationView showInView:self.view];
    [self.withdrawModel refreashDataAndShow];
}

- (void)loadDataAndShow{
    [self.exceptionView dismiss];
    self.exceptionView = nil;

    self.tableView.mj_footer.hidden=NO;
    self.withdrawModel->_drawingsState = self.rechargeStates;
    self.withdrawModel->_beginDate = [NSString stringWithFormat:@"%@ 00:00:00",self.beginDate];
    NSString *str = [NSString stringWithFormat:@"%@ 23:59:59",self.endDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [dateFormatter setTimeZone:timeZone];
    NSDate *date = [dateFormatter dateFromString:str];
    NSComparisonResult result = [date compare:[NSDate date]];
    if (result == NSOrderedDescending) {
        self.withdrawModel->_endDate = [dateFormatter stringFromDate:[NSDate date]];
    }else{
        self.withdrawModel->_endDate = [NSString stringWithFormat:@"%@ 23:59:59",self.endDate];
    }
    self.withdrawModel->_currentPageIndex = @"1";
    self.withdrawModel->_currentPageSize = @"10";
    
    __weak typeof(self) weakSelf = self;
    self.withdrawModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if ([manager isKindOfClass:[NSString class]]) {
            
            [weakSelf.tableViewDataArray removeAllObjects];
            weakSelf.filterView.totalLabel.text = [NSString stringWithFormat:@"记录总数：%@条",manager[@"DataCount"]];
            [weakSelf.tableView reloadData];
            return ;
            
        }
        weakSelf.tableViewDataArray = [MCWithdrawModel mj_objectArrayWithKeyValuesArray:manager[@"ModelList"]];
        if (weakSelf.tableViewDataArray.count == 0) {
             [weakSelf.exceptionView showInView:weakSelf.view];
        }
        weakSelf.filterView.totalLabel.text = [NSString stringWithFormat:@"记录总数：%@条",manager[@"DataCount"]];
        if (weakSelf.tableViewDataArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tableView.mj_footer.hidden=YES;
        }
        [weakSelf.tableView reloadData];
    };
    
    self.withdrawModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
    };
    [BKIndicationView showInView:self.view];
    [self.withdrawModel refreashDataAndShow];
}

- (void)showNoData{
    
    

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCWithdrawTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCWithdrawTableViewCell"];
    cell.dataSource = self.tableViewDataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MCWithdrawDetailViewController *vc = [[MCWithdrawDetailViewController alloc] init];
    vc.dataSorce = self.tableViewDataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
        datePicker.frame =CGRectMake(0, self.view.frame.size.height - 200 , self.view.frame.size.width, 200);
        datePicker.Datetitle =@"日期选择";
        [self.view addSubview:datePicker];
        _datePicker = datePicker;
    }
    return _datePicker;
}
- (void)tap{
    _isShowPopView=NO;
    self.popView.hidden = YES;
    
}
- (MCNaviPopView *)popView{
    if (_popView == nil) {
        MCNaviPopView * popView = [[MCNaviPopView alloc] init];
        [self.navigationController.view addSubview:popView];
        UITapGestureRecognizer *ge = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [popView addGestureRecognizer:ge];
        _popView = popView;
    }
    return _popView;
}
- (MCNaviPopView *)recordPopView{
    if (_recordPopView == nil) {
        MCNaviPopView * popView = [[MCNaviPopView alloc] init];
        [self.navigationController.view addSubview:popView];
        _recordPopView = popView;
    }
    return _recordPopView;
}
-(ExceptionView *)exceptionView{
    if (!_exceptionView) {
        _exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
        _exceptionView.originY=64;
        _exceptionView.backgroundColor=RGB(255,255,255);
        _exceptionView.heightH=G_SCREENHEIGHT-128;
    }
    return _exceptionView;
}

- (MCWithdrawModel *)withdrawModel{
    if (_withdrawModel == nil) {
        MCWithdrawModel *model = [[MCWithdrawModel alloc] init];
        _withdrawModel = model;
    }
    return _withdrawModel;
}

@end
