//
//  MCChaKanPersonViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCChaKanPersonViewController.h"
#import "MCEmailReceiverModel.h"
#import "MCGetPersonNameTableViewCell.h"
#import <MJRefresh/MJRefresh.h>

@interface MCChaKanPersonViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) MCEmailReceiverModel *receiverModel;
@property (nonatomic,assign) int CurrentPageIndex;

@end

@implementation MCChaKanPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"所有收件人";
    self.view.backgroundColor =RGB(231, 231, 231);
    [self setUpUI];
    self.CurrentPageIndex = 1;
    [self loadListData];
}
- (void)loadData{
    [super loadData];
    [self loadListData];
}
- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT - 64 - MC_REALVALUE(26)) style:UITableViewStyleGrouped];
    [self.view addSubview:tab];
    tab.dataSource = self;
    tab.delegate = self;
    [tab registerClass:[MCGetPersonNameTableViewCell class] forCellReuseIdentifier:@"cell"];
    tab.layer.cornerRadius = 6;
    tab.clipsToBounds = YES;
    tab.sectionIndexColor = RGB(67, 67, 67);
    self.tableView = tab;
    tab.rowHeight = MC_REALVALUE(50);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadListData];
    }];
}

#pragma mark --发送请求
-(void)loadListData{
    
    __weak typeof(self) weakself = self;
    MCEmailReceiverModel *receiverModel = [[MCEmailReceiverModel alloc] init];
    self.receiverModel = receiverModel;
    receiverModel.Sendid = self.Sendid;
    receiverModel.CurrentPageSize = 15;
    receiverModel.CurrentPageIndex = 1;
    [receiverModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    receiverModel.callBackSuccessBlock = ^(NSDictionary *manager) {
        [weakself tableViewEndRefreshing];
        [BKIndicationView dismiss];
        
        weakself.dataArray = [MCEmailReceiverModel mj_objectArrayWithKeyValuesArray:manager[@"StationEmailReceiveBoxs"]];
       
        if (weakself.dataArray.count == 0) {
            [weakself showExDataView];
        }else{
            [weakself hiddenExDataView];
        }
        if (weakself.dataArray.count==[manager[@"DataCount"] integerValue]) {
            weakself.tableView.mj_footer.hidden=YES;
        }
        if (MC_REALVALUE(65) *weakself.dataArray.count <= G_SCREENHEIGHT - 26 -64 -49) {
            weakself.tableView.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(65) *weakself.dataArray.count );
        }
        [weakself.tableView reloadData];
    };
    receiverModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [BKIndicationView dismiss];
        [weakself tableViewEndRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [weakself.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [weakself.errNetWin setHidden:NO];
            }
        } else {
            [weakself.errDataWin setHidden:NO];
        }
        
        [SVProgressHUD dismiss];
    };
    
}



- (void)loadMoreData{
    
    self.tableView.mj_footer.hidden=NO;
    self.receiverModel.CurrentPageIndex = ++self.CurrentPageIndex;
    __weak typeof(self) weakSelf = self;
    self.receiverModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf tableViewEndRefreshing];
        NSArray *arr = [MCEmailReceiverModel mj_objectArrayWithKeyValuesArray:manager[@"StationEmailReceiveBoxs"]];
        [weakSelf.dataArray addObjectsFromArray:arr];
        if (weakSelf.dataArray.count == 0) {
            [weakSelf showExDataView];
        }
        
        [weakSelf.tableView reloadData];
        [weakSelf tableViewEndRefreshing];
        if (weakSelf.dataArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tableView.mj_footer.hidden=YES;
        }
    };
    
    self.receiverModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf tableViewEndRefreshing];
    };
    [BKIndicationView showInView:self.view];
    [self.receiverModel refreashDataAndShow];
}
- (void)tableViewEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return MC_REALVALUE(50);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *titleL = [[UILabel alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    titleL.text = @"收件人";
    [view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(MC_REALVALUE(20));
        make.height.equalTo(@(MC_REALVALUE(50)));
        make.centerY.equalTo(view);
    }];
    titleL.textColor = RGB(46, 46, 46);
    titleL.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.backgroundColor = [UIColor whiteColor];
    UILabel *statusL = [[UILabel alloc] init];
    statusL.text = @"消息状态";
    statusL.backgroundColor = [UIColor whiteColor];
    [view addSubview:statusL];
    [statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(MC_REALVALUE(-20));
        make.height.equalTo(@(MC_REALVALUE(50)));
        make.centerY.equalTo(view);
    }];
    statusL.textColor = RGB(46, 46, 46);
    statusL.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    statusL.textAlignment = NSTextAlignmentRight;
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCGetPersonNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.dataSource = self.dataArray[indexPath.row];
    return cell;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _dataArray = arr;
    }
    return _dataArray;
    
}
@end
