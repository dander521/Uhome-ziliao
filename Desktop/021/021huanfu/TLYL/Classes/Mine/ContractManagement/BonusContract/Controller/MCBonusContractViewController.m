//
//  MCBonusContractViewController.m
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBonusContractViewController.h"
#import "MCBonusContractHeaderView.h"
#import "MCContractMgtBaseModel.h"
#import "MCMyBonusContractListModel.h"
#import "MCMyBonusContractTableViewCell.h"
#import "MCMyXiaJiBonusContractListModel.h"
#import "MCBonusOneKeySettlementModel.h"
#import "MCMineInfoModel.h"
#import "MCModifyOrSignBonusContractViewController.h"
#import "MCContractContentModelsData.h"
#import "MCAgreeHigherBonusContractViewController.h"
#import "MCGetSelfContractStateModel.h"
#import "MCClickBonusSettlementModel.h"
#import "MCBonusJieSuanViewController.h"

#define MORENCOUNT @"15"
@interface MCBonusContractViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MGBaseSwipeTableViewCellDelegate
>

typedef void(^Compeletion)(BOOL result, NSDictionary *data );
typedef void(^RefreashCompeletion)(BOOL result, NSDictionary *data1,NSDictionary *data2 );

@property(nonatomic, strong) MCBonusContractHeaderView * headerView;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)ExceptionView * exceptionView;
@property(nonatomic, strong)NSMutableArray * xiaJiDataMarray;

//查看我的分红契约列表
@property(nonatomic, strong)MCMyBonusContractListModel * myBonusContractListModel;
@property(nonatomic, strong)MCMyBonusContractListDataModel* myBonusContractListData;

//获取下级的分红契约列表
@property(nonatomic, strong)MCMyXiaJiBonusContractListModel * xiaJiBonusContractListModel;
@property(nonatomic, strong)MCMyXiaJiBonusContractListDataModel * xiajiListData;

//查看 当前登录用户 是否有新的分红契约
@property(nonatomic, strong)MCGetSelfContractStateModel *getSelfContractStateModel;

@property(nonatomic, strong)NSString * CurrentPageIndex;
@property(nonatomic, strong)NSString * subUserName;

//一键结算
@property(nonatomic, strong)MCBonusOneKeySettlementModel * oneKeySettlementModel;
@property(nonatomic, strong)NSString * LockState;//是否显示“一键结算”（1：显示，0：不显示）

//分红结算
@property (nonatomic,strong)MCClickBonusSettlementModel * clickBonusSettlementModel;
@property (nonatomic,assign)int T;
@property (nonatomic,strong)NSDictionary * dic1;
@property (nonatomic,strong)NSDictionary * dic2;

@property(nonatomic, strong)MCNaviSelectedPopView *popView1;
@property(nonatomic, assign) BOOL  isShowPopView1;

@property(nonatomic,assign)BOOL isHadRefreashUI;
@end

@implementation MCBonusContractViewController

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
    MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];
    [data removeDataSource];
    if (!_isHadRefreashUI) {
       [self refreashData];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}


#pragma mark-
-(void) cancelTableEditClick: (id) sender{
    [_tableView setEditing: NO animated: YES];
}

-(NSArray *) createRightButtons: (int) number andTitle:(NSArray *)titles{

    NSMutableArray * result = [NSMutableArray array];
    NSArray * colors;
    if (number==1) {
        colors=@[RGB(228,66,65)];
    }else{
        colors=@[RGB(248,193,1),RGB(228,66,65)];
    }
//    UIColor * colors[2] = {RGB(248,193,1),RGB(228,66,65)};
    for (int i = 0; i < number; ++i){
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            BOOL autoHide = i != 0;
            return autoHide;
        }];
        [result addObject:button];
    }
    return result;
}



