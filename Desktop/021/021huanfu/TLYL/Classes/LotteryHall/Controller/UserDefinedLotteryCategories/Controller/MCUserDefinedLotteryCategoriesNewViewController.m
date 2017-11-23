//
//  MCUserDefinedLotteryCategoriesNewViewController.m
//  TLYL
//
//  Created by MC on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCUserDefinedLotteryCategoriesNewViewController.h"
#import "MCUserDefinedLotteryCategoriesTableViewCell.h"
#import "MCUserDefinedLotteryCategoriesHeaderView.h"
#import "MCMineCellModel.h"
#import "MCBasePWFModel.h"
#import "MCPullMenuModel.h"
#import "MCDataTool.h"
#import "MCUserDefinedAPIModel.h"
#import "ExceptionView.h"
#import "MCNoDataWindow.h"
#import "MCNONetWindow.h"
#import "MCErrorWindow.h"
#import "MCGetLotteryCustomModel.h"
#import "MCSetLotteryCustomModel.h"
#define MCPCMENU  @"MCPCMENU"

@interface MCUserDefinedLotteryCategoriesNewViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*sectionMarr;
@property(nonatomic, strong)NSDictionary * cZHelperDictionary;

@property(nonatomic,strong)MCUserDefinedAPIModel *apiModel;

//从网上拉去的数据  全部展示的彩种
@property(nonatomic,strong)NSMutableArray  *cZListMarr;

/*
 * 设置选中彩种
 */
@property(nonatomic, strong)NSMutableArray<MCUserDefinedLotteryCategoriesModel*>*marr_LotteryCategories;

@property(nonatomic, strong)ExceptionView * exceptionView;
@property (nonatomic,weak) MCNoDataWindow *dataWind;

@property(nonatomic,strong)MCGetLotteryCustomModel *getLotteryCustomModel;
@property(nonatomic,strong)MCSetLotteryCustomModel *setLotteryCustomModel;

@end

@implementation MCUserDefinedLotteryCategoriesNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setProperty];
    
    [self setNav];
    
    [self createUI];
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCErrorWindow_Retry" object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCNoDataWindow_Retry" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCNONetWindow_Retry" object:nil];
    
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
    self.navigationItem.title = @"自定义彩种";
    _sectionMarr=[[NSMutableArray alloc]init];
    _cZListMarr=[[NSMutableArray alloc]init];
    _marr_LotteryCategories=[[NSMutableArray alloc]init];
    [_marr_LotteryCategories addObjectsFromArray:[MCDataTool MC_GetMarr_withID:MCHomePageLotteryCategoryData]];
    
}

#pragma mark ====================设置导航栏========================
-(void)setNav{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 28, 28);
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"MCUserDefined_Sure"] forState:UIControlStateNormal];
    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rewardItem];
    
}
#pragma mark ======点击设置完成
-(void)rightBtnAction{
    
    __weak typeof(self) weakSelf = self;
    
    /*
     * 存储数据
     */
    [MCDataTool MC_SaveMarr:_marr_LotteryCategories withID: MCHomePageLotteryCategoryData];
    
    if (self.block) {
        self.block(_marr_LotteryCategories);
    }
    
    [self setLotteryCustomCZ:^(BOOL result, NSMutableArray *defaultCZArray) {
        
        [weakSelf.navigationController  popViewControllerAnimated:YES];
        
    }];
    
    
}

#pragma mark==================createUI======================
-(void)createUI{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.and.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
}
/*
 * 数据
 */
