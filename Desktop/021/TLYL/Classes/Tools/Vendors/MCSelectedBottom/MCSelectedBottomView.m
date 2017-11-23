//
//  MCSelectedBottomView.m
//  TLYL
//
//  Created by MC on 2017/7/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSelectedBottomView.h"
#import "MCSelectedBottomTableViewCell.h"
#import "MCMineCellModel.h"
#import "MCDataTool.h"

#define ProvinceIDArr @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35"]
//sdb : {name:'平安银行',logo:'images/bank/sdb.png'},
//cpb : {name:'平安银行'},  //充值
//citic : {name:'中信银行',logo:'images/bank/citic.png'},
//ecitic : {name:'中信银行'},  //充值

#define AddBankIDArr @[@"icbc",@"abc",@"ccb",@"comm",@"cmb",@"boc",@"cib",@"bos",@"ecitic",@"ceb",@"psbc",@"sdb",@"cmbc",@"hxb",@"spdb",@"bob",@"cbhb",@"gzb",@"bod",@"hzb",@"czb",@"gdb",@"citic"]

@interface MCSelectedBottomView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic, assign)Type_Bottom type;
@property(nonatomic, strong)NSMutableArray*marr_Section;
@property(nonatomic, strong)UITableView *tableView;

@end

@implementation MCSelectedBottomView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
    }
    return self;
}

#pragma mark==================createUI======================
-(void)createUI{

    _marr_Section =[[NSMutableArray alloc]init];
    self.backgroundColor=RGB(213, 220, 226);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 键盘会当tableView上下滚动的时候自动收起
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.and.right.equalTo(self).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];

}
-(void)reloadDataWithType:(Type_Bottom)type andDataSource:(NSArray *)arr_FastPayment{
    NSDictionary * dicB=[MCDataTool MC_GetDic_Bank];
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    for (NSString * item in arr_FastPayment) {
        MCBankModel * model=[[MCBankModel alloc]init];
        model.bankId=item;
        model.bankLogo=dicB[item][@"logo"];
        model.bankName=dicB[item][@"name"];
        [marr addObject:model];
    }
    
    [_tableView  setContentOffset:CGPointMake(0,0) animated:NO];
    _type=type;
    [self setDataSource:marr];

}
-(void)reloadDataWithType:(Type_Bottom)type andModel:(MCBankModel *)model{
    
    [_tableView  setContentOffset:CGPointMake(0,0) animated:NO];

    
    _type=type;
     NSMutableArray * marr=[[NSMutableArray alloc]init];
    
    
    if (type==ProvinceType) {
       
        NSDictionary * dicP=[MCDataTool MC_GetDic_Province];
        for (NSString * item in ProvinceIDArr) {
            MCBankModel * model=[[MCBankModel alloc]init];
            model.provinceId=item;
            model.provinceName=dicP[item];
            [marr addObject:model];
        }
        [self setDataSource:marr];
        
    }else if (type==CityType){
        
        NSDictionary * dicC=[MCDataTool MC_GetDic_City];

        NSArray * arr = dicC[model.provinceName][@"city"];
        
        for (NSDictionary * item in arr) {
            MCBankModel * model=[[MCBankModel alloc]init];
            model.cityId=item[@"cityId"];
            model.cityName=item[@"cityName"];
            [marr addObject:model];
        }
        [self setDataSource:marr];
        
    }else if (type==BankType){
  
        NSDictionary * dicB=[MCDataTool MC_GetDic_Bank];
        
        for (NSString * item in AddBankIDArr) {
            MCBankModel * model=[[MCBankModel alloc]init];
            model.bankId=item;
            model.bankLogo=dicB[item][@"logo"];
            model.bankName=dicB[item][@"name"];
            [marr addObject:model];
        }
        [self setDataSource:marr];

    }
}

-(void)setDataSource:(NSMutableArray *)dataSource{
    
    [_marr_Section removeAllObjects];
    
    NSMutableArray * marr_model = [[NSMutableArray alloc]init];
    
    for (NSString * item in dataSource) {
        CellModel* Cmodel =[[CellModel alloc]init];
        Cmodel.reuseIdentifier = [NSString stringWithFormat:@"%@",NSStringFromClass([MCSelectedBottomTableViewCell class])];
        Cmodel.className=NSStringFromClass([MCSelectedBottomTableViewCell class]);
        Cmodel.height = [MCSelectedBottomTableViewCell computeHeight:nil];
        Cmodel.selectionStyle=UITableViewCellSelectionStyleNone;
        Cmodel.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        Cmodel.userInfo = item;
        
        [marr_model addObject:Cmodel];
    }

    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr_model];
    model0.headerhHeight=10;
    model0.footerHeight=10;
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.footerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel *sm = _marr_Section[section];
    return sm.headerhHeight;
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
    
    
    if ([cm.className isEqualToString:NSStringFromClass([MCSelectedBottomTableViewCell class])]) {
        
        MCSelectedBottomTableViewCell *ex_cell=(MCSelectedBottomTableViewCell *)cell;

        MCBankModel * model = cm.userInfo;
        if (_type==ProvinceType) {
            //省份选择
            ex_cell.dataSource=model.provinceName;
            
        }else if (_type==CityType){
            
            //市区选择
           ex_cell.dataSource=model.cityName;
            
        }else if (_type==BankType||_type==FastPayType){
            
            //银行选择
            ex_cell.dataSource=model.bankName;
            
        }
  
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionModel *sm = _marr_Section[indexPath.section];
    CellModel *cm = sm.cells[indexPath.row];
    
    if (_type==ProvinceType) {
        //省份选择
        if ([self.delegate respondsToSelector:@selector(MCSelectedBottom_Province:)]) {
            [self.delegate MCSelectedBottom_Province:cm.userInfo];
        }
        
    }else if (_type==CityType){
        
        //市区选择
        if ([self.delegate respondsToSelector:@selector(MCSelectedBottom_City:)]) {
            [self.delegate MCSelectedBottom_City:cm.userInfo];
        }
        
    }else if (_type==BankType||_type==FastPayType){
        
        //银行选择
        if ([self.delegate respondsToSelector:@selector(MCSelectedBottom_Bank:)]) {
            [self.delegate MCSelectedBottom_Bank:cm.userInfo];
        }
        
    }

}



@end














































