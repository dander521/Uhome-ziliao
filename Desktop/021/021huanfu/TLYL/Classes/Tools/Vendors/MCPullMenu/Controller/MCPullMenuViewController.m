//
//  MCPullMenuViewController.m
//  TLYLSF
//
//  Created by MC on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCPullMenuViewController.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCMineCellModel.h"
#import "MCPullMenuModel.h"
#import "MCDataTool.h"
#import "MCPullMenuSelectedCollectionViewCell.h"
#import "MCPullMenuHeader.h"
#import "MCPullMenuTool.h"

#define HEIGHT_MENU G_SCREENHEIGHT-40-64
@implementation WFModel
@end
@interface MCPullMenuViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIAlertViewDelegate,
MCMenuCellDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource
>


//上面的collectionView
@property(nonatomic,strong) UICollectionView *selectedCollectionView;
@property(nonatomic, strong)NSMutableArray * collectionViewMarray;

/**左边的tableView 一级菜单*/
@property(nonatomic,strong) UITableView *tableView;


/**UITableView的数据源*/
@property(nonatomic,strong) NSMutableArray <SectionModel *>* marr_Section;

/***/
@property(nonatomic,strong) NSDictionary   * dic_CZHelper;

/***/
@property(nonatomic,strong) NSDictionary   * dic_CZ;

/***/
@property(nonatomic,strong) NSDictionary   * dic_WFHelper;

@property(nonatomic,strong) NSArray * marr_Title;

@property(nonatomic,strong) NSMutableArray * dataSource;

/**状态值*/
@property(nonatomic,assign)FinishOrEditType Type;
@end

@implementation MCPullMenuViewController
#pragma mark-life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self  checkOutLotteryId];
    [self  updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    [self  setProperty];
    [self  createUI];
    [self  loadData];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
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
        [_selectedCollectionView registerClass:[MCPullMenuSelectedCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCPullMenuSelectedCollectionViewCell class])];
        
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
    CGFloat W = ( G_SCREENWIDTH-20-20 )/3.0;
    CGFloat H = 29 ;
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
    return 5;
}
//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionViewMarray.count;
}

//numberOfSections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//UICollectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MCPullMenuSelectedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MCPullMenuSelectedCollectionViewCell class]) forIndexPath:indexPath];
    [cell relayOutData:self.collectionViewMarray[indexPath.row] withType:_Type];
    NSDictionary *dic=self.collectionViewMarray[indexPath.row];
    if ([dic[@"playOnlyNum"] isEqualToString:_lotteriesTypeModel.playOnlyNum]) {
        [cell setCellSelected:YES];
    }else{
        [cell setCellSelected:NO];
    }
    return cell;
}

#pragma mark-didSelect
#pragma mark-【collectionView上面】点击删除/跳转已经选择的彩种
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary * dic=self.collectionViewMarray[indexPath.row];
    MCBasePWFModel *baseWFmodel = [MCBasePWFModel mj_objectWithKeyValues:dic];

    if (_Type==FinishType) {//完成状态
        if ([self.delegate respondsToSelector:@selector(selectLotteryKindWithTag:)]) {
            [self.delegate selectLotteryKindWithTag:baseWFmodel];
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    }else if(_Type==EditType){//编辑状态
        [_collectionViewMarray removeObject:dic];
        [self.selectedCollectionView reloadData];
        [self loadData];
    }
}

