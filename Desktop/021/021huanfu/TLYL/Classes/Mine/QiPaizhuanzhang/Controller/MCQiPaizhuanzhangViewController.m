//
//  MCQiPaizhuanzhangViewController.m
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQiPaizhuanzhangViewController.h"
#import "MCQiPaizhuanzhangHeaderView.h"
#import "MCMCQiPaizhuanzhangTableViewCell.h"
#import "MCTransferLotteryAndGameModel.h"
#import "MCGetGameBalanceModel.h"
#import "MCMineInfoModel.h"

@interface MCQiPaizhuanzhangViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic, strong)ExceptionView * exceptionView;
@property (nonatomic,strong)MCQiPaizhuanzhangHeaderView * headerView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataMarray;

@property (nonatomic,strong)MCTransferLotteryAndGameModel * transferLotteryAndGameModel;

@property (nonatomic,strong)MCMCQiPaizhuanzhangTableViewCell *ex_cell;
@end

@implementation MCQiPaizhuanzhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
    [self loadData];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [BKIndicationView dismiss];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark-Header
-(MCQiPaizhuanzhangHeaderView *)headerView{
    if (!_headerView) {
        _headerView =[[MCQiPaizhuanzhangHeaderView alloc]init];
    }
    return _headerView;
}

-(void)setProperty{
    self.navigationItem.title = @"转账";
    self.view.backgroundColor = RGB(231, 231, 231);
    _dataMarray=[[NSMutableArray alloc]init];
}

#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
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
    return [MCMCQiPaizhuanzhangTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCMCQiPaizhuanzhangTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCMCQiPaizhuanzhangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCMCQiPaizhuanzhangTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _ex_cell=cell;
    __weak __typeof__ (self) wself = self;
    cell.sBlock = ^(Zhuanzhang_Type Type) {
        if (Type==ZhuanzhangType_LottoryToQiPai) {
            wself.ex_cell.DrawMaxMoney = [wself.headerView.lottory_yuElab.text doubleValue];
        }else if (Type==ZhuanzhangType_QiPaiToLottory){
            wself.ex_cell.DrawMaxMoney = [wself.headerView.qipai_yuElab.text doubleValue];
        }
    };
    
    cell.gBlock = ^{
#pragma mark-调用转账接口
        [wself requestZhuanZhang];
    };
    return cell;
}



- (void)createUI{
    
    [self.view addSubview:self.headerView];
    self.headerView.frame=CGRectMake(0, 0, G_SCREENWIDTH, [MCQiPaizhuanzhangHeaderView computeHeight:nil]);

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(52);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];

}

#pragma mark-loadData
-(void)loadData{
    
    __weak __typeof__ (self) wself = self;
    [wself.exceptionView dismiss];
    wself.exceptionView = nil;
    [_headerView shuaXinYuE:^(BOOL result) {
        [BKIndicationView dismiss];
        if (!result) {
            
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
               [wself reloadDataS];
            });
            
        }else{
            wself.ex_cell.DrawMaxMoney = [wself.headerView.lottory_yuElab.text doubleValue];
        }
    }];
    
    
}

-(void)reloadDataS{
    self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
    ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
        [self.exceptionView dismiss];
        self.exceptionView = nil;
        [self loadData];
    }];
    [self.exceptionView addAction:action];
    [self.exceptionView showInView:self.view];
}

-(void)requestZhuanZhang{

    __weak __typeof__ (self) wself = self;

    NSString * TranseferType=@"1";
    if (_ex_cell.Type==ZhuanzhangType_QiPaiToLottory) {
        TranseferType=@"2";
    }
    MCMineInfoModel * mineInfoModel=[MCMineInfoModel sharedMCMineInfoModel];
    NSString * UserName;
    if (mineInfoModel.UserName.length>1) {
        UserName=mineInfoModel.UserName;
    }else{
        UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    }
    NSDictionary * dic = @{
                           @"UserName":UserName,
                           @"TranseferType":TranseferType,
                           @"TranseferMoney":_ex_cell.moneyTextField.text,
                           @"PayPassWord":_ex_cell.passwordTextField.text
                           };
    [BKIndicationView showInView:self.view];
    MCTransferLotteryAndGameModel * transferLotteryAndGameModel = [[MCTransferLotteryAndGameModel alloc]initWithDic:dic];
    [transferLotteryAndGameModel refreashDataAndShow];
    self.transferLotteryAndGameModel=transferLotteryAndGameModel;
    transferLotteryAndGameModel.callBackSuccessBlock = ^(id manager) {
        NSDictionary * dic = manager;
        if (dic[@"SystemState"]) {
            NSString * SystemState = [NSString stringWithFormat:@"%@",dic[@"SystemState"]];
            if ([SystemState isEqualToString:@"128"]) {
                [SVProgressHUD showInfoWithStatus:@"转账失败！"];
                return ;
            }
        }
        [SVProgressHUD showInfoWithStatus:@"转账成功！"];
        [wself.headerView shuaXinYuE:^(BOOL result) {
            [BKIndicationView dismiss];
        }];
    };
    
    transferLotteryAndGameModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {

    };
}

@end





