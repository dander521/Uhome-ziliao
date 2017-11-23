//
//  MCGameRecordViewController.m
//  TLYL
//
//  Created by miaocai on 2017/7/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGameRecordViewController.h"
#import "MCGameRecordTableViewCell.h"
#import "MCGameRecordDetailViewController.h"
#import "MCGameRecordMineFilterView.h"
#import "MCNaviButton.h"
#import "DatePickerView.h"
#import "MCNaviPopView.h"
#import "MJRefresh.h"
#import "MCGameRecordModel.h"
#import "MCNoDataWindow.h"
#import "MCNONetWindow.h"
#import "MCErrorWindow.h"
#import "MCChaseNumberViewController.h"
#import "MCPickNumberViewController.h"
#import "MCUserDefinedAPIModel.h"
#import "MCInputView.h"
#import "MCTMNavigationViewController.h"

@interface MCGameRecordViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>


@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableViewDataArray;
@property (nonatomic,weak) DatePickerView  *datePicker;
@property (nonatomic,weak) MCNaviPopView *popView;
@property (nonatomic,weak) MCNaviPopView *recordPopView;
@property (nonatomic,strong) NSString *sourceCode;
@property (nonatomic,strong) NSString *lotteryCode;
@property (nonatomic,assign) BOOL isHistory;
@property (nonatomic,strong) NSString *insertTimeMin;
@property (nonatomic,strong) NSString *insertTimeMax;
@property (nonatomic,strong) NSString *currentPageIndex;
@property (nonatomic,strong) NSString *currentPageSize;
@property (nonatomic,strong) NSDate *minDate;
@property (nonatomic,strong) NSDate *maxDate;
@property (nonatomic,strong) MCGameRecordModel *gameRecordModel;
@property (nonatomic,assign) int index;
@property (nonatomic,weak) MCNaviButton *btn;
@property (nonatomic,assign) BOOL isShowPopView;
@property (nonatomic,assign) BOOL isShowrecordPopView;
@property(nonatomic, strong)ExceptionView * exceptionView;
@property (nonatomic,weak) MCInputView *viewPop;

@end

@implementation MCGameRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"投注记录";
    [self addNavRightBtn];
    [self setUpUI];
    self.index = 1;
    [self configRequstNormalParmas];
    
    
    
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

-(void)loadDataAndShow{
    [self loadDataAndShow:@""];
}
- (void)configRequstNormalParmas{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    self.minDate = [NSDate dateWithTimeIntervalSinceNow:-3 * 3600 * 24];
    self.maxDate = [NSDate date];
    self.sourceCode = @"1";
    self.lotteryCode = @"";
    self.isHistory = false;
    self.insertTimeMin = currentDateStr;
    self.insertTimeMax = currentDateStr;
    self.currentPageIndex = @"1";
    self.currentPageSize = @"10";
    self.popView.titleLabDetail.text = @"全部彩种";
    if (self.mmViewContoller == YES) {
        
    } else {
        self.mmViewContoller = NO;
        self.subUserName = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
        self.subUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
   
    
    

}

- (void)dealloc{
    
    NSLog(@"%@----dealloc",self);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.navigationController isKindOfClass:[MCTMNavigationViewController class]]) {
        
    } else {
        self.navigationController.navigationBarHidden=NO;
        self.navigationController.navigationBar.translucent = NO;
    }
   [self loadDataAndShow:self.lotteryCode];
    _isShowPopView=NO;
    _isShowrecordPopView=NO;
    [self.tableView reloadData];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.popView hidePopView];
    [self.recordPopView hidePopView];
    [self.viewPop hiden];
//    [[MCNONetWindow alertInstance] hideModelWindow];
//    [[MCErrorWindow alertInstance] hideModelWindow];
    if ([self.navigationController.viewControllers.lastObject isKindOfClass:[MCChaseNumberViewController class]] || [self.navigationController.viewControllers.lastObject isKindOfClass:[MCPickNumberViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.tabBarController.selectedIndex = 3;
    }
   
}

- (BOOL)bissextile:(int)year {
    
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}

- (void)addNavRightBtn {
    
    MCNaviButton *btn = [[MCNaviButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
    self.btn = btn;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor = RGB(239,246,253);
    UIScrollView *baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
    [self.view addSubview:baseScrollView];
    baseScrollView.contentSize = CGSizeMake(G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT - 64);
    baseScrollView.pagingEnabled = YES;
    /**tabView 创建*/

    
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(13, 13, G_SCREENWIDTH - 26, G_SCREENHEIGHT - 64 - 25) style:UITableViewStylePlain];
    if ([self.navigationController isKindOfClass:[MCTMNavigationViewController class]]) {
        tab.frame = CGRectMake(13, 13 +64, G_SCREENWIDTH - 26, G_SCREENHEIGHT - 64 - 25);
    }
    tab.layer.cornerRadius = 6;
    tab.clipsToBounds = YES;
    [self.view addSubview:tab];
    baseScrollView.delegate = self;
    tab.delegate = self;
    tab.dataSource = self;
    self.tableView = tab;
    self.view.backgroundColor = RGB(231, 231, 231);
    self.tableView.backgroundColor=RGB(255,255,255);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = MC_REALVALUE(77);
    __weak typeof(self) weakself = self;
    [self.tableView registerClass:[MCGameRecordTableViewCell class] forCellReuseIdentifier:@"MCGameRecordTableViewCell"];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadDataAndShow:weakself.lotteryCode];
    }];


}

