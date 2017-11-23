//
//  MCLotteryDrawDetailsViewController.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryDrawDetailsViewController.h"
#import "MCLotteryDrawDetailsTableViewCell.h"
#import "MCLotteryDrawDetailsFooterView.h"
#import "MCPickNumberViewController.h"
#import "MCMineCellModel.h"
#import "MCHistoryIssueDetailAPIModel.h"
#import "MCMmcIssueDetailAPIModel.h"
#import "ExceptionView.h"
#import "MCDataTool.h"
#import <MJRefresh/MJRefresh.h>
#import "MCNoDataWindow.h"
#import "MCNONetWindow.h"
#import "MCErrorWindow.h"
#import "MCIssueModel.h"

@interface MCLotteryDrawDetailsViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    int _currentIndex;
}


@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray*sectionMarr;

@property(nonatomic, strong)MCLotteryDrawDetailsFooterView * lotteryDrawDetailsFooterView;

@property(nonatomic, strong)MCHistoryIssueDetailAPIModel * historyIssueDetailAPIModel;
@property(nonatomic, strong)MCMmcIssueDetailAPIModel *mmcIssueDetailAPIModel;
@property(nonatomic, strong)MCIssueModel *issueModel;
@property(nonatomic, strong)ExceptionView * exceptionView;
@property (nonatomic,weak) MCNoDataWindow *dataWind;
/**05：33：22*/
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)NSTimer * timer;

@property (nonatomic,assign)int RemainTime;


@end

@implementation MCLotteryDrawDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCErrorWindow_Retry" object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCNoDataWindow_Retry" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCNONetWindow_Retry" object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _currentIndex = 1;
    [self loadData];
//    [self loadTime];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.dataWind hideModelWindow];
//    [[MCNONetWindow alertInstance] hideModelWindow];
//    [[MCErrorWindow alertInstance] hideModelWindow];
}
#pragma mark==================setProperty======================
-(void)setProperty{
    
    _currentIndex = 1;
    
    self.view.backgroundColor=RGB(231, 231, 231);
    
    NSDictionary * dic = [MCDataTool MC_GetDic_CZHelper];
    
    self.navigationItem.title = dic[_LotteryCode][@"name"];
    
    _sectionMarr=[[NSMutableArray alloc]init];
    
}

#pragma mark==================createUI======================
-(void)createUI{
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.layer.cornerRadius=5;
    _tableView.clipsToBounds=YES;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
    
//    [self.view addSubview:self.lotteryDrawDetailsFooterView];
//    self.lotteryDrawDetailsFooterView.dataSource=_LotteryCode;
//    [self.lotteryDrawDetailsFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_tableView.mas_bottom).offset(0);
//        make.left.and.right.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
//    }];
//    /*
//     * 走势按钮
//     */
//    UIButton *btn = [[UIButton alloc] init];
//    [btn setTitle:@"走势"  forState:UIControlStateNormal];
//    btn.frame = CGRectMake(0, 0, MC_REALVALUE(50), MC_REALVALUE(30));
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    [btn addTarget:self action:@selector(goToZouShi) forControlEvents:UIControlEventTouchDown];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self createHeaderView];
}

-(void)goToZouShi{
    [SVProgressHUD showInfoWithStatus:@"完善中...."];
}