-(NSMutableArray *)GetCZListMarrWithDic:(NSArray *)arr{
    
    
    NSMutableArray * sscMarry=[[NSMutableArray alloc]init];
    NSMutableArray * jscMarry=[[NSMutableArray alloc]init];
    NSMutableArray * klcMarry=[[NSMutableArray alloc]init];
    NSMutableArray * dpcMarry=[[NSMutableArray alloc]init];
    NSMutableArray * esfMarry=[[NSMutableArray alloc]init];
    
    NSMutableArray * saleCZIDArry=[[NSMutableArray alloc]init];
    
    for (NSDictionary * cDic in arr) {
        
        NSString * LotteryID=[NSString stringWithFormat:@"%@",cDic[@"LotteryCode"]];
        NSString * SaleState=[NSString stringWithFormat:@"%@",cDic[@"SaleState"]];
        NSString * MaxRebate=[NSString stringWithFormat:@"%@",cDic[@"MaxRebate"]];
        NSString * BetRebate=[NSString stringWithFormat:@"%@",cDic[@"BetRebate"]];
        
        MCUserDefinedLotteryCategoriesModel * model=[MCUserDefinedLotteryCategoriesModel mj_objectWithKeyValues:[self.cZHelperDictionary objectForKey:LotteryID]];
        model.LotteryID=LotteryID;
        model.SaleState=SaleState;
        model.MaxRebate=MaxRebate;
        model.BetRebate=BetRebate;
        model.isSelected=[self Get_isSelectedWithID:LotteryID];
        
        if ([SaleState intValue]==1) {
            
            //SSC
            if ([sscArry containsObject: LotteryID]) {
                
                [sscMarry addObject:model];
                [saleCZIDArry addObject:model];
                
                //竞速彩
            }else if ([jscArry containsObject: LotteryID]){
                
                [jscMarry addObject:model];
                [saleCZIDArry addObject:model];
                
                //快乐彩
            }else if ([klcArry containsObject: LotteryID]){
                
                [klcMarry addObject:model];
                [saleCZIDArry addObject:model];
                
                //低频彩
            }else if ([dpcArry containsObject: LotteryID]){
                
                [dpcMarry addObject:model];
                [saleCZIDArry addObject:model];
                
                //11选5
            }else if ([esfArry containsObject: LotteryID]){
                
                [esfMarry addObject:model];
                [saleCZIDArry addObject:model];
                
            }
            
        }
        
    }
    [MCUserDefinedAPIModel saveSaleCZIDArry:saleCZIDArry];
    
    _cZListMarr=[NSMutableArray arrayWithArray:@[sscMarry,jscMarry,klcMarry,dpcMarry,esfMarry]];
    
    return _cZListMarr;
}

-(NSInteger)Get_isSelectedWithID:(NSString *)categoryID{
    /*
     * 比对哪些是被选中的  【选中就放上选中标记】
     */
    for (MCUserDefinedLotteryCategoriesModel * item in _marr_LotteryCategories) {
        if ([item.LotteryID isEqualToString:categoryID]) {
            return 1;
        }
    }
    return 0;
}

#pragma mark==================loadData======================
-(void)loadData{
    
    
    MCUserDefinedAPIModel *apiModel = [MCUserDefinedAPIModel sharedMCUserDefinedAPIModel];
    
    [apiModel refreashDataAndShow];
    
    self.apiModel = apiModel;
    __weak __typeof__ (self) wself = self;
    
    apiModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        
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
        
        
        [wself GetCZListMarrWithDic:manager.ResponseRawData];
        
        [wself setMarr_Section];
        
        [wself.tableView reloadData];
        
    };
    
    
    
    
}


