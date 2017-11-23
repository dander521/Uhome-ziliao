//
//  MCLotteryRecordView.m
//  TLYL
//
//  Created by MC on 2017/6/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryRecordView.h"
#import "MCLotteryDrawDetailsViewController.h"
#import "UIView+MCParentController.h"
#import "MCMineCellModel.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCLotteryRecordCollectionViewCell.h"

@interface MCLotteryRecordView ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource
>
//背景
@property(nonatomic ,strong)UIImageView * backImgV;

//logo
@property(nonatomic, strong)UIImageView * logoimgV;
//名称：
@property(nonatomic, strong)UILabel * nameLab;
//期号
@property(nonatomic, strong)UILabel * IssueNumberLab;

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray*marr_Section;
@property(nonatomic, strong)NSMutableArray*cellMarr;
@property(nonatomic,strong)UICollectionView * firstCollectionView;
//查看更多
@property(nonatomic,strong)UIButton *btn_detail;
//开奖走势
@property(nonatomic,strong)UIButton *btn_ZouShi;
//小球之间的间隙
@property(nonatomic,assign)CGFloat InteritemSpacing;

//小球宽度
@property(nonatomic,assign)CGFloat item_W;
//小球个数
@property(nonatomic,assign)NSInteger ballcount;
//行数
@property(nonatomic,assign)NSInteger lineCount;
@end

@implementation MCLotteryRecordView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame andModel:(MCUserDefinedLotteryCategoriesModel *)model{
    
    if (self = [super initWithFrame:frame]) {
        self.model=model;
        [self setProperty];
        [self setUpUI];
    }
    return self;
}


-(void)setProperty{
    _marr_Section = [[NSMutableArray alloc]init];
    _cellMarr = [[NSMutableArray alloc]init];
    //小球宽度
    _item_W =0;
    //小球个数
    _ballcount = [MCMathUnits getBallCountWithCZType:_model.type];
    //行数
    _lineCount = 1;
    if (_ballcount>10) {
        _lineCount = 2;
    }
    
    //小球之间的间隙
    _InteritemSpacing=[MCLotteryRecordTableViewCell computeInteritemSpacing:_model andWidth:(G_SCREENWIDTH-20-(15+60+11)-10)];
    CGFloat all_InteritemSpacing=0;
    
    if (_ballcount>10) {
        all_InteritemSpacing=_InteritemSpacing*9.0;
        _item_W = (G_SCREENWIDTH-20-(15+60+11)-10 -all_InteritemSpacing)/10.0;
    }else{
        all_InteritemSpacing=_InteritemSpacing*(_ballcount-1);
        _item_W = (G_SCREENWIDTH-20-(15+60+11)-10.0 -all_InteritemSpacing)/_ballcount;
    }
    if (_lineCount==1) {
        if (_item_W>34) {
            _item_W=34;
        }
    }else if (_lineCount==2){
        if (_item_W>18) {
            _item_W=18;
        }
    }
}

- (void)setUpUI{

    [self createBackView];
    [self createUpView];
    [self createDownView];
    
    [self addSubview:self.btn_detail];
    [self.btn_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(100);
        make. bottom.equalTo(self.mas_bottom).offset(-23);
    }];
//    [self.btn_detail mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset((G_SCREENWIDTH-205)/2.0);
//        make.height.mas_equalTo(28);
//        make.width.mas_equalTo(100);
//        make. bottom.equalTo(self.mas_bottom).offset(-23);
//    }];
    
//    [self addSubview:self.btn_ZouShi];
//    [self.btn_ZouShi mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.btn_detail.mas_right).offset(5);
//        make.height.mas_equalTo(28);
//        make.width.mas_equalTo(100);
//        make. bottom.equalTo(self.mas_bottom).offset(-23);
//    }];
    
    
}

#pragma mark-设置背景
-(void)createBackView{
    
    _backImgV=[[UIImageView alloc]init];
    [self addSubview:_backImgV];
    _backImgV.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, 343);
    UIImage * image = [UIImage imageNamed:@"touzhu-beijing"];

    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    _backImgV.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

