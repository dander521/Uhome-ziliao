//
//  MCBuyLotteryTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/9/15.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBuyLotteryTableViewCell.h"
#import "MCBuyLotteryCollectionViewCell.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCMineCellModel.h"

@interface MCBuyLotteryTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>


@property (nonatomic,strong) NSMutableArray*cellMarr;

@end

@implementation MCBuyLotteryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    
    self.backgroundColor=[UIColor  clearColor];
    
    UIView * upView=[[UIView alloc]init];
    upView.backgroundColor=[UIColor whiteColor];
    [self addSubview:upView];
    [upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    UILabel * lab =[[UILabel alloc]init];
    lab.backgroundColor=RGB(120, 0, 179);
    [upView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(18);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(16);
    }];
    
    _maintitleLab= [UILabel new];
    _maintitleLab.layer.masksToBounds = YES;
    _maintitleLab.textColor=RGB(136, 136, 136);
    _maintitleLab.font = [UIFont systemFontOfSize:15];
    _maintitleLab.numberOfLines=1;
    _maintitleLab.text = @"加载中...";
    _maintitleLab.textAlignment=NSTextAlignmentLeft;
    [upView addSubview:_maintitleLab];
    [_maintitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab.mas_centerY);
        make.left.equalTo(lab.mas_right).offset(5);
        make.width.mas_equalTo(G_SCREENWIDTH);
        make.height.mas_equalTo(20);
    }];
    
    
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor=[UIColor clearColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(upView.mas_bottom).offset(0.5);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    _cellMarr=[[NSMutableArray alloc]init];
    [_cellMarr    removeAllObjects];
    
}

/*
 * collectionView
 */
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        //创建一个layout布局类
        MCCollectionViewFlowLayout * layout = [[MCCollectionViewFlowLayout alloc]init];
        //设置布局方向为横向流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        [_collectionView registerClass:[MCBuyLotteryCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCBuyLotteryCollectionViewCell class])];
        
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
    if (self.cellMarr.count>0) {
        CollectionModel * model=self.cellMarr[section];
        return model.section_color;
    }else{
        return [UIColor clearColor];
    }
}

//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat W = (G_SCREENWIDTH-2)/3.0;
    CGFloat H = W;
    return CGSizeMake(W,H);
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.cellMarr.count>0){
        CollectionModel * model=self.cellMarr[section];
        if ([model.id_dentifier isEqualToString:NSStringFromClass([MCBuyLotteryCollectionViewCell class])]) {
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
    
    UICollectionViewCell*  cell=nil;
    CollectionModel * model=self.cellMarr[indexPath.section];
    if (model.id_dentifier) {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:model.id_dentifier forIndexPath:indexPath];
    }
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCBuyLotteryCollectionViewCell class])]) {
        
        MCBuyLotteryCollectionViewCell *ex_cell=(MCBuyLotteryCollectionViewCell *)cell;
        NSArray * arr=(NSArray*)model.userInfo;
        if (arr.count>indexPath.row) {
            ex_cell.dataSource=[model.userInfo objectAtIndex:indexPath.row];
        }else{
            ex_cell.dataSource=nil;
        }
    }
    return cell;
}

#pragma mark-didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.cellMarr[indexPath.section];
    
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCBuyLotteryCollectionViewCell class])]) {
        if (model.userInfo) {
            if ([self.delegate respondsToSelector:@selector(cellDidSelectWithModel:)]) {
                if ([model.userInfo count]>indexPath.row) {
                    MCUserDefinedLotteryCategoriesModel * Cmodel=[model.userInfo objectAtIndex:indexPath.row];
                    [self.delegate cellDidSelectWithModel:Cmodel];
                }
            }
        }
    }
}

-(void)setDataSource:(NSMutableArray *)dataSource{
    
    _dataSource=dataSource;
    
    
    if (_cellMarr.count>0) {
        
    }else{
        
        CGFloat W = (G_SCREENWIDTH-2)/3.0;
        CGFloat H = W;

        NSInteger count = dataSource.count;
        if (count%3!=0) {
            count=count+(3-count%3);
        }
        for (int i=0; i<count ; i++) {
            CollectionModel * model0=[[CollectionModel alloc]init];
            model0.header_size=CGSizeMake(G_SCREENWIDTH, 0.0001);
            model0.item_size=CGSizeMake(W, H);
            model0.section_color=[UIColor clearColor];
            model0.section_Edge=UIEdgeInsetsMake(0, 0, 0, 0);
            model0.interitemSpacing=10;
            model0.lineSpacing=10;
            model0.isHaveHeader=YES;
            model0.id_dentifier=NSStringFromClass([MCBuyLotteryCollectionViewCell class]);
            /*
             * info
             */
            model0.userInfo=dataSource;
            [_cellMarr addObject:model0];
        }
    }
    
    [self.collectionView reloadData];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
}

+(CGFloat)computeHeight:(id)info{
    
    NSArray * arr=info;
    int  line = ceilf(arr.count/3.0);
    
    return line * ([MCBuyLotteryCollectionViewCell computeHeight:nil]+1) +30;
        
}

@end




































































