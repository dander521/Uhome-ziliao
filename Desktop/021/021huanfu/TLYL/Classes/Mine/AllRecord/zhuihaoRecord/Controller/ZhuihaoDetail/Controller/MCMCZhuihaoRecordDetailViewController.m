//
//  MCMCZhuihaoRecordDetailViewController.m
//  TLYL
//
//  Created by MC on 2017/10/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMCZhuihaoRecordDetailViewController.h"
#import "MCMineCellModel.h"
#import "ExceptionView.h"
#import "MCDataTool.h"
#import <MJRefresh/MJRefresh.h>
#import "MCUserChaseRecordDetailModel.h"
#import "MCMCZhuihaoRecordDetailTableViewCell.h"
#import "MCCancelOrderOneTimeModel.h"
#import "MCCancelPopView.h"
#import "MCMCZhuihaoRecordSubDetailViewController.h"

@interface MCMCZhuihaoRecordDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void(^Compeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic, strong)MCUserChaseRecordDetailDataModel * dataSource;
@property(nonatomic, strong)MCUserChaseRecordDetailModel *userChaseRecordDetailModel;

@property(nonatomic, strong)MCCancelOrderOneTimeModel * cancelOrderOneTimeModel;

@end

@implementation MCMCZhuihaoRecordDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
    [self loadData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
#pragma mark==================setProperty======================
-(void)setProperty{
    self.view.backgroundColor=RGB(231, 231, 231);
    self.navigationItem.title = @"注单详情";
    _dataSource=[[MCUserChaseRecordDetailDataModel alloc]init];
}

#pragma mark==================createUI======================
-(void)createUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.layer.cornerRadius=5;
    _tableView.clipsToBounds=YES;
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(10);
    }];
    
    
    
}


#pragma mark==================loadData======================
-(void)loadData{

    __weak __typeof__ (self) wself = self;

    NSDictionary * dic=@{
                         @"LotteryCode":_model.BetTb,
                         @"IsHistory":[NSNumber numberWithBool:_IsHistory],
                         @"InsertTime":_model.InsertTime,
                         @"ChaseOrderID":_model.OrderID
                         };
    
    
    MCUserChaseRecordDetailModel * userChaseRecordDetailModel = [[MCUserChaseRecordDetailModel alloc]initWithDic:dic];
    [userChaseRecordDetailModel refreashDataAndShow];
    self.userChaseRecordDetailModel = userChaseRecordDetailModel;
    
    userChaseRecordDetailModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
        ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
            [wself.exceptionView dismiss];
            wself.exceptionView = nil;
            [wself loadData];
        }];
        [wself.exceptionView addAction:action];
        [wself.exceptionView showInView:wself.view];
        
    };
    
    userChaseRecordDetailModel.callBackSuccessBlock = ^(id manager) {
        
        MCUserChaseRecordDetailDataModel * model = [MCUserChaseRecordDetailDataModel mj_objectWithKeyValues:manager];
        NSLog(@"%@-",model.Bet);
        wself.dataSource=model;
        [wself.tableView reloadData];

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
    return [MCMCZhuihaoRecordDetailTableViewCell computeHeight:self.dataSource];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof__ (self) wself = self;

    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCMCZhuihaoRecordDetailTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCMCZhuihaoRecordDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCMCZhuihaoRecordDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.dataSource=self.dataSource;
    cell.dataContent=self.model;

    cell.cancelBlock = ^{
        [wself CancelOrderOneTime];
    };
    cell.goToBlock = ^(MCUserChaseRecordDetailSubDataModel *model, MCUserChaseRecordDetailDataModel *Amodel) {
        MCMCZhuihaoRecordSubDetailViewController * vc=[[MCMCZhuihaoRecordSubDetailViewController alloc]init];
        vc.dataSource=model;
        vc.Amodel=Amodel;
        vc.goBackBlock = ^{
            [wself loadData];
        };
        [wself.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

-(void)CancelOrderOneTime{
    __weak __typeof__ (self) wself = self;

    MCCancelPopView * popView=[MCCancelPopView InitPopViewWithTitle:@"你确定要停止追号吗？" sureTitle:@"立即停追" andCancelTitle:@"以后再说"];
    [popView show];
    popView.block = ^(NSInteger type) {
        if (type==1) {
            [wself requestCancelOrderOneTime];
        }
    };
    
    
 
}

-(void)requestCancelOrderOneTime{
    
    __weak __typeof__ (self) wself = self;
    //    Code	是	Int	彩种 ID
    //    OrderID	是	String	订单号
    NSDictionary * dic=@{
                         @"Code":_model.BetTb,
                         @"OrderID":_model.OrderID
                         };
    
    [BKIndicationView showInView:self.view];
    MCCancelOrderOneTimeModel * cancelOrderOneTimeModel = [[MCCancelOrderOneTimeModel alloc]initWithDic:dic];
    [cancelOrderOneTimeModel refreashDataAndShow];
    self.cancelOrderOneTimeModel = cancelOrderOneTimeModel;
    
    cancelOrderOneTimeModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
    };
    
    cancelOrderOneTimeModel.callBackSuccessBlock = ^(id manager) {
        
        [SVProgressHUD showInfoWithStatus:@"停追成功"];
        [wself.navigationController popViewControllerAnimated:YES];
        
    };
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
