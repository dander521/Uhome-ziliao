//
//  MCTopUpRecordViewController.m
//  TLYL
//
//  Created by miaocai on 2017/7/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTopUpRecordViewController.h"
#import "MCTopUpRecrdTableViewCell.h"
#import "MCTopUpRecordModel.h"
#import "MCTopUpRecDetailViewController.h"
#import "MCTopUpMineFilterView.h"
#import "MCNaviButton.h"
#import "DatePickerView.h"
#import "MCNaviPopView.h"
#import "MJRefresh.h"
#import "MCNoDataWindow.h"
#import "MCNONetWindow.h"
#import "MCErrorWindow.h"
#import "MCGroupPaymentModel.h"
#import "MCButton.h"
#import "MCInputView.h"
#import "MCUserDefinedAPIModel.h"
#import "MCWithdrawTableViewCell.h"
#import "MCCoverView.h"
#import "MCRechargeViewController.h"
#import "MCWithdrawRecDeltailViewController.h"
#import "MCZhuanTableViewCell.h"
#import "MCZhuanRecordModel.h"
#import "MCMineInfoModel.h"

@interface MCTopUpRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
/**充值tableView*/
@property (nonatomic,  weak) UITableView *tableView;
/**充值tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewDataArray;
/**提款tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewDataDarwArray;
/**datePicker的最小时间*/
@property (nonatomic,strong) NSDate *minDate;
/**datePicker的最大时间*/
@property (nonatomic,strong) NSDate *maxDate;
/**datePicker 日期选择器*/
@property (nonatomic,  weak) DatePickerView  *datePicker;
/**充值的模型*/
@property (nonatomic,strong) MCTopUpRecordModel *topUpRecordModel;
/**筛选框*/
@property (nonatomic,  weak) MCNaviPopView *popView;
/**筛选框按钮*/
@property (nonatomic,  weak) MCNaviButton *btn;
/**查询状态*/
@property (nonatomic,strong) NSString *rechargeStates;
/**查询开始日期*/
@property (nonatomic,strong) NSDate *beginDate;
/**查询结束日期*/
@property (nonatomic,strong) NSDate *endDate;
/**查询当前页*/
@property (nonatomic,strong) NSString *currentPageIndex;
/**查询当前页数量*/
@property (nonatomic,strong) NSString *currentPageSize;

@property (nonatomic,weak) UITableView *tabRightZhuanView;

/**查询下一页*/
@property (nonatomic,assign) int index;
@property (nonatomic,strong) MCGroupPaymentModel *paymentModel;
@property (nonatomic,strong) NSArray *arrData;
@property (nonatomic,assign) BOOL isShowPopView;
@property (nonatomic,weak) MCInputView *viewPop;
@property (nonatomic,strong) NSString *insertTimeMin;
@property (nonatomic,strong) NSString *insertTimeMax;
@property (nonatomic,weak) UIButton *bottomViewTopBtn;
@property (nonatomic,weak) UIButton *bottomViewDrawBtn;
@property (nonatomic,weak) UIScrollView *baseScrollView;
@property (nonatomic,weak) UITableView *tabRightView;
@property (nonatomic,strong) MCWithdrawModel *withdrawModel;
@property (nonatomic,strong) MCZhuanRecordModel *zhuanRecordModel;
@property (nonatomic,weak) UIView *bottomView;
@property (nonatomic,weak) MCCoverView *cloverView;
@property (nonatomic,assign) int TransferType;
@property (nonatomic,strong) NSMutableArray *tableViewDataZhuanArray;
@property (nonatomic,assign) BOOL isZhuanHistory;
@property (nonatomic,assign) int  zhuanTransferType;
@property (nonatomic,assign) int zhuanCurrentPageIndex;
@property (nonatomic,strong) NSString *MiddleTitle;
@property (nonatomic,strong) NSString *rightTitle;
@property (nonatomic,strong) NSString *leftTitle;
@property (nonatomic,assign) int rightRechargeStates;
@property (nonatomic,strong) NSString *leftRechargeStates;
@property (nonatomic,strong) NSString *middleRechargeStates;

@end