#pragma mark-设置头部
-(void)createUpView{
    
    //上面的背景
    _upView=[[UIView alloc]init];
    [_backImgV addSubview:_upView];
    _upView.backgroundColor=RGB(251, 251, 251);
    _upView.frame=CGRectMake(0, 0, G_SCREENWIDTH-20, 84);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_upView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _upView.bounds;
    maskLayer.path = maskPath.CGPath;
    _upView.layer.mask = maskLayer;

    //图标
    _logoimgV=[[UIImageView alloc]init];
    [_upView addSubview:_logoimgV];
    [_logoimgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_upView.mas_centerY);
        make.left.equalTo(_upView.mas_left).offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    _logoimgV.layer.cornerRadius=30;
    _logoimgV.clipsToBounds=YES;
    _logoimgV.image=[UIImage imageNamed:_model.logo];
    

    //名字
    _nameLab = [[UILabel alloc]init];
    [_upView addSubview:_nameLab];
    _nameLab.text=_model.name;
    _nameLab.font=[UIFont systemFontOfSize:16];
    _nameLab.textColor=RGB(0, 0, 0);
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_upView.mas_top).offset(15);
        make.left.equalTo(_logoimgV.mas_right).offset(11);
    }];
    
    //期号
    _IssueNumberLab = [[UILabel alloc]init];
    [_upView addSubview:_IssueNumberLab];
    _IssueNumberLab.text=@"加载中...";
    _IssueNumberLab.font=[UIFont systemFontOfSize:12];
    _IssueNumberLab.textColor=RGB(0, 0, 0);
    [_IssueNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_upView.mas_top).offset(20);
        make.left.equalTo(_nameLab.mas_right).offset(12);
    }];
    
    //第一个开奖号码
    [_upView addSubview:self.firstCollectionView];
    self.firstCollectionView.backgroundColor=[UIColor clearColor];
    [self.firstCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLab.mas_left).offset(0);
        make.right.equalTo(_upView.mas_right).offset(-10);
        make.top.equalTo(_nameLab.mas_bottom).offset(3);
        make. bottom.equalTo(_upView.mas_bottom).offset(-3);
    }];

}

-(void)createDownView{
    [self addSubview:self.tableView];
    
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.frame=CGRectMake(10, 84+10, G_SCREENWIDTH-20, 200);
    [self.tableView setScrollEnabled:YES];
}

#pragma mark==============setDataSource=================
-(void)setDataSource:(id)dataSource{
    if (!dataSource) {
        return;
    }

    _dataSource=dataSource;
    [_marr_Section removeAllObjects];
    [_cellMarr removeAllObjects];
    
    NSArray * arr=dataSource;
    
    int  count = (int)arr.count;
    if (count>7) {
        count=7;
    }
    CGFloat W_CzPeriod=90;
#pragma mark-设置第一个开奖号的数据
    if (count>0) {
        NSDictionary * dic=arr[0];
        NSString * CzNum=dic[@"CzNum"];
        NSString * CzPeriod = dic[@"CzPeriod"];
        if (CzPeriod.length>=10&&[_model.tag containsString:@"mmc"]) {
            CzPeriod=[CzPeriod substringFromIndex:8];
        }
        _IssueNumberLab.text=[NSString stringWithFormat:@"第%@期",CzPeriod];//@"0511023"
        NSArray * numArr=[CzNum componentsSeparatedByString:@","];
        NSString * len=[NSString stringWithFormat:@"%@期",CzPeriod];//@"0511023"
        W_CzPeriod=14*len.length;
        if (len.length<4) {
            W_CzPeriod+=10;
        }
        if (_ballcount<numArr.count) {
        }else{
            _ballcount = numArr.count;
        }
        for (int i =0 ; i<_ballcount ; i++){
            CollectionModel * model0=[[CollectionModel alloc]init];
            model0.header_size=CGSizeMake(0, 0);
            model0.isHaveHeader=YES;
            model0.id_dentifier=NSStringFromClass([MCLotteryRecordCollectionViewCell class]);
            model0.userInfo=numArr[i];
            [_cellMarr addObject:model0];
        }
    }
    [self.firstCollectionView reloadData];
    
    

    NSMutableArray * marr_Model=[[NSMutableArray alloc]init];
    for(int i=1 ;i<count; i++){
        CellModel* model =[[CellModel alloc]init];
        model.reuseIdentifier = NSStringFromClass([MCLotteryRecordTableViewCell class]);
        model.className=NSStringFromClass([MCLotteryRecordTableViewCell class]);
//        model.height = [MCLotteryRecordTableViewCell computeHeight:_model andWidth:G_SCREENWIDTH-20-90-10-20];
        model.height = [MCLotteryRecordTableViewCell computeHeight:_model andWidth:G_SCREENWIDTH-20-W_CzPeriod-10];
        model.selectionStyle=UITableViewCellSelectionStyleNone;
        model.accessoryType=UITableViewCellAccessoryNone;
        /*
         * 传递参数
         */
        model.userInfo = arr[i];
        [marr_Model addObject:model];
    }
    SectionModel *model0=[SectionModel sectionModelWithTitle:@"" cells:marr_Model];
    model0.headerhHeight=10;
    model0.footerHeight=10;
    [_marr_Section addObject:model0];
    [_tableView reloadData];

}