- (void)loadMoreData{
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    self.gameRecordModel->_currentPageIndex = [NSString stringWithFormat:@"%d",++self.index];
    __weak typeof(self) weakSelf = self;
    self.gameRecordModel.callBackSuccessBlock = ^(id manager) {
        
        NSArray *arr = [MCGameRecordModel mj_objectArrayWithKeyValuesArray:manager[@"BtInfo"]];
        [weakSelf.tableViewDataArray addObjectsFromArray:arr];
        if (weakSelf.tableViewDataArray.count == 0) {
            [weakSelf.exceptionView showInView:weakSelf.view];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
        if (weakSelf.tableViewDataArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tableView.mj_footer.hidden=YES;
        }
    };
    
    self.gameRecordModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
    };
    [BKIndicationView showInView:self.view];
    [self.gameRecordModel refreashDataAndShow];
}

- (void)allBtnClick:(UIButton *)btn{
    NSArray * arr=[MCUserDefinedAPIModel getGameRecordMarr];
    if (_isShowPopView) {
        _isShowPopView=NO;
        [self.popView hidePopView];
        
    }else{
        _isShowPopView=YES;
        
        NSMutableArray *arrTemp = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            [arrTemp addObject:dic[@"name"]];
        }
        typeof(self) weakself = self;
        self.popView.lotteryBlock = ^{
            
            weakself.viewPop.dataArray = arr;
            weakself.viewPop.cellDidSelectedBlock = ^(NSDictionary * dic) {
                weakself.popView.titleLabDetail.text = dic[@"name"];
                [weakself.viewPop hiden];
                weakself.lotteryCode = dic[@"lotteryId"];
            };
            [weakself.viewPop show];
            
            
        };
        self.popView.statusBlock = ^{
            
            weakself.viewPop.dataArray = @[@"当前记录",@"历史记录"];
            [weakself.viewPop show];
            weakself.viewPop.cellDidSelected = ^(NSInteger i) {
                [weakself.viewPop hiden];
                weakself.popView.statusLabDetail.text = weakself.viewPop.dataArray[i];
                if (i == 0) {
                     weakself.isHistory = NO;
                    weakself.minDate = [NSDate dateWithTimeIntervalSinceNow:-3 * 3600 * 24];
                    weakself.maxDate = [NSDate date];
                    
                } else {
                     weakself.isHistory = YES;
                    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                    
                    NSDateComponents *comps = nil;
                    
                    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
                    NSArray *arrMouth = nil;
                    
                    if ([weakself bissextile:(int)[comps year]]) {
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
                weakself.insertTimeMin = endDateStr;
                weakself.insertTimeMax = endDateStr;
                weakself.popView.endDateLabDetail.text = endDateStr;
                weakself.popView.startDateLabDetail.text = endDateStr;
            };

            
        
        };

        self.popView.startDateBlock = ^{
            
            weakself.datePicker.cancelBlock = ^{
                
                [UIView animateWithDuration:0.25 animations:^{
                    [weakself.datePicker removeFromSuperview];
                }];
            };
            
            weakself.datePicker.sureBlock = ^(NSString *selectDateStr) {
                weakself.popView.startDateLabDetail.text = selectDateStr;
                weakself.insertTimeMin = selectDateStr;
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
                weakself.insertTimeMax = selectDateStr;
                [UIView animateWithDuration:0.25 animations:^{
                    [weakself.datePicker removeFromSuperview];
                    
                }];
            };
            
            
        };
        
    
        self.popView.startBtnBlock = ^{
            _isShowPopView = NO;
             [weakself.datePicker removeFromSuperview];
            [weakself loadDataAndShow:self.lotteryCode];
            
        };
        self.popView.dataSourceArray = arrTemp;
        self.popView.frame= CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT);
        [self.popView showPopView];
            self.popView.recordSelectedBlock = ^(NSInteger index) {
            NSDictionary *dic = arr[index];
            [weakself.btn setTitle:dic[@"name"] forState:UIControlStateNormal];
            [weakself.btn sizeToFit];
            weakself.lotteryCode=dic[@"lotteryId"];
            [weakself loadDataAndShow:dic[@"lotteryId"]];
        };
    
    }

}

