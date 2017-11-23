//
//  MCModifyOrSignBonusContractViewController.m
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCModifyOrSignBonusContractViewController.h"
#import "MCModifyOrSignBonusContractHeaderView.h"
#import "MCModifyOrSignBonusContractFooterView.h"
#import "MCModifyOrSignBonusContractTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "MCGetMyAndSubSignBounsContractModel.h"
#import "MCContractContentModelsData.h"
#import "MCContractMgtTool.h"
#import "MCAddSubBonusContractModel.h"
#import "MCModifySubBonusContractModel.h"

@interface MCModifyOrSignBonusContractViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

typedef void(^MCModifyOrSignBonusContractCompeletion)(BOOL result, NSDictionary *data );
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic, strong)MCModifyOrSignBonusContractHeaderView * headerView;
@property(nonatomic, strong)MCModifyOrSignBonusContractFooterView *footerView;

//获取我的和下级的已签约分红数据
@property(nonatomic, strong)MCGetMyAndSubSignBounsContractModel * getMyAndSubSignBounsContractModel;
@property(nonatomic, strong)MCGetMyAndSubSignBounsContractDataModel *dataSource;

//给下级添加新的分红契约
@property(nonatomic, strong)MCAddSubBonusContractModel * addSubBonusContractModel;
//修改下级的分红契约
@property(nonatomic, strong)MCModifySubBonusContractModel * modifySubBonusContractModel;
@end

@implementation MCModifyOrSignBonusContractViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setProperty];
    
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
    self.navigationItem.title = @"分红契约";
    
}



#pragma mark==================createUI======================
-(void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self refreashData];
//    }];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(13);
        make.right.equalTo(self.view.mas_right).offset(-13);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
}

#pragma mark ========================tableView 代理相关========================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];
    
    if (data.dataSource.count<1) {
        return 1;
    }else{
        return data.dataSource.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return [MCModifyOrSignBonusContractHeaderView computeHeight:_dataSource];
    }
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [MCModifyOrSignBonusContractFooterView computeHeight:nil];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return self.headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    __weak __typeof__ (self) wself = self;
    self.footerView.footerActionBlock = ^(Type_MCModifyOrSignBonusContractFooterAction type) {
#pragma mark-删除行
        if (type==MC_ModifyOrSignBonusContractFooterAction_Delete) {

            MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];
            if (data.dataSource.count>_dataSource.DownContract.count) {
                [data.dataSource removeLastObject];
            }
            if (data.dataSource.count == _dataSource.DownContract.count) {
                [wself.footerView setDeleteBtnHidden:YES];
            }
            [wself.tableView reloadData];
            
#pragma mark-增加行
        }else if (type==MC_ModifyOrSignBonusContractFooterAction_Add){
            MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];
            if (data.dataSource.count==1) {
                MCGetMyAndSubSignBounsContractDetailDataModel * last_1 = [data.dataSource lastObject];
                double K = [last_1.DividendRatio doubleValue] - 0.0001 + 0.00001;
                if (K>0) {
                }else{
                    [SVProgressHUD showInfoWithStatus:@"分红比例范围:0.01~100%!"];
                    return ;
                }
            }
            if (data.dataSource.count>_dataSource.DownContract.count&&data.dataSource.count>1) {
                MCGetMyAndSubSignBounsContractDetailDataModel * last_1 = [data.dataSource lastObject];
                MCGetMyAndSubSignBounsContractDetailDataModel * last_2 = [data.dataSource objectAtIndex:(data.dataSource.count-2)];
                if (([last_1.BetMoneyMin doubleValue]>=[last_2.BetMoneyMin doubleValue]) && ([last_1.LossMoneyMin doubleValue]>=[last_2.LossMoneyMin doubleValue]) && ([last_1.ActivePersonNum doubleValue]>=[last_2.ActivePersonNum doubleValue]) ) {
                    double K = [last_1.DividendRatio doubleValue] - 0.0001 + 0.00001;
                    if (K>0) {
                    }else{
                        [SVProgressHUD showInfoWithStatus:@"分红比例范围:0.01~100%!"];
                        return ;
                    }
                    
                    
                }else{
                    [SVProgressHUD showInfoWithStatus:@"存在错误信息,无法添加新行!"];
                    return ;
                }
            }
            
            
            [data addInitModel];
            
            [wself.footerView setDeleteBtnHidden:NO];

            [wself.tableView reloadData];

