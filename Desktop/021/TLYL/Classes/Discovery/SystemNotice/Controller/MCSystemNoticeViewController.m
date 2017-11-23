//
//  MCSystemNoticeViewController.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSystemNoticeViewController.h"
#import "MCSystemNoticeTableViewCell.h"
#import "MCMineCellModel.h"
#import "MCSystemNoticeDetailViewController.h"
#import "MCSystemNoticeListModel.h"
#import "MCNoDataWindow.h"
#import "MCNONetWindow.h"
#import "MCErrorWindow.h"
#import <MJRefresh/MJRefresh.h>

typedef void(^Compeletion)(BOOL result, NSMutableArray *dataSource);

@interface MCSystemNoticeViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    // 分页下标
    int _pageIndex;
}
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*marr_Section;
@property(nonatomic, strong)MCSystemNoticeListModel * systemNoticeListModel;
@property (nonatomic,weak) MCNoDataWindow *dataWind;
@property(nonatomic, strong)NSMutableArray * dataSourece;

@end

@implementation MCSystemNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setProperty];
    
    [self createUI];
    _pageIndex = 1;
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCErrorWindow_Retry" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCNoDataWindow_Retry" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCNONetWindow_Retry" object:nil];


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.dataWind setHidden:YES];
//    [[MCNONetWindow alertInstance] hideModelWindow];
//    [[MCErrorWindow alertInstance] hideModelWindow];
}
#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"系统公告";
    _marr_Section=[[NSMutableArray alloc]init];
    _dataSourece=[[NSMutableArray alloc]init];
    
}

#pragma mark==================createUI======================
-(void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.and.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
}

#pragma mark==================loadData==================
-(void)requstData:(Compeletion)compeletion{
    [BKIndicationView showInView:self.view];
    MCSystemNoticeListModel * systemNoticeListModel = [[MCSystemNoticeListModel alloc]init];
    systemNoticeListModel->_currentPageIndex = _pageIndex;
    systemNoticeListModel.isHomePage = NO;
    [systemNoticeListModel refreashDataAndShow];
    self.systemNoticeListModel=systemNoticeListModel;
    
    
    systemNoticeListModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        [BKIndicationView dismiss];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        compeletion(NO,nil);
    };
    systemNoticeListModel.callBackSuccessBlock = ^(id manager) {
        [BKIndicationView dismiss];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        compeletion(YES,manager);
        
    };

}
-(void)loadData{
    _pageIndex=1;
    _tableView.mj_footer.hidden=NO;
    __weak __typeof__ (self) wself = self;
    [self requstData:^(BOOL result, NSMutableArray *dataSource) {
        if (result) {
            if (dataSource.count<1) {
                MCNoDataWindow *dataWind = [[MCNoDataWindow alloc]alertInstanceWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
                self.dataWind = dataWind;
                if (_marr_Section.count == 0) {
                    [dataWind setHidden:NO];
                } else {
                    [dataWind setHidden:YES];
                }
                return ;
            }
            [wself.dataSourece removeAllObjects];
            [wself.marr_Section removeAllObjects];
            [wself setData:dataSource];
        }
    }];
}

-(void)loadMoreData{
    __weak __typeof__ (self) wself = self;
    _pageIndex++;
    [self requstData:^(BOOL result, NSMutableArray *dataSource) {
        if (result) {
            if (dataSource.count%20!=0) {
                _tableView.mj_footer.hidden=YES;
            }
            [wself setData:dataSource];
            
        }
    }];
}

-(void)setData:(NSArray *)arr{

    for (NSDictionary * dic in arr) {
        MCSystemNoticeListModel * systemNoticeListModel = [MCSystemNoticeListModel  mj_objectWithKeyValues:dic];
        [_dataSourece addObject:systemNoticeListModel];
    }
    NSMutableArray * marr_Model=[[NSMutableArray alloc]init];
    
    for(MCSystemNoticeListModel * systemNoticeListModel in _dataSourece){
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCSystemNoticeTableViewCell class]);
        model.className=NSStringFromClass([MCSystemNoticeTableViewCell class]);
        model.height = [MCSystemNoticeTableViewCell computeHeight:nil];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo=systemNoticeListModel;
        [marr_Model addObject:model];
    }
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr_Model];
    model0.headerhHeight=0.0001;
    model0.footerHeight=0.0001;
    [_marr_Section addObject:model0];
    
    [_tableView reloadData];
}


#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _marr_Section.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.headerhHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.footerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _marr_Section[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    
    return cm.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionModel *sm = _marr_Section[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cm.reuseIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(cm.className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cm.reuseIdentifier];
    }
    cell.selectionStyle = cm.selectionStyle;
    
    if ([cm.className isEqualToString:NSStringFromClass([MCSystemNoticeTableViewCell class])]) {
        
        MCSystemNoticeTableViewCell *ex_cell=(MCSystemNoticeTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _marr_Section[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];

    MCSystemNoticeListModel * systemNoticeListModel=cm.userInfo;
    
    MCSystemNoticeDetailViewController * vc=[[MCSystemNoticeDetailViewController alloc]init];
    vc.NewsID=systemNoticeListModel.MerchantNews_ID;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
