//
//  MCRechargePaymentTypeTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargePaymentTypeTableViewCell.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCRechargeCollectionViewCell.h"
#import "MCMineCellModel.h"
#import "MCGroupPaymentModel.h"

@interface MCRechargePaymentTypeTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic,strong) UILabel* titleLab;
@property (nonatomic,strong) NSMutableArray*cellMarr;
@end

@implementation MCRechargePaymentTypeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor  clearColor];
    
    _titleLab =[[UILabel alloc]initWithFrame:CGRectZero];
    _titleLab.textColor=RGB(102, 102, 102);
    _titleLab.font=[UIFont boldSystemFontOfSize:12];
    _titleLab.text =@"请选择充值方式:";
    _titleLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_titleLab];
   
    _titleLab.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, 30);

    
    [self addSubview:self.collectionView];
    

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(45);
        make.bottom.equalTo(self.mas_bottom).offset(-5);

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
        [_collectionView registerClass:[MCRechargeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCRechargeCollectionViewCell class])];
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
//// 设置section头视图的参考大小，与tableheaderview类似
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    BKIntegralCollectionModel * model=self.cellMarr[section];
//    return model.header_size;
//}
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
    if (self.cellMarr.count<section+1) {
        return 0;
    }
    CollectionModel * model=self.cellMarr[section];
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCRechargeCollectionViewCell class])]) {
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
    
#pragma mark - /Users/miaocai/Desktop/tl/ios/TLYL/TLYL/Classes/Mine/View/MCRecharge/MCRechargePaymentTypeTableViewCell.m:155:5: nil returned from a method that is expected to return a non-null value
    UICollectionViewCell*  cell=nil;
    CollectionModel * model=self.cellMarr[indexPath.row];
    if (model.id_dentifier) {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:model.id_dentifier forIndexPath:indexPath];
    }
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCRechargeCollectionViewCell class])]) {
        
        MCRechargeCollectionViewCell *ex_cell=(MCRechargeCollectionViewCell *)cell;

        if (model.userInfo) {
            ex_cell.dataSource=model.userInfo;
        }
        
    }
 
    return cell;
}

//didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.cellMarr[indexPath.row];
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCRechargeCollectionViewCell class])]) {
        /*
         * 选择付款方式
         */
        if ([self.delegate respondsToSelector:@selector(celldidSelectPaymentType:)]) {
            [self.delegate celldidSelectPaymentType:model.userInfo];
        }
    }
}


+(CGFloat)computeHeight:(NSUInteger)info{
    if (info<7) {
        return 125+5;
    }else{
        CGFloat H=125+5+(int)ceil((info-6) / 3.0) * 50;
        return H;
    }
    
}

-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    CGFloat  W= (G_SCREENWIDTH-20-27*2)/3.0;
    if (_cellMarr.count<1) {
        NSArray * arr=dataSource;
        for (MCPaymentModel * model in arr) {
        
            CollectionModel * model0=[[CollectionModel alloc]init];
            model0.header_size=CGSizeMake(G_SCREENWIDTH, 40);
            model0.item_size=CGSizeMake(W, 34);
            model0.section_color=[UIColor whiteColor];
            model0.section_Edge=UIEdgeInsetsMake(0, 10, 0, 10);
            model0.interitemSpacing=0.1;
            model0.lineSpacing=10;
            model0.isHaveHeader=YES;
            model0.id_dentifier=NSStringFromClass([MCRechargeCollectionViewCell class]);
            /*
             * info
             */
            model0.userInfo=model;
            [_cellMarr addObject:model0];
        }
        
        [_collectionView reloadData];
        
        /*
         * 设置默认选择
         */
        if (self.cellMarr.count>0) {
            [self.collectionView  selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            if ([self.delegate respondsToSelector:@selector(celldidSelectPaymentType:)]) {
                CollectionModel * model=self.cellMarr[0];
                [self.delegate celldidSelectPaymentType:model.userInfo];
            }
        }
        
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end






