-(void)setMarr_Section{
    
    
    NSArray * arr_Name=@[@"时时彩",@"竞速彩",@"快乐彩",@"低频彩",@"11选5"];
    [_sectionMarr removeAllObjects];
    int i=0;
    for (NSArray * item1 in _cZListMarr) {
        NSMutableArray * marr_Model=[[NSMutableArray alloc]init];
        for(int j=0 ;j<item1.count; j++){
            CellModel* model =[[CellModel alloc]init];
            model.reuseIdentifier = NSStringFromClass([MCUserDefinedLotteryCategoriesTableViewCell class]);
            model.className=NSStringFromClass([MCUserDefinedLotteryCategoriesTableViewCell class]);
            model.height = [MCUserDefinedLotteryCategoriesTableViewCell computeHeight:nil];
            model.selectionStyle=UITableViewCellSelectionStyleNone;
            model.accessoryType=UITableViewCellAccessoryNone;
            /*
             * 传递参数
             */
            model.userInfo=item1[j];
            [marr_Model addObject:model];
            
        }
        if (marr_Model.count>0) {
            SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr_Model];
            model0.headerhHeight=[MCUserDefinedLotteryCategoriesHeaderView computeHeight:nil];
            model0.footerHeight=0.00001;
            model0.userInfo=arr_Name[i];
            model0.className=NSStringFromClass([MCUserDefinedLotteryCategoriesHeaderView class]);
            [_sectionMarr addObject:model0];
        }
        
        i++;
    }
    if (_sectionMarr.count < 1) {
        //无数据
        self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
        [self.exceptionView showInView:self.view];
        return;
    }
    MCNoDataWindow *dataWind = [[MCNoDataWindow alloc]alertInstanceWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
    self.dataWind = dataWind;
    if (_sectionMarr.count == 0) {
        [dataWind setHidden:NO];
    } else {
        [dataWind setHidden:YES];
    }
    
    
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
    SectionModel *sm = _sectionMarr[section];
    MCUserDefinedLotteryCategoriesHeaderView * view=[[MCUserDefinedLotteryCategoriesHeaderView alloc]init];
    view.dataSource=sm.userInfo;
    return view;
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
    
    if ([cm.className isEqualToString:NSStringFromClass([MCUserDefinedLotteryCategoriesTableViewCell class])]) {
        
        MCUserDefinedLotteryCategoriesTableViewCell *ex_cell=(MCUserDefinedLotteryCategoriesTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
    }
    return cell;
}

#pragma mark-addModel
-(void)addModel:(MCUserDefinedLotteryCategoriesModel * )model{
    
    [self.marr_LotteryCategories addObject:model];
    
    [self setMarr_Section];
    
}

#pragma mark-removeModel
-(void)removeModel:(MCUserDefinedLotteryCategoriesModel * )model{
    
    for (MCUserDefinedLotteryCategoriesModel * item in _marr_LotteryCategories) {
        if ([item.LotteryID isEqualToString:model.LotteryID]) {
            [_marr_LotteryCategories removeObject:item];
            return;
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MCUserDefinedLotteryCategoriesTableViewCell* cell=[_tableView cellForRowAtIndexPath:indexPath];
    SectionModel *sm = _sectionMarr[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    MCUserDefinedLotteryCategoriesModel * model=cm.userInfo;
    
    if (!cell.selectedBtn.selected) {
        if (self.marr_LotteryCategories.count>7) {
            /*
             * 最多只能选择8个彩种
             */
            [SVProgressHUD showErrorWithStatus:@"最多只能选择8个彩种"];
            
            return;
        }else{
            
            model.isSelected=1;
            [self addModel:model];
            [cell.selectedBtn setSelected:YES];
            
        }
        
    }else{
        model.isSelected=0;
        [self removeModel:model];
        [cell.selectedBtn setSelected:NO];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-懒加载
-(NSDictionary *)cZHelperDictionary{
    if (!_cZHelperDictionary) {
        _cZHelperDictionary = [MCDataTool MC_GetDic_CZHelper];
    }
    return _cZHelperDictionary;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark-获取用户自定义彩种
-(void)GetLotteryCustomArray:(Compeletion)compeletion{
    
    __weak typeof(self) weakSelf = self;
    NSString  *Token= [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
    if (Token.length<1) {
        return;
    }
    [self loadCanSaleCZArry:^(BOOL result, NSMutableArray *defaultCZArray) {
        
        if (result) {
            
            //获取用户服务器自定义彩种列表
            MCGetLotteryCustomModel * getLotteryCustomModel=[[MCGetLotteryCustomModel alloc]init];
            weakSelf.getLotteryCustomModel=getLotteryCustomModel;
            [getLotteryCustomModel refreashDataAndShow];
            
            getLotteryCustomModel.callBackSuccessBlock = ^(id manager) {
                NSString * CustomItem=manager[@"CustomItem"];
                [weakSelf CombinData:CustomItem andCompeletion:^(BOOL result, NSMutableArray *defaultCZArray) {
                    compeletion(result,defaultCZArray);
                }];
            };
        }else{
            compeletion(result,defaultCZArray);
        }
    }];
    
}
- (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

-(void)CombinData:(NSString *)CustomItem andCompeletion:(Compeletion)compeletion{
    NSArray *Arry= [CustomItem componentsSeparatedByString:@","];
    
    NSMutableArray * CustomItemArry = [[NSMutableArray alloc]init];
    
    NSMutableArray * PCCustomItemArry = [[NSMutableArray alloc]init];
    for (NSString * str in Arry) {
        if ([self isNum:str]) {//如果是彩种  就加入
            [CustomItemArry addObject:str];
        }else{
            [PCCustomItemArry addObject:str];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[PCCustomItemArry componentsJoinedByString:@","] forKey:MCPCMENU];
    
    NSArray * SaleArry=[MCUserDefinedAPIModel getSaleCZIDArry];
    NSMutableArray * defineCZArry=[[NSMutableArray alloc]init];
    if (CustomItemArry.count>0&&CustomItem.length>0) {
        
        for (NSString * CZID in CustomItemArry) {
            //            BOOL isSale=NO;
            for (MCUserDefinedLotteryCategoriesModel * model in SaleArry) {
                
                if ([CZID isEqualToString:model.LotteryID]) {
                    /*
                     * 开售的
                     */
                    model.SaleState=@"1";
                    [defineCZArry addObject:model];
                    //                    isSale=YES;
                }
            }
            //            if (!isSale) {
            //                /*
            //                 * 没有开售
            //                 */
            //                MCUserDefinedLotteryCategoriesModel * model = [MCUserDefinedLotteryCategoriesModel mj_objectWithKeyValues:[self.cZHelperDictionary objectForKey:CZID]];
            //                model.isSelected=YES;
            //                model.SaleState=@"0";
            //                [defineCZArry addObject:model];
            //            }
        }
        
    }else{
        //重庆时时彩-12， 韩国1.5分彩-56， 极限秒秒彩-50，北京PK拾-10，11选5分分彩-61
        //如果从网上拉取的数据里面没有彩种   使用默认的5个
        for (MCUserDefinedLotteryCategoriesModel * model in SaleArry) {
            if ([model.LotteryID isEqualToString:@"12"]||[model.LotteryID isEqualToString:@"56"]||[model.LotteryID isEqualToString:@"50"]||[model.LotteryID isEqualToString:@"10"]||[model.LotteryID isEqualToString:@"61"]) {
                
                model.isSelected=1;
                [defineCZArry addObject:model];
            }else{
                
                model.isSelected=0;
                continue;
            }
        }
        
    }
    
    
    //存储用户选择的彩种
    [MCDataTool MC_SaveMarr:defineCZArry withID: MCHomePageLotteryCategoryData];
    
    compeletion(YES,defineCZArry);
    
}

-(void)loadCanSaleCZArry:(Compeletion)compeletion{
    
    MCUserDefinedAPIModel *apiModel = [MCUserDefinedAPIModel sharedMCUserDefinedAPIModel];
    [apiModel refreashDataAndShow];
    self.apiModel = apiModel;
    
    apiModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        
        compeletion(NO,nil);
    };
    
    apiModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        
        NSArray * arr = manager.ResponseRawData;
        
        NSMutableArray * saleCZIDArry=[[NSMutableArray alloc]init];
        
        for (NSDictionary * cDic in arr) {
            
            NSString * LotteryID=[NSString stringWithFormat:@"%@",cDic[@"LotteryCode"]];
            NSString * SaleState=[NSString stringWithFormat:@"%@",cDic[@"SaleState"]];
            NSString * MaxRebate=[NSString stringWithFormat:@"%@",cDic[@"MaxRebate"]];
            NSString * BetRebate=[NSString stringWithFormat:@"%@",cDic[@"BetRebate"]];
            
            MCUserDefinedLotteryCategoriesModel * model=[MCUserDefinedLotteryCategoriesModel mj_objectWithKeyValues:[self.cZHelperDictionary objectForKey:LotteryID]];
            model.LotteryID=LotteryID;
            model.SaleState=SaleState;
            model.MaxRebate=MaxRebate;
            model.BetRebate=BetRebate;
            
            
            //            if ([SaleState intValue]==1) {
            
            //SSC
            if ([sscArry containsObject: LotteryID]) {
                
                [saleCZIDArry addObject:model];
                
                //竞速彩
            }else if ([jscArry containsObject: LotteryID]){
                
                [saleCZIDArry addObject:model];
                
                //快乐彩
            }else if ([klcArry containsObject: LotteryID]){
                
                [saleCZIDArry addObject:model];
                
                //低频彩
            }else if ([dpcArry containsObject: LotteryID]){
                
                [saleCZIDArry addObject:model];
                
                //11选5
            }else if ([esfArry containsObject: LotteryID]){
                
                [saleCZIDArry addObject:model];
                
            }
            
            //            }
        }
        
        
        [MCUserDefinedAPIModel saveSaleCZIDArry:saleCZIDArry];
        
        compeletion(YES,saleCZIDArry);
        
    };
    
    
}
#pragma mark-设置用户自定义彩种
-(void)setLotteryCustomCZ:(Compeletion)compeletion{
    
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    
    for (MCUserDefinedLotteryCategoriesModel * model in _marr_LotteryCategories) {
        [marr addObject:model.LotteryID];
    }
    
    MCSetLotteryCustomModel *setLotteryCustomModel=[[MCSetLotteryCustomModel alloc]init];
    
    
    
    NSString *pCMenu = [[NSUserDefaults standardUserDefaults] objectForKey:MCPCMENU];
    if (pCMenu.length>1) {
        
        setLotteryCustomModel.CustomItem=[NSString stringWithFormat:@"%@,%@",[marr componentsJoinedByString:@","],pCMenu];
        
    }else{
        setLotteryCustomModel.CustomItem=[marr componentsJoinedByString:@","];
    }
    
    [setLotteryCustomModel refreashDataAndShow];
    self.setLotteryCustomModel=setLotteryCustomModel;
    setLotteryCustomModel.callBackSuccessBlock = ^(id manager) {
        compeletion(YES,manager);
    };
    setLotteryCustomModel.callBackFailedBlock = ^(id manager,NSString *errorCode) {
        compeletion(NO,manager);
    };
}

#pragma mark-退出登录 清空自定义彩种
+(void)clearUserDefinedCZ{
    
    [MCDataTool MC_SaveMarr:nil withID: MCHomePageLotteryCategoryData];
    
    [MCUserDefinedAPIModel saveSaleCZIDArry:nil];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MCPCMENU];
    
}
@end










