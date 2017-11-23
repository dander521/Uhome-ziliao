//
//  MCLotteryDrawViewController.m
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryDrawViewController.h"
#import "MCLotteryDrawTableViewCell.h"
#import "MCLotteryDrawDetailsViewController.h"
#import "MCMineCellModel.h"
#import "MCUserDefinedAPIModel.h"
#import "ExceptionView.h"
#import "MCDataTool.h"
#import <MJRefresh/MJRefresh.h>
#import "MCUserDefinedLotteryCategoriesModel.h"
#import "MCNoDataWindow.h"
#import "MCNONetWindow.h"
#import "MCErrorWindow.h"
#import "MCUserDefinedLotteryCategoriesViewController.h"

@interface MCLotteryDrawViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray*sectionMarr;

@property(nonatomic, strong)MCUserDefinedAPIModel *userDefinedAPIModel;

@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic, strong)NSDictionary * cZHelperDictionary;

@property (nonatomic,weak) MCNoDataWindow *dataWind;
@end

@implementation MCLotteryDrawViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setProperty];
        
    [self createUI];
    
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCErrorWindow_Retry" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCNONetWindow_Retry" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.dataWind hideModelWindow];
//    [[MCNONetWindow alertInstance] hideModelWindow];
//    [[MCErrorWindow alertInstance] hideModelWindow];
}
#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=RGB(231, 231, 231);
    self.navigationItem.title = @"开奖公告";
    _sectionMarr=[[NSMutableArray alloc]init];
    
}

#pragma mark==================createUI======================
-(void)createUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.layer.cornerRadius=5;
    _tableView.clipsToBounds=YES;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(10);
    }];
    
}

#pragma mark-下拉刷新
- (void)loadMoreData{
    [BKIndicationView showInView:self.view];
    __weak __typeof__ (self) wself = self;
    MCUserDefinedLotteryCategoriesViewController * vc = [[MCUserDefinedLotteryCategoriesViewController alloc]init];
    [vc loadCanSaleCZArry:^(BOOL result, NSMutableArray *defaultCZArray) {
        [BKIndicationView dismiss];
        [wself.tableView.mj_header endRefreshing];
        
        if (result) {
            
            [wself setData:defaultCZArray];
            
        }else{
            
            [wself.tableView.mj_header endRefreshing];
            
            wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
            ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
                [wself.exceptionView dismiss];
                wself.exceptionView = nil;
                [wself loadData];
            }];
            [wself.exceptionView addAction:action];
            [wself.exceptionView showInView:wself.view];
            
        }
    }];

}


#pragma mark-懒加载
-(NSDictionary *)cZHelperDictionary{
    if (!_cZHelperDictionary) {
        _cZHelperDictionary = [MCDataTool MC_GetDic_CZHelper];
    }
    return _cZHelperDictionary;
}


#pragma mark==================loadData======================
-(void)loadData{
    
    
    NSArray *saleCZIDArry= [MCUserDefinedAPIModel getSaleCZIDArry];
    
    if (saleCZIDArry==nil||saleCZIDArry.count<1) {
       
        [self loadMoreData];
        
    }else{
        
        [self setData:saleCZIDArry];
        
    }

}



-(void)setData:(NSArray *)arr{
    
    if (arr.count<1) {
        //无数据
        self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
        [self.exceptionView showInView:self.view];
        return;
    }

    [_sectionMarr removeAllObjects];
    
    NSMutableArray * marr_Model=[[NSMutableArray alloc]init];
    
    for (MCUserDefinedLotteryCategoriesModel * userDefinedLotteryCategoriesModel in arr) {
        
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCLotteryDrawTableViewCell class]);
        model.className=NSStringFromClass([MCLotteryDrawTableViewCell class]);
        model.height = [MCLotteryDrawTableViewCell computeHeight:nil];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo=userDefinedLotteryCategoriesModel;
        [marr_Model addObject:model];
    }
   
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr_Model];
    model0.headerhHeight=0.001;
    model0.footerHeight=10;
    [_sectionMarr addObject:model0];
    
    MCNoDataWindow *dataWind = [[MCNoDataWindow alloc]alertInstanceWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
    self.dataWind = dataWind;
    if (_sectionMarr.count == 0) {
        [dataWind setHidden:NO];
    } else {
        [dataWind setHidden:YES];
    }
    [_tableView reloadData];
    
    
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
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
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
    
    if ([cm.className isEqualToString:NSStringFromClass([MCLotteryDrawTableViewCell class])]) {
        
        MCLotteryDrawTableViewCell *ex_cell=(MCLotteryDrawTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    
    MCLotteryDrawDetailsViewController * vc =[[MCLotteryDrawDetailsViewController alloc]init];
    vc.fromClass = NSStringFromClass([MCLotteryDrawViewController class]);
    
    MCUserDefinedLotteryCategoriesModel * dataSource = cm.userInfo;
    vc.LotteryCode=dataSource.LotteryID;
    vc.dataSource=dataSource;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
