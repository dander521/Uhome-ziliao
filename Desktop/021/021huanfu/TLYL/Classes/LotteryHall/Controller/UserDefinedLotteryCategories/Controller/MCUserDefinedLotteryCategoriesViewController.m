//
//  MCUserDefinedLotteryCategoriesViewController.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCUserDefinedLotteryCategoriesViewController.h"
#import "MCUserDefinedCZTableViewCell.h"
#import "MCUserDefinedLotteryCategoriesHeaderView.h"
#import "MCMineCellModel.h"
#import "MCBasePWFModel.h"
#import "MCPullMenuModel.h"
#import "MCDataTool.h"
#import "MCUserDefinedAPIModel.h"
#import "ExceptionView.h"
#import "MCGetLotteryCustomModel.h"
#import "MCSetLotteryCustomModel.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCUserDefinedLotteryCategoriesCollectionViewCell.h"
#define MCPCMENU  @"MCPCMENU"

@interface MCUserDefinedLotteryCategoriesViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property(nonatomic, strong)UICollectionView * selectedCollectionView;
@property(nonatomic, strong)NSMutableArray * collectionViewMarray;
@property(nonatomic, strong)UITableView *tableView;

/*
 * 用户选择的彩种
 */
@property(nonatomic, strong)NSMutableArray*tableViewMarray;
@property(nonatomic, strong)NSDictionary * cZHelperDictionary;

@property(nonatomic,strong)MCUserDefinedAPIModel *apiModel;

//从网上拉去的数据  全部展示的彩种
@property(nonatomic,strong)NSMutableArray  *cZListMarr;

@property(nonatomic, strong)ExceptionView * exceptionView;

@property(nonatomic,strong)MCGetLotteryCustomModel *getLotteryCustomModel;
@property(nonatomic,strong)MCSetLotteryCustomModel *setLotteryCustomModel;

@property(nonatomic,strong)NSArray * ResponseRawDataArray;
@end

@implementation MCUserDefinedLotteryCategoriesViewController
//第一个开奖期号
-(UICollectionView *)selectedCollectionView{
    if (!_selectedCollectionView) {
        
        //创建一个layout布局类
        MCCollectionViewFlowLayout * layout = [[MCCollectionViewFlowLayout alloc]init];
        //设置布局方向为横向流布局
        //        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _selectedCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _selectedCollectionView.backgroundColor=[UIColor clearColor];
        _selectedCollectionView.dataSource=self;
        _selectedCollectionView.delegate=self;
        [_selectedCollectionView registerClass:[MCUserDefinedHadSelectedCZCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCUserDefinedHadSelectedCZCollectionViewCell class])];
        
    }
    return _selectedCollectionView;
}
#pragma mark - <UICollectionViewDataSource>
// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        return nil ;
    }
    return nil ;
}

//设置section的颜色
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{
    return [UIColor clearColor];
}
//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat W = ( G_SCREENWIDTH-20-30 )/4.0;
    CGFloat H = 35 ;
    return CGSizeMake(W, H);
}
//设置section的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
// 两个cell之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.collectionViewMarray.count>0) {
        CollectionModel * model=self.collectionViewMarray[section];
        if ([model.id_dentifier isEqualToString:NSStringFromClass([MCUserDefinedHadSelectedCZCollectionViewCell class])]) {
            return self.collectionViewMarray.count;
        }
    }
    return 0;
}

//numberOfSections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


//UICollectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell*  cell = nil;
    CollectionModel * model=_collectionViewMarray[indexPath.row];
    if (model.id_dentifier) {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:model.id_dentifier forIndexPath:indexPath];
    }
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCUserDefinedHadSelectedCZCollectionViewCell class])]) {
        
        MCUserDefinedHadSelectedCZCollectionViewCell *ex_cell=(MCUserDefinedHadSelectedCZCollectionViewCell *)cell;

        ex_cell.dataSource=model.userInfo;

    }
    return cell;
}
#pragma mark-didSelect
#pragma mark-点击删除已经选择的彩种
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.collectionViewMarray[indexPath.row];
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCUserDefinedHadSelectedCZCollectionViewCell class])]) {
        //删除数据
        [self removeModel:model.userInfo];
        //修改上面的collectionView
        [self setCollectionViewMarry];
        [self.selectedCollectionView reloadData];
        //修改下面的tableview
        [self GetCZListMarrWithDic:self.ResponseRawDataArray];
        [self setMarr_Section];
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self setNav];
    
    [self createUI];
    
    [self loadData];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"自定义彩种";
    
    _collectionViewMarray=[[NSMutableArray alloc]init];
    
    _tableViewMarray=[[NSMutableArray alloc]init];
    _cZListMarr=[[NSMutableArray alloc]init];
    _userSelectedCZMarray=[[NSMutableArray alloc]init];
    [_userSelectedCZMarray addObjectsFromArray:[MCDataTool MC_GetMarr_withID:MCHomePageLotteryCategoryData]];
    
}

#pragma mark ====================设置导航栏========================
-(void)setNav{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 20);
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setImage:[UIImage imageNamed:@"MCUserDefined_Sure"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rewardItem];
    
}
#pragma mark ======点击设置完成
-(void)rightBtnAction{
    
    __weak typeof(self) weakSelf = self;

    if (_userSelectedCZMarray.count>0) {
        
        /*
         * 存储数据
         */
        [MCDataTool MC_SaveMarr:_userSelectedCZMarray withID: MCHomePageLotteryCategoryData];
        
        if (self.block) {
            self.block(_userSelectedCZMarray);
        }
        
        [self setLotteryCustomCZ:^(BOOL result, NSMutableArray *defaultCZArray) {
            
            [weakSelf.navigationController  popViewControllerAnimated:YES];
            
        }];
        
    }else{

        //重庆时时彩-12， 韩国1.5分彩-56， 极限秒秒彩-50，北京PK拾-10，11选5分分彩-61
        //如果从网上拉取的数据里面没有彩种   使用默认的5个
        NSArray * SaleArry=[MCUserDefinedAPIModel getSaleCZIDArry];
        NSMutableArray * defineCZArry=[[NSMutableArray alloc]init];
        for (MCUserDefinedLotteryCategoriesModel * model in SaleArry) {
            if ([model.LotteryID isEqualToString:@"12"]||[model.LotteryID isEqualToString:@"56"]||[model.LotteryID isEqualToString:@"50"]||[model.LotteryID isEqualToString:@"10"]||[model.LotteryID isEqualToString:@"61"]) {
                
                model.isSelected=1;
                [defineCZArry addObject:model];
            }
        }
    
        //存储用户选择的彩种
        [MCDataTool MC_SaveMarr:defineCZArry withID: MCHomePageLotteryCategoryData];
        
        if (self.block) {
            self.block(_userSelectedCZMarray);
        }
        
        [weakSelf.navigationController  popViewControllerAnimated:YES];
    }

}

#pragma mark==================createUI======================
-(void)createUI{
    
    self.view.backgroundColor=RGB(231, 231, 231);
    
    CGFloat H = 35+10 ;
    UIView * upView=[[UIView alloc]init];
    [self.view addSubview:upView];
    upView.backgroundColor=RGB(255, 255, 255);
    upView.frame=CGRectMake(0, 0, G_SCREENWIDTH, H*2+10+30);
    [upView addSubview:self.selectedCollectionView];
    
    [self.selectedCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView.mas_top).offset(10);
        make.left.and.right.equalTo(upView).offset(0);
        make.bottom.equalTo(upView.mas_bottom).offset(-30);
    }];

    [self setCollectionViewMarry];
    
    UILabel * lab=[[UILabel alloc]init];
    [upView addSubview:lab];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:10];
    lab.textColor=RGB(102, 102, 102);
    lab.text=@"首页最多可以收藏8个彩种，如果要添加新彩种，请先去掉默认收藏。";
    lab.frame=CGRectMake(0, H*2+10, G_SCREENWIDTH, 30);
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView.mas_bottom).offset(20);
        make.left.and.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
}

