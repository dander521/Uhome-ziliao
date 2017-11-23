//
//  MCLotteryRecordTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/9/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryRecordTableViewCell.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCLotteryRecordCollectionViewCell.h"
#import "MCMineCellModel.h"

#pragma mark-Cell
@interface MCLotteryRecordTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic,strong)UILabel *lab_left;

@property (nonatomic,strong) UICollectionView* collectionView;

@property (nonatomic,strong) NSMutableArray*cellMarr;

@end

@implementation MCLotteryRecordTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    UILabel * lab_left=[[UILabel alloc]init];
    [self addSubview:lab_left];
    _lab_left=lab_left;
    _lab_left.textAlignment=NSTextAlignmentLeft;
    _lab_left.text=@"加载中...";
    _lab_left.font=[UIFont systemFontOfSize:14];
    _lab_left.textColor=RGB(68, 68, 68);
    [_lab_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(10);
//        make.width.mas_equalTo(90);
    }];
    
    [self addSubview:self.collectionView];
    
    self.collectionView.backgroundColor=[UIColor clearColor];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lab_left.mas_right).offset(10);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}
/*
 * collectionView
 */
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        //创建一个layout布局类
        MCCollectionViewFlowLayout * layout = [[MCCollectionViewFlowLayout alloc]init];
        //设置布局方向为横向流布局
        //        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        [_collectionView registerClass:[MCLotteryRecordCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCLotteryRecordCollectionViewCell class])];
        
    }
    return _collectionView;
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
    CollectionModel * model=self.cellMarr[section];
    return model.section_color;
}
//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.cellMarr[indexPath.section];
    return model.item_size;
}
//设置section的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    CollectionModel * model=self.cellMarr[section];
    return model.section_Edge;
}
// 两个cell之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    CollectionModel * model=self.cellMarr[section];
    return model.interitemSpacing;
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    CollectionModel * model=self.cellMarr[section];
    return model.lineSpacing;
}

//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    CollectionModel * model=self.cellMarr[section];
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCLotteryRecordCollectionViewCell class])]) {
        return self.cellMarr.count;
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
            
            [ex_cell relayOutCellWithDataSource:model.userInfo andType:2 andIndex:indexPath.row];
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



- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setDataSource:(id)dataSource{
    
    _cellMarr=[[NSMutableArray alloc]init];
    [_cellMarr removeAllObjects];
    _dataSource=dataSource;
    NSDictionary * dic=dataSource;
    NSString * CzPeriod = dic[@"CzPeriod"];
    NSString * CzNum=dic[@"CzNum"];
    if (CzPeriod.length>=10&&[_model.tag containsString:@"mmc"]) {
        CzPeriod = [CzPeriod substringFromIndex:8];
    }
    _lab_left.text=[NSString stringWithFormat:@"%@期",CzPeriod];//@"0511023"
    
    CGFloat W_CzPeriod=14*_lab_left.text.length;
    if (_lab_left.text.length<4) {
        W_CzPeriod+=10;
    }
    
    NSArray * numArr=[CzNum componentsSeparatedByString:@","];
    NSInteger count = [MCMathUnits getBallCountWithCZType:_model.type];
    
    if (count<numArr.count) {
    }else{
        count = numArr.count;
    }
    
    CGFloat W=[MCLotteryRecordTableViewCell computeWidth:_model andWidth:G_SCREENWIDTH-20-90-10];

    [_lab_left mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset((W-14)/2.0);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(W_CzPeriod);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    for (int i =0 ; i<count ; i++) {
        CollectionModel * model0=[[CollectionModel alloc]init];
        model0.header_size=CGSizeMake(0, 0);
        model0.item_size=CGSizeMake(W, W);
        model0.section_color=[UIColor clearColor];
        model0.section_Edge=UIEdgeInsetsMake(2, 0, 5, 10);
        model0.interitemSpacing=[MCLotteryRecordTableViewCell computeInteritemSpacing:_model andWidth:G_SCREENWIDTH-20-100];
        model0.lineSpacing=[MCLotteryRecordTableViewCell computeLineSpacing:_model andWidth:G_SCREENWIDTH-20-100];
        model0.isHaveHeader=YES;
        model0.id_dentifier=NSStringFromClass([MCLotteryRecordCollectionViewCell class]);
        /*
         * info
         */
        model0.userInfo=numArr[i];
        [_cellMarr addObject:model0];
    }
    [self.collectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

#pragma mark-
+(CGFloat)computeInteritemSpacing:(MCUserDefinedLotteryCategoriesModel *)info andWidth:(CGFloat)S_W{
    NSInteger ballCount = [MCMathUnits getBallCountWithCZType:info.type];
    if (ballCount>8) {
        return 2;
    }else if(ballCount>5){
        return 3;
    }else{
        return 8;
    }
}
#pragma mark-获取tableViewCell的小球的宽度
+(CGFloat)computeWidth:(MCUserDefinedLotteryCategoriesModel *)info andWidth:(CGFloat)S_W{
    return 18;
}

#pragma mark-获取tableViewCell的高度
+(CGFloat)computeHeight:(MCUserDefinedLotteryCategoriesModel *)info andWidth:(CGFloat)S_W{

    CGFloat W = [MCLotteryRecordTableViewCell computeWidth:info andWidth:S_W];
    
    CGFloat InteritemSpacing=[MCLotteryRecordTableViewCell computeInteritemSpacing:info andWidth:S_W];
    
    NSInteger ballCount = [MCMathUnits getBallCountWithCZType:info.type];
    CGFloat H = 0;
    
    
    int countLine=floorf((S_W - InteritemSpacing*(ballCount-1))/W);
    
    if (countLine>10) {
        countLine=10;
    }
    
    int line = ceilf((1.00*ballCount)/countLine);
    
    if (line>1) {
        H= (W + 5)*line +5;
    }else{
        H= W + 10;
    }
    
    return H;
}


+(CGFloat)computeLineSpacing:(MCUserDefinedLotteryCategoriesModel *)info andWidth:(CGFloat)S_W{
    return 5;
}


@end


