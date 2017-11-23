//
//  MCSignContractViewController.m
//  TLYL
//
//  Created by MC on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSignContractViewController.h"
#import "MCContractMgtBaseModel.h"
#import "MCModifyOrSignContractTableViewCell.h"
#import "MCSignContractHeaderView.h"
#import "MCSignContractFooterView.h"
#import "MCGetMyAndSubDayWagesThreeModel.h"
#import "MCAddSubDayWageContractModel.h"
#import "MCModifySubDayWageContractModel.h"

@interface MCSignContractViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void(^MCSignContractVCCompeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic, strong)MCSignContractHeaderView *headerView;
@property(nonatomic, strong)MCSignContractFooterView *footerView;

//获取自己和下级的日工资契约 （日工资3）
@property(nonatomic, strong)MCGetMyAndSubDayWagesThreeModel *myAndSubDayWagesThreeModel;
@property(nonatomic, strong)MCGetMyAndSubDayWagesThreeDataModel *myAndSubDayWagesThreeDataModel;

@property(nonatomic, strong)MCModifyOrSignContractTableViewCell *ex_cell;

//添加下级的日工资契约 （日工资3）
@property(nonatomic, strong)MCAddSubDayWageContractModel * addSubDayWageContractModel;

//修改下级的日工资契约 （日工资3）
@property(nonatomic, strong)MCModifySubDayWageContractModel * modifySubDayWageContractModel;


@end

@implementation MCSignContractViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setProperty];

    [self setNav];

    [self createUI];

    [self refreashData];
    
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
    self.navigationItem.title = @"签订契约";

}

#pragma mark ====================设置导航栏========================
-(void)setNav{
    
}

#pragma mark==================createUI======================
-(void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreashData];
    }];

    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(13);
        make.right.equalTo(self.view.mas_right).offset(-13);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
}

-(void)rightBtnAction{
    
}

#pragma mark-下拉刷新
- (void)refreashData{
    self.tableView.mj_footer.hidden=NO;

    [self.exceptionView dismiss];
    self.exceptionView = nil;

    [BKIndicationView showInView:self.view];
    __weak __typeof__ (self) wself = self;
    [self loadData:^(BOOL result, NSDictionary *data) {

        [wself.tableView.mj_footer endRefreshing];
        [wself.tableView.mj_header endRefreshing];

        if (result) {

            [wself setData:data];

        }else{

            wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
            ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                [wself.exceptionView dismiss];
                wself.exceptionView = nil;
                [wself refreashData];
            }];
            [wself.exceptionView addAction:action];
            [wself.exceptionView showInView:wself.view];
        }
    }];


}

#pragma mark==================loadData======================
-(void)loadData:(MCSignContractVCCompeletion)compeletion{
    //UserID    是    String    我的用户 ID
    //subUserID （旧：SubordinateUserid）    是    String
    NSDictionary * dic=@{
                         @"UserID" : [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                         @"subUserID" : _xiaJiModel.UserID
                         };


    MCGetMyAndSubDayWagesThreeModel *myAndSubDayWagesThreeModel = [[MCGetMyAndSubDayWagesThreeModel alloc]initWithDic:dic];
    [myAndSubDayWagesThreeModel refreashDataAndShow];
    self.myAndSubDayWagesThreeModel = myAndSubDayWagesThreeModel;

    myAndSubDayWagesThreeModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {

        compeletion(NO,nil);

    };

    myAndSubDayWagesThreeModel.callBackSuccessBlock = ^(id manager) {

        compeletion(YES,manager);

    };

}

-(void)setData:(NSDictionary *)dic{

    _myAndSubDayWagesThreeDataModel = [MCGetMyAndSubDayWagesThreeDataModel mj_objectWithKeyValues:dic];

    self.headerView.dataSource=_myAndSubDayWagesThreeDataModel;
    self.headerView.xiaJiModel=_xiaJiModel;

    [self.tableView reloadData];
}


#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return [MCSignContractHeaderView computeHeight:nil];
    }
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [MCSignContractFooterView computeHeight:nil];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    __weak __typeof__ (self) wself = self;
    
    self.footerView.block = ^{
        [wself setSignContract];
    };
    [self.footerView setFooterViewHidden:_myAndSubDayWagesThreeDataModel];
    return self.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [MCModifyOrSignContractTableViewCell computeHeight:_myAndSubDayWagesThreeDataModel];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCModifyOrSignContractTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];

    MCModifyOrSignContractTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCModifyOrSignContractTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.dataSources=_myAndSubDayWagesThreeDataModel;
    _ex_cell = cell;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-签订/修改日工资契约
-(void)setSignContract{
    if (!_ex_cell.modifyOrSign_selectedModel) {
        [SVProgressHUD showInfoWithStatus:@"请选择日工资标准！"];
        return;
    }
    
    if ( (_ex_cell.end_T==(_ex_cell.begin_T+1)) && _ex_cell.modifyOrSign_selectedModel) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        __weak __typeof__ (self) wself = self;
        NSDictionary * dic=@{
                             @"subUserName" : _xiaJiModel.UserName,
                             @"subUserID" : _xiaJiModel.UserID,
//                             @"subUserID" : [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                             @"ModifyId"  : _ex_cell.modifyOrSign_selectedModel.ID
                             };

        if (_Type == MCSignOrModifyContractVCType_Sign) {
            
            [BKIndicationView showInView:self.view];
            MCAddSubDayWageContractModel *addSubDayWageContractModel = [[MCAddSubDayWageContractModel alloc]initWithDic:dic];
            [addSubDayWageContractModel refreashDataAndShow];
            self.addSubDayWageContractModel = addSubDayWageContractModel;
            
            addSubDayWageContractModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
                [SVProgressHUD showInfoWithStatus:@"签订失败！"];
            };
            
            addSubDayWageContractModel.callBackSuccessBlock = ^(id manager) {
                [SVProgressHUD showInfoWithStatus:@"签订成功！"];
                if (wself.goBackBlock) {
                    wself.goBackBlock();
                }
                [wself.navigationController popViewControllerAnimated:YES];
            };
            
        }else if (_Type == MCSignOrModifyContractVCType_Modify){
            [BKIndicationView showInView:self.view];
            MCModifySubDayWageContractModel *modifySubDayWageContractModel = [[MCModifySubDayWageContractModel alloc]initWithDic:dic];
            [modifySubDayWageContractModel refreashDataAndShow];
            self.modifySubDayWageContractModel = modifySubDayWageContractModel;
            
            modifySubDayWageContractModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
                [SVProgressHUD showInfoWithStatus:@"修改失败！"];
            };
            
            modifySubDayWageContractModel.callBackSuccessBlock = ^(id manager) {
                [SVProgressHUD showInfoWithStatus:@"修改成功！"];
                if (wself.goBackBlock) {
                    wself.goBackBlock();
                }
                [wself refreashData];
//                [wself.navigationController popViewControllerAnimated:YES];
            };
        }
    }
}

#pragma mark-set/get
-(MCSignContractHeaderView *)headerView{
    if (!_headerView) {
        _headerView=[[MCSignContractHeaderView alloc]init];
    }
    return _headerView;
}

-(MCSignContractFooterView *)footerView{
    if (!_footerView) {
        _footerView=[[MCSignContractFooterView alloc]init];
    }
    return _footerView;
}

@end




