-(void)setSelectedState{
    /*
     * 如果传入玩法ID  就选玩法ID  没有就默认选中第二级玩法的第一个
     */
    NSIndexPath *indexPath;
    int i=0,j=0;
    if (_lotteriesTypeModel.typeId.length>0) {
        for (MCMenuDataModel * Dmodel in _dataSource) {
            if ([Dmodel.typeId isEqualToString:_lotteriesTypeModel.typeId]) {
                indexPath= [NSIndexPath indexPathForRow:i inSection:0];
                j=i;
            }
            i++;
        }
    }
    if (!indexPath) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    MCPullMenuTableViewCell *ex_cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (_lotteriesTypeModel.playOnlyNum.length>1) {
        int k=0;
        MCMenuDataModel * DDmodel = _dataSource[j];
        for (NSDictionary * dic in DDmodel.dataSource) {
            if ([dic[@"playOnlyNum"] isEqualToString:_lotteriesTypeModel.playOnlyNum]) {
                [ex_cell.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:k inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            }
            k++;
        }
        
    }else{
        [ex_cell.collectionView  selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
}
#pragma mark-【tableview上面的彩种】点击选择彩种玩法
- (void)cellDidSelectWithDic:(NSDictionary *)dic{
    MCBasePWFModel *baseWFmodel = [MCBasePWFModel mj_objectWithKeyValues:dic];
    if (_Type==FinishType) {//完成状态
        if ([self.delegate respondsToSelector:@selector(selectLotteryKindWithTag:)]) {
            [self.delegate selectLotteryKindWithTag:baseWFmodel];
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    }else if(_Type==EditType){//编辑状态
        if ([_collectionViewMarray containsObject:dic]) {
            return;
        }
        if (_collectionViewMarray.count>=9) {
            [SVProgressHUD showInfoWithStatus:@"最多只能添加9个玩法！"];
            return;
        }
        [_collectionViewMarray addObject:dic];
        
        [self loadData];
        [self.selectedCollectionView reloadData];
    }
}

#pragma mark-校验传过来的彩种ID是否正确
-(void)checkOutLotteryId{
    if (!_lotteriesTypeModel.LotteryID||_lotteriesTypeModel.LotteryID.length<1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你没有传入彩种ID" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        return;
    }else{
        
        if ([self.dic_CZHelper objectForKey:_lotteriesTypeModel.LotteryID]) {
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到该彩种" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
            return;
        }
    }
}

#pragma mark==================setProperty======================
-(void)setProperty{
    
    _dataSource  =[[NSMutableArray alloc]init];
    _marr_Section=[[NSMutableArray alloc]init];
    _collectionViewMarray=[[NSMutableArray alloc]init];
    _collectionViewMarray=[MCPullMenuTool GetSelectedWFMarrayWithCZID:_lotteriesTypeModel.LotteryID];
    
    _Type=FinishType;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title=NSStringFromClass([self class]);
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.clipsToBounds = NO;
    }
}

#pragma mark==================createUI======================
-(void)createUI{
    
    self.view.backgroundColor=RGB(231,231,231);

//    [self createUpView];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame=CGRectMake(0, 0, G_SCREENWIDTH, HEIGHT_MENU);
//    self.tableView.frame=CGRectMake(0, 160, G_SCREENWIDTH, HEIGHT_MENU-160);
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.estimatedRowHeight = 10;
    
}

-(void)createUpView{
    UIView * upView =[[UIView alloc]init];
    upView.frame=CGRectMake(0, 0, G_SCREENWIDTH, 150);
    [self.view addSubview:upView];
    upView.backgroundColor=[UIColor whiteColor];
    
    UILabel * lab =[[UILabel alloc]init];
    lab.backgroundColor=RGB(120, 0, 179);
    [upView addSubview:lab];
    lab.frame=CGRectMake(10, 7, 2, 16);
    
    
    UILabel *maintitleLab= [UILabel new];
    maintitleLab.layer.masksToBounds = YES;
    maintitleLab.textColor=RGB(120, 0, 179);
    maintitleLab.font = [UIFont systemFontOfSize:15];
    maintitleLab.numberOfLines=1;
    maintitleLab.text = @"自定义";
    maintitleLab.textAlignment=NSTextAlignmentLeft;
    [upView addSubview:maintitleLab];
    [maintitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab.mas_centerY);
        make.left.equalTo(lab.mas_right).offset(5);
        make.width.mas_equalTo(G_SCREENWIDTH);
        make.height.mas_equalTo(20);
    }];
    
    UIButton * btnSaveOrEdit=[[UIButton alloc]init];
    [upView addSubview:btnSaveOrEdit];
    btnSaveOrEdit.layer.cornerRadius=10;
    btnSaveOrEdit.clipsToBounds=YES;
    btnSaveOrEdit.backgroundColor=RGB(144,8,215);
    btnSaveOrEdit.titleLabel.font=[UIFont systemFontOfSize:12];
    [btnSaveOrEdit setTitle:@"编辑" forState:UIControlStateNormal];
    [btnSaveOrEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSaveOrEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab.mas_centerY);
        make.right.equalTo(upView.mas_right).offset(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    [btnSaveOrEdit addTarget:self action:@selector(actionSaveOrEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    [upView addSubview:self.selectedCollectionView];
    self.selectedCollectionView.backgroundColor=[UIColor clearColor];
    self.selectedCollectionView.frame=CGRectMake(0, 30, G_SCREENWIDTH, 150-30);
    
    UILabel *tipLab= [UILabel new];
    tipLab.textColor=RGB(165,165,165);
    tipLab.font = [UIFont systemFontOfSize:9];
    tipLab.numberOfLines=1;
    tipLab.text = @"最多可收藏9个玩法，如要添加新玩法，请先去掉默认收藏。";
    tipLab.textAlignment=NSTextAlignmentCenter;
    [upView addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView.mas_top).offset(133);
        make.left.equalTo(upView.mas_left).offset(10);
        make.right.equalTo(upView.mas_right).offset(-10);
        make.height.mas_equalTo(11);
    }];
}
#pragma mark-选择状态
-(void)actionSaveOrEdit:(UIButton *)btn{
    NSLog(@"------%@",btn.titleLabel.text);
    if ([btn.titleLabel.text isEqualToString:@"编辑"]) {
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        _Type=EditType;
        [self.selectedCollectionView reloadData];
        [self.tableView reloadData];
    }else if ([btn.titleLabel.text isEqualToString:@"完成"]){
        [MCPullMenuTool SaveSelectedWFMarrayWithCZID:_lotteriesTypeModel.LotteryID andMarray:_collectionViewMarray];
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        _Type=FinishType;
        [self.selectedCollectionView reloadData];
        [self.tableView reloadData];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark==================loadData======================
-(void)loadData{
    [_dataSource removeAllObjects];
    /*
     *  根据传入的ID  获取彩种信息
     */
    NSDictionary * czInfo=[self.dic_CZHelper objectForKey:_lotteriesTypeModel.LotteryID];
    MCCZHelperModel * modelCZ=[MCCZHelperModel mj_objectWithKeyValues:czInfo];
    NSLog(@"%@-%@-%@-%@",modelCZ.tag,modelCZ.type,modelCZ.name,modelCZ.logo);
    
    _marr_Title=[[self.dic_WFHelper objectForKey:modelCZ.type] objectForKey:@"playType"];
    
    
    //    玩法二级字典组
    NSDictionary * mdic=[[self.dic_WFHelper objectForKey:modelCZ.type] objectForKey:@"playMethod"];
    for (NSDictionary * temp in _marr_Title) {
        
        WFModel * Wmodel=[self isCanAddWithTypeId:temp[@"typeId"] andCZTag:modelCZ.tag andDataSource:[mdic objectForKey:temp[@"typeId"]]];
        
        if (Wmodel.isCanAdd) {
            MCMenuDataModel * model =[[MCMenuDataModel alloc]init];
            model.name=temp[@"name"];
            model.typeId=temp[@"typeId"];
            model.dataSource=Wmodel.dataSource;
            [_dataSource addObject:model];
            
        }
    }
    
    [self createMarr_Section];
}

-(WFModel *)isCanAddWithTypeId:(NSString *)typeId andCZTag:(NSString *)czTag andDataSource:(NSArray * )marr{
    
    WFModel * model = [[WFModel alloc]init];
    NSMutableArray * Dmarr=[[NSMutableArray alloc]init];
    NSMutableArray * dataSource=[[NSMutableArray alloc]init];
    BOOL isCan =YES;
    NSString * firstTypeID=@"0";
    
    //【015】时时彩（新疆 天津 北京 重庆 台湾五分彩）去掉龙虎斗
    //去掉龙虎
    if([typeId isEqualToString:@"14"]){
        if ([czTag isEqualToString:@"xjssc"]||[czTag isEqualToString:@"tjssc"]||[czTag isEqualToString:@"bjssc"]||[czTag isEqualToString:@"cqssc"]||[czTag isEqualToString:@"twwfc"]){
            
            isCan=NO;
            
        }
    }
    
    //去掉骰宝
    if ([typeId isEqualToString:@"15"]){
        isCan=NO;
    }
    
    //qqffc bjssc twwfc
    //台湾五分彩/北京时时彩/QQ分分彩   台湾五分彩/北京时时彩
    if ([czTag isEqualToString:@"qqffc"]||[czTag isEqualToString:@"bjssc"]||[czTag isEqualToString:@"twwfc"]){
        
        //去掉 五星  四星  不定位
        if ([typeId isEqualToString:@"0"]||[typeId isEqualToString:@"1"]||[typeId isEqualToString:@"12"]) {
            isCan = NO;
            firstTypeID=@"2";
        }
        
        // 台湾五分彩/北京时时彩/QQ分分彩  去掉 不定位(8)的四星五星 。
        if([typeId intValue]==8){
            
            [Dmarr addObject:marr[0]];
            [Dmarr addObject:marr[1]];
            [Dmarr addObject:marr[2]];
            [Dmarr addObject:marr[3]];
            
        }
    }
    
    //          jsuesf   gdesf  ahesf sdesf jxesf shesf
    //官方11选5（江苏11选5  广东11选5  安徽  山东  江西  上海）：屏蔽掉任选五中五单式和胆拖。
    if ([czTag isEqualToString:@"jsuesf"]||[czTag isEqualToString:@"gdesf"]||[czTag isEqualToString:@"ahesf"]||[czTag isEqualToString:@"sdesf"]||[czTag isEqualToString:@"jxesf"]||[czTag isEqualToString:@"shesf"]) {
        
        if ([typeId intValue]==7) {
            
            [Dmarr addObject:marr[0]];
            [Dmarr addObject:marr[1]];
            [Dmarr addObject:marr[2]];
            [Dmarr addObject:marr[3]];
            
            [Dmarr addObject:marr[5]];
            [Dmarr addObject:marr[6]];
            [Dmarr addObject:marr[7]];
            
            
        }else if ([typeId intValue]==8){
            
            [Dmarr addObject:marr[0]];
            [Dmarr addObject:marr[1]];
            [Dmarr addObject:marr[2]];
            
            [Dmarr addObject:marr[4]];
            [Dmarr addObject:marr[5]];
            [Dmarr addObject:marr[6]];
            
        }
    }
    
    if (Dmarr.count<1) {
        [Dmarr addObjectsFromArray:marr];
    }
    
    
    if (_lotteriesTypeModel.typeId.length>0) {
        firstTypeID=_lotteriesTypeModel.typeId;
    }
    
    if ([typeId isEqualToString:firstTypeID]) {
        int i=0;
        for (NSDictionary * dic in Dmarr) {
            
            //有默认选择的
            if (_lotteriesTypeModel.playOnlyNum.length>1) {
                
                if ([dic[@"playOnlyNum"] isEqualToString:_lotteriesTypeModel.playOnlyNum]) {
                    
                    [dataSource addObject:[self getModelWithSelected:YES andDic:dic]];
                    
                }else{
                    [dataSource addObject:[self getModelWithSelected:NO andDic:dic]];
                }
                
            }else{
                if (i==0) {
                    [dataSource addObject:[self getModelWithSelected:YES andDic:dic]];
                }else{
                    [dataSource addObject:[self getModelWithSelected:NO andDic:dic]];
                }
                
            }
            
            i++;
        }
        
    }else{
        for (NSDictionary * dic in Dmarr) {
            [dataSource addObject:[self getModelWithSelected:NO andDic:dic]];
        }
    }
    model.dataSource=dataSource;
    model.isCanAdd=isCan;
    return model;
}

-(MCPullMenuCollectionCellModel *)getModelWithSelected:(BOOL)isSelected andDic:(NSDictionary *)dic{
    MCPullMenuCollectionCellModel * model =[[MCPullMenuCollectionCellModel alloc]init];
    model.dic=dic;
    model.isSelected = isSelected;
    if (isSelected) {
        model.type=UsingSelectedType;
    }else{
        model.type=WithoutSelectedType;
    }
    BOOL isHad=NO;
    for (NSDictionary * item in _collectionViewMarray) {
        if ([item[@"playOnlyNum"] isEqualToString:dic[@"playOnlyNum"]]) {
            isHad=YES;
        }
    }
    if (isHad) {
        model.type=HadSelectedType;
    }
    return model;
}

#pragma mark-构建菜单
-(void)createMarr_Section{
    
    [_marr_Section removeAllObjects];
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    for(int i=0 ;i<_dataSource.count; i++){
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = [NSString stringWithFormat:@"%@-%d",NSStringFromClass([MCPullMenuTableViewCell class]),i];
        model.className=NSStringFromClass([MCPullMenuTableViewCell class]);
        model.height = [MCPullMenuTableViewCell computeHeight:[_dataSource objectAtIndex:i]];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo = [_dataSource objectAtIndex:i];
        [marr addObject:model];
    }
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr];
    model0.headerhHeight=13;
    model0.footerHeight=0.0001;
    [_marr_Section addObject:model0];
    [self.tableView reloadData];
    
    
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
    
    if ([cm.className isEqualToString:NSStringFromClass([MCPullMenuTableViewCell class])]) {
        
        MCPullMenuTableViewCell *ex_cell=(MCPullMenuTableViewCell *)cell;
        [ex_cell relayOutData:cm.userInfo withType:_Type];
        ex_cell.delegate=self;
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
    
}

#pragma mark-更新高度
- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection{
    
    self.preferredContentSize = CGSizeMake(G_SCREENWIDTH, HEIGHT_MENU);
    
}
- (void)dealloc{
    
    NSLog(@"updatePreferredContentSizeWithTraitCollection----dealloc");
}

#pragma mark-懒加载
-(NSDictionary *)dic_CZ{
    if (!_dic_CZ) {
        _dic_CZ = [MCDataTool MC_GetDic_CZ];
    }
    return _dic_CZ;
}

-(NSDictionary *)dic_CZHelper{
    if (!_dic_CZHelper) {
        _dic_CZHelper = [MCDataTool MC_GetDic_CZHelper];
    }
    return _dic_CZHelper;
}
-(NSDictionary *)dic_WFHelper{
    if (!_dic_WFHelper) {
        _dic_WFHelper = [MCDataTool MC_GetDic_WFHelper];
    }
    return _dic_WFHelper;
}

+(MCBasePWFModel*)Get_DefaultDicWithID:(NSString *)LotteryCode and:(NSString * )PlayCode{
    
    //    if (PlayCode.length>0) {
    //        NSDictionary * dicCZHelper=[MCDataTool MC_GetDic_CZHelper];
    //        NSDictionary * dicCZ=dicCZHelper[LotteryCode];
    //        //    "type": "ssc",
    //        NSString * type = dicCZ[@"type"];
    //
    //        NSDictionary * dicWFHelper = [MCDataTool MC_GetDic_WFHelper];
    //        NSDictionary * dicCZ_WF = dicWFHelper[type];
    //
    //        NSDictionary *dicPlayMethod=dicCZ_WF[@"playMethod"];
    //        NSArray *dicKeyArr = dicPlayMethod.allValues;
    //        NSMutableArray * marrrry=[[NSMutableArray alloc]init];
    //
    //        for (NSArray * aa in dicKeyArr) {
    //            for (NSDictionary *tt in aa) {
    //                [marrrry addObject:tt];
    //            }
    //
    //        }
    //
    //        NSString * methodId =[PlayCode stringByReplacingOccurrencesOfString:LotteryCode withString:@""];
    //
    //        for (NSDictionary * dic in marrrry) {
    //            if ([dic[@"methodId"] isEqualToString:methodId]) {
    //
    //                MCBasePWFModel *baseWFmodel = [MCBasePWFModel mj_objectWithKeyValues:dic];
    //                baseWFmodel.LotteryID=LotteryCode;
    //                return baseWFmodel;
    //            }
    //        }
    //
    //
    //    }
    /*
     *  根据传入的ID  获取彩种信息
     */
    NSDictionary * dic_CZHelper = [MCDataTool MC_GetDic_CZHelper];
    NSDictionary * czInfo=[dic_CZHelper objectForKey:LotteryCode];
    
    NSString * type = czInfo[@"type"];
    MCCZHelperModel * modelCZ=[MCCZHelperModel mj_objectWithKeyValues:czInfo];
    
    /*
     * 根据type找出玩法
     */
    NSDictionary * dic_WF = [MCDataTool MC_GetDic_WFHelper];
    //    玩法一级数组
    NSMutableArray *  marr_Left=[[dic_WF objectForKey:modelCZ.type] objectForKey:@"playType"];
    //    玩法二级字典组
    NSMutableDictionary * mdic_Right=[[dic_WF objectForKey:modelCZ.type] objectForKey:@"playMethod"];
    
    /*
     * 默认选中第一级玩法的第一个
     */
    if ([type isEqualToString:@"ssc"]) {
        
        MC_PlayType_Model * modelF = [MC_PlayType_Model mj_objectWithKeyValues:marr_Left[2]];
        NSMutableArray * marr_Right=[mdic_Right objectForKey:modelF.typeId];
        MCBasePWFModel *baseWFmodel = [MCBasePWFModel mj_objectWithKeyValues:[marr_Right objectAtIndex:0]];
        baseWFmodel.LotteryID=LotteryCode;
        
        return baseWFmodel;
        
    }else{
        
        MC_PlayType_Model * modelF = [MC_PlayType_Model mj_objectWithKeyValues:marr_Left[0]];
        NSMutableArray * marr_Right=[mdic_Right objectForKey:modelF.typeId];
        MCBasePWFModel *baseWFmodel = [MCBasePWFModel mj_objectWithKeyValues:[marr_Right objectAtIndex:0]];
        baseWFmodel.LotteryID=LotteryCode;
        return baseWFmodel;
        
    }
    
    
    
}

@end

























