#pragma mark-保存
        }else if (type==MC_ModifyOrSignBonusContractFooterAction_Save){
            
            if ([wself checkContractContentModelsData]) {
                
                if (_Type == MCModifyOrSignBonusContractType_Sign) {
                    [wself AddSubBonusContract];
                }else{
                    [wself ModifySubBonusContract];
                }
                NSLog(@"保存！！！！！！！！");
            }
            
        }
    };
    return self.footerView;
}

#pragma mark-监测是否能够保存
-(BOOL)checkContractContentModelsData{
    
    MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];
    if (data.dataSource.count==1) {
        MCGetMyAndSubSignBounsContractDetailDataModel * model = data.dataSource[0];
        
        double K = [model.DividendRatio doubleValue] - 0.0001 + 0.00001;
        if (K>0) {
        }else{
            [SVProgressHUD showInfoWithStatus:@"分红比例范围:0.01~100%!"];
            return NO;
        }
    }
    
    for (int i = 0 ; i < (data.dataSource.count-1) ; i++ ) {
        
        MCGetMyAndSubSignBounsContractDetailDataModel * last_2 = data.dataSource[i];
        MCGetMyAndSubSignBounsContractDetailDataModel * last_1= data.dataSource[i+1];
        if (([last_1.BetMoneyMin doubleValue]>=[last_2.BetMoneyMin doubleValue]) && ([last_1.LossMoneyMin doubleValue]>=[last_2.LossMoneyMin doubleValue]) && ([last_1.ActivePersonNum doubleValue]>=[last_2.ActivePersonNum doubleValue]) ) {
        }else{
            [SVProgressHUD showInfoWithStatus:@"存在错误信息,无法修改!"];
            return NO;
        }
    }

    return YES;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];

    if (data.dataSource.count<1) {
        return 0.0001;
    }
    return [MCModifyOrSignBonusContractTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier_2 =[NSString stringWithFormat:@"MCModifyOrSignBonusContractTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    
    MCModifyOrSignBonusContractTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier_2];
    if (!cell2) {
        cell2 = [[MCModifyOrSignBonusContractTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier_2];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell2.row=indexPath.row;
    
    MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];

    if (data.dataSource.count>indexPath.row) {
        cell2.dataSource=data.dataSource[indexPath.row];
    }
    
    return cell2;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark==================set/get==================
-(MCModifyOrSignBonusContractHeaderView *)headerView{
    if (!_headerView) {
        _headerView=[[MCModifyOrSignBonusContractHeaderView alloc]init];
    }
    return _headerView;
}

-(MCModifyOrSignBonusContractFooterView *)footerView{
    if (!_footerView) {
        _footerView=[[MCModifyOrSignBonusContractFooterView alloc]init];
    }
    return _footerView;
}


#pragma mark==================Http==================
#pragma mark-refreashData
-(void)refreashData{
    
    [BKIndicationView showInView:self.view];
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    
    __weak __typeof__ (self) wself = self;
    
    [self loadData:^(BOOL result, NSDictionary *data) {
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

#pragma mark-loadData
-(void)loadData:(MCModifyOrSignBonusContractCompeletion)compeletion{
//    UserID    是    String    当前登录用户 ID
//    subUserID （旧：DownUserId）    是    String    下级用户 ID
    NSDictionary * dic=@{
                         @"UserID" : [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                         @"subUserID":_models.UserID
                         };
    
    MCGetMyAndSubSignBounsContractModel * getMyAndSubSignBounsContractModel = [[MCGetMyAndSubSignBounsContractModel alloc]initWithDic:dic];
    [getMyAndSubSignBounsContractModel refreashDataAndShow];
    self.getMyAndSubSignBounsContractModel = getMyAndSubSignBounsContractModel;
    
    getMyAndSubSignBounsContractModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        compeletion(NO,nil);
    };
    
    getMyAndSubSignBounsContractModel.callBackSuccessBlock = ^(id manager) {
        compeletion(YES,manager);
    };

}
#pragma mark-添加契约
-(void)AddSubBonusContract{
    __weak __typeof__ (self) wself = self;
    NSMutableArray * ContractContentModels = [[NSMutableArray alloc]init];
    MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];

    
    for (MCGetMyAndSubSignBounsContractDetailDataModel * model in data.dataSource) {
        NSDictionary * dicc=@{
                              @"DividendRatio":model.DividendRatio,
                              @"BetMoneyMin":model.BetMoneyMin,
                              @"BetMoneyMax":@"999999999",
                              @"LossMoneyMin":model.LossMoneyMin,
                              @"LossMoneyMax":@"999999999",
                              @"ActivePersonNum":model.ActivePersonNum
                              };
        [ContractContentModels addObject:dicc];
    }
    NSDictionary * dic=@{
                         @"subUserName":_models.UserName,
                         @"ContractContentModels":ContractContentModels
                         };
    

    MCAddSubBonusContractModel * addSubBonusContractModel = [[MCAddSubBonusContractModel alloc]initWithDic:dic];
    [addSubBonusContractModel refreashDataAndShow];
    self.addSubBonusContractModel = addSubBonusContractModel;
    
    addSubBonusContractModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        [SVProgressHUD showInfoWithStatus:@"添加失败！"];
    };
    
    addSubBonusContractModel.callBackSuccessBlock = ^(id manager) {

        if (wself.goBackBlock) {
            wself.goBackBlock();
        }
        [SVProgressHUD showInfoWithStatus:@"添加成功！"];
        [wself.navigationController popViewControllerAnimated:YES];
    };
}

#pragma mark-修改契约
-(void)ModifySubBonusContract{
    __weak __typeof__ (self) wself = self;

    NSMutableArray * ContractContentModels = [[NSMutableArray alloc]init];
    MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];
    
    
    for (MCGetMyAndSubSignBounsContractDetailDataModel * model in data.dataSource) {
        NSDictionary * dicc=@{
                              @"DividendRatio":model.DividendRatio,
                              @"BetMoneyMin":model.BetMoneyMin,
                              @"BetMoneyMax":@"999999999",
                              @"LossMoneyMin":model.LossMoneyMin,
                              @"LossMoneyMax":@"999999999",
                              @"ActivePersonNum":model.ActivePersonNum
                              };
        [ContractContentModels addObject:dicc];
    }
    NSDictionary * dic=@{
                         @"subUserName":_models.UserName,
                         @"subUserID":_models.UserID,
                         @"ContractContentModels":ContractContentModels
                         };
    
    
    MCModifySubBonusContractModel * modifySubBonusContractModel = [[MCModifySubBonusContractModel alloc]initWithDic:dic];
    [modifySubBonusContractModel refreashDataAndShow];
    self.modifySubBonusContractModel = modifySubBonusContractModel;
    
    modifySubBonusContractModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        [SVProgressHUD showInfoWithStatus:@"修改失败！"];
    };
    
    modifySubBonusContractModel.callBackSuccessBlock = ^(id manager) {
        if (wself.goBackBlock) {
            wself.goBackBlock();
        }
        [SVProgressHUD showInfoWithStatus:@"修改成功！"];
        [wself.navigationController popViewControllerAnimated:YES];
    };
}

#pragma mark=================数据处理=================
#pragma mark-下拉刷新 数据处理
-(void)setData:(NSDictionary *)dic{
    
    _dataSource = [MCGetMyAndSubSignBounsContractDataModel mj_objectWithKeyValues:dic];

    self.headerView.dataSource=_dataSource;
    self.headerView.lab2.text=[NSString stringWithFormat:@"下级%@的分红契约",_models.UserName];
    
    MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];
    
    [data removeDataSource];
    
    if (_Type == MCModifyOrSignBonusContractType_Sign && _dataSource.DownContract.count<1) {

        [data addInitModel];
        
    }else{
        for (MCGetMyAndSubSignBounsContractDetailDataModel * model in _dataSource.DownContract) {
            
            model.Percent_DividendRatio = [MCContractMgtTool getNPercentNumber:model.DividendRatio];
            [data addDataSourceModel:model];
            
        }
    }
    
    [self.footerView setDeleteBtnHidden:YES];
    [self.tableView reloadData];
    
    
}

@end

















































