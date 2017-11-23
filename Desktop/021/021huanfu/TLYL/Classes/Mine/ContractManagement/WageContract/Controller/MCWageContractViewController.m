//
//  MCWageContractViewController.m
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCWageContractViewController.h"
#import "MCContractMgtBaseModel.h"
#import "MCHomeWageContractHeaderView.h"
#import "MCXiaJiWageContractTableViewCell.h"
#import "MCGetDayWagesThreeRdModel.h"
#import "MCMyDayWagesThreeRdListModel.h"
#import "MCMyDayWagesThreeRdListDataModel.h"
#import "MCMyXiaJiDayWagesThreeRdListModel.h"
#import "MCSignContractViewController.h"
#import "MCNaviSelectedPopView.h"
#import "MCMMIputView.h"

#define MORENCOUNT @"15"
#define DayWagesStateDic @{@"全部":@"-1",@"已签约":@"1",@"修改待确认":@"0",@"未签约":@"2"}
@interface MCWageContractViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MGBaseSwipeTableViewCellDelegate
>

typedef void(^Compeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong) MCHomeWageContractHeaderView * headerView;
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)ExceptionView * exceptionView;


@property(nonatomic, strong)NSMutableArray * xiaJiDataMarray;

//获取自己的日工资契约 （日工资3）
@property(nonatomic, strong)MCMyDayWagesThreeRdListModel * myDayWagesThreeRdListModel;
@property(nonatomic, strong)MCMyDayWagesThreeRdListDataModel * myDayWagesDataModel;

//查看下级的日工资列表 （日工资3）
@property(nonatomic, strong)MCMyXiaJiDayWagesThreeRdListModel * xiaJiDayWagesThreeRdListModel;
@property(nonatomic, strong)NSString * CurrentPageIndex;
@property(nonatomic, strong)NSString * subUserName;
@property(nonatomic, strong)NSString * DayWagesState;//查询类型（-1：全部，1：已签约，0：修改待确认，2：未签约）



@property(nonatomic, strong)MCNaviSelectedPopView *popView1;
@property(nonatomic, weak)  MCMMIputView * viewPop1;
@property(nonatomic, assign) BOOL  isShowPopView1;


@property(nonatomic,assign)BOOL isHadRefreashUI;
@end

@implementation MCWageContractViewController

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
    number=1;
    NSMutableArray * result = [NSMutableArray array];
    UIColor * colors[1] = {RGB(249,84,83)};
    for (int i = 0; i < number; ++i){
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            BOOL autoHide = i != 0;
            return autoHide; //Don't autohide in delete button to improve delete expansion animation
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

-(BOOL) swipeTableCell:(nonnull MCXiaJiWageContractTableViewCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    NSLog(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",
          direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    __weak __typeof__ (self) wself = self;

    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
        
        MCSignContractViewController * vc = [[MCSignContractViewController alloc]init];
        MCMyXiaJiDayWagesThreeListModelsDataModel * model=_xiaJiDataMarray[indexPath.section];
        vc.xiaJiModel = model;
        MCMyXiaJiDayWagesThreeListModelsDataModel *models = _xiaJiDataMarray[indexPath.section];
        NSString * State= StateDic[models.State][1];
        if ([State isEqualToString:@"修改契约"]) {
            vc.Type=MCSignOrModifyContractVCType_Modify;
        }else if ([State isEqualToString:@"签订契约"]){
            vc.Type=MCSignOrModifyContractVCType_Sign;
        }
        vc.goBackBlock = ^{
            [wself refreashData];
        };
        [self.navigationController pushViewController:vc animated:YES];

        return YES;
    }
    
    return YES;
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tapped accessory button");
}

#pragma mark==================setProperty======================
-(void)setProperty{
    self.view.backgroundColor=RGB(231, 231, 231);
    self.navigationItem.title = @"日工资契约";
    _xiaJiDataMarray=[[NSMutableArray alloc]init];
    _CurrentPageIndex=@"1";
    _subUserName=@"";
    _DayWagesState=@"-1";
    _isHadRefreashUI=NO;
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
    _tableView.backgroundColor = [UIColor clearColor];
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
            }else if (type==1){
                //查询类型（-1：全部，1：已签约，0：修改待确认，2：未签约）
                NSArray * arr = @[@"全部",@"已签约",@"未签约"];
                weakself.viewPop1.dataArray =  arr;
                [weakself.viewPop1 show];
                weakself.viewPop1.cellDidSelectedTop = ^(NSInteger i) {
                    
                    weakself.DayWagesState=DayWagesStateDic[arr[i]];
                    weakself.popView1.label2.text=arr[i];
                    [weakself.viewPop1 hiden];
                    
                };
#pragma mark-搜索
            }else if (type==8){
                
                weakself.isShowPopView1=NO;
                [weakself dismissAllPopView1];
                
                weakself.subUserName = weakself.popView1.tf1.text;
                
                [weakself refreashData];
            }
        };
        
        self.popView1.frame= CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT);
        [self.popView1 showPopView];
    }
}

