//
//  MCQiPaiXiaJiReportCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQiPaiXiaJiReportCollectionViewCell.h"
#import "UIView+MCParentController.h"
#import "MCNaviSelectedPopView.h"
#import <MJRefresh/MJRefresh.h>
#import "MCSignalPickView.h"
#import "MCRecordTool.h"
#import "MCDatePickerView.h"
#import "MCQiPaiXiaJiReportTableViewCell.h"
#import "MCQiPaiXiaJiReportModel.h"
#import "MCQiPaiTeamSlideView.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCQiPaiXiaJiNameCollectionViewCell.h"
#import "MCMineCellModel.h"

#define MORENCOUNT 15
@interface MCQiPaiXiaJiReportCollectionViewCell()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource
>

typedef void(^Compeletion)(BOOL result, NSDictionary *data );

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)ExceptionView * exceptionView;
@property(nonatomic, strong)NSMutableArray * dataMarray;

@property(nonatomic, strong) NSString * statTime;
@property(nonatomic, strong) NSString * endTime;
@property(nonatomic, strong) NSString * CurrentPageIndex;
@property(nonatomic, strong) NSString * CurrentPageSize    ;
@property(nonatomic, assign) BOOL IsHistory;
@property(nonatomic, strong) NSString * GetUserType;//下级类型（0：全部，1：会员，2：代理）
@property(nonatomic, strong) NSString * UserName;//默认传空串，当搜索用户名时传所搜用户名
@property(nonatomic, strong) NSString * User_ID;

@property (nonatomic,strong) MCQiPaiXiaJiReportModel * xiaJiReportModel;
@property (nonatomic,strong) MCQiPaiXiaJiReportDataModel * Xmodel;

@property(nonatomic,strong)UICollectionView * firstCollectionView;
@property(nonatomic, strong)NSMutableArray  *  collectionMarry;

@end

@implementation MCQiPaiXiaJiReportCollectionViewCell
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
    _collectionMarry = [[NSMutableArray alloc]init];

    NSString * UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    [_collectionMarry addObject:[NSString stringWithFormat:@"%@ >",UserName]];
    _User_ID =[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];

}

-(void)setCollectionViewMarry{
    
}

-(void)refreashQiPaiPersonProperty{
    MCQiPaiTeamProperty * TeamProperty = [MCQiPaiTeamProperty sharedMCQiPaiTeamProperty];
    self.statTime=TeamProperty.statTime;
    self.endTime=TeamProperty.endTime;
    self.CurrentPageIndex=TeamProperty.CurrentPageIndex;
    self.CurrentPageSize=TeamProperty.CurrentPageSize;
    self.UserName=TeamProperty.UserName;
    self.GetUserType=TeamProperty.GetUserType;
}

#pragma mark==================createUI======================
-(void)createUI{
    UIView * upView = [[UIView alloc]init];
    upView.backgroundColor=RGB(249,249,249);
    [self addSubview:upView];
    [upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView * logoImgV = [[UIImageView alloc]init];
    [upView addSubview:logoImgV];
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(self.mas_left).offset(18);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    logoImgV.image=[UIImage imageNamed:@"qygl-gzjl-xz"];
    
    
    [upView addSubview:self.firstCollectionView];
    [self.firstCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView.mas_top).offset(0);
        make.left.equalTo(upView.mas_left).offset(40);
        make.right.equalTo(upView.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    
    
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
        make.top.equalTo(self.mas_top).offset(50);
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
    [self.exceptionView dismiss];
    self.exceptionView = nil;
    [BKIndicationView showInView:self];
    __weak __typeof__ (self) wself = self;
    
    [self loadData:^(BOOL result, NSDictionary *data) {
        [wself.tableView.mj_footer endRefreshing];
        [wself.tableView.mj_header endRefreshing];
        if (result) {
            
            [wself setData:data];
            
        }else{
            wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
            wself.exceptionView.heightH=G_SCREENHEIGHT-64-49-40-50;
            ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                [wself.exceptionView dismiss];
                wself.exceptionView = nil;
                [wself refreashData];
            }];
            [wself.exceptionView addAction:action];
            [wself.exceptionView showInView:self];
        }
    }];
    
}