#if TEST_USE_MG_DELEGATE
-(nullable NSArray<UIView*>*) swipeTableCell:(nonnull MCXiaJiWageContractTableViewCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
                               swipeSettings:(nonnull MGSwipeSettings*) swipeSettings expansionSettings:(nonnull MGSwipeExpansionSettings*) expansionSettings{
    
    swipeSettings.transition = MGSwipeTransitionBorder;
    if (direction == MGSwipeDirectionLeftToRight) {
        return nil;
    }else {
        expansionSettings.buttonIndex = 1;
        expansionSettings.fillOnTrigger = YES;
        return [self createRightButtons:1];
    }
}
#endif

-(BOOL) swipeTableCell:(nonnull MCMyBonusContractTableViewCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    NSLog(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",
          direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    
    if (direction == MGSwipeDirectionRightToLeft && (index == 0||index == 1)) {
        //delete button
        NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
        if (_xiaJiDataMarray.count>indexPath.section) {
            MCMyXiaJiBonusContractListDeatailDataModel *models = _xiaJiDataMarray[indexPath.section];
            NSArray * stateArray = [self GetTouchArrayWithState:models.State];
            NSLog(@"-----点击%@----",stateArray[index]);
            __weak __typeof__ (self) wself = self;
            if ([stateArray[index] isEqualToString:@"签订契约"]) {
#pragma mark-跳转【签订契约】
                MCModifyOrSignBonusContractViewController * VC = [[MCModifyOrSignBonusContractViewController alloc]init];
                VC.models=models;
                VC.Type=MCModifyOrSignBonusContractType_Sign;
                VC.goBackBlock = ^{
                    [wself refreashData];
                };
                [self.navigationController pushViewController:VC animated:YES];
                
            }else if ([stateArray[index] isEqualToString:@"更改契约"]){
#pragma mark-跳转【更改契约】
                MCModifyOrSignBonusContractViewController * VC = [[MCModifyOrSignBonusContractViewController alloc]init];
                VC.models=models;
                VC.Type=MCModifyOrSignBonusContractType_Modify;
                VC.goBackBlock = ^{
                    [wself refreashData];
                };
                [self.navigationController pushViewController:VC animated:YES];
                
#pragma mark-点击【分红结算】
            }else if ([stateArray[index] isEqualToString:@"分红结算"]){
                [self ClickBonusSettlement:models];
            }
        }

        return YES; //Don't autohide to improve delete expansion animation
    }
    
    return YES;
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tapped accessory button");
}


#pragma mark==================setProperty======================
-(void)setProperty{
    self.view.backgroundColor=RGB(231, 231, 231);
    self.navigationItem.title = @"分红契约";
    _xiaJiDataMarray=[[NSMutableArray alloc]init];
    _CurrentPageIndex=@"1";
    _subUserName=@"";
    self.isHadRefreashUI=NO;
}

#pragma mark ====================设置导航栏========================
-(void)setNav{
    MCNaviButton *rightBtn = [[MCNaviButton alloc] init];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark==================createUI======================
-(void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreashData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(13);
        make.right.equalTo(self.view.mas_right).offset(-13);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
}

-(void)rightBtnAction{
    if (_isShowPopView1) {
        _isShowPopView1=NO;
        [self.popView1 dismiss];
        
    }else{
        _isShowPopView1=YES;
        
        typeof(self) weakself = self;
        
        self.popView1.block = ^(NSInteger type) {
            
            if (type==0) {
#pragma mark-搜索
            }else if (type==8){
                
                weakself.isShowPopView1=NO;
                [weakself dismissAllPopView1];
                
                weakself.subUserName = weakself.popView1.tf1.text;
                [weakself.xiaJiDataMarray removeAllObjects];
                weakself.CurrentPageIndex = @"1";
                [weakself loadXiaJi];

            }
        };
        
        self.popView1.frame= CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT);
        [self.popView1 showPopView];
    }
}

#pragma mark ========================tableView 代理相关========================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_xiaJiDataMarray.count<1) {
        return 1;
    }else{
        return _xiaJiDataMarray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return [MCBonusContractHeaderView computeHeight:_myBonusContractListData andLockState:_xiajiListData.LockState];
    }
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak __typeof__ (self) wself = self;
    
    if (section==0) {
#pragma mark-点击一键结算
        self.headerView.settleBlock = ^{
            NSLog(@"-----一键结算------");
            [wself oneKeySettlement];
        };
#pragma mark-点击新契约
        self.headerView.goToContractBlock = ^{
            MCAgreeHigherBonusContractViewController * VC = [[MCAgreeHigherBonusContractViewController alloc]init];
            VC.goBackBlock = ^{
              [wself refreashData];
            };
            [wself.navigationController pushViewController:VC animated:YES];
        };
        return self.headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_xiaJiDataMarray.count<1) {
        return 0.0001;
    }
    return [MCMyBonusContractTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier_2 =[NSString stringWithFormat:@"MCMyBonusContractTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    
    MCMyBonusContractTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier_2];
    if (!cell2) {
        cell2 = [[MCMyBonusContractTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier_2];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_xiaJiDataMarray.count>indexPath.section) {
        cell2.dataSource=_xiaJiDataMarray[indexPath.section];
    }
    cell2.accessoryType = UITableViewCellAccessoryNone;
    cell2.delegate = self;
    cell2.allowsMultipleSwipe = NO;
    cell2.layer.cornerRadius = 6;
    cell2.clipsToBounds = YES;
    
#if !TEST_USE_MG_DELEGATE
    
    cell2.rightSwipeSettings.transition = MGSwipeTransitionStatic;
    cell2.rightExpansion.buttonIndex = 1;
    cell2.rightExpansion.buttonIndex = -1;
    cell2.rightExpansion.fillOnTrigger = YES;

    if (_xiaJiDataMarray.count>indexPath.section) {
        MCMyXiaJiBonusContractListDeatailDataModel *models = _xiaJiDataMarray[indexPath.section];
        NSArray * stateArray = [self GetTouchArrayWithState:models.State];
        cell2.rightButtons = [self createRightButtons:(int)stateArray.count andTitle:stateArray];

    }else{
        cell2.rightButtons = [self createRightButtons:1 andTitle:@[@"..."]];
    }
#endif
    
    return cell2;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Http
#pragma mark-一键结算
-(void)oneKeySettlement{
//    UserName    是    String    当前登录用户名
//    UserID    是    String    当前登录用户 ID
//    Sign    是    Int    固定值：1
    
    MCMineInfoModel * mineInfoModel=[MCMineInfoModel sharedMCMineInfoModel];
    NSString * UserName;
    if (mineInfoModel.UserName.length>1) {
        UserName=mineInfoModel.UserName;
    }else{
        UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    }
    NSDictionary * dic=@{
                         @"UserID" : [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                         @"UserName": UserName,
                         @"Sign":@"1"
                         };
    
    
    MCBonusOneKeySettlementModel * oneKeySettlementModel = [[MCBonusOneKeySettlementModel alloc]initWithDic:dic];
    [oneKeySettlementModel refreashDataAndShow];
    self.oneKeySettlementModel = oneKeySettlementModel;
    
    oneKeySettlementModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        [SVProgressHUD showInfoWithStatus:@"结算失败！"];
    };
    
    oneKeySettlementModel.callBackSuccessBlock = ^(id manager) {
        [SVProgressHUD showInfoWithStatus:@"结算成功！"];

    };

}

#pragma mark-分红结算
-(void)ClickBonusSettlement:( MCMyXiaJiBonusContractListDeatailDataModel * )models{
    if (!models.UserID||!models.UserName) {
        return;
    }
    __weak __typeof__ (self) wself = self;
    MCBonusJieSuanViewController * vc = [[MCBonusJieSuanViewController alloc]init];
    vc.models = models;
    vc.goBackBlock = ^{
        [wself refreashData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark-下拉刷新
- (void)refreashData{
    
    __weak __typeof__ (self) wself = self;
    //刷新余额
    [BKIndicationView showInView:self.view];
    self.tableView.mj_footer.hidden=NO;
    _CurrentPageIndex=@"1";
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    
    [self refreashData:^(BOOL result, NSDictionary *data1, NSDictionary *data2) {
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [BKIndicationView dismiss];
            [wself.tableView.mj_header endRefreshing];
            [wself.tableView.mj_footer endRefreshing];
            if (result) {
                wself.isHadRefreashUI=YES;
                [wself.exceptionView dismiss];
                wself.exceptionView = nil;
                [wself setDataWithDic1:data1 andDic2:data2];
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
        });
    }];
    

    NSDictionary * dic = @{
                           @"UserName":[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"],
                           @"subUserName":[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"],
                           @"CurrentPageIndex":@"1",
                           @"CurrentPageSize":MORENCOUNT
                           };

    MCGetSelfContractStateModel * getSelfContractStateModel = [[MCGetSelfContractStateModel alloc]initWithDic:dic];
    [getSelfContractStateModel refreashDataAndShow];
    self.getSelfContractStateModel = getSelfContractStateModel;
    
    getSelfContractStateModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
    };
    getSelfContractStateModel.callBackSuccessBlock = ^(id manager) {
        //    State    Int    0：当前用户有新契约；1：当前用户没有新契约
        NSDictionary * dic = manager;
        NSString * State = [NSString stringWithFormat:@"%@",dic[@"State"]];
        if ([State isEqualToString:@"0"]) {
            [wself.headerView setNewState:NO];
        }else{
            [wself.headerView setNewState:YES];
        }
    };
}
-(void)refreashData:(RefreashCompeletion)compeletion{
    __weak __typeof__ (self) wself = self;
    
    _T = 0;
    NSDictionary * dic=@{
                         @"UserID" : [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                         @"IsState":@"1"
                         };
    MCMyBonusContractListModel * myBonusContractListModel = [[MCMyBonusContractListModel alloc]initWithDic:dic];
    [myBonusContractListModel refreashDataAndShow];
    self.myBonusContractListModel = myBonusContractListModel;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_async(group, quene, ^{
        
        myBonusContractListModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
            NSLog(@"complete task 1-NO");
            dispatch_semaphore_signal(semaphore);
        };
        
        myBonusContractListModel.callBackSuccessBlock = ^(id manager) {
            NSLog(@"complete task 1-YES");
            dispatch_semaphore_signal(semaphore);
            wself.T++;
            wself.dic1=manager;
        };
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    NSDictionary * x_dic = @{
                             @"subUserName":_subUserName,
                             @"CurrentPageIndex":_CurrentPageIndex,
                             @"CurrentPageSize":MORENCOUNT
                             };
    
    MCMyXiaJiBonusContractListModel * xiaJiBonusContractListModel = [[MCMyXiaJiBonusContractListModel alloc]initWithDic:x_dic];
    [xiaJiBonusContractListModel refreashDataAndShow];
    self.xiaJiBonusContractListModel = xiaJiBonusContractListModel;
    
    dispatch_group_async(group, quene, ^{
        
        xiaJiBonusContractListModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
            dispatch_semaphore_signal(semaphore);
            NSLog(@"complete task 2-NO");
            
        };
        xiaJiBonusContractListModel.callBackSuccessBlock = ^(id manager) {
            NSLog(@"complete task 2-YES");
            dispatch_semaphore_signal(semaphore);
            wself.T++;
            wself.dic2=manager;
        };
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"完成了网络请求，不管网络请求失败了还是成功了。");
        if (wself.T>1) {
            NSLog(@"11111111111111111111111111111111111");
            compeletion(YES,wself.dic1,wself.dic2);
        }else{
            NSLog(@"22222222222222222222222222222222222");
            compeletion(NO,wself.dic1,wself.dic2);
        }
    });
}


-(void)loadXiaJi{
    [BKIndicationView showInView:self.view];
    __weak __typeof__ (self) wself = self;
    [self loadXiaJi:^(BOOL result, NSDictionary *data) {
        [BKIndicationView dismiss];
        [wself.tableView.mj_footer endRefreshing];
        [wself.tableView.mj_header endRefreshing];
        
        if (result) {
            
            [wself setXiaJiData:data];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            wself.CurrentPageIndex=[NSString stringWithFormat:@"%d",[_CurrentPageIndex intValue]-1];
        }
    }];
}

#pragma mark-上拉加载更多
-(void)loadMoreData{
    _CurrentPageIndex=[NSString stringWithFormat:@"%d",[_CurrentPageIndex intValue]+1];
    [self loadXiaJi];
}
-(void)loadXiaJi:(Compeletion)compeletion{
    //    UserName    是    String    当前登录用户名
    //    CurrentPageIndex    是    Int    当前页下标（第一页为1，后续页码依次加1）
    //    CurrentPageSize    是    Int    当前页请求条目数
    NSDictionary * dic = @{
                            @"subUserName":@"",
                            @"CurrentPageIndex":_CurrentPageIndex,
                            @"CurrentPageSize":MORENCOUNT
                            };
    if (_subUserName.length>0) {
        dic = @{
                @"subUserName":_subUserName,
                @"CurrentPageIndex":_CurrentPageIndex,
                @"CurrentPageSize":MORENCOUNT
                };
    }
    
    MCMyXiaJiBonusContractListModel * xiaJiBonusContractListModel = [[MCMyXiaJiBonusContractListModel alloc]initWithDic:dic];
    [xiaJiBonusContractListModel refreashDataAndShow];
    self.xiaJiBonusContractListModel = xiaJiBonusContractListModel;
    
    xiaJiBonusContractListModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
        compeletion(NO,nil);
        
    };
    xiaJiBonusContractListModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
}


#pragma mark-数据处理
#pragma mark-下拉刷新 数据处理
-(void)setDataWithDic1:(NSDictionary *)dic1 andDic2:(NSDictionary *)dic2{
    
    [_xiaJiDataMarray removeAllObjects];
    
    MCMyBonusContractListDataModel* dataSource1 = [MCMyBonusContractListDataModel mj_objectWithKeyValues:dic1];
    _myBonusContractListData=dataSource1;
    self.headerView.dataSource = dataSource1;
    
    _xiajiListData = [MCMyXiaJiBonusContractListDataModel mj_objectWithKeyValues:dic2];
    
    self.headerView.frame=CGRectMake(0, 0, G_SCREENWIDTH, [MCBonusContractHeaderView computeHeight:_myBonusContractListData andLockState:_xiajiListData.LockState]);
    
    self.headerView.lockState  = _xiajiListData.LockState;
    _LockState  = _xiajiListData.LockState;
    if (_xiajiListData.ContractManagerModels.count<1) {
        self.tableView.mj_footer.hidden=YES;
    }else{
        [_xiaJiDataMarray addObjectsFromArray:_xiajiListData.ContractManagerModels];

    }
    if (_xiajiListData.ContractManagerModels.count%[MORENCOUNT integerValue]!=0) {
        self.tableView.mj_footer.hidden=YES;
    }
    [_tableView reloadData];
}


-(void)setXiaJiData:(NSDictionary *)dic{
    
    _xiajiListData = [MCMyXiaJiBonusContractListDataModel mj_objectWithKeyValues:dic];

    if (_xiajiListData.ContractManagerModels.count<1) {
        self.tableView.mj_footer.hidden=YES;
        [_tableView reloadData];
        return;
    }
    if (_xiajiListData.ContractManagerModels.count%[MORENCOUNT integerValue]!=0) {
        self.tableView.mj_footer.hidden=YES;
    }
    
    [_xiaJiDataMarray addObjectsFromArray:_xiajiListData.ContractManagerModels];
    
    [_tableView reloadData];
    
}

#pragma mark-Tool
-(NSArray *)GetTouchArrayWithState:(NSString *)State{
    
//    State    Int    0：当前用户有新契约；1：当前用户没有新契约
//    当 LockState == 1 && State >= 0，则显示“分红结算”按钮，否则不显示。
    NSString * str1=@"";
    if ([[NSString stringWithFormat:@"%@",State]isEqualToString:@"-1"]) {
        str1=@"签订契约";
    }else{
        str1=@"更改契约";
    }
    //    switch (state){
    //        case -1:
    //            return ['未签约','签订契约'];
    //        case 0:
    //            return ['待确认','修改契约'];
    //        case 1:
    //            return ['已签约','修改契约'];
    //        case 2:
    //            return ['已拒绝','修改契约'];
    //    }
    //    当 LockState == 1 && State >= 0，则显示“分红结算”按钮，否则不显示。
    
    if ([_LockState intValue]== 1 && [State intValue] >= 0) {
        return @[@"分红结算",str1];
    }else{
        return @[str1];
    }
    
}

#pragma mark-set/get
- (MCNaviSelectedPopView *)popView1{
    
    if (_popView1 == nil) {
        MCNaviSelectedPopView * popView1 = [[MCNaviSelectedPopView alloc]InitWithType:MCNaviSelectedPopType_BonusContract];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        [popView1 addGestureRecognizer:tap1];
        [self.navigationController.view addSubview:popView1];
        _popView1 = popView1;
    }
    return _popView1;
}
-(MCBonusContractHeaderView *)headerView{
    if (!_headerView) {
        _headerView=[[MCBonusContractHeaderView alloc]init];
    }
    return _headerView;
}
- (void)tap1{
    _isShowPopView1=NO;
    [self dismissAllPopView1];
}
-(void)dismissAllPopView1{
    [self.popView1 dismiss];
}
@end
















































