//
//  MCAgreeHigherBonusContractViewController.m
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCAgreeHigherBonusContractViewController.h"
#import "MCAgreeHigherNewBonusContractTableViewCell.h"
#import "MCAgreeHigherOldBonusContractTableViewCell.h"
#import "MCAgreeHigherBonusContractFooterView.h"
#import "MCContractMgtBaseModel.h"
#import "MCMyBonusContractListModel.h"
#import "MCAgreeMyBounsContractModel.h"
#import "MCMineInfoModel.h"
@interface MCAgreeHigherBonusContractViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void(^MCAgreeHigherBonusContractCompeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic, strong)NSMutableArray * sectionMarr;

@property(nonatomic, strong)MCMyBonusContractListModel * myBonusContractListModel;
@property(nonatomic, strong)MCMyBonusContractListDataModel * dataSourceModel;
@property(nonatomic, strong)MCAgreeMyBounsContractModel *agreeMyBounsContractModel;
@property(nonatomic, strong) MCAgreeHigherBonusContractFooterView *footerView;

@end

@implementation MCAgreeHigherBonusContractViewController
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
    self.navigationItem.title = @"同意分红契约";
    _sectionMarr=[[NSMutableArray alloc]init];

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

-(void)refreashData{
    __weak __typeof__ (self) wself = self;
    //刷新余额
    [BKIndicationView showInView:self.view];
    self.tableView.mj_footer.hidden=NO;
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    
    [self loadData:^(BOOL result, NSDictionary *data) {
        [BKIndicationView dismiss];
        [wself.tableView.mj_header endRefreshing];
        if (result) {
            [wself setData:data ];
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
-(void)loadData:(MCAgreeHigherBonusContractCompeletion)compeletion{
    //    UserID    是    String    当前登录用户ID
    //    IsState    是    Int    当前登录用户契约状态
    NSDictionary * dic=@{
                         @"UserID" : [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                         @"IsState":@"0"
                         };
    
    MCMyBonusContractListModel * myBonusContractListModel = [[MCMyBonusContractListModel alloc]initWithDic:dic];
    [myBonusContractListModel refreashDataAndShow];
    self.myBonusContractListModel = myBonusContractListModel;
    
    myBonusContractListModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        compeletion(NO,nil);
        
    };
    myBonusContractListModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
}


-(void)setData:(NSDictionary *)dic{
  
    [_sectionMarr removeAllObjects];
    
    MCMyBonusContractListDataModel * dataSourceModel = [MCMyBonusContractListDataModel mj_objectWithKeyValues:dic];
    NSMutableArray * marr1 = [[NSMutableArray alloc]init];
    NSMutableArray * marr2 = [[NSMutableArray alloc]init];

    for (MCMyBonusContractListDeatailDataModel * mModel in dataSourceModel.ContractContentModels) {
        ;//判断是已同意还是未同意列表的数据（0：已同意，1：未同意）
        if ([[NSString stringWithFormat:@"%@",mModel.IsHistoryData] isEqualToString:@"0"]) {
            [marr1 addObject:mModel];
        }else if ([[NSString stringWithFormat:@"%@",mModel.IsHistoryData] isEqualToString:@"1"]){
            [marr2 addObject:mModel];
        }
    }
    if (marr1.count>0) {
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCAgreeHigherOldBonusContractTableViewCell class]);
        model.className=NSStringFromClass([MCAgreeHigherOldBonusContractTableViewCell class]);
        model.height = [MCAgreeHigherNewBonusContractTableViewCell computeHeight:marr1];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo = marr1;
        
        SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[model]];
        model0.headerhHeight=13;
        model0.footerHeight=0.0001;
        [_sectionMarr addObject:model0];
    }

    if (marr2.count>0) {
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCAgreeHigherNewBonusContractTableViewCell class]);
        model.className=NSStringFromClass([MCAgreeHigherNewBonusContractTableViewCell class]);
        model.height = [MCAgreeHigherNewBonusContractTableViewCell computeHeight:marr2];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo = marr2;
        SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[model]];
        model0.headerhHeight=13;
        model0.footerHeight=[MCAgreeHigherBonusContractFooterView computeHeight:nil];
        [_sectionMarr addObject:model0];
    }
    
    [self.tableView reloadData];
    
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
    if (section==1) {
        __weak __typeof__ (self) wself = self;
        self.footerView.block = ^{
            [wself agreeContract];
        };
        return self.footerView;
    }
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
    
    if ([cm.className isEqualToString:NSStringFromClass([MCAgreeHigherOldBonusContractTableViewCell class])]) {
        MCAgreeHigherOldBonusContractTableViewCell *ex_cell=(MCAgreeHigherOldBonusContractTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        ex_cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if ([cm.className isEqualToString:NSStringFromClass([MCAgreeHigherNewBonusContractTableViewCell class])]) {
        MCAgreeHigherNewBonusContractTableViewCell *ex_cell=(MCAgreeHigherNewBonusContractTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        ex_cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(MCAgreeHigherBonusContractFooterView *)footerView{
    if (!_footerView) {
        _footerView=[[MCAgreeHigherBonusContractFooterView alloc]init];
    }
    return _footerView;
}

-(void)agreeContract{
//    UserName    是    String    当前登录用户名
//    UserID    是    String    当前登录用户ID
//    IsAgree    是    String    同意确认（固定值：1）
    MCMineInfoModel * mineInfoModel=[MCMineInfoModel sharedMCMineInfoModel];
    NSString * UserName;
    if (mineInfoModel.UserName.length>1) {
        UserName=mineInfoModel.UserName;
    }else{
        UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    }
    NSDictionary * dic=@{
                         @"UserName":UserName,
                         @"UserID" : [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                         @"IsAgree":@"1"
                         
                         };
    __weak __typeof__ (self) wself = self;

    MCAgreeMyBounsContractModel *agreeMyBounsContractModel = [[MCAgreeMyBounsContractModel alloc]initWithDic:dic];
    [agreeMyBounsContractModel refreashDataAndShow];
    self.agreeMyBounsContractModel = agreeMyBounsContractModel;
    
    agreeMyBounsContractModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {

    };
    agreeMyBounsContractModel.callBackSuccessBlock = ^(id manager) {
        
        [SVProgressHUD showInfoWithStatus:@"签订成功！"];
        if (wself.goBackBlock) {
            wself.goBackBlock();
        }
        
        [wself.navigationController popViewControllerAnimated:YES];
    };
}

@end






























