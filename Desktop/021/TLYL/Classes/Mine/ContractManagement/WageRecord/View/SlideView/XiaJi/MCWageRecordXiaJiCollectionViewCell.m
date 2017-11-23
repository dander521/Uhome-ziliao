//
//  MCWageRecordXiaJiCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCWageRecordXiaJiCollectionViewCell.h"
#import "MCWageRecordHeaderView.h"
#import "MCWageRecordXiaJiTableViewCell.h"
#import "MCRecordTool.h"
#import <MJRefresh/MJRefresh.h>
#import "MCGetDaywagesThreeRdRecordModel.h"

#define MORENCOUNT 15
@interface MCWageRecordXiaJiCollectionViewCell ()
<
UITableViewDelegate,
UITableViewDataSource
>

typedef void(^MCWageRecordXiaJiCompeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong) ExceptionView * exceptionView;
@property(nonatomic, strong) NSMutableArray * dataMarray;

@property (nonatomic,strong) MCGetDaywagesThreeRdRecordModel * getDaywagesThreeRdRecordModel;

@end

@implementation MCWageRecordXiaJiCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}


- (void)initView{
    
    self.backgroundColor=RGB(231,231,231);
    MCWageRecordHeaderView * headerView=[[MCWageRecordHeaderView alloc]initWithTitleArr:@[@"用户名",@"契约",@"日工资金额",@"时间"]];
    [self addSubview:headerView];
    headerView.frame=CGRectMake(0, 0, G_SCREENWIDTH, 40);
    
    [self setProperty];
    
    [self createUI];
    
    [self refreashData];
    
}


#pragma mark==================setProperty======================
-(void)setProperty{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//    NSArray * arr=[MCRecordTool GetMonthFirstAndLastDay];
//    NSString * BenMonthFirstDay =arr[0];
    _BeginTime=[NSString stringWithFormat:@"%@ 00:00:00",currentDateStr];
    _EndTime=[NSString stringWithFormat:@"%@ 23:59:59",currentDateStr];
    _CurrentPageIndex=@"1";
    _CurrentPageSize=[NSString stringWithFormat:@"%d",MORENCOUNT];
    _dataMarray=[[NSMutableArray alloc]init];
    
    _IsSelf=@"1";
    _UserID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    _User_Name=@"";
}

#pragma mark==================createUI======================
-(void)createUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.layer.cornerRadius=5;
    _tableView.clipsToBounds=YES;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreashData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10+40);
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-13);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
    }];
    
}

#pragma mark-下拉刷新
- (void)refreashDataFromSearchBar{
    
    MCDayagesRecordProperty * property = [MCDayagesRecordProperty sharedMCDayagesRecordProperty];
    _CurrentPageIndex=property.CurrentPageIndex;
    _CurrentPageSize =property.CurrentPageSize;
    _User_Name =property.User_Name;//默认传空串，当搜索用户名时传所搜用户名
    if (property.User_Name.length>0) {
        _UserID=nil;//搜索用户名时不传，其他情况传
    }
    _BeginTime=property.BeginTime;
    _EndTime=property.EndTime;
    
    [self refreashData];
}
#pragma mark-下拉刷新
- (void)refreashData{
    
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    [_dataMarray removeAllObjects];
    
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
            wself.exceptionView.heightH=G_SCREENHEIGHT-64-49-10-40;
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
-(void)loadData:(MCWageRecordXiaJiCompeletion)compeletion{
    NSDictionary * dic;
    
    if (_User_Name.length>0) {
        dic=@{
              @"IsSelf":_IsSelf,
              @"User_Name":_User_Name,
              @"BeginTime":_BeginTime,
              @"EndTime":_EndTime,
              @"CurrentPageIndex":_CurrentPageIndex,
              @"CurrentPageSize":_CurrentPageSize
              };
    }else{
        dic=@{
              @"IsSelf":_IsSelf,
              @"UserID":_UserID,
              @"BeginTime":_BeginTime,
              @"EndTime":_EndTime,
              @"CurrentPageIndex":_CurrentPageIndex,
              @"CurrentPageSize":_CurrentPageSize
              };
    }
    
    
    MCGetDaywagesThreeRdRecordModel * getDaywagesThreeRdRecordModel = [[MCGetDaywagesThreeRdRecordModel alloc]initWithDic:dic];
    [getDaywagesThreeRdRecordModel refreashDataAndShow];
    self.getDaywagesThreeRdRecordModel = getDaywagesThreeRdRecordModel;
    
    getDaywagesThreeRdRecordModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
        compeletion(NO,nil);
        
    };
    
    getDaywagesThreeRdRecordModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
    
}

-(void)setData:(NSDictionary *)dic{
    
    MCGetDaywagesThreeRdRecordDataModel * Gmodel=[MCGetDaywagesThreeRdRecordDataModel mj_objectWithKeyValues:dic];
    
    if (Gmodel.GetWayWagesList.count<1) {
        if (_dataMarray.count<1) {
            //无数据
            self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
            self.exceptionView.heightH=G_SCREENHEIGHT-64-49-10-40;
            [self.exceptionView showInView:self.tableView];
            self.tableView.mj_footer.hidden=YES;
            self.tableView.mj_header.hidden=YES;
            return;
        }else{
            self.tableView.mj_footer.hidden=YES;
        }
        
    }
    
    [_dataMarray addObjectsFromArray:Gmodel.GetWayWagesList];
    
    if (_dataMarray.count%MORENCOUNT!=0) {
        self.tableView.mj_footer.hidden=YES;
    }
    [self.tableView reloadData];
}

#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataMarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MCWageRecordXiaJiTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCWageRecordXiaJiTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCWageRecordXiaJiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCWageRecordXiaJiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.dataSource=_dataMarray[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCGetDaywagesThreeRdRecordDetailDataModel * model=_dataMarray[indexPath.row];
    MCPopAlertView * popView=[[MCPopAlertView alloc ]initWithType:MCPopAlertTypeContractMgt_DayWageDeatil Title:[NSString stringWithFormat:@"%@日工资详情",model.User_Name] leftBtn:@"我知道了" rightBtn:nil DaywagesThreeRdRecordDetailDataModel:model];
    [popView showXLAlertView];
    popView.resultIndex = ^(NSInteger index){
        if (index==1) {
            
        }
    };
    
}


@end

















