//
//  MCLotteryDrawDetailsTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryDrawDetailsTableViewCell.h"
#import "MCLotteryDrawDetailsCollectionViewCell.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCMineCellModel.h"
@interface MCLotteryDrawDetailsTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
/*
 * 彩种期号
 */
@property (nonatomic,strong)UILabel * titleLab;
/*
 * 分隔线
 */
@property (nonatomic,strong)UIView * lineView;

@property (nonatomic,strong) UICollectionView* collectionView;

@property (nonatomic,strong) NSMutableArray*cellMarr;

@end

@implementation MCLotteryDrawDetailsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor whiteColor];
    
    /*
     * 彩种期号
     */
    _titleLab =[[UILabel alloc]init];
    _titleLab.textColor=RGB(68, 68, 68);
    _titleLab.font=[UIFont systemFontOfSize:15];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_titleLab];
    
    /*
     * 画线
     */
    _lineView=[[UIView alloc]init];
    _lineView.backgroundColor=RGB(239, 246, 253);
    [self addSubview:_lineView];
    
    
    [self addSubview:self.collectionView];
    
    
    
    _cellMarr=[[NSMutableArray alloc]init];
    [_cellMarr    removeAllObjects];
    [self layOutConstraints];
    
    
   
    
}

-(void)layOutConstraints{
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(30);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    /*
     * 画线
     */
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLab.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(0.8);
        make.bottom.equalTo(self.mas_bottom);
    }];
    

}

-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    NSMutableArray * arrData=[NSMutableArray arrayWithArray:dataSource[@"CzNumArry"]];
    _titleLab.text=[NSString stringWithFormat:@"第%@期",dataSource[@"CzPeriod"]];
    
    if (_cellMarr.count>0) {
        
    }else{
        

        if (arrData.count>20) {
            [arrData removeLastObject];
        }
        for (int i=0; i<arrData.count; i++) {
            
            CollectionModel * model0=[[CollectionModel alloc]init];
            model0.header_size=CGSizeMake(0, 0);
            model0.item_size=CGSizeMake([MCLotteryDrawDetailsCollectionViewCell computeHeight:nil], [MCLotteryDrawDetailsCollectionViewCell computeHeight:nil]);
            model0.section_color=[UIColor clearColor];
            model0.section_Edge=UIEdgeInsetsMake(10, 10, 5, 10);
            model0.interitemSpacing=(G_SCREENWIDTH-27*10-20 -20)/9.0;
            model0.lineSpacing=5;
            model0.isHaveHeader=YES;
            model0.id_dentifier=NSStringFromClass([MCLotteryDrawDetailsCollectionViewCell class]);
            /*
             * info
             */
            model0.userInfo=arrData[i];
            [_cellMarr addObject:model0];
        }
    }
    
    [self.collectionView reloadData];
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
        [_collectionView registerClass:[MCLotteryDrawDetailsCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCLotteryDrawDetailsCollectionViewCell class])];
        
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
    
    CollectionModel * model=self.cellMarr[section];
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCLotteryDrawDetailsCollectionViewCell class])]) {
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
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCLotteryDrawDetailsCollectionViewCell class])]) {
        
        MCLotteryDrawDetailsCollectionViewCell *ex_cell=(MCLotteryDrawDetailsCollectionViewCell *)cell;

        ex_cell.dataSource=model.userInfo;
        
    }
    return cell;
}
#pragma mark-didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.cellMarr[indexPath.section];
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCLotteryDrawDetailsCollectionViewCell class])]) {
        
        
    }
}




+(CGFloat)computeHeight:(int)info{
    
    return 14+14+14+info*(27+5);
    
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