-(void)setCollectionViewMarry{
    [_collectionViewMarray removeAllObjects];
    CGFloat W = ( G_SCREENWIDTH-20-30 )/4.0;
    CGFloat H = 35 ;
    for (MCUserDefinedLotteryCategoriesModel * model in _userSelectedCZMarray) {
        CollectionModel * model0=[[CollectionModel alloc]init];
        model0.header_size=CGSizeMake(G_SCREENWIDTH, 0.0001);
        model0.item_size=CGSizeMake(W, H);
        model0.section_color=[UIColor clearColor];
        model0.section_Edge=UIEdgeInsetsMake(0, 10, 0, 10);
        model0.interitemSpacing=10;
        model0.lineSpacing=10;
        model0.isHaveHeader=YES;
        model0.id_dentifier=NSStringFromClass([MCUserDefinedHadSelectedCZCollectionViewCell class]);
        /*
         * info
         */
        model0.userInfo=model;
        [_collectionViewMarray addObject:model0];
    }
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
        
//        if ([SaleState intValue]==1) {
        
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
            
//        }
        
    }
    [MCUserDefinedAPIModel saveSaleCZIDArry:saleCZIDArry];
    
    _cZListMarr=[NSMutableArray arrayWithArray:@[sscMarry,jscMarry,klcMarry,dpcMarry,esfMarry]];
    
    return _cZListMarr;
}

-(NSInteger)Get_isSelectedWithID:(NSString *)categoryID{
    /*
     * 比对哪些是被选中的  【选中就放上选中标记】
     */
    for (MCUserDefinedLotteryCategoriesModel * item in _userSelectedCZMarray) {
        if ([item.LotteryID isEqualToString:categoryID]) {
            return 1;
        }
    }
    return 0;
}

#pragma mark==================loadData======================
-(void)loadData{
    
    
    MCUserDefinedAPIModel *apiModel = [MCUserDefinedAPIModel sharedMCUserDefinedAPIModel];
    [BKIndicationView showInView:self.view];
    [apiModel refreashDataAndShow];
    
    self.apiModel = apiModel;
    __weak __typeof__ (self) wself = self;
    
    apiModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [BKIndicationView dismiss];
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
        [BKIndicationView dismiss];
        wself.ResponseRawDataArray=[[NSArray alloc]init];
        wself.ResponseRawDataArray=manager.ResponseRawData;
        
        [wself GetCZListMarrWithDic:manager.ResponseRawData];
        
        [wself setMarr_Section];
        
        [wself.tableView reloadData];
        
    };
    
    
    
    
}