-(void)createHeaderView{
    
//    UIView * headerView = [[UIView alloc]init];
//    [self.view addSubview:headerView];
//    headerView.frame=CGRectMake(0, 0, G_SCREENWIDTH, 40);
//    headerView.backgroundColor = RGB(249, 249, 249);
//    
//    UILabel * czLab = [[UILabel alloc]init];
//    [headerView addSubview:czLab];
//    NSDictionary * dic = [MCDataTool MC_GetDic_CZHelper];
//    czLab.text=dic[_LotteryCode][@"name"];
//    czLab.textColor=RGB(46, 46, 46);
//    czLab.font=[UIFont boldSystemFontOfSize:14];
//    [czLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(headerView);
//        make.left.equalTo(headerView.mas_left).offset(10);
//    }];
//    
//    UILabel * kaijiangLab = [[UILabel alloc]init];
//    [headerView addSubview:kaijiangLab];
//    kaijiangLab.text=@"开奖公告";
//    kaijiangLab.textColor=RGB(102, 102, 102);
//    kaijiangLab.font=[UIFont systemFontOfSize:14];
//    [kaijiangLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(headerView);
//        make.left.equalTo(czLab.mas_right).offset(10);
//    }];
    
    UIButton * tzBtn=[[UIButton alloc]init];
    [self.view addSubview:tzBtn];
    tzBtn.backgroundColor=RGB(144, 8, 215);
    [tzBtn setTitle:@"立即投注" forState:UIControlStateNormal];
    [tzBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tzBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [tzBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.right.left.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [tzBtn addTarget:self action:@selector(goToTzViewController) forControlEvents:UIControlEventTouchUpInside];
    
//    _titleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
//    _titleLabel.textColor=RGB(255, 168, 0);
//    _titleLabel.font=[UIFont systemFontOfSize:14];
//    _titleLabel.text =@"加载中";
//    _titleLabel.textAlignment=NSTextAlignmentCenter;
//    [headerView  addSubview:_titleLabel];
//    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(headerView);
//        make.right.equalTo(headerView.mas_right).offset(-10);
//    }];
    
}

-(void)loadTime{

    if ([self.dataSource.LotteryID isEqualToString:@"50"]){
        //秒秒彩不调用倒计时
        _titleLabel.hidden=YES;
        
    }else{
        MCIssueModel *issueModel = [[MCIssueModel alloc] init];
        issueModel.lotteryNumber = [self.dataSource.LotteryID intValue];
        [issueModel refreashDataAndShow];
        self.issueModel = issueModel;
        __weak typeof(self) weakSelf = self;
        issueModel.callBackSuccessBlock = ^(id manager) {
            MCIssueModel *model = [MCIssueModel mj_objectWithKeyValues:manager];
            weakSelf.RemainTime= model.RemainTime;
            [weakSelf add_timer];
        };
        issueModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
            
        };
    }

}

-(void)stopTimer{
    //关闭定时器
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [self.timer invalidate];
    
    self.timer = nil;
}
#pragma mark-添加定时器
-(void)add_timer{
    
    [self stopTimer];
    
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    [currentRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

-(void)timerAction{
    if (_RemainTime==0) {
        _titleLabel.text =@"00:00:00";
        [self stopTimer];
        [self loadTime];
    }else{
        _RemainTime--;
        [self SetTime];
        
    }
    
}
#pragma mark-设计时间
-(void)SetTime{
    int hour   = (int)_RemainTime/3600;
    int minute = (int)(_RemainTime - hour*3600)/60;
    int second = (int)_RemainTime%60;
    _titleLabel.text =[NSString stringWithFormat:@"%.2d:%.2d:%.2d",hour,minute,second];
    
}


-(void)loadMoreData{
    _currentIndex++;
    
    __weak __typeof(self)wself = self;
    
    if ([self.LotteryCode isEqualToString:@"50"]) {
        
        MCMmcIssueDetailAPIModel  * mmcIssueDetailAPIModel =[MCMmcIssueDetailAPIModel sharedMCMmcIssueDetailAPIModel];
        mmcIssueDetailAPIModel.LotteryCode=self.LotteryCode;
        mmcIssueDetailAPIModel.Page=_currentIndex;
        self.mmcIssueDetailAPIModel=mmcIssueDetailAPIModel;
        [BKIndicationView showInView:self.view];
        [mmcIssueDetailAPIModel refreashDataAndShow];
        mmcIssueDetailAPIModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
            
            [_tableView.mj_header  endRefreshing];
            [_tableView.mj_footer  endRefreshing];
            
        };
        mmcIssueDetailAPIModel.callBackSuccessBlock = ^(id manager) {
            
            [_tableView.mj_header  endRefreshing];
            [_tableView.mj_footer  endRefreshing];
            
            [wself setData:manager];
        };
    }else{
        
        MCHistoryIssueDetailAPIModel  * historyIssueDetailAPIModel =[MCHistoryIssueDetailAPIModel sharedMCHistoryIssueDetailAPIModel];
        
        historyIssueDetailAPIModel.LotteryCode=self.LotteryCode;
        historyIssueDetailAPIModel.Page=_currentIndex;
        self.historyIssueDetailAPIModel=historyIssueDetailAPIModel;
        [BKIndicationView showInView:self.view];
        [historyIssueDetailAPIModel refreashDataAndShow];
        
        historyIssueDetailAPIModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
            
            [_tableView.mj_header  endRefreshing];
            [_tableView.mj_footer  endRefreshing];
            
            
            
            
        };
        historyIssueDetailAPIModel.callBackSuccessBlock = ^(id manager) {
            
            
            [_tableView.mj_header  endRefreshing];
            [_tableView.mj_footer  endRefreshing];
            
            [wself setData:manager];
        };
        
    }
}


#pragma mark==================loadData======================
-(void)loadData{
    
    if ([self.LotteryCode isEqualToString:@""]||self.LotteryCode==nil) {
        return;
    }
    __weak __typeof(self)wself = self;
    
   [BKIndicationView showInView:self.view];
    
    if ([self.LotteryCode isEqualToString:@"50"]) {
        
        MCMmcIssueDetailAPIModel  * mmcIssueDetailAPIModel =[MCMmcIssueDetailAPIModel sharedMCMmcIssueDetailAPIModel];
        mmcIssueDetailAPIModel.LotteryCode=self.LotteryCode;
        mmcIssueDetailAPIModel.Page=_currentIndex;
        self.mmcIssueDetailAPIModel=mmcIssueDetailAPIModel;
        [BKIndicationView showInView:self.view];
        [mmcIssueDetailAPIModel refreashDataAndShow];
        mmcIssueDetailAPIModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
            [BKIndicationView dismiss];
            [_tableView.mj_header  endRefreshing];
            [_tableView.mj_footer  endRefreshing];
            wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
            ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                [wself.exceptionView dismiss];
                wself.exceptionView = nil;
                [wself loadData];
            }];
            [wself.exceptionView addAction:action];
            [wself.exceptionView showInView:wself.view];
            
        };
        mmcIssueDetailAPIModel.callBackSuccessBlock = ^(id manager) {
            [BKIndicationView dismiss];
            [_tableView.mj_header  endRefreshing];
            [_tableView.mj_footer  endRefreshing];
            
            [_sectionMarr removeAllObjects];
            [wself setData:manager];
        };
    }else{
        
        MCHistoryIssueDetailAPIModel  * historyIssueDetailAPIModel =[MCHistoryIssueDetailAPIModel sharedMCHistoryIssueDetailAPIModel];
        
        historyIssueDetailAPIModel.LotteryCode=self.LotteryCode;
        historyIssueDetailAPIModel.Page=1;
        self.historyIssueDetailAPIModel=historyIssueDetailAPIModel;
        [BKIndicationView showInView:self.view];
        [historyIssueDetailAPIModel refreashDataAndShow];
        
        historyIssueDetailAPIModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
            [BKIndicationView dismiss];
            [_tableView.mj_header  endRefreshing];
            [_tableView.mj_footer  endRefreshing];
            
            
            wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
            ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                [wself.exceptionView dismiss];
                wself.exceptionView = nil;
                [wself loadData];
            }];
            [wself.exceptionView addAction:action];
            [wself.exceptionView showInView:wself.view];
            
        };
        historyIssueDetailAPIModel.callBackSuccessBlock = ^(id manager) {
            
            [BKIndicationView dismiss];
            [_tableView.mj_header  endRefreshing];
            [_tableView.mj_footer  endRefreshing];
            
            [_sectionMarr removeAllObjects];
            
            [wself setData:manager];
        };
        
    }

}