#pragma mark-下拉刷新
- (void)refreashData{
    self.tableView.mj_footer.hidden=NO;
    _CurrentPageIndex=@"1";
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    
    [BKIndicationView showInView:self.view];
    __weak __typeof__ (self) wself = self;
    [self loadData:^(BOOL result, NSDictionary *data) {
        
        [wself.tableView.mj_footer endRefreshing];
        [wself.tableView.mj_header endRefreshing];
        
        if (result) {
            wself.isHadRefreashUI=YES;
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
    
    [_xiaJiDataMarray removeAllObjects];
    
    [self loadXiaJi:^(BOOL result, NSDictionary *data) {
        if (result) {
            [wself setXiaJiData:data];
        }else{
        }
    }];
}

-(void)setXiaJiData:(NSDictionary *)dic{
    MCMyXiaJiDayWagesThreeRdListDataModel * model = [MCMyXiaJiDayWagesThreeRdListDataModel mj_objectWithKeyValues:dic];

    if (model.DayWagesThreeListModels.count<1) {
//        //无数据
//        self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
//        [self.exceptionView showInView:self.view];
//        return;
        self.tableView.mj_footer.hidden=YES;

    }
    
    if (model.DayWagesThreeListModels.count%[MORENCOUNT intValue]!=0) {
        self.tableView.mj_footer.hidden=YES;
    }
    
    
    [_xiaJiDataMarray addObjectsFromArray:model.DayWagesThreeListModels];
    
    [_tableView reloadData];
}

-(void)loadMoreData{

    
    _CurrentPageIndex=[NSString stringWithFormat:@"%d",[_CurrentPageIndex intValue]+1];
    [BKIndicationView showInView:self.view];
    __weak __typeof__ (self) wself = self;
    [self loadXiaJi:^(BOOL result, NSDictionary *data) {
        
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


#pragma mark==================loadData======================
-(void)loadData:(Compeletion)compeletion{
    //UserID    是    String    我的用户 ID
    NSDictionary * dic=@{
                          @"UserID" : [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]
                         };
    
    
    MCMyDayWagesThreeRdListModel * myDayWagesThreeRdListModel = [[MCMyDayWagesThreeRdListModel alloc]initWithDic:dic];
    [myDayWagesThreeRdListModel refreashDataAndShow];
    self.myDayWagesThreeRdListModel = myDayWagesThreeRdListModel;
    
    myDayWagesThreeRdListModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        compeletion(NO,nil);
    };
    
    myDayWagesThreeRdListModel.callBackSuccessBlock = ^(id manager) {
        compeletion(YES,manager);
    };

}


-(void)loadXiaJi:(Compeletion)compeletion{
    
    NSDictionary * dic = @{
                           @"subUserName":_subUserName,
                           @"DayWagesState":_DayWagesState,
                           @"UserType":@"0",
                           @"AgentLevel":@"0",
                           @"CurrentPageIndex":_CurrentPageIndex,
                           @"CurrentPageSize":MORENCOUNT
                           };
    
    
    MCMyXiaJiDayWagesThreeRdListModel * xiaJiDayWagesThreeRdListModel = [[MCMyXiaJiDayWagesThreeRdListModel alloc]initWithDic:dic];
    [xiaJiDayWagesThreeRdListModel refreashDataAndShow];
    self.xiaJiDayWagesThreeRdListModel = xiaJiDayWagesThreeRdListModel;
    
    xiaJiDayWagesThreeRdListModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
        compeletion(NO,nil);
        
    };
    
    xiaJiDayWagesThreeRdListModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
    
}
-(void)setData:(NSDictionary *)dic{
    
    _myDayWagesDataModel = [MCMyDayWagesThreeRdListDataModel mj_objectWithKeyValues:dic];
    
    if (_myDayWagesDataModel.Before_DayWagesRules.count>0) {
        _headerView.dataSource=_myDayWagesDataModel.Before_DayWagesRules[0];
    }
    [self.tableView reloadData];
    
}

#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_xiaJiDataMarray.count<1) {
        return 1;
    }
    return  _xiaJiDataMarray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return [MCHomeWageContractHeaderView computeHeight:nil];
    }
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak __typeof__ (self) wself = self;
    if (section==0) {
        self.headerView.dayWageRuleBlock = ^{
            MCPopAlertView * pop = [[MCPopAlertView alloc]initWithType:MCPopAlertTypeContractMgt_DayWageRules Title:@"日工资规则" leftBtn:@"我知道了" rightBtn:nil MyDayWagesThreeRdListDataModel: wself.myDayWagesDataModel];
            pop.resultIndex = ^(NSInteger index){
            };
            [pop showXLAlertView];
        };
        if (_myDayWagesDataModel.Before_DayWagesRules.count>0) {
        self.headerView.dataSource=_myDayWagesDataModel.Before_DayWagesRules[0];
        }
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
    return [MCXiaJiWageContractTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        NSString *reuseIdentifier_2 =[NSString stringWithFormat:@"MCXiaJiWageContractTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
        
        MCXiaJiWageContractTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier_2];
        if (!cell2) {
            cell2 = [[MCXiaJiWageContractTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier_2];
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
        NSString * State=@"";
        if (_xiaJiDataMarray.count>indexPath.section) {
            MCMyXiaJiDayWagesThreeListModelsDataModel *models = _xiaJiDataMarray[indexPath.section];
            State= StateDic[models.State][1];
            cell2.rightButtons = [self createRightButtons:1 andTitle:@[State]];

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

#pragma mar-set/get
-(MCHomeWageContractHeaderView *)headerView{
    if (!_headerView) {
        _headerView=[[MCHomeWageContractHeaderView alloc]init];
        _headerView.frame=CGRectMake(0, 0, G_SCREENWIDTH, [MCHomeWageContractHeaderView computeHeight:nil]);
    }
    return _headerView;
}
- (MCNaviSelectedPopView *)popView1{
    
    if (_popView1 == nil) {
        MCNaviSelectedPopView * popView1 = [[MCNaviSelectedPopView alloc]InitWithType:MCNaviSelectedPopType_dayWageContract];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        [popView1 addGestureRecognizer:tap1];
        [self.navigationController.view addSubview:popView1];
        _popView1 = popView1;
    }
    return _popView1;
}
- (void)tap1{
    _isShowPopView1=NO;
    [self dismissAllPopView1];
}
-(void)dismissAllPopView1{
    [self.popView1 dismiss];
    [self.viewPop1 hiden];
}
- (MCMMIputView *)viewPop1{
    if (_viewPop1 == nil) {
        
        MCMMIputView *viewStatus = [[MCMMIputView alloc] init];
        [self.navigationController.view addSubview:viewStatus];
        _viewPop1 = viewStatus;
    }
    return _viewPop1;
}
@end















