@implementation MCTopUpRecordViewController
@synthesize noDataWin = _noDataWin;
@synthesize errDataWin = _errDataWin;
@synthesize errNetWin = _errNetWin;
#pragma mark - view life clycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资金明细";
    [self addNavRightBtn];
    [self setUpUI];
    self.index = 1;
    [self configRequstNormalParmas];
    [self loadDataAndShow];
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePop:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:singleTapGesture];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.bottomView.hidden = NO;
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    _isShowPopView=NO;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [self.popView hidePopView];
    [self.viewPop hiden];
    self.bottomView.hidden = YES;
    [self.cloverView hidden];

}

#pragma mark - gesture actions
- (void)closePop:(UITapGestureRecognizer *)recognizer {
    _isShowPopView=NO;
    [self.popView hidePopView];
}

#pragma mark - configRequstNormalParmas
- (void)configRequstNormalParmas{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    self.minDate = [NSDate dateWithTimeIntervalSinceNow:-3*3600*24];
    self.maxDate = [NSDate date];
    self.rechargeStates = @"";
    self.isZhuanHistory = NO;
    self.zhuanCurrentPageIndex = 1;
    self.zhuanTransferType = 0;
    self.beginDate = [NSDate date];
    self.endDate = [NSDate date];
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


- (void)setUpUI{
    
    UIScrollView *baseScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:baseScrollView];
    baseScrollView.pagingEnabled = YES;
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    baseScrollView.contentSize = CGSizeMake(3*G_SCREENWIDTH, G_SCREENHEIGHT);
    self.baseScrollView = baseScrollView;
    baseScrollView.scrollEnabled = NO;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, MC_REALVALUE(40))];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"类型",@"时间",@"金额",@"状态"];
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
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(13, 50, G_SCREENWIDTH-26, G_SCREENHEIGHT - 64 - 50 - 49 -10) style:UITableViewStylePlain];
    [self.baseScrollView addSubview:tab];
    tab.delegate = self;
    tab.dataSource = self;
    self.tableView = tab;
    self.tableView.layer.cornerRadius = 6;
    self.tableView.clipsToBounds = YES;
    self.tableView.rowHeight = MC_REALVALUE(50);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.tableView.contentOffset = CGPointMake(0, 40);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MCTopUpRecrdTableViewCell class] forCellReuseIdentifier:@"MCTopUpRecrdTableViewCell"];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    __weak typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadDataAndShow];
    }];
    self.view.backgroundColor = RGB(231, 231, 231);
    // 提款记录
    UITableView *tabRight = [[UITableView alloc] initWithFrame:CGRectMake(13 + G_SCREENWIDTH, 50, G_SCREENWIDTH-26, G_SCREENHEIGHT - 64 - 50 - 49 -10) style:UITableViewStylePlain];
    [self.baseScrollView addSubview:tabRight];
    tabRight.delegate = self;
    tabRight.dataSource = self;
    self.tabRightView = tabRight;
    self.tabRightView.layer.cornerRadius = 6;
    self.tabRightView.clipsToBounds = YES;
    self.tabRightView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tabRightView.rowHeight = MC_REALVALUE(50);
    self.tabRightView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tabRightView registerClass:[MCWithdrawTableViewCell class] forCellReuseIdentifier:@"MCWithdrawTableViewCell"];
    self.tabRightView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDrawData)];
    self.tabRightView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadDrawDataAndShow];
    }];
    //转账记录
    UITableView *tabZhuanRight = [[UITableView alloc] initWithFrame:CGRectMake(13 + G_SCREENWIDTH *2, 50, G_SCREENWIDTH-26, G_SCREENHEIGHT - 64 - 50 - 49 -10) style:UITableViewStylePlain];
    [self.baseScrollView addSubview:tabZhuanRight];
    tabZhuanRight.delegate = self;
    tabZhuanRight.dataSource = self;
    self.tabRightZhuanView = tabZhuanRight;
    self.tabRightZhuanView.layer.cornerRadius = 6;
    self.tabRightZhuanView.clipsToBounds = YES;
    self.tabRightZhuanView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tabRightZhuanView.rowHeight = MC_REALVALUE(50);
    self.tabRightZhuanView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tabRightZhuanView registerClass:[MCZhuanTableViewCell class] forCellReuseIdentifier:@"MCZhuanTableViewCell"];
    self.tabRightZhuanView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreZhuanData)];
    self.tabRightZhuanView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadZhuanDataAndShow];
    }];
    
    self.view.backgroundColor = RGB(231, 231, 231);

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, G_SCREENHEIGHT - 49, G_SCREENWIDTH, 49)];
    [self.navigationController.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView = bottomView;
    
    
    
    NSArray *botArr = nil;
    
    
    int Mode = (int)[[NSUserDefaults standardUserDefaults] objectForKey:MerchantMode];
    MCMineInfoModel *mineInfoModel =[MCMineInfoModel sharedMCMineInfoModel];
    if (((Mode & 32) != 32) || ([mineInfoModel.UserType intValue] ==1) ) {
        //隐藏转账和棋牌项

        botArr = @[@"充值记录",@"提款记录"];
    }else{
        //显示转账和棋牌项

        botArr = @[@"充值记录",@"提款记录",@"转账记录"];
    }

    for (NSInteger i = 0; i<botArr.count; i++) {
        MCButton *btn = [[MCButton alloc] initWithFrame:CGRectMake(i*G_SCREENWIDTH/botArr.count, 0, G_SCREENWIDTH/botArr.count, 49)];
        [bottomView addSubview:btn];
        [btn setTitle:botArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(144, 8, 215) forState:UIControlStateSelected];
        [btn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
        if (i == 0) {
            [btn setImage:[UIImage imageNamed:@"czjl"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"czjl-xz"] forState:UIControlStateSelected];
        } else if(i==1) {
            [btn setImage:[UIImage imageNamed:@"txjl"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"txjl-xz"] forState:UIControlStateSelected];
        }else{
            [btn setImage:[UIImage imageNamed:@"drbzzjlwxz"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"denzzjlxz"] forState:UIControlStateSelected];
        }
        
        btn.tag = 1500 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        if (btn.tag == 1500) {
            self.bottomViewTopBtn = btn;
            btn.selected = YES;
        }
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

#pragma mark - touch event
- (void)recordBtnClick:(NSInteger)i{
    [self.viewPop hiden];
    self.popView.statusLabDetail.text = self.viewPop.dataArray[i];
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


- (void)btnClick:(UIButton *)btn{
    
    self.bottomViewTopBtn.selected = NO;
    btn.selected = !btn.selected;
    self.bottomViewTopBtn = btn;
    if (btn.tag == 1500) {
        if ([self.leftTitle isEqualToString:@""] || self.leftTitle == nil) {
           self.popView.titleLabDetail.text = @"全部";
        } else {
            self.rechargeStates = self.leftRechargeStates;
           self.popView.titleLabDetail.text = self.leftTitle;
        }
        
        [self loadDataAndShow];
        [self.baseScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if(btn.tag == 1501){
        if ([self.MiddleTitle isEqualToString:@""] || self.MiddleTitle == nil) {
            self.popView.titleLabDetail.text = @"全部";
        } else {
            self.rechargeStates = self.middleRechargeStates;
            self.popView.titleLabDetail.text = self.MiddleTitle;
        }

        [self loadDrawDataAndShow];
        [self.baseScrollView setContentOffset:CGPointMake(G_SCREENWIDTH, 0) animated:YES];
    }else{
        if ([self.rightTitle isEqualToString:@""] || self.rightTitle == nil) {
            self.popView.titleLabDetail.text = @"全部";
        } else {
            self.zhuanTransferType = self.rightRechargeStates;
            self.popView.titleLabDetail.text = self.rightTitle;
        }
        [self loadZhuanDataAndShow];
        [self.baseScrollView setContentOffset:CGPointMake(G_SCREENWIDTH * 2, 0) animated:YES];
    }
    
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
        if (self.baseScrollView.contentOffset.x == 0) {
            [self setShaiXianChongView:arr tempArr:arrTemp];
           
        } else if(self.baseScrollView.contentOffset.x == G_SCREENWIDTH){
            
            [self setShuaiXuanTiView:arr tempArr:arrTemp];
                
        }else{
            [self setShaiXuanZhuan:arr tempArr:arrTemp];
            
        }
    }
    
    
}
#pragma mark -- 转账的筛选view
- (void)setShaiXuanZhuan:(NSArray *)arr tempArr:(NSArray *)arrTemp{
    
    self.popView.titleLab.text = @"转账类型";
//    self.popView.titleLabDetail.text = @"全部";
    typeof(self) weakself = self;
    self.popView.lotteryBlock = ^{
        weakself.viewPop.dataArray = @[@"全部",@"成功",@"处理中",@"失败"];
        weakself.viewPop.cellDidSelectedTop = ^(NSInteger i) {
            int str = 0;
            if (i == 0) {
                str = 0;
            }else{
                str = i+1;
            }
            self.rightRechargeStates = str;
            self.zhuanTransferType = self.rightRechargeStates;
            self.rightTitle = weakself.viewPop.dataArray[i];
            self.popView.titleLabDetail.text = self.rightTitle;
            [weakself.viewPop hiden];
        };
        [weakself.viewPop show];
    };
    self.popView.statusBlock = ^{
        weakself.viewPop.dataArray = @[@"当前记录",@"历史记录"];
        [weakself.viewPop show];
        weakself.viewPop.cellDidSelected = ^(NSInteger i) {
            [weakself.viewPop hiden];
            
            weakself.popView.statusLabDetail.text = weakself.viewPop.dataArray[i];
            [weakself recordBtnClick:i];
        };
    };
    
    [weakself datePickerCallBack];
    self.popView.startBtnBlock = ^{
        _isShowPopView=NO;
        [weakself loadZhuanDataAndShow];
    };
    self.popView.dataSourceArray = arrTemp;
    self.popView.frame= CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT);
    [self.popView showPopView];
    self.popView.recordSelectedBlock = ^(NSInteger index) {
        NSDictionary *dic = arr[index];
        [weakself.btn setTitle:dic[@"name"] forState:UIControlStateNormal];
        [weakself.btn sizeToFit];
        [weakself loadZhuanDataAndShow];
    };
    
}
- (void)setShaiXianChongView:(NSArray *)arr tempArr:(NSArray *)arrTemp{
    self.popView.titleLab.text = @"充值类型";

    typeof(self) weakself = self;
    self.popView.lotteryBlock = ^{
        weakself.viewPop.dataArray = @[@"全部",@"交易成功",@"交易失败",@"未处理"];
        weakself.viewPop.cellDidSelectedTop = ^(NSInteger i) {
            NSString *str = @"";
            if (i==0) {
               str = @"";
            } else if(i==1){
                str = @"1";
            }else if(i==2){
                str = @"2";
            }else if(i==3){
                str= @"0";
            }
            
            self.leftRechargeStates = str;
            self.rechargeStates = self.leftRechargeStates;
            self.leftTitle = weakself.viewPop.dataArray[i];
            self.popView.titleLabDetail.text = self.leftTitle;
          
            [weakself.viewPop hiden];
        };
        [weakself.viewPop show];
    };
    self.popView.statusBlock = ^{
        weakself.viewPop.dataArray = @[@"当前记录",@"历史记录"];
        [weakself.viewPop show];
        weakself.viewPop.cellDidSelected = ^(NSInteger i) {
            [weakself.viewPop hiden];
            weakself.popView.statusLabDetail.text = weakself.viewPop.dataArray[i];
            [weakself recordBtnClick:i];
        };
    };
    
    [weakself datePickerCallBack];
    self.popView.startBtnBlock = ^{
        _isShowPopView=NO;
        [weakself loadDataAndShow];
    };
    self.popView.dataSourceArray = arrTemp;
    self.popView.frame= CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT);
    [self.popView showPopView];
    self.popView.recordSelectedBlock = ^(NSInteger index) {
        NSDictionary *dic = arr[index];
        [weakself.btn setTitle:dic[@"name"] forState:UIControlStateNormal];
        [weakself.btn sizeToFit];
        [weakself loadDataAndShow];
    };
    
}
- (void)setShuaiXuanTiView:(NSArray *)arr tempArr:(NSArray *)arrTemp{
    self.popView.titleLab.text = @"提款类型";
//    self.popView.titleLabDetail.text = @"全部";
    typeof(self) weakself = self;
    self.popView.lotteryBlock = ^{
        weakself.viewPop.dataArray = @[@"全部",@"未处理",@"交易中",@"拒绝",@"交易成功",@"交易失败"];
        weakself.viewPop.cellDidSelectedTop = ^(NSInteger i) {
            NSString *str = @"";
            if (i == 0) {
            } else if(i == 1){
                str = @"0";
            }else{
                str = [NSString stringWithFormat:@"%ld",i-1];
            }
            self.middleRechargeStates = str;
            self.rechargeStates = self.middleRechargeStates;
            self.MiddleTitle = weakself.viewPop.dataArray[i];
            self.popView.titleLabDetail.text = self.MiddleTitle;
            [weakself.viewPop hiden];
        };
        [weakself.viewPop show];
    };
    self.popView.statusBlock = ^{
        weakself.viewPop.dataArray = @[@"当前记录",@"历史记录"];
        [weakself.viewPop show];
        weakself.viewPop.cellDidSelected = ^(NSInteger i) {
            [weakself.viewPop hiden];
            
            weakself.popView.statusLabDetail.text = weakself.viewPop.dataArray[i];
            [weakself recordBtnClick:i];
        };
    };
    
    [weakself datePickerCallBack];
    self.popView.startBtnBlock = ^{
        _isShowPopView=NO;
        [weakself loadDrawDataAndShow];
    };
    self.popView.dataSourceArray = arrTemp;
    self.popView.frame= CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT);
    [self.popView showPopView];
    self.popView.recordSelectedBlock = ^(NSInteger index) {
        NSDictionary *dic = arr[index];
        [weakself.btn setTitle:dic[@"name"] forState:UIControlStateNormal];
        [weakself.btn sizeToFit];
        [weakself loadDrawDataAndShow];
    };
}
#pragma mark - load data
- (void)loadDrawDataAndShow{

    self.tabRightView.mj_footer.hidden=NO;
    self.withdrawModel->_drawingsState = self.rechargeStates;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateTemps = [dateFormatter stringFromDate:self.beginDate];
    NSString *dateTempe = [dateFormatter stringFromDate:self.endDate];
    self.withdrawModel->_beginDate = [NSString stringWithFormat:@"%@ 00:00:00",dateTemps];
    self.withdrawModel->_endDate = [NSString stringWithFormat:@"%@ 23:59:59",dateTempe];
    self.withdrawModel->_currentPageIndex = @"1";
    self.withdrawModel->_currentPageSize = @"15";
    __weak typeof(self) weakSelf = self;
    self.withdrawModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf.tabRightView.mj_header endRefreshing];
        [weakSelf.tabRightView.mj_footer endRefreshing];
        if ([manager isKindOfClass:[NSString class]]) {
            [weakSelf.tableViewDataDarwArray removeAllObjects];
            [weakSelf.tabRightView reloadData];
            return ;
            
        }
        weakSelf.tableViewDataDarwArray = [MCWithdrawModel mj_objectArrayWithKeyValuesArray:manager[@"ModelList"]];
        if (weakSelf.tableViewDataDarwArray.count == 0) {
           [weakSelf showExDataView];
        }else{
            [weakSelf hiddenExDataView];
        }
        if (weakSelf.tableViewDataDarwArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tabRightView.mj_footer.hidden=YES;
        }
        [weakSelf.tabRightView reloadData];
    };
    
    self.withdrawModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
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
    };