-(void)setData:(NSArray *)arr{

    if (_currentIndex==1) {
        if (arr==nil||!arr||(![arr isKindOfClass:[NSArray class]])) {
            //无数据
            self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
            self.exceptionView.heightH=G_SCREENHEIGHT-64-49;
            [self.exceptionView showInView:self.view];
            return;
            
        }
        if (arr.count<1) {
            //无数据
            self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
            self.exceptionView.heightH=G_SCREENHEIGHT-64-49;
            [self.exceptionView showInView:self.view];
            return;
        }
    }
    
    if (arr.count%20!=0) {
        //数据已经全部加载完成
        [_tableView.mj_footer setHidden:YES];
        _tableView.mj_footer=nil;
    }

    NSMutableArray * arrData=[[NSMutableArray alloc]init];
    for (NSDictionary *dic in arr) {
        NSArray * arr=[dic[@"CzNum"] componentsSeparatedByString:@","];
        NSDictionary * dicc=@{
                              @"CzNumArry":arr,
                              @"CzPeriod":dic[@"CzPeriod"]
                              };
        [arrData addObject:dicc];
    }
    

    NSMutableArray * marr_Model=[[NSMutableArray alloc]init];
    
    for(int i=0 ;i<arrData.count; i++){
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCLotteryDrawDetailsTableViewCell class]);
        model.className=NSStringFromClass([MCLotteryDrawDetailsTableViewCell class]);
        int line=1;
        if ([(NSArray *)arrData[i][@"CzNumArry"] count]>10) {
            line=2;
        }
        
        model.height = [MCLotteryDrawDetailsTableViewCell computeHeight:line];
        
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo=arrData[i];
        [marr_Model addObject:model];
    }
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr_Model];
    model0.headerhHeight=0.0001;
    model0.footerHeight=20;
    [_sectionMarr addObject:model0];
    MCNoDataWindow *dataWind = [[MCNoDataWindow alloc]alertInstanceWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
    self.dataWind = dataWind;
    if (_sectionMarr.count == 0) {
        [dataWind setHidden:NO];
    } else {
        [dataWind setHidden:YES];
    }
    [_tableView reloadData];
    
}
#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.headerhHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.footerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    
    return cm.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cm.reuseIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(cm.className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cm.reuseIdentifier];
    }
    cell.selectionStyle = cm.selectionStyle;
    
    if ([cm.className isEqualToString:NSStringFromClass([MCLotteryDrawDetailsTableViewCell class])]) {
        
        MCLotteryDrawDetailsTableViewCell *ex_cell=(MCLotteryDrawDetailsTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    
}

-(UIView *)lotteryDrawDetailsFooterView{
    
    if (!_lotteryDrawDetailsFooterView) {
        _lotteryDrawDetailsFooterView=[[MCLotteryDrawDetailsFooterView alloc]init];
        __weak MCLotteryDrawDetailsViewController *weakSelf = self;
        _lotteryDrawDetailsFooterView.block=^(){
            
            
            //如果是投注页面过来的   直接返回
            if ([weakSelf.fromClass isEqualToString:NSStringFromClass([MCPickNumberViewController class])]) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                
                [weakSelf goToTzViewController];
            }

        };
    }
    return _lotteryDrawDetailsFooterView;
}

-(void)goToTzViewController{
    /*
     * 跳转投注页面
     */
    if ([_fromClass isEqualToString:NSStringFromClass([MCPickNumberViewController class])]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if ([self.dataSource.SaleState isEqualToString:@"1"]) {
        MCPickNumberViewController *pickVc = [[MCPickNumberViewController alloc] init];
        pickVc.lotteriesTypeModel = self.dataSource;
        [self.navigationController pushViewController:pickVc animated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"该彩种已经停售！"];
        return ;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end













































