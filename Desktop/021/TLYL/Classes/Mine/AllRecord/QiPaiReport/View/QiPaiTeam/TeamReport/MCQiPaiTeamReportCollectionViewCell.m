//
//  MCQiPaiTeamReportCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQiPaiTeamReportCollectionViewCell.h"
#import "UIView+MCParentController.h"
#import "MCNaviSelectedPopView.h"
#import <MJRefresh/MJRefresh.h>
#import "MCSignalPickView.h"
#import "MCRecordTool.h"
#import "MCDatePickerView.h"
#import "MCQiPaiTeamReportTableViewCell.h"
#import "MCQiPaiTeamReportModel.h"
#import "MCMineInfoModel.h"
#import "MCQiPaiTeamSlideView.h"

#define MORENCOUNT 15
@interface MCQiPaiTeamReportCollectionViewCell()
<
UITableViewDelegate,
UITableViewDataSource
>


typedef void(^Compeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic, strong) NSString * statTime;
@property(nonatomic, strong) NSString * endTime;
@property(nonatomic, strong) NSString * CurrentPageIndex;
@property(nonatomic, strong) NSString * CurrentPageSize    ;
@property(nonatomic, assign) BOOL IsHistory;


@property (nonatomic,strong) MCQiPaiTeamReportModel * teamReportModel;
@property (nonatomic,strong) MCQiPaiTeamReportDataModel * Tmodel;
@end

@implementation MCQiPaiTeamReportCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}


- (void)initView{
    
    self.backgroundColor=RGB(231,231,231);
    
    [self setProperty];
    
    [self createUI];
    
    [self refreashData];
    
}


#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.backgroundColor=RGB(231, 231, 231);
    [self refreashQiPaiPersonProperty];
    
}

-(void)refreashQiPaiPersonProperty{
    MCQiPaiTeamProperty * PersonProperty = [MCQiPaiTeamProperty sharedMCQiPaiTeamProperty];
    self.statTime=PersonProperty.statTime;
    self.endTime=PersonProperty.endTime;
    self.CurrentPageIndex=PersonProperty.CurrentPageIndex;
    self.CurrentPageSize=PersonProperty.CurrentPageSize;
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
    _tableView.layer.cornerRadius=5;
    _tableView.clipsToBounds=YES;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreashData];
    }];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    
    
}



#pragma mark-下拉刷新
- (void)refreashData{
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    self.tableView.mj_footer.hidden=NO;
    self.tableView.mj_header.hidden=NO;
    [BKIndicationView showInView:self];
    __weak __typeof__ (self) wself = self;
    _CurrentPageIndex=@"1";
    
    [self loadData:^(BOOL result, NSDictionary *data) {
        [wself.tableView.mj_footer endRefreshing];
        [wself.tableView.mj_header endRefreshing];
        if (result) {
            
            [wself setData:data];
            
        }else{
            wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
            wself.exceptionView.heightH=G_SCREENHEIGHT-64-49-40;
            ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                [wself.exceptionView dismiss];
                wself.exceptionView = nil;
                [wself refreashData];
            }];
            [wself.exceptionView addAction:action];
            [wself.exceptionView showInView:wself.tableView];
        }
    }];
    
}


-(void)loadMoreData{
    
    _CurrentPageIndex=[NSString stringWithFormat:@"%d",[_CurrentPageIndex intValue]+1];
    [BKIndicationView showInView:self];
    __weak __typeof__ (self) wself = self;
    [self loadData:^(BOOL result, NSDictionary *data) {
        [wself.tableView.mj_footer endRefreshing];
        [wself.tableView.mj_header endRefreshing];
        if (result) {
            [wself setData:data];
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            wself.CurrentPageIndex=[NSString stringWithFormat:@"%d",[_CurrentPageIndex intValue]-1];
        }
    }];
}


#pragma mark==================loadData======================
-(void)loadData:(Compeletion)compeletion{
//    UserID    是    String    当前登录用户ID
//    UserName    是    String    当前登录用户名
//    isCurrent    是    Int    是否为当前（固定值：1）
//    ISself    是    Int    是否为自身（固定值：0）
//    BeginTime    是    String    开始时间（如：”2017/10/10 00:00:00”）
//    EndTime    是    String    结束时间（如：”2017/10/10 23:59:59”）
    
    
    MCMineInfoModel * mineInfoModel=[MCMineInfoModel sharedMCMineInfoModel];
    NSString * UserName;
    if (mineInfoModel.UserName.length>1) {
        UserName=mineInfoModel.UserName;
    }else{
        UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    }
    NSDictionary * dic=@{
                         @"UserID":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"],
                         @"UserName":UserName,
                         @"isCurrent":@"1",
                         @"ISself":@"0",
                         @"BeginTime":_statTime,
                         @"EndTime":_endTime
                         };
    
    
    MCQiPaiTeamReportModel * teamReportModel = [[MCQiPaiTeamReportModel alloc]initWithDic:dic];
    [teamReportModel refreashDataAndShow];
    self.teamReportModel = teamReportModel;
    
    teamReportModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
        compeletion(NO,nil);
        
    };
    
    teamReportModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
    
}

-(void)setData:(NSDictionary *)dic{

    _Tmodel=[MCQiPaiTeamReportDataModel mj_objectWithKeyValues:dic];
    
    if (!_Tmodel) {
        //无数据
        self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
        self.exceptionView.heightH=G_SCREENHEIGHT-64-49-40;
        [self.exceptionView showInView:self.tableView];
        self.tableView.mj_header.hidden=YES;
        return;
    }
    

    [self.tableView reloadData];
}

#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (_Tmodel) {
        return 1;
//    }
//    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
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
    return [MCQiPaiTeamReportTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCQiPaiTeamReportTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCQiPaiTeamReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCQiPaiTeamReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.dataSource=_Tmodel;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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