//    if (self.tableViewDataDarwArray.count == 0) {
//        [self.exceptionView showInView:weakSelf.view];
//    }
    [BKIndicationView showInView:self.view];
    [self.withdrawModel refreashDataAndShow];
    
}



- (void)loadMoreDrawData{

    self.tabRightView.mj_footer.hidden=NO;
    self.withdrawModel->_currentPageIndex = [NSString stringWithFormat:@"%d",++self.index];
    __weak typeof(self) weakSelf = self;
    self.withdrawModel.callBackSuccessBlock = ^(id manager) {
        NSArray *arr = [MCTopUpRecordModel mj_objectArrayWithKeyValuesArray:manager[@"ModelList"]];
        [weakSelf.tableViewDataDarwArray addObjectsFromArray:arr];
        if (weakSelf.tableViewDataDarwArray.count == 0) {
            
            [weakSelf showExDataView];
        }else{
            [weakSelf hiddenExDataView];
        }
        
        if (weakSelf.tableViewDataDarwArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tabRightView.mj_footer.hidden=YES;
        }
        [weakSelf.tabRightView reloadData];

        [weakSelf.tabRightView.mj_header endRefreshing];
    };
    self.withdrawModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
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
    };
    [BKIndicationView showInView:self.view];
    [self.withdrawModel refreashDataAndShow];
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
    self.tableView.mj_footer.hidden=NO;
    self.tabRightView.mj_footer.hidden = NO;
    self.topUpRecordModel->_rechargeState = self.rechargeStates;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateTemps = [dateFormatter stringFromDate:self.beginDate];
    NSString *dateTempe = [dateFormatter stringFromDate:self.endDate];
    self.topUpRecordModel->_beginDate = [NSString stringWithFormat:@"%@ 00:00:00",dateTemps];
    self.topUpRecordModel->_endDate = [NSString stringWithFormat:@"%@ 23:59:59",dateTempe];
    self.topUpRecordModel->_currentPageIndex = @"1";
    self.topUpRecordModel->_currentPageSize = @"15";
    self.topUpRecordModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf tableViewEndRefreshing];
        if ([manager isKindOfClass:[NSString class]]) {
            [weakSelf.tableViewDataArray removeAllObjects];
            [weakSelf.tableView reloadData];
            return ;
        }
        weakSelf.tableViewDataArray = [MCTopUpRecordModel mj_objectArrayWithKeyValuesArray:manager[@"ModelList"]];
        if (weakSelf.tableViewDataArray.count == 0) {
            [weakSelf showExDataView];
        }else{
            [weakSelf hiddenExDataView];
        }
        
        if (weakSelf.tableViewDataArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tableView.mj_footer.hidden=YES;
        }
        [weakSelf.tableView reloadData];
    };
    
    self.topUpRecordModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf tableViewEndRefreshing];
        
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [weakSelf.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [weakSelf.errNetWin setHidden:NO];
            
        } else {
            [weakSelf.errDataWin setHidden:NO];
        }
        }
    };
    [BKIndicationView showInView:self.view];
    [self.topUpRecordModel refreashDataAndShow];
}
- (void)loadMoreData{

    self.tableView.mj_footer.hidden=NO;
    self.topUpRecordModel->_currentPageIndex = [NSString stringWithFormat:@"%d",++self.index];
    __weak typeof(self) weakSelf = self;
    self.topUpRecordModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf tableViewEndRefreshing];
        NSArray *arr = [MCTopUpRecordModel mj_objectArrayWithKeyValuesArray:manager[@"ModelList"]];
        [weakSelf.tableViewDataArray addObjectsFromArray:arr];
        if (weakSelf.tableViewDataArray.count == 0) {
            [weakSelf showExDataView];
        }else{
            [weakSelf hiddenExDataView];
        }
        
        [weakSelf.tableView reloadData];
        [weakSelf tableViewEndRefreshing];
        if (weakSelf.tableViewDataArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tableView.mj_footer.hidden=YES;
        }
    };
    self.topUpRecordModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf tableViewEndRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [weakSelf.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [weakSelf.errNetWin setHidden:NO];
                
            } else {
                [weakSelf.errDataWin setHidden:NO];
            }
        }
    };
    [BKIndicationView showInView:self.view];
    [self.topUpRecordModel refreashDataAndShow];
}