- (void)loadDataAndShow:(NSString *)lotteryCode{
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    
    self.tableView.mj_footer.hidden=NO;
    self.gameRecordModel->_sourceCode = @"1";
    self.gameRecordModel->_lotteryCode = lotteryCode;
    self.gameRecordModel->_isHistory = self.isHistory;
    self.gameRecordModel->_subUserName = self.subUserName;
    self.gameRecordModel->_subUserID = self.subUserID;
    self.gameRecordModel->_insertTimeMin = [NSString stringWithFormat:@"%@ 00:00:00",self.insertTimeMin];
    NSString *str = [NSString stringWithFormat:@"%@ 23:59:59",self.insertTimeMax];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [dateFormatter setTimeZone:timeZone];
    NSDate *date = [dateFormatter dateFromString:str];
    NSComparisonResult result = [date compare:[NSDate date]];
    
    if (result == NSOrderedDescending) {
        
        self.gameRecordModel->_insertTimeMax = [dateFormatter stringFromDate:[NSDate date]];
    }else{
        self.gameRecordModel->_insertTimeMax = [NSString stringWithFormat:@"%@ 23:59:59",self.insertTimeMax];
    }
    self.gameRecordModel->_currentPageIndex = self.currentPageIndex;
    self.gameRecordModel->_currentPageSize = @"10";
    __weak typeof(self) weakSelf = self;
    
    self.gameRecordModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
        if ([manager isKindOfClass:[NSString class]]) {
            [weakSelf.tableViewDataArray removeAllObjects];
     
            
            
            [weakSelf.tableView reloadData];
            return ;
        }
        
      
        weakSelf.tableViewDataArray = [MCGameRecordModel mj_objectArrayWithKeyValuesArray:manager[@"BtInfo"]];
        if (weakSelf.tableViewDataArray.count == 0) {
            [weakSelf.exceptionView showInView:weakSelf.view];
        }
  
        if (weakSelf.tableViewDataArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tableView.mj_footer.hidden=YES;
        }
        [weakSelf.tableView reloadData];
    };
    self.gameRecordModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
    };
    [BKIndicationView showInView:self.view];
    [self.gameRecordModel refreashDataAndShow];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewDataArray.count;//self.tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCGameRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCGameRecordTableViewCell"];
    cell.dataSource = self.tableViewDataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCGameRecordDetailViewController *vc = [[MCGameRecordDetailViewController alloc] init];
    vc.dataSource = self.tableViewDataArray[indexPath.row];
    vc.isHistory = self.isHistory;
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
        datePicker.frame =CGRectMake(0, self.view.frame.size.height  - 200 + 64, self.view.frame.size.width, 200);
        datePicker.Datetitle =@"日期选择";
        [self.navigationController.view addSubview:datePicker];
        _datePicker = datePicker;
    }
    return _datePicker;
}

- (void)tap{
    _isShowPopView=NO;
    self.popView.hidden = YES;
    [self.datePicker removeFromSuperview];
    [self.viewPop hiden];
}
- (MCNaviPopView *)popView{
    
    if (_popView == nil) {
        MCNaviPopView * popView = [[MCNaviPopView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [popView addGestureRecognizer:tap];
        [self.navigationController.view addSubview:popView];
        _popView = popView;
    }
    return _popView;
}


-(ExceptionView *)exceptionView{
    if (!_exceptionView) {
        _exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
        _exceptionView.originY=0;
         _exceptionView.heightH=G_SCREENHEIGHT-64;
        if ([self.navigationController isKindOfClass:[MCTMNavigationViewController class]]) {
            _exceptionView.originY=64;
            _exceptionView.heightH=G_SCREENHEIGHT-64 - 26;
        }
        _exceptionView.backgroundColor=RGB(255,255,255);
       
    }
    return _exceptionView;
}

- (MCGameRecordModel *)gameRecordModel{
    if (_gameRecordModel == nil) {
        MCGameRecordModel *model = [[MCGameRecordModel alloc] init];
        _gameRecordModel = model;
    }
    return _gameRecordModel;
}

- (MCInputView *)viewPop{
    if (_viewPop == nil) {
        
        MCInputView *viewStatus = [[MCInputView alloc] init];
        [self.navigationController.view addSubview:viewStatus];
//        [self.popView addSubview:viewStatus];
        _viewPop = viewStatus;
    }
    return _viewPop;
}
@end
