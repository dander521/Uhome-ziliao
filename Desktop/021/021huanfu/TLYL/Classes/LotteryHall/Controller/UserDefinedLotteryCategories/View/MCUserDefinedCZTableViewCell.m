//
//  MCUserDefinedCZTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCUserDefinedCZTableViewCell.h"
#import "MCDataTool.h"
#import "UIView+MCParentController.h"
#import "MCPickNumberViewController.h"
#import "MCUserDefinedLotteryCategoriesCollectionViewCell.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCMineCellModel.h"
#import "MCUserDefinedLotteryCategoriesViewController.h"
#define HEIGHT_CELL  35


@interface MCUserDefinedCZTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic,strong)NSDictionary * cZHelperDic;


@property(nonatomic, strong)UICollectionView * collectionView;
@property(nonatomic, strong)NSMutableArray * collectionViewMarray;


@end

@implementation MCUserDefinedCZTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    _collectionViewMarray=[[NSMutableArray alloc]init];
    [self addSubview:self.collectionView];

}

-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    
    [_collectionViewMarray removeAllObjects];
    
    CGFloat W = ( G_SCREENWIDTH-20-30 )/4.0;
    CGFloat H = HEIGHT_CELL ;
    
    if (dataSource.count>0) {
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
        
    }else{
        return;
    }
    for (MCUserDefinedLotteryCategoriesModel * model in dataSource) {
        
        CollectionModel * model0=[[CollectionModel alloc]init];
        model0.header_size=CGSizeMake(G_SCREENWIDTH, 0.0001);
        model0.item_size=CGSizeMake(W, H);
        model0.section_color=[UIColor clearColor];
        model0.section_Edge=UIEdgeInsetsMake(0, 10, 0, 10);
        model0.interitemSpacing=7;
        model0.lineSpacing=7;
        model0.isHaveHeader=YES;
        model0.id_dentifier=NSStringFromClass([MCUserDefinedLotteryCategoriesCollectionViewCell class]);
        /*
         * info
         */
        model0.userInfo=model;
        [_collectionViewMarray addObject:model0];
    }
    [self.collectionView reloadData];
    
}

//第一个开奖期号
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
        [_collectionView registerClass:[MCUserDefinedLotteryCategoriesCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCUserDefinedLotteryCategoriesCollectionViewCell class])];
        
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
    CollectionModel * model=self.collectionViewMarray[section];
    return model.section_color;
}
//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.collectionViewMarray[indexPath.section];
    return model.item_size;
}
//设置section的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    CollectionModel * model=self.collectionViewMarray[section];
    return model.section_Edge;
}
// 两个cell之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    CollectionModel * model=self.collectionViewMarray[section];
    return model.interitemSpacing;
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    CollectionModel * model=self.collectionViewMarray[section];
    return model.lineSpacing;
}

//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.collectionViewMarray.count>0) {
        CollectionModel * model=self.collectionViewMarray[section];
        if ([model.id_dentifier isEqualToString:NSStringFromClass([MCUserDefinedLotteryCategoriesCollectionViewCell class])]) {
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
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCUserDefinedLotteryCategoriesCollectionViewCell class])]) {
        
        MCUserDefinedLotteryCategoriesCollectionViewCell *ex_cell=(MCUserDefinedLotteryCategoriesCollectionViewCell *)cell;
        
        ex_cell.dataSource=model.userInfo;
        
    }
    return cell;
}
#pragma mark-didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.collectionViewMarray[indexPath.row];
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCUserDefinedLotteryCategoriesCollectionViewCell class])]) {
        MCUserDefinedLotteryCategoriesViewController *vc=(MCUserDefinedLotteryCategoriesViewController *)[UIView MCcurrentViewController];
        MCUserDefinedLotteryCategoriesModel * mmodel = model.userInfo;
        
        if (mmodel.isSelected) {
            return;
        }
        if (vc.userSelectedCZMarray.count>7) {
            
            
//            [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];

            /*
             * 最多只能选择8个彩种
             */
            [SVProgressHUD showErrorWithStatus:@"最多只能选择8个彩种"];
            
            return;
        }else{
            MCUserDefinedLotteryCategoriesCollectionViewCell * cell=(MCUserDefinedLotteryCategoriesCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            [cell setCellSelected:YES];
        }
        if (self.block) {
            self.block(mmodel);
        }
    }
}

+(CGFloat)computeHeight:(NSMutableArray *)info{

    int  line = ceilf(info.count/4.0);
    
    return line * (HEIGHT_CELL+7);
}

-(NSDictionary *)cZHelperDic{
    if (!_cZHelperDic) {
        _cZHelperDic=[MCDataTool MC_GetDic_CZHelper];
    }
    return _cZHelperDic;
}

//设置不同字体颜色
-(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    label.attributedText = str;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
}

@end





































