//
//  MCKaiHuThdViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCKaiHuThdViewController.h"
#import "MCKaiHuLJTableViewCell.h"
#import "MCRegisteredLinksModel.h"
#import <MJRefresh/MJRefresh.h>
#import "MCRefreshNormalHeader.h"
#import "MCKaiHuThdPopView.h"
#import "MCCloseReModel.h"
#import "MCDelReModel.h"

@interface MCKaiHuThdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) MCRegisteredLinksModel *linkModel;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,weak) UITableView *tabView;
@property (nonatomic,weak) UILabel *labelInfo;
@property (nonatomic,weak) MCKaiHuThdPopView *popView;
@property (nonatomic,strong) MCCloseReModel *closeModel;
@property (nonatomic,strong) MCDelReModel *delModel;
@property (nonatomic,assign) int CloseID;
@property (nonatomic,assign) int delID;
@property (nonatomic,assign) int closeStatus;

@end

@implementation MCKaiHuThdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"开户中心";
    self.view.backgroundColor = RGB(231, 231, 231);
    [self setUpUI];
    [self laodData];
}
- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tabView = [[UITableView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT - 64 - 49 - MC_REALVALUE(26)) style:UITableViewStylePlain];
    [self.view addSubview:tabView];
    self.tabView=tabView;
    tabView.layer.cornerRadius = 6;
    tabView.clipsToBounds = YES;
    tabView.backgroundColor = RGB(255, 255, 255);
    tabView.delegate = self;
    tabView.contentInset = UIEdgeInsetsMake(MC_REALVALUE(17), 0, 0, 0);
    tabView.dataSource= self;
    tabView.rowHeight = MC_REALVALUE(44);
    __weak typeof(self) weakself = self;
    tabView.separatorStyle = UITableViewCellSelectionStyleNone;
    [tabView registerClass:[MCKaiHuLJTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tabView.mj_header = [MCRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself laodData];
    }];
    
    UILabel *labelInfo = [[UILabel alloc] init];
    labelInfo.text = @"最多可添加10条记录";
    labelInfo.textColor =  RGB(136, 136, 136);
    labelInfo.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
    [self.view addSubview:labelInfo];
    labelInfo.textAlignment = NSTextAlignmentCenter;
    [labelInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(tabView.mas_bottom).offset(MC_REALVALUE(13));
    }];
    labelInfo.hidden = YES;
    self.labelInfo = labelInfo;
}

- (void)loadData{
    [super loadData];
    [self laodData];
}
- (void)laodData{
    MCRegisteredLinksModel *linkModel = [[MCRegisteredLinksModel alloc] init];
    self.linkModel = linkModel;
    [linkModel refreashDataAndShow];
    __weak typeof(self) weakself = self;
    [BKIndicationView showInView:self.view];
    linkModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        [weakself.tabView.mj_header endRefreshing];
        weakself.dataArray = [MCRegisteredLinksModel mj_objectArrayWithKeyValuesArray:manager.ResponseRawData[@"UserRegistUrlList"]];
        if (weakself.dataArray.count == 0) {
            [weakself showExDataView];
        }else{
            [weakself hiddenExDataView];
        }
        weakself.tabView.frame = CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), weakself.dataArray.count * MC_REALVALUE(44) + MC_REALVALUE(34));
        
        [weakself.tabView reloadData];
    };
    linkModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [weakself.tabView.mj_header endRefreshing];
        if ([errorCode[@"code"] isKindOfClass:[NSError class]]) {
            NSError *err = errorCode[@"code"];
            if (err.code == -1001) {// 超时
                [weakself.errDataWin setHidden:NO];
            } else if (err.code == -1009){//没有网络
                [weakself.errNetWin setHidden:NO];
            }
        } else {
            [weakself.errDataWin setHidden:NO];
        }
    };
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        self.labelInfo.hidden = YES;
    } else {
        self.labelInfo.hidden = NO;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCKaiHuLJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.dataSource = self.dataArray[indexPath.row];
    cell.numLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCRegisteredLinksModel *model = self.dataArray[indexPath.row];
    self.CloseID = model.ID;
    self.delID = model.ID;
    self.closeStatus = model.Status;
    self.popView.dataSource = model;
    [self.popView show];
}
- (MCKaiHuThdPopView *)popView{
    if (_popView == nil) {
        MCKaiHuThdPopView *popView = [[MCKaiHuThdPopView alloc] init];
        __weak typeof(self) weakself = self;
        [self.view addSubview:popView];
        _popView = popView;
        __weak MCKaiHuThdPopView *weakClo = popView;
        popView.closeBtnBlock = ^(NSString *str){
            [weakClo hidden];
            MCCloseReModel *closeModel = [[MCCloseReModel alloc] init];
            weakself.closeModel = closeModel;
            closeModel.ID = weakself.CloseID;
            if ([str isEqualToString:@"开启链接"]) {
                closeModel.Status =1;
            } else {
                closeModel.Status =0;
            }
            
            [closeModel refreashDataAndShow];
            
            [BKIndicationView showInView:weakself.view];
            closeModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
                [SVProgressHUD showInfoWithStatus:@"链接关闭成功"];
                [weakself laodData];
            };
            closeModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
                
            };
        };
        popView.delBtnBlock = ^{
            [weakClo hidden];
            MCDelReModel *delModel = [[MCDelReModel alloc] init];
            weakself.delModel = delModel;
            delModel.ID = weakself.delID;
            [delModel refreashDataAndShow];

            [BKIndicationView showInView:weakself.view];
            delModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
              [SVProgressHUD showInfoWithStatus:@"链接删除成功"];
                [weakself laodData];
            };
            delModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
                
            };
        };
        
        popView.hiddenViewBlock = ^{
            [weakself.tabView reloadData];
            
        };
    }
    return _popView;
    
    
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _dataArray = arr;
    }
    return _dataArray;
}
@end