//第一个开奖期号
-(UICollectionView *)firstCollectionView{
    if (!_firstCollectionView) {
        
        //创建一个layout布局类
        MCCollectionViewFlowLayout * layout = [[MCCollectionViewFlowLayout alloc]init];
        //设置布局方向为横向流布局
        //        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _firstCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _firstCollectionView.backgroundColor=[UIColor clearColor];
        _firstCollectionView.dataSource=self;
        _firstCollectionView.delegate=self;
        [_firstCollectionView registerClass:[MCLotteryRecordCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCLotteryRecordCollectionViewCell class])];
        
    }
    return _firstCollectionView;
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
    return CGSizeMake(_item_W, _item_W);
}
//设置section的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (_lineCount==1) {
        return UIEdgeInsetsMake((45-_item_W)/2.0, 0, 0, 0);
    }else if(_lineCount==2){
        return UIEdgeInsetsMake((45-2*_item_W-2)/2.0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// 两个cell之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return _InteritemSpacing;
    
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.cellMarr.count>0) {
        CollectionModel * model=self.cellMarr[section];
        if ([model.id_dentifier isEqualToString:NSStringFromClass([MCLotteryRecordCollectionViewCell class])]) {
            return self.cellMarr.count;
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
    CollectionModel * model=self.cellMarr[indexPath.row];
    if (model.id_dentifier) {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:model.id_dentifier forIndexPath:indexPath];
    }
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCLotteryRecordCollectionViewCell class])]) {
        
        MCLotteryRecordCollectionViewCell *ex_cell=(MCLotteryRecordCollectionViewCell *)cell;
        if ([_model.type isEqualToString:@"pks"]) {
            [ex_cell relayOutCellWithDataSource:model.userInfo andType:3 andIndex:indexPath.row];
        }else{
            [ex_cell relayOutCellWithDataSource:model.userInfo andType:1 andIndex:indexPath.row];
        }
    }
    return cell;
}
#pragma mark-didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.cellMarr[indexPath.section];
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCLotteryRecordCollectionViewCell class])]) {
        
        
    }
}

+(CGFloat)computeHeight:(id)info{
    return  350;
}
#pragma mark-懒加载
-(UIButton *)btn_detail{
    if (!_btn_detail) {
        _btn_detail=[[UIButton alloc]init];
        _btn_detail.backgroundColor=RGB(143, 0, 210);
        [_btn_detail setTitle:@"更多记录" forState:UIControlStateNormal];
        [_btn_detail.titleLabel setFont:[UIFont systemFontOfSize:MC_REALVALUE(15)]];
        [_btn_detail addTarget:self action:@selector(action_detail) forControlEvents:UIControlEventTouchUpInside];
        [_btn_detail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_detail.clipsToBounds=YES;
        _btn_detail.layer.cornerRadius=MC_REALVALUE(5);
    }
    return _btn_detail;
}

-(UIButton *)btn_ZouShi{
    if (!_btn_ZouShi) {
        _btn_ZouShi=[[UIButton alloc]init];
        _btn_ZouShi.backgroundColor=RGB(255,168,0);
        [_btn_ZouShi setTitle:@"开奖走势" forState:UIControlStateNormal];
        [_btn_ZouShi.titleLabel setFont:[UIFont systemFontOfSize:MC_REALVALUE(15)]];
        [_btn_ZouShi addTarget:self action:@selector(action_ZouShi) forControlEvents:UIControlEventTouchUpInside];
        [_btn_ZouShi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_ZouShi.clipsToBounds=YES;
        _btn_ZouShi.layer.cornerRadius=MC_REALVALUE(5);
    }
    return _btn_ZouShi;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark-action_detail
-(void)action_detail{
    if ([self.delegate respondsToSelector:@selector(MCLookAllLotteryRecord)]) {
        [self.delegate MCLookAllLotteryRecord];
    }
    
}
-(void)action_ZouShi{
    if ([self.delegate respondsToSelector:@selector(MCLookKaiJiangZouShi)]) {
        [self.delegate MCLookKaiJiangZouShi];
    }
    
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
    
    if ([cm.className isEqualToString:NSStringFromClass([MCLotteryRecordTableViewCell class])]) {
        
        MCLotteryRecordTableViewCell *ex_cell=(MCLotteryRecordTableViewCell *)cell;
        ex_cell.model=self.model;
        ex_cell.dataSource=cm.userInfo;
        
    }
    return cell;
}


@end

