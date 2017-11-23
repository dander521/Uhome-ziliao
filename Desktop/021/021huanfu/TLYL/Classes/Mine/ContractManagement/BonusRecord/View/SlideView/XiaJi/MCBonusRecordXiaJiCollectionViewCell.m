//
//  MCBonusRecordXiaJiCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBonusRecordXiaJiCollectionViewCell.h"
#import "MCWageRecordHeaderView.h"
#import "MCBonusRecordXiaJiTableViewCell.h"
#import "MCRecordTool.h"
#import <MJRefresh/MJRefresh.h>
#import "MCGetDividentsListModel.h"

#define MORENCOUNT 15
@interface MCBonusRecordXiaJiCollectionViewCell ()
<
UITableViewDelegate,
UITableViewDataSource
>

typedef void(^MCBonusRecordXiaJiCompeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong) ExceptionView * exceptionView;
@property(nonatomic, strong) NSMutableArray * dataMarray;

@property (nonatomic,strong) MCGetDividentsListModel * getDividentsListModel;

@end

@implementation MCBonusRecordXiaJiCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}


- (void)initView{
    
    self.backgroundColor=RGB(231,231,231);
    MCWageRecordHeaderView * headerView=[[MCWageRecordHeaderView alloc]initWithTitleArr:@[@"用户名",@"比例",@"分红金额",@"时间"]];
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
    NSArray * arr=[MCRecordTool GetMonthFirstAndLastDay];
    NSString * BenMonthFirstDay =arr[0];
    _BeginTime=[NSString stringWithFormat:@"%@ 00:00:00",BenMonthFirstDay];
    _EndTime=[NSString stringWithFormat:@"%@ 23:59:59",currentDateStr];
    _CurrentPageIndex=@"1";
    _CurrentPageSize=[NSString stringWithFormat:@"%d",MORENCOUNT];
    _dataMarray=[[NSMutableArray alloc]init];
    
    _IsSelf=@"1";
    _UserID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    _UserName=@"";
    
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
    MCBonusRecordProperty * property = [MCBonusRecordProperty sharedMCBonusRecordProperty];
    _CurrentPageIndex=property.CurrentPageIndex;
    _CurrentPageSize =property.CurrentPageSize;
    _UserName =property.UserName;//默认传空串，当搜索用户名时传所搜用户名
//    if (property.UserName.length>0) {
//        _UserID=nil;//搜索用户名时不传，其他情况传
//    }
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
-(void)loadData:(MCBonusRecordXiaJiCompeletion)compeletion{
    
    NSDictionary * dic;
    if (_UserName.length>0) {
        dic=@{
              @"IsSelf":_IsSelf,
              @"subUserName":_UserName,
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
    
    MCGetDividentsListModel * getDividentsListModel = [[MCGetDividentsListModel alloc]initWithDic:dic];
    [getDividentsListModel refreashDataAndShow];
    self.getDividentsListModel = getDividentsListModel;
    
    getDividentsListModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
        compeletion(NO,nil);
        
    };
    
    getDividentsListModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
    
}

-(void)setData:(NSDictionary *)dic{

    MCGetDividentsListDataModel  * Gmodel=[MCGetDividentsListDataModel mj_objectWithKeyValues:dic];
    
    if (Gmodel.DividentsDetailAllList.count<1) {
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
    
    [_dataMarray addObjectsFromArray:Gmodel.DividentsDetailAllList];
    
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
    return [MCBonusRecordXiaJiTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCBonusRecordXiaJiTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCBonusRecordXiaJiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCBonusRecordXiaJiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.dataSource=_dataMarray[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCGetDividentsListDeatailDataModel * model=_dataMarray[indexPath.row];
    MCPopAlertView * popView=[[MCPopAlertView alloc ]initWithType:MCPopAlertTypeContractMgt_BonusRecordDeatil Title:[NSString stringWithFormat:@"%@分红记录",model.UserName] leftBtn:@"我知道了" rightBtn:nil MCGetDividentsListDeatailDataModel:model];
    [popView showXLAlertView];
    popView.resultIndex = ^(NSInteger index){
        if (index==1) {

        }
    };

}


@end