- (void)loadZhuanDataAndShow{
    
    MCZhuanRecordModel *model = [[MCZhuanRecordModel alloc] init];
    self.zhuanRecordModel = model;
    [BKIndicationView showInView:self.view];
    
    __weak typeof(self)weakSelf = self;
    self.tabRightZhuanView.mj_footer.hidden = NO;
    self.zhuanRecordModel->_UserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    self.zhuanRecordModel->_IsHistory =self.isZhuanHistory;
    self.zhuanRecordModel->_CurrentPageIndex = 1;
    self.zhuanRecordModel->_CurrentPageSize = 15;
    self.zhuanRecordModel->_TransferType1 = self.zhuanTransferType;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateTemps = [dateFormatter stringFromDate:self.beginDate];
    NSString *dateTempe = [dateFormatter stringFromDate:self.endDate];
    self.zhuanRecordModel->_InsertTimeMin = [NSString stringWithFormat:@"%@ 00:00:00",dateTemps];
    self.zhuanRecordModel->_InsertTimeMax = [NSString stringWithFormat:@"%@ 23:59:59",dateTempe];
    [model refreashDataAndShow];
    self.zhuanRecordModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf tableViewEndRefreshing];
        if ([manager isKindOfClass:[NSString class]]) {
            [weakSelf.tableViewDataZhuanArray removeAllObjects];
            [weakSelf.tabRightZhuanView reloadData];
            return ;
        }
        weakSelf.tableViewDataZhuanArray = [MCZhuanRecordModel mj_objectArrayWithKeyValuesArray:manager[@"DsUserTransfer"]];
        if (weakSelf.tableViewDataZhuanArray.count == 0) {
            [weakSelf showExDataView];
        }else{
            [weakSelf hiddenExDataView];
        }
            
        
        if (weakSelf.tableViewDataZhuanArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tabRightZhuanView.mj_footer.hidden=YES;
        }
        [weakSelf.tabRightZhuanView reloadData];
    };
    
    self.zhuanRecordModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf.tabRightZhuanView.mj_footer endRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [weakSelf.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [weakSelf.errNetWin setHidden:NO];
                
            } else {
                [weakSelf.errDataWin setHidden:NO];
            }
        }
    };
    
    
}
- (void)loadMoreZhuanData{
    
    self.tabRightZhuanView.mj_footer.hidden=NO;
    self.zhuanRecordModel->_CurrentPageIndex = ++self.zhuanCurrentPageIndex;
    __weak typeof(self) weakSelf = self;
    self.zhuanRecordModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf tableViewEndRefreshing];
        NSArray *arr = [MCZhuanRecordModel mj_objectArrayWithKeyValuesArray:manager[@"DsUserTransfer"]];
        [weakSelf.tableViewDataZhuanArray addObjectsFromArray:arr];
        if (weakSelf.tableViewDataZhuanArray.count == 0) {
            [weakSelf showExDataView];
        }else{
            [weakSelf hiddenExDataView];
        }
        
        [weakSelf.tabRightZhuanView reloadData];
        [weakSelf tableViewEndRefreshing];
        if (weakSelf.tableViewDataZhuanArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tabRightZhuanView.mj_footer.hidden=YES;
        }
    };
    self.zhuanRecordModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf tableViewEndRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [weakSelf.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [weakSelf.errNetWin setHidden:NO];
                
            } else {
                [weakSelf.errDataWin setHidden:NO];
            }
        }
    };
    [BKIndicationView showInView:self.view];
    [self.zhuanRecordModel refreashDataAndShow];
}
- (void)tableViewEndRefreshing{
    [self.tabRightView.mj_footer endRefreshing];
    [self.tabRightView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    [self.tabRightZhuanView.mj_footer endRefreshing];
    [self.tabRightZhuanView.mj_header endRefreshing];
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

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView== self.tableView) {
        return self.tableViewDataArray.count;
    } else if(tableView == self.tabRightView){
        return self.tableViewDataDarwArray.count;
    }else{
        return self.tableViewDataZhuanArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (tableView == self.tableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MCTopUpRecrdTableViewCell"];
        MCTopUpRecrdTableViewCell *cellT = (MCTopUpRecrdTableViewCell *)cell;
        cellT.dataSource = self.tableViewDataArray[indexPath.row];
    } else if(tableView == self.tabRightView){
        cell = [tableView dequeueReusableCellWithIdentifier:@"MCWithdrawTableViewCell"];
        MCWithdrawTableViewCell *cellT = (MCWithdrawTableViewCell *)cell;
        cellT.dataSource = self.tableViewDataDarwArray[indexPath.row];

    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"MCZhuanTableViewCell"];
        MCZhuanTableViewCell *cellT = (MCZhuanTableViewCell *)cell;
        cellT.dataSource = self.tableViewDataZhuanArray[indexPath.row];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.cloverView.dataArr = self.arrData;
    if (tableView == self.tableView) {
        self.cloverView.dataSource = self.tableViewDataArray[indexPath.row];
        [self.cloverView show];
    }else if(tableView == self.tabRightView){
  
        self.cloverView.dataSourceD = self.tableViewDataDarwArray[indexPath.row];
        [self.cloverView show];
        
    }else{

        self.cloverView.dataSourceZ = self.tableViewDataZhuanArray[indexPath.row];
        [self.cloverView show];
    }
  
    
}
- (void)dealloc{
    NSLog(@"MCTopUpRecordViewController----dealloc");
}

#pragma mark - getter and setter

- (void)tap{
    _isShowPopView=NO;
    self.popView.hidden = YES;
    [self.viewPop hiden];
}
- (MCCoverView *)cloverView{
    if (_cloverView == nil) {
            MCCoverView *cloverView = [[MCCoverView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
            cloverView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
            __weak typeof(self) weakself = self;
            [self.navigationController.view addSubview:cloverView];
            _cloverView = cloverView;
            __weak typeof(cloverView) weakClo = cloverView;
            cloverView.cancelBlock = ^{
                [weakClo hidden];
                [weakself.tableView reloadData];
                [weakself.tabRightView reloadData];
            };
            cloverView.coverViewBlock = ^{
                [weakClo hidden];
                if (weakself.baseScrollView.contentOffset.x == 0) {
                    MCRechargeViewController *re = [[MCRechargeViewController alloc] init];
                    [weakself.navigationController pushViewController:re animated:YES];
                } else if(weakself.baseScrollView.contentOffset.x == G_SCREENWIDTH){
                    MCWithdrawRecDeltailViewController *re1 = [[MCWithdrawRecDeltailViewController alloc] init];
                    [weakself.navigationController pushViewController:re1 animated:YES];
                }else{

                }


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
- (NSMutableArray *)tableViewDataDarwArray{
    
    if (_tableViewDataDarwArray == nil) {
        _tableViewDataDarwArray = [NSMutableArray array];
    }
    return _tableViewDataDarwArray;
}
- (NSMutableArray *)tableViewDataZhuanArray{
    if (_tableViewDataZhuanArray == nil) {
        _tableViewDataZhuanArray = [NSMutableArray array];
    }
    return _tableViewDataZhuanArray;
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

- (MCTopUpRecordModel *)topUpRecordModel{
    
    if (_topUpRecordModel == nil) {
        MCTopUpRecordModel *model = [[MCTopUpRecordModel alloc] init];
        _topUpRecordModel = model;
    }
    return _topUpRecordModel;
}

- (MCNaviPopView *)popView{
    
    if (_popView == nil) {
      MCNaviPopView * popView = [[MCNaviPopView alloc] init];
        [self.navigationController.view addSubview:popView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [popView addGestureRecognizer:tap];
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

- (MCWithdrawModel *)withdrawModel{
    if (_withdrawModel == nil) {
        MCWithdrawModel *model = [[MCWithdrawModel alloc] init];
        _withdrawModel = model;
    }
    return _withdrawModel;
}
- (MCNoDataWindow *)noDataWin{
    if (_noDataWin == nil) {
        MCNoDataWindow *win = [[MCNoDataWindow alloc] alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + MC_REALVALUE(40), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(66) - 64 -49)];

        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _noDataWin = win;
    }
    return _noDataWin;

}

- (MCErrorWindow *)errDataWin{
    if (_errDataWin == nil) {
        MCErrorWindow *win = [[MCErrorWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + MC_REALVALUE(40) , G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(66) - 64 -49)];

        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _errDataWin = win;
    }
    return _errDataWin;

}
- (MCNONetWindow *)errNetWin{
    if (_errNetWin == nil) {
        MCNONetWindow *win = [[MCNONetWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + MC_REALVALUE(40), G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(66) - 64 -49)];

        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _errNetWin = win;
    }
    return _errNetWin;

}
@end
