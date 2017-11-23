//
//  MCPeiEFrtViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPeiEFrtViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "MCPeiHuFirTableViewCell.h"
#import "MCPeiEFModel.h"
#import "MCSecPeiEViewController.h"

@interface MCPeiEFrtViewController ()<UITableViewDelegate,UITableViewDataSource>

/**tableView*/
@property (nonatomic,  weak) UITableView *tableView;
/**tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewDataArray;
/**firModel*/
@property (nonatomic,strong) MCPeiEFModel *firModel;

@end

@implementation MCPeiEFrtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"代理配额";
    [self setUpUI];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDataAndShow];
}

- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, MC_REALVALUE(40))];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"序号",@"返点",@"人数限制",@"已注册人数"];
    for (NSInteger i = 0; i<titleArr.count; i++) {
        UILabel *lable = [[UILabel alloc] init];
        [topView addSubview:lable];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = titleArr[i];
        if (i==0) {
            lable.frame = CGRectMake(MC_REALVALUE(20), 0, MC_REALVALUE(50), MC_REALVALUE(40));
        } else if(i==1){
            lable.frame = CGRectMake(MC_REALVALUE(70), 0, MC_REALVALUE(94), MC_REALVALUE(40));
        }else if(i==2){
            lable.frame = CGRectMake(MC_REALVALUE(164), 0, MC_REALVALUE(100), MC_REALVALUE(40));
        }else if(i==3){
            lable.frame = CGRectMake(MC_REALVALUE(267), 0,G_SCREENWIDTH - MC_REALVALUE(267), MC_REALVALUE(40));
        }
        lable.textColor =RGB(46, 46, 46);
        lable.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        lable.textAlignment = NSTextAlignmentCenter;
    }
    
    for (NSInteger i = 0; i<titleArr.count -1; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake((i+1)*G_SCREENWIDTH*0.25, 40/4, 1, MC_REALVALUE(30))];
        [topView addSubview:lable];
        lable.backgroundColor =[RGB(212, 212, 212) colorWithAlphaComponent:0.5];
        
        
    }
    //    /**tabView 创建*/
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(13, MC_REALVALUE(50) + 64, G_SCREENWIDTH-26, G_SCREENHEIGHT - 64 - 50 -10) style:UITableViewStylePlain];
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
    [self.tableView registerClass:[MCPeiHuFirTableViewCell class] forCellReuseIdentifier:@"MCPeiHuFirTableViewCell"];
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
    [self.tableViewDataArray removeAllObjects];
    MCPeiEFModel *firModel = [[MCPeiEFModel alloc] init];
    self.firModel = firModel;
    __weak typeof(self)weakSelf = self;
    firModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        [weakSelf tableViewEndRefreshing];
      NSArray *arr = [MCPeiEFModel mj_objectArrayWithKeyValuesArray:manager.ResponseRawData];
        for (MCPeiEFModel *model in arr) {
            if (model.Rebate >= 1950) {
                if (![weakSelf.tableViewDataArray containsObject:model]) {
                    [weakSelf.tableViewDataArray addObject:model];
                }
            }
        }
       
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
    MCPeiHuFirTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCPeiHuFirTableViewCell"];
    cell.dataSource = self.tableViewDataArray[indexPath.row];
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    MCSecPeiEViewController *secVC = [[MCSecPeiEViewController alloc] init];
    MCPeiEFModel *peieModel = self.tableViewDataArray[indexPath.row];
    secVC.Rebate = peieModel.Rebate;
    [self.navigationController pushViewController:secVC animated:YES];
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
