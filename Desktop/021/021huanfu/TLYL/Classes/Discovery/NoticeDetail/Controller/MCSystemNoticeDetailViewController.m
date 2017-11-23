//
//  MCSystemNoticeDetailViewController.m
//  TLYL
//
//  Created by MC on 2017/8/4.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import "MCSystemNoticeDetailViewController.h"
#import "MCMCSystemNoticeDetailCell.h"
#import "MCSystemNoticeDetailModel.h"
#import "MCMineCellModel.h"
#import "ExceptionView.h"
#import "MCNoDataWindow.h"
#import "MCNONetWindow.h"
#import "MCErrorWindow.h"

@interface MCSystemNoticeDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*sectionMarr;

@property(nonatomic, strong)MCSystemNoticeDetailModel * systemNoticeDetailModel;
@property (nonatomic,weak) MCNoDataWindow *dataWind;
@property(nonatomic, strong)ExceptionView * exceptionView;

@end

@implementation MCSystemNoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
    
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCErrorWindow_Retry" object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCNoDataWindow_Retry" object:nil];
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
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"系统公告";
    _sectionMarr=[[NSMutableArray alloc]init];
    
}

#pragma mark==================createUI======================
-(void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.and.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
}

#pragma mark==================loadData======================
-(void)loadData{

    MCSystemNoticeDetailModel * systemNoticeDetailModel = [[MCSystemNoticeDetailModel alloc]init];
    
    systemNoticeDetailModel.NewsID = self.NewsID;
    [BKIndicationView showInView:self.view];
    [systemNoticeDetailModel refreashDataAndShow];
    
    self.systemNoticeDetailModel=systemNoticeDetailModel;
    
    __weak __typeof__ (self) wself = self;
    
    
    systemNoticeDetailModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
      

        wself.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeRequestFailed];
        ExceptionViewAction *action = [ExceptionViewAction actionWithType:ExceptionCodeTypeRequestFailed handler:^(ExceptionViewAction *action) {
            [wself.exceptionView dismiss];
            wself.exceptionView = nil;
            [wself loadData];
        }];
        [wself.exceptionView addAction:action];
        [wself.exceptionView showInView:wself.view];

    };
    systemNoticeDetailModel.callBackSuccessBlock = ^(id manager) {
    
        [wself setData:manager];
        
    };

    
    
}

-(void)setData:(NSDictionary *)dic{
//    "NewsTitle": "Welcome",
//    "InsertTime": "2017/6/13 20:15:08",
//    "NewsContent":"消息主体内容"
    MCSystemNoticeDetailModel * dataSource = [MCSystemNoticeDetailModel mj_objectWithKeyValues:dic];
    
    CellModel* model =[[CellModel alloc]init];
    model.reuseIdentifier = NSStringFromClass([MCMCSystemNoticeDetailCell class]);
    model.className=NSStringFromClass([MCMCSystemNoticeDetailCell class]);
    model.height = [MCMCSystemNoticeDetailCell computeHeight:nil];
    model.selectionStyle=UITableViewCellSelectionStyleNone;
    model.accessoryType=UITableViewCellAccessoryNone;
    /*
     * 传递参数
     */
    model.userInfo=dataSource;
    
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[model]];
    model0.headerhHeight=0.0001;
    model0.footerHeight=0.0001;
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
    
    if ([cm.className isEqualToString:NSStringFromClass([MCMCSystemNoticeDetailCell class])]) {
        
        MCMCSystemNoticeDetailCell *ex_cell=(MCMCSystemNoticeDetailCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

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
