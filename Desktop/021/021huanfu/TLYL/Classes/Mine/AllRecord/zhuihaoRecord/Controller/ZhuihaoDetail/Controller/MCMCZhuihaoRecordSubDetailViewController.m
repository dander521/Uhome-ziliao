//
//  MCMCZhuihaoRecordSubDetailViewController.m
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMCZhuihaoRecordSubDetailViewController.h"
#import "MCMineCellModel.h"
#import "ExceptionView.h"
#import "MCDataTool.h"
#import <MJRefresh/MJRefresh.h>
#import "MCUserChaseRecordDetailModel.h"
#import "MCMCZhuihaoRecordSubDetailUITableViewCell.h"
#import "MCCancleLotteryModel.h"
#import "MCCancelPopView.h"

@interface MCMCZhuihaoRecordSubDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIButton *chedanBtn;
@property(nonatomic, strong)MCCancleLotteryModel *cancleLotteryModel;

@end

@implementation MCMCZhuihaoRecordSubDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.goBackBlock) {
        self.goBackBlock();
    }
}
#pragma mark==================setProperty======================
-(void)setProperty{
    self.view.backgroundColor=RGB(231, 231, 231);
    self.navigationItem.title = @"注单详情";

}

#pragma mark==================createUI======================
-(void)createUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(10);
    }];
    
    /*
     * 撤单
     */
    UIButton *chedanBtn = [[UIButton alloc] init];
    self.chedanBtn = chedanBtn;
    [chedanBtn setTitle:@"撤单" forState:UIControlStateNormal];
    [chedanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chedanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [chedanBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchDown];
    chedanBtn.frame = CGRectMake(0, 0, 64, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chedanBtn];
    
    int BetOrderState = [[NSString stringWithFormat:@"%@",_dataSource.BetOrderState] intValue];
    NSString *str = @"";
    self.chedanBtn.hidden = YES;
    if ((BetOrderState & 1) == 1) {
        str = @"【购买成功】";
        self.chedanBtn.hidden = NO;
    } else if ((BetOrderState & 32768) == 32768) {
        str = @"【已撤奖】";
        
    } else if ((BetOrderState & 64) == 64) {
        str = @"【已出票】";
        
    } else if ((BetOrderState & 16777216) == 16777216) {
        str = @"【已派奖】";
        
    } else if ((BetOrderState & 33554432) == 33554432) {
        str = @"【未中奖】";
        
    } else if ((BetOrderState & 4096) == 4096) {
        str = @"【已结算】";
        
    } else if ((BetOrderState & 512) == 512) {
        str = @"【强制结算】";
        
    } else if ((BetOrderState & 4) == 4) {
        str = @"【已撤单】";
    } else {
        str = @"【订单异常】";
        
    }
    if ((1048577 & BetOrderState) == 1048577) {
        self.chedanBtn.hidden = NO;
    } else {
        self.chedanBtn.hidden = YES;
    }
    
}
- (void)cancleBtnClick:(UIButton *)btn{
    
    __weak __typeof__ (self) wself = self;
    
    MCCancelPopView * popView=[MCCancelPopView InitPopViewWithTitle:@"你确定撤销该订单吗？" sureTitle:@"立即撤单" andCancelTitle:@"以后再说"];
    [popView show];
    popView.block = ^(NSInteger type) {
        if (type==1) {
            [wself requestCancelOrder];
        }
    };
    
}

-(void)requestCancelOrder{
    
//    参数名    必选    类型    说明
//    Code    是    Int    彩种 ID
//    OrderID    是    String    订单流水号
    MCCancleLotteryModel *cancleLotteryModel = [[MCCancleLotteryModel alloc] init];
    NSString * OrderID = _dataSource.OrderID;
    self.cancleLotteryModel = cancleLotteryModel;
    cancleLotteryModel->_code = _Amodel.LotteryCode;
    cancleLotteryModel->_orderID = OrderID;
    [BKIndicationView showInView:self.view];
    [cancleLotteryModel refreashDataAndShow];
    cancleLotteryModel.callBackSuccessBlock = ^(id manager) {
        self.chedanBtn.enabled = NO;
        [self.chedanBtn setTitle:@"已撤单" forState:UIControlStateNormal];
    };
    
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
    
    if (!_Amodel) {
        return 574;
    }
    NSDictionary * dic = [MCDataTool MC_GetDic_CZHelper];
    /*
     * 获取小球个数
     */
    NSInteger count = [MCMathUnits getBallCountWithCZType:dic[_Amodel.LotteryCode][@"type"]];
    int line = ceilf((1.00*count)/5.0);
    return 574+(line-1)*30+20;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCMCZhuihaoRecordDetailTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCMCZhuihaoRecordSubDetailUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier ];
    if (!cell) {
        NSDictionary * dic = [MCDataTool MC_GetDic_CZHelper];
        int count = (int)[MCMathUnits getBallCountWithCZType:dic[_Amodel.LotteryCode][@"type"]];
        cell = [[MCMCZhuihaoRecordSubDetailUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier BallCount:count];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.BetRebate=_Amodel.BetRebate;
    cell.LotteryCode=_Amodel.LotteryCode;
    cell.dataSource=self.dataSource;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
