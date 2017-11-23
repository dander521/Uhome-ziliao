//
//  MCBuyLotteryViewController.m
//  TLYL
//
//  Created by MC on 2017/9/15.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBuyLotteryViewController.h"
#import "MCBuyLotteryTableViewCell.h"
#import "MCMineCellModel.h"
#import "MCUserDefinedLotteryCategoriesViewController.h"
#import "MCUserDefinedAPIModel.h"
#import "MCPickNumberViewController.h"
#import "ExceptionView.h"
#import <MJRefresh/MJRefresh.h>

@interface MCBuyLotteryViewController ()
<

UITableViewDelegate,
UITableViewDataSource,
MCBuyLotteryCellDelegate

>

/**tableView*/
@property(nonatomic, strong)UITableView *tableView;
/**sectionMarr*/
@property(nonatomic, strong)NSMutableArray*sectionMarr;


@property (nonatomic, strong)MCUserDefinedAPIModel *apiModel;
@property(nonatomic, strong)ExceptionView * exceptionView;


@end

@implementation MCBuyLotteryViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    NSString  *Token= [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
    if (Token.length<1) {
    }else{
        [self loadData];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=RGB(231, 231, 231);
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
//    self.title=@"购彩";
    self.navigationItem.title=@"购彩大厅";
    _sectionMarr= [[NSMutableArray alloc]init];
    
}

#pragma mark==================createUI======================
-(void)createUI{

    UIView * backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT)];
    [self.view addSubview:backView];
    backView.backgroundColor=[UIColor clearColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [backView addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(backView);
        make.bottom.equalTo(backView.mas_bottom).offset(-49);
    }];
}

#pragma mark==================loadData======================
-(void)loadData{
    MCUserDefinedAPIModel *apiModel = [MCUserDefinedAPIModel sharedMCUserDefinedAPIModel];
    [BKIndicationView showInView:self.view];
    [apiModel refreashDataAndShow];
    self.apiModel = apiModel;
    __weak __typeof__ (self) wself = self;

    apiModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [wself.tableView.mj_header endRefreshing];
        
        wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
        ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
            [wself.exceptionView dismiss];
            wself.exceptionView = nil;
            [wself loadData];
        }];
        [wself.exceptionView addAction:action];
        [wself.exceptionView showInView:wself.view];

    };
    
    apiModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        
        [wself.tableView.mj_header endRefreshing];
        
        NSArray * arr = manager.ResponseRawData;
        [self createSectionMarr:arr];
        
    };

    
    
    
    
}
-(void)createSectionMarr:(NSArray *)arr{
    
    [_sectionMarr removeAllObjects];
    
    MCUserDefinedLotteryCategoriesViewController * vc =[[MCUserDefinedLotteryCategoriesViewController alloc]init];
    NSMutableArray * marr=[vc GetCZListMarrWithDic:arr];
    
    
    for(int i=0; i< marr.count;i++ ){
        
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = [NSString stringWithFormat:@"%@--%d",NSStringFromClass([MCBuyLotteryTableViewCell class]),i];
        model.className=NSStringFromClass([MCBuyLotteryTableViewCell class]);
        model.height = [MCBuyLotteryTableViewCell computeHeight:marr[i]];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo = marr[i];
        
        SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[model]];
        model0.headerhHeight=0.0001;
        model0.footerHeight=10;
        [_sectionMarr addObject:model0];
    }
    
    [_tableView reloadData];
}
-(void)refreshData{
    
    
    
}
#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.headerhHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionModel *sm = _sectionMarr[section];
    return sm.footerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    
    return cm.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cm.reuseIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(cm.className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cm.reuseIdentifier];
    }
    cell.selectionStyle = cm.selectionStyle;
    
    if ([cm.className isEqualToString:NSStringFromClass([MCBuyLotteryTableViewCell class])]) {
        MCBuyLotteryTableViewCell *ex_cell=(MCBuyLotteryTableViewCell *)cell;
        ex_cell.delegate=self;
        NSArray * arr_Name=@[@"时时彩",@"竞速彩",@"快乐彩",@"低频彩",@"11选5"];
        
        ex_cell.maintitleLab.text=arr_Name[indexPath.section];
        ex_cell.dataSource=cm.userInfo;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-MCMineCellDelegate  /点击Cell跳转/
- (void)cellDidSelectWithModel:(MCUserDefinedLotteryCategoriesModel *)model{
    
    if ([model.SaleState isEqualToString:@"0"]) {
        [SVProgressHUD showInfoWithStatus:@"当前彩种未开售！"];
        return;
    }
    MCPickNumberViewController *pickVC =  [[MCPickNumberViewController alloc] init];
    pickVC.lotteriesTypeModel = model;
    [self.navigationController pushViewController:pickVC animated:YES];
    
}
@end











































