//
//  MCQiPaiDailyReportCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQiPaiDailyReportCollectionViewCell.h"
#import "UIView+MCParentController.h"
#import "MCGamePersonalReportModel.h"
#import "MCNaviSelectedPopView.h"
#import <MJRefresh/MJRefresh.h>
#import "MCRecordTool.h"
#import "MCQiPaiDailyReportTableViewCell.h"
#import "MCQiPaiPersonSlideView.h"

#define MORENCOUNT 15
@interface MCQiPaiDailyReportCollectionViewCell()
<
UITableViewDelegate,
UITableViewDataSource
>


typedef void(^Compeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)ExceptionView * exceptionView;
@property(nonatomic, strong)NSMutableArray * dataMarray;
@property (nonatomic,strong) MCGamePersonalReportModel * gamePersonalReportModel;
@property (nonatomic,strong) MCGamePersonalReportDataModel * Gmodel;

@end

@implementation MCQiPaiDailyReportCollectionViewCell
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
    _dataMarray=[[NSMutableArray alloc]init];

}

-(void)refreashQiPaiPersonProperty{
    MCQiPaiPersonProperty * PersonProperty = [MCQiPaiPersonProperty sharedMCQiPaiPersonProperty];
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
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
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
    [_dataMarray removeAllObjects];
    self.tableView.mj_header.hidden=NO;
    self.tableView.mj_footer.hidden=NO;
    
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
            [wself.exceptionView showInView:self.tableView];
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
    
    NSDictionary * dic=@{
//                         @"UserID":@"-1",
                         @"UserID":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],
                         @"Type":@"1",
                         @"BeginTime":_statTime,
                         @"EndTime":_endTime,
                         @"CurrentPageIndex":_CurrentPageIndex,
                         @"CurrentPageSize":_CurrentPageSize
                         };
    
    
    MCGamePersonalReportModel * gamePersonalReportModel = [[MCGamePersonalReportModel alloc]initWithDic:dic];
    [gamePersonalReportModel refreashDataAndShow];
    self.gamePersonalReportModel = gamePersonalReportModel;
    
    gamePersonalReportModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
        compeletion(NO,nil);
        
    };
    
    gamePersonalReportModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
    
}

-(void)setData:(NSDictionary *)dic{
    
    _Gmodel=[MCGamePersonalReportDataModel mj_objectWithKeyValues:dic];
    
    if (_Gmodel.Reportlst.count<1) {
        if (_dataMarray.count<1) {
            //无数据
            self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
            self.exceptionView.heightH=G_SCREENHEIGHT-64-49-40;
            [self.exceptionView showInView:self.tableView];
            self.tableView.mj_footer.hidden=YES;
            self.tableView.mj_header.hidden=YES;
            return;
        }else{
            self.tableView.mj_footer.hidden=YES;
        }
        
    }
    
    [_dataMarray addObjectsFromArray:_Gmodel.Reportlst];
    
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
    return [MCQiPaiDailyReportTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCQiPaiDailyReportTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCQiPaiDailyReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCQiPaiDailyReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.dataSource=_dataMarray[indexPath.row];
    
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