-(void)loadMoreData{
    [self.exceptionView dismiss];
    self.exceptionView = nil;
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
    
//    User_ID    是    String    当前登录用户ID
//    UserName    是    String    默认传空串，当搜索用户名时传所搜用户名
//    GetUserType    是    Int    下级类型（0：全部，1：会员，2：代理）
//    BeginTime    是    String    开始时间（如：”2017/10/10 00:00:00”）
//    EndTime    是    String    结束时间（如：”2017/10/10 23:59:59”）
//    CurrentPageIndex    是    Int    当前页下标（第一页为1，后续所有页码依次加1）
//    CurrentPageSize    是    Int    当前页请求条目数
    NSDictionary *  dic =@{
               @"User_ID":_User_ID,
               //                         @"User_ID":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"],
               @"subUserName":_UserName,
               @"GetUserType":_GetUserType,
               @"BeginTime":_statTime,
               @"EndTime":_endTime,
               @"CurrentPageIndex":_CurrentPageIndex,
               @"CurrentPageSize":_CurrentPageSize
               };
    

    MCQiPaiXiaJiReportModel * xiaJiReportModel = [[MCQiPaiXiaJiReportModel alloc]initWithDic:dic];
    [xiaJiReportModel refreashDataAndShow];
    self.xiaJiReportModel = xiaJiReportModel;
    
    xiaJiReportModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
        compeletion(NO,nil);
        
    };
    
    xiaJiReportModel.callBackSuccessBlock = ^(id manager) {
        
        compeletion(YES,manager);
        
    };
    
}

-(void)setData:(NSDictionary *)dic{
    
    _Xmodel=[MCQiPaiXiaJiReportDataModel mj_objectWithKeyValues:dic];
    
    if (_Xmodel.ReportComm.count<1) {
        if (_dataMarray.count<1) {
            //无数据
            self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
            self.exceptionView.heightH=G_SCREENHEIGHT-64-49-40-50;
            [self.exceptionView showInView:self.tableView];
            self.tableView.mj_header.hidden=YES;
            self.tableView.mj_footer.hidden=YES;
            return;
        }else{
            self.tableView.mj_footer.hidden=YES;
        }
        
    }
    
    [_dataMarray addObjectsFromArray:_Xmodel.ReportComm];

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
    return [MCQiPaiXiaJiReportTableViewCell computeHeight:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier =[NSString stringWithFormat:@"MCQiPaiXiaJiReportTableViewCell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    MCQiPaiXiaJiReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MCQiPaiXiaJiReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.dataSource=_dataMarray[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCQiPaiXiaJiReportCommModel * model = _dataMarray[indexPath.row];
    
    if ([model.ChildNum integerValue]<1) {
//        [SVProgressHUD showInfoWithStatus:@"暂无下级！"];
        return;
    }

    _User_ID = model.UserID;
    if (_User_ID.length<1) {
        _User_ID =[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    }
    
    self.CurrentPageIndex=@"1";
    
    
    [self refreashData];
    
    [_collectionMarry addObject:[NSString stringWithFormat:@"%@ >",model.UserName]];
    [self.firstCollectionView reloadData];
    
    
}


//第一个开奖期号
-(UICollectionView *)firstCollectionView{
    if (!_firstCollectionView) {
        
        //创建一个layout布局类
        MCCollectionViewFlowLayout * layout = [[MCCollectionViewFlowLayout alloc]init];
        //设置布局方向为横向流布局
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _firstCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _firstCollectionView.backgroundColor=[UIColor clearColor];
        _firstCollectionView.dataSource=self;
        _firstCollectionView.delegate=self;
        [_firstCollectionView registerClass:[MCQiPaiXiaJiNameCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCQiPaiXiaJiNameCollectionViewCell class])];
        
    }
    return _firstCollectionView;
}



#pragma mark - <UICollectionViewDataSource>
// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        return nil ;
    }
    return nil ;
}

//设置section的颜色
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{
    return [UIColor clearColor];
}
//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_collectionMarry.count>0) {
        NSString * aString = _collectionMarry[indexPath.row];
        CGFloat width=[aString boundingRectWithSize:CGSizeMake(1000, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.width +10;
        return CGSizeMake(width, 40);
    }
    return CGSizeMake(0, 0);
}
//设置section的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// 两个cell之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
    
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.collectionMarry.count>0) {
        return self.collectionMarry.count;
    }
    return 0;
}

//numberOfSections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


//UICollectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MCQiPaiXiaJiNameCollectionViewCell*  cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MCQiPaiXiaJiNameCollectionViewCell class]) forIndexPath:indexPath];
    if (_collectionMarry.count>0) {
        cell.dataSource=_collectionMarry[indexPath.row];
    }
    return cell;
   
}
#pragma mark-didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.row+1)==self.collectionMarry.count) {
        return;
    }
    NSString * name=self.collectionMarry[indexPath.row];
    name=[name stringByReplacingOccurrencesOfString:@" " withString:@""];
    name=[name stringByReplacingOccurrencesOfString:@">" withString:@""];
//    NSString * UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    _User_ID = @"";
    for (MCQiPaiXiaJiReportCommModel * model in _Xmodel.ReportComm) {
        if ([model.UserName isEqualToString:name]) {
            _User_ID = model.UserID;
        }
    }
    if (_User_ID.length<1) {
        _User_ID =[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    }

    [self refreashData];
    
    NSInteger t = _collectionMarry.count - indexPath.row -1;
    if (t>0) {
        for (NSInteger i =0 ; i < t; i++) {
            [_collectionMarry removeLastObject];
        }
    }
    [self.firstCollectionView reloadData];
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

