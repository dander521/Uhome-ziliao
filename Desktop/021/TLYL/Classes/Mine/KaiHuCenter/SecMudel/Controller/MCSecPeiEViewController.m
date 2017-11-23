//
//  MCSecPeiEViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSecPeiEViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "MCPeiHuFirTableViewCell.h"
#import "MCPeiESubTableViewCell.h"
#import "MCPeiEDModel.h"

@interface MCSecPeiEViewController ()<UITableViewDelegate,UITableViewDataSource>
/**充值tableView*/
@property (nonatomic,  weak) UITableView *tableView;
/**充值tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewDataArray;

@property (nonatomic,strong) MCPeiEDModel *firModel;

@end

@implementation MCSecPeiEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    self.navigationItem.title = @"代理配额";
    [self loadDataAndShow];
}


- (void)setUpUI{
    //    /**tabView 创建*/
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), 64 + MC_REALVALUE(13), G_SCREENWIDTH-MC_REALVALUE(26), G_SCREENHEIGHT - 64-MC_REALVALUE(26)) style:UITableViewStylePlain];
    [self.view addSubview:tab];
    tab.delegate = self;
    tab.dataSource = self;
    self.tableView = tab;
    self.tableView.layer.cornerRadius = 6;
    self.tableView.clipsToBounds = YES;
    self.tableView.rowHeight = MC_REALVALUE(50);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    self.tableView.contentOffset = CGPointMake(0, 40);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MCPeiESubTableViewCell class] forCellReuseIdentifier:@"MCPeiESubTableViewCell"];
    __weak typeof(self) weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadDataAndShow];
    }];
    self.view.backgroundColor = RGB(231, 231, 231);
}

- (void)loadData{
    [super loadData];
    [self loadDataAndShow];
}
- (void)loadDataAndShow{
    
    MCPeiEDModel *firModel = [[MCPeiEDModel alloc] init];
    firModel.Rebate = self.Rebate;
    self.firModel = firModel;
    __weak typeof(self)weakSelf = self;
    firModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        [weakSelf tableViewEndRefreshing];
        weakSelf.tableViewDataArray = manager.ResponseRawData[@"UserName"];
        if (weakSelf.tableViewDataArray.count == 0) {
            [weakSelf showExDataView];
        }else{
            [weakSelf hiddenExDataView];
        }
        [weakSelf.tableView reloadData];
    };
    
    self.firModel.callBackFailedBlock = ^(id manager, NSDictionary *errorCode) {
        [weakSelf tableViewEndRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [weakSelf.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [weakSelf.errNetWin setHidden:NO];
                
            } else {
                [weakSelf.errDataWin setHidden:NO];
            }
        }
    };
    [BKIndicationView showInView:self.view];
    [self.firModel refreashDataAndShow];
}


- (void)tableViewEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCPeiESubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCPeiESubTableViewCell"];
    cell.dataSource = self.tableViewDataArray[indexPath.row];
    cell.numLabeF.text = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
    return cell;
}



#pragma mark -- setter and getter
- (NSMutableArray *)tableViewDataArray{
    if (_tableViewDataArray == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _tableViewDataArray = arr;
    }
    return _tableViewDataArray;
}
@end
