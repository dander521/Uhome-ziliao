//
//  MCPullMenuTableViewCell.m
//  TLYLSF
//
//  Created by Canny on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCPullMenuTableViewCell.h"
#import "MCMineCellModel.h"
#import "MCCollectionViewFlowLayout.h"
#import "UIView+MCParentController.h"
#import "MCPersonInformationViewController.h"

@interface MCPullMenuTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic,strong) UILabel* maintitleLab;
@property (nonatomic,strong) NSMutableArray*cellMarr;
@property (nonatomic,assign) FinishOrEditType type;
@end

@implementation MCPullMenuTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    
    self.backgroundColor=[UIColor  clearColor];
    
    UILabel * lab =[[UILabel alloc]init];
    lab.backgroundColor=RGB(120, 0, 179);
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(16);
    }];
    
    _maintitleLab= [UILabel new];
    _maintitleLab.layer.masksToBounds = YES;
    _maintitleLab.textColor=RGB(120, 0, 179);
    _maintitleLab.font = [UIFont systemFontOfSize:15];
    _maintitleLab.numberOfLines=1;
    _maintitleLab.text = @"加载中...";
    _maintitleLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_maintitleLab];
    [_maintitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab.mas_centerY);
        make.left.equalTo(lab.mas_right).offset(5);
        make.width.mas_equalTo(G_SCREENWIDTH);
        make.height.mas_equalTo(20);
    }];
    
    
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor=[UIColor clearColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_maintitleLab.mas_bottom).offset(10);
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
        [_collectionView registerClass:[MCPullMenuCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCPullMenuCollectionViewCell class])];
        
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
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCPullMenuCollectionViewCell class])]) {
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
    
    UICollectionViewCell*  cell=nil;
    CollectionModel * model=self.cellMarr[indexPath.section];
    if (model.id_dentifier) {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:model.id_dentifier forIndexPath:indexPath];
    }
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCPullMenuCollectionViewCell class])]) {
        
        MCPullMenuCollectionViewCell *ex_cell=(MCPullMenuCollectionViewCell *)cell;
        NSArray * arr=(NSArray*)model.userInfo;
        if (arr.count>indexPath.row) {
            [ex_cell relayOutData:[model.userInfo objectAtIndex:indexPath.row] withType:_type];
        }
    }
    return cell;
}

#pragma mark-didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel * model=self.cellMarr[indexPath.section];
    
    MCPullMenuCollectionViewCell *ex_cell=(MCPullMenuCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    if ([model.id_dentifier isEqualToString:NSStringFromClass([MCPullMenuCollectionViewCell class])]) {
        if (model.userInfo) {
            if ([self.delegate respondsToSelector:@selector(cellDidSelectWithDic:)]) {
                MCPullMenuCollectionCellModel * Cmodel=[model.userInfo objectAtIndex:indexPath.row];
                [self.delegate cellDidSelectWithDic:Cmodel.dic];
            }
        }
    }
}
-(void)relayOutData:(MCMenuDataModel *)dataSource withType:(FinishOrEditType)type{
    _dataSource=dataSource;
    _type=type;
    

    [_cellMarr removeAllObjects];
        CGFloat W = ( G_SCREENWIDTH-20-30 )/4.0;
        CGFloat H = 25;
        
    MCMenuDataModel * model =dataSource;
    _maintitleLab.text=model.name;
    for (int i=0; i<model.dataSource.count; i++) {
        CollectionModel * model0=[[CollectionModel alloc]init];
        model0.header_size=CGSizeMake(G_SCREENWIDTH, 0.0001);
        model0.item_size=CGSizeMake(W, H);
        model0.section_color=[UIColor clearColor];
        model0.section_Edge=UIEdgeInsetsMake(0, 0, 0, 0);
        model0.interitemSpacing=10;
        model0.lineSpacing=10;
        model0.isHaveHeader=YES;
        model0.id_dentifier=NSStringFromClass([MCPullMenuCollectionViewCell class]);
        /*
         * info
         */
        model0.userInfo=model.dataSource;
        [_cellMarr addObject:model0];
    }
    [self.collectionView reloadData];

}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
}

+(CGFloat)computeHeight:(id)info{
    
    MCMenuDataModel * model = info;
    
    int  line = ceilf(model.dataSource.count/4.0);
    
    return line * (25+10) +30;
    
}

@end



































































