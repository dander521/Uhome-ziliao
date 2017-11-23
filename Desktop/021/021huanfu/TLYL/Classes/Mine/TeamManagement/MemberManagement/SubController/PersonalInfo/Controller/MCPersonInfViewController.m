//
//  MCPersonInfViewController.m
//  TLYL
//
//  Created by miaocai on 2017/10/23.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPersonInfViewController.h"
#import "MCPIRefreshNormalHeader.h"
#import <MJRefresh/MJRefresh.h>
#import"MCPITopView.h"
#import "MCPISubTableViewCell.h"
#import "MCUrStatusModel.h"
#import "MCUserDefinedAPIModel.h"
#import "MCNaviButton.h"
#import "MCModifySubTypeModel.h"

@interface MCPersonInfViewController ()<UITableViewDelegate,UITableViewDataSource>
/**数据源tableViewDataArray*/
@property (nonatomic,strong) NSMutableArray *tableViewDataArray;
@property(nonatomic,weak) UITableView *subTableView;
@property(nonatomic,weak) MCPITopView *topView;
@property (nonatomic,strong) MCUrStatusModel *urStModel;
@property (nonatomic,strong) MCUserDefinedAPIModel *ufmodel;
@property (nonatomic,strong) MCModifySubTypeModel *subTypemodel;
@end

@implementation MCPersonInfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    [self setUpUI];
    self.view.backgroundColor = RGB(231, 231, 231);
    [self loadListData];
    if ((self.dataSource.Category&64)==64) {
        [self addNavRightBtn];
    }
  
    
}

- (void)addNavRightBtn {
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"转为代理" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)allBtnClick{
    MCModifySubTypeModel *subTypemodel = [[MCModifySubTypeModel alloc] init];
    self.subTypemodel = subTypemodel;
    subTypemodel.subUserID = self.dataSource.UserID;
    subTypemodel.Type = 1;
    [subTypemodel refreashDataAndShow];
    subTypemodel.callBackSuccessBlock = ^(id manager) {
        [SVProgressHUD showInfoWithStatus:@"修改成功"];
    };
    
}
-(void)setUpUI{
  
   
    UITableView *tab1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:tab1];
    tab1.backgroundColor = RGB(231, 231, 231);
    tab1.contentInset = UIEdgeInsetsMake(MC_REALVALUE(96+13), 0, 0, 0);
    self.subTableView = tab1;
    self.subTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakself = self;
    [tab1 registerClass:[MCPISubTableViewCell class] forCellReuseIdentifier:@"subcell"];
   
    self.subTableView.mj_header = [MCPIRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadListData];
    }];
    self.subTableView.rowHeight = MC_REALVALUE(133);
    tab1.delegate = self;
    tab1.dataSource = self;
    MCPITopView *topView = [[MCPITopView alloc] initWithFrame:CGRectMake(0, -MC_REALVALUE(96), G_SCREENWIDTH, MC_REALVALUE(96 + 13))];
    [tab1 addSubview:topView];
    topView.userName = self.dataSource.UserName;
    self.topView = topView;
}
-(void)loadData{
    [super loadData];
    [self loadListData];
}

#pragma mark --发送请求
-(void)loadListData{
    
    __weak typeof(self) weakself = self;
    MCUrStatusModel *urStModel = [[MCUrStatusModel alloc] init];
    self.urStModel = urStModel;
    self.urStModel.UserIDList = @[[NSNumber numberWithInt:self.dataSource.UserID]];
    [urStModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    urStModel.callBackSuccessBlock = ^(id manager) {
        [weakself tableViewEndRefreshing];
        [SVProgressHUD dismiss];
        weakself.topView.dataSource =[MCUrStatusModel mj_objectWithKeyValues:manager[@"UserLoginStateList"][0][@"IOS"]];
        if (weakself.tableViewDataArray.count == 0) {
            [weakself showExDataView];
        }else{
            [weakself hiddenExDataView];
        }
        [weakself.subTableView reloadData];
    };
    urStModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [weakself tableViewEndRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [self.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [self.errNetWin setHidden:NO];
            }
        } else {
            [self.errDataWin setHidden:NO];
        }
        
     
    };
    
    [self.tableViewDataArray removeAllObjects];
    MCUserDefinedAPIModel *ufModel = [[MCUserDefinedAPIModel alloc] init];
    [ufModel refreashDataAndShow];
    ufModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        [weakself tableViewEndRefreshing];
        [SVProgressHUD dismiss];
        NSArray *arr = manager.ResponseRawData;
        for (NSDictionary *model in arr) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:model];
          NSNumber *max =  [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMaxRebate];
          NSNumber *min =  [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMinRebate];
//            “我的最大返奖”：
            int vol1 = [max intValue] - ([model[@"BetRebate"] intValue] - [model[@"MaxRebate"]intValue] );
            int mm = (vol1>=[min intValue])?vol1:[min intValue];
//            “下级的最大返奖”：
            int val_1 = weakself.dataSource.Rebate - - ([model[@"BetRebate"]intValue]  - [model[@"MaxRebate"]intValue] );//下级用户返点 - (商户最大返点 - 当前彩种的最大返点)；
            int mm1 = (val_1>=[min intValue])?val_1:[min intValue];
            if ([model[@"SaleState"]intValue] == 1) {
                [dic setValue:@(mm) forKey:@"MaxRebate"];
                [dic setValue:@(mm1) forKey:@"BetRebate"];
                [weakself.tableViewDataArray addObject:dic];
            }
        }
        if (weakself.tableViewDataArray.count == 0) {
            [weakself showExDataView];
        }else{
            [weakself hiddenExDataView];
        }
        [weakself.subTableView reloadData];
    };
    
    ufModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [weakself tableViewEndRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {
                [self.errDataWin setHidden:NO];
            } else if (err.code == -1009){
                [self.errNetWin setHidden:NO];
            }
        } else {
            [self.errDataWin setHidden:NO];
        }
        
        [SVProgressHUD dismiss];
    };
}

- (void)tableViewEndRefreshing{
    
    [self.subTableView.mj_footer endRefreshing];
    [self.subTableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.tableViewDataArray.count;

   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   MCPISubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subcell"];
    cell.name = self.dataSource.UserName;
    cell.rebateId = self.dataSource.Rebate;
   cell.dataSource = self.tableViewDataArray[indexPath.row];
   return cell;
}

- (NSMutableArray *)tableViewDataArray{
    
    if (_tableViewDataArray == nil) {
        _tableViewDataArray = [NSMutableArray array];
    }
    return _tableViewDataArray;
}



@end