-(void)setMarr_Section{
    
    
    NSArray * arr_Name=@[@"时时彩",@"竞速彩",@"快乐彩",@"低频彩",@"11选5"];
    [_tableViewMarray removeAllObjects];
    int i=0;
    for (NSArray * item1 in _cZListMarr) {
        
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCUserDefinedCZTableViewCell class]);
        model.className=NSStringFromClass([MCUserDefinedCZTableViewCell class]);
        model.height = [MCUserDefinedCZTableViewCell computeHeight:[NSMutableArray arrayWithArray:item1]];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo=item1;

        
        
        if (item1.count>0) {
            
            SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:@[model]];
            model0.headerhHeight=[MCUserDefinedLotteryCategoriesHeaderView computeHeight:nil];
            model0.footerHeight=0.00001;
            model0.userInfo=arr_Name[i];
            model0.className=NSStringFromClass([MCUserDefinedLotteryCategoriesHeaderView class]);
            [_tableViewMarray addObject:model0];
            
        }
        
        i++;
    }
    if (_tableViewMarray.count < 1) {
        //无数据
        self.exceptionView = [ExceptionView exceptionViewWithType:ExceptionCodeTypeNoData];
        [self.exceptionView showInView:self.view];
        return;
    }
    
    
}
#pragma mark tableView 代理相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _tableViewMarray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sm = _tableViewMarray[section];
    return sm.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _tableViewMarray[section];
    return sm.headerhHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionModel *sm = _tableViewMarray[section];
    return sm.footerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _tableViewMarray[section];
    MCUserDefinedLotteryCategoriesHeaderView * view=[[MCUserDefinedLotteryCategoriesHeaderView alloc]init];
    view.dataSource=sm.userInfo;
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *sm = _tableViewMarray[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    return cm.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof__ (self) wself = self;
    SectionModel *sm = _tableViewMarray[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cm.reuseIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(cm.className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cm.reuseIdentifier];
    }
    cell.selectionStyle = cm.selectionStyle;
    
    if ([cm.className isEqualToString:NSStringFromClass([MCUserDefinedCZTableViewCell class])]) {
        
        MCUserDefinedCZTableViewCell *ex_cell=(MCUserDefinedCZTableViewCell *)cell;
        ex_cell.dataSource=cm.userInfo;
        
#pragma mark-添加彩种
        ex_cell.block = ^(MCUserDefinedLotteryCategoriesModel *model) {
            
            if (model.isSelected) {
                return ;
            }
            if (wself.userSelectedCZMarray.count>7) {
                /*
                 * 最多只能选择8个彩种
                 */
                [SVProgressHUD showErrorWithStatus:@"最多只能选择8个彩种"];
                
                return;
            }
            
            [wself addModel:model];
            
            //修改上面的collectionView
            [wself setCollectionViewMarry];
            [wself.selectedCollectionView reloadData];
            
            //修改下面的tableview
            [wself GetCZListMarrWithDic:self.ResponseRawDataArray];
            
            [wself setMarr_Section];
            
            [wself.tableView reloadData];
            
        };
        
    }
    return cell;
}

#pragma mark-addModel-添加彩种
-(void)addModel:(MCUserDefinedLotteryCategoriesModel * )model{
    
    [self.userSelectedCZMarray addObject:model];
    
    [self setMarr_Section];
    
}

#pragma mark-removeModel-删除彩种
-(void)removeModel:(MCUserDefinedLotteryCategoriesModel * )model{
    
    for (MCUserDefinedLotteryCategoriesModel * item in _userSelectedCZMarray) {
        if ([item.LotteryID isEqualToString:model.LotteryID]) {
            [_userSelectedCZMarray removeObject:item];
            return;
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
        _tableView.backgroundColor = RGB(255, 255, 255);
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
    //获取用户服务器自定义彩种列表
    MCGetLotteryCustomModel * getLotteryCustomModel=[[MCGetLotteryCustomModel alloc]init];
    weakSelf.getLotteryCustomModel=getLotteryCustomModel;
    
    [self loadCanSaleCZArry:^(BOOL result, NSMutableArray *defaultCZArray) {
        
        if (result) {

            [getLotteryCustomModel refreashDataAndShow];
            getLotteryCustomModel.callBackSuccessBlock = ^(id manager) {
                NSString * CustomItem=manager[@"CustomItem"];
                [weakSelf CombinData:CustomItem andCompeletion:^(BOOL result, NSMutableArray *defaultCZArray) {
                    compeletion(result,defaultCZArray);
                }];
            };
            
            getLotteryCustomModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
                compeletion(NO,nil);
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
    NSArray *Arry;
    if ([CustomItem isKindOfClass:[NSNull class]] || [CustomItem isEqualToString:@""] || CustomItem == nil) {
//        return;
        Arry = @[];
    }else{
        Arry = [CustomItem componentsSeparatedByString:@","];
    }
   
    
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
    
    for (MCUserDefinedLotteryCategoriesModel * model in _userSelectedCZMarray) {
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









