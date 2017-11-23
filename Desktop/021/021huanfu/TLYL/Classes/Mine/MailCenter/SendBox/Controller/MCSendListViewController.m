//
//  MCSendListViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSendListViewController.h"
#import "MCKefuViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "MCInBoxTableViewCell.h"
#import "MCSendListModel.h"
#import "MCInBoxDetailViewController.h"
#import "MCSendDetailViewController.h"

@interface MCSendListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *tableViewDataArray;

@property (nonatomic,strong) MCSendListModel *listModel;

@property (nonatomic,assign) int currentPageIndex;

@end

@implementation MCSendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发件箱";
    self.view.backgroundColor = RGB(231, 231, 231);
    [self addNavRightBtn];
    [self setUpUI];
    [self configRequstNormalParmas];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadListData];
    
}
- (void)loadData{
    [super loadData];
    [self loadListData];
}
#pragma mark -- set UI
- (void)addNavRightBtn {
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"客服" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(18)];
    [btn sizeToFit];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)allBtnClick{
    MCKefuViewController *kefu = [[MCKefuViewController alloc] init];
    //    [self presentViewController:kefu animated:YES completion:nil];
    [self.navigationController pushViewController:kefu animated:YES];
}

#pragma mark - configRequstNormalParmas
- (void)configRequstNormalParmas{
    self.currentPageIndex = 1;
    
}
#pragma mark --发送请求
-(void)loadListData{
    
    __weak typeof(self) weakself = self;
    MCSendListModel *listModel = [[MCSendListModel alloc] init];
    self.listModel = listModel;
    listModel.UserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    listModel.CurrentPageSize = 15;
    listModel.CurrentPageIndex = 1;
    [listModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    listModel.callBackSuccessBlock = ^(NSDictionary *manager) {
        [weakself tableViewEndRefreshing];
        [BKIndicationView dismiss];
        if ([manager.allKeys containsObject:@"EmailSendBoxs"]) {
            weakself.tableViewDataArray = [MCSendListModel mj_objectArrayWithKeyValuesArray:manager[@"EmailSendBoxs"]];
        }
        if (weakself.tableViewDataArray.count == 0) {
            [weakself showExDataView];
        }else{
            [weakself hiddenExDataView];
        }
        if (weakself.tableViewDataArray.count==[manager[@"DataCount"] integerValue]) {
            weakself.tableView.mj_footer.hidden=YES;
        }
        if (MC_REALVALUE(65) *weakself.tableViewDataArray.count <= G_SCREENHEIGHT - 26 -64 -49) {
            weakself.tableView.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(65) *weakself.tableViewDataArray.count );
        }
        [weakself.tableView reloadData];
    };
    listModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
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
    self.listModel.CurrentPageIndex = ++self.currentPageIndex;
    __weak typeof(self) weakSelf = self;
    self.listModel.callBackSuccessBlock = ^(id manager) {
        [weakSelf tableViewEndRefreshing];
        NSArray *arr = [MCSendListModel mj_objectArrayWithKeyValuesArray:manager[@"EmailReceiveBoxs"]];
        [weakSelf.tableViewDataArray addObjectsFromArray:arr];
        if (weakSelf.tableViewDataArray.count == 0) {
            [weakSelf showExDataView];
        }
        if (MC_REALVALUE(65) *weakSelf.tableViewDataArray.count <= G_SCREENHEIGHT - 26 -64 -49) {
            weakSelf.tableView.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(65) *weakSelf.tableViewDataArray.count );
        }
        [weakSelf.tableView reloadData];
        [weakSelf tableViewEndRefreshing];
        if (weakSelf.tableViewDataArray.count==[manager[@"DataCount"] integerValue]) {
            weakSelf.tableView.mj_footer.hidden=YES;
        }
    };
    self.listModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf tableViewEndRefreshing];
    };
    [BKIndicationView showInView:self.view];
    [self.listModel refreashDataAndShow];
}
- (void)tableViewEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

-(void)setUpUI{
    //    self.view
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT  - MC_REALVALUE(26)-49 - 64) style:UITableViewStylePlain];
    [self.view addSubview:tab];
    tab.backgroundColor = RGB(231, 231, 231);
    self.tableView = tab;
    self.tableView.separatorColor = RGB(213, 213, 213);
    __weak typeof(self) weakself = self;
    tab.layer.cornerRadius = 6;
    tab.clipsToBounds = YES;
    [tab registerClass:[MCInBoxTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadListData];
    }];
    
    self.tableView.rowHeight = MC_REALVALUE(65);
    tab.delegate = self;
    tab.dataSource = self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCInBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.dataSourceSend = self.tableViewDataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCSendListModel *model = self.tableViewDataArray[indexPath.row];
    MCSendDetailViewController *vc = [[MCSendDetailViewController alloc] init];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSMutableArray *)tableViewDataArray{
    if (_tableViewDataArray == nil) {
        _tableViewDataArray = [NSMutableArray array];
        
    }
    return _tableViewDataArray;
}
@end

