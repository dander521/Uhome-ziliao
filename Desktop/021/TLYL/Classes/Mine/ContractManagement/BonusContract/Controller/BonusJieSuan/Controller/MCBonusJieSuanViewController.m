//
//  MCBonusJieSuanViewController.m
//  TLYL
//
//  Created by MC on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBonusJieSuanViewController.h"
#import "MCBonusJieSuanQiYueTableViewCell.h"
#import "MCContractMgtBaseModel.h"
#import "MCMineInfoModel.h"
#import "MCBonusJieSuanFooterView.h"
#import "MCGetDividendSettlementModel.h"
#import "MCClickBonusSettlementModel.h"

@interface MCBonusJieSuanViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
typedef void(^MCBonusJieSuanViewControllerCompeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic, strong)NSMutableArray * sectionMarr;

@property(nonatomic, strong)MCGetDividendSettlementModel * getDividendSettlementModel;
@property(nonatomic, strong)MCGetDividendSettlementDataModel * dataSourceModel;
@property(nonatomic, strong)MCClickBonusSettlementModel *clickBonusSettlementModel;

@property(nonatomic, strong) MCBonusJieSuanFooterView *footerView;

@end

@implementation MCBonusJieSuanViewController
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
    self.navigationItem.title = @"分红结算";
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
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    
    [self loadData:^(BOOL result, NSDictionary *data) {
        [BKIndicationView dismiss];

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
-(void)loadData:(MCBonusJieSuanViewControllerCompeletion)compeletion{
    //  subUserID （旧：UserID）    是    String    当前下级用户 ID
    NSDictionary * dic=@{
                         @"subUserID" : _models.UserID
                         };
    
    MCGetDividendSettlementModel * getDividendSettlementModel = [[MCGetDividendSettlementModel alloc]initWithDic:dic];
    [getDividendSettlementModel refreashDataAndShow];
    self.getDividendSettlementModel = getDividendSettlementModel;
    
    getDividendSettlementModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        compeletion(NO,nil);
        
    };
    getDividendSettlementModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
}


-(void)setData:(NSDictionary *)dic{
    
    [_sectionMarr removeAllObjects];

    MCGetDividendSettlementDataModel * dataSourceModel = [MCGetDividendSettlementDataModel mj_objectWithKeyValues:dic];
    _dataSourceModel=dataSourceModel;
    

    CellModel* model =[[CellModel alloc]init];
    model.reuseIdentifier = NSStringFromClass([MCBonusJieSuanQiYueTableViewCell class]);
    model.className=NSStringFromClass([MCBonusJieSuanQiYueTableViewCell class]);
    model.height = [MCBonusJieSuanQiYueTableViewCell computeHeight:dataSourceModel];
    model.selectionStyle=UITableViewCellSelectionStyleNone;
    model.accessoryType=UITableViewCellAccessoryNone;
    /*
     * 传递参数
     */
    model.userInfo = dataSourceModel;
    
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[model]];
    model0.headerhHeight=13;
    model0.footerHeight=[MCBonusJieSuanFooterView computeHeight:nil];
    [_sectionMarr addObject:model0];
    
    
    
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
    if (section==0) {
        __weak __typeof__ (self) wself = self;
        self.footerView.block = ^{
            [wself jieSuan];
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
    
    if ([cm.className isEqualToString:NSStringFromClass([MCBonusJieSuanQiYueTableViewCell class])]) {
        MCBonusJieSuanQiYueTableViewCell *ex_cell=(MCBonusJieSuanQiYueTableViewCell *)cell;
        ex_cell.models=_models;
        ex_cell.dataSource=cm.userInfo;
        ex_cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(MCBonusJieSuanFooterView *)footerView{
    if (!_footerView) {
        _footerView=[[MCBonusJieSuanFooterView alloc]init];
    }
    return _footerView;
}

-(void)jieSuan{
    
    NSDictionary * dic=@{
                         @"subUserID" : _models.UserID,
//                         @"subUserID" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                         @"subUserName": _models.UserName
                         };
    
    [BKIndicationView showInView:self.view];
    MCClickBonusSettlementModel * clickBonusSettlementModel = [[MCClickBonusSettlementModel alloc]initWithDic:dic];
    [clickBonusSettlementModel refreashDataAndShow];
    self.clickBonusSettlementModel = clickBonusSettlementModel;
    
    clickBonusSettlementModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        [SVProgressHUD showInfoWithStatus:@"结算失败！"];
    };
    __weak __typeof__ (self) wself = self;
    clickBonusSettlementModel.callBackSuccessBlock = ^(id manager) {
        [SVProgressHUD showInfoWithStatus:@"结算成功！"];
        if (wself.goBackBlock) {
            wself.goBackBlock();
        }
        [wself.navigationController popViewControllerAnimated:YES];
    };
    
}

@end































