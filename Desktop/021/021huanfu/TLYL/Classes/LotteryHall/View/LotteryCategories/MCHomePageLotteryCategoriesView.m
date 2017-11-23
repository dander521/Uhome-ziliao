//
//  MCHomePageLotteryCategoriesView.m
//  Uhome
//
//  Created by miaocai on 2017/5/27.
//  Copyright © 2017年 menhao. All rights reserved.
//

#import "MCHomePageLotteryCategoriesView.h"
#import "MCHomePageLotteryCategoriesCollectionViewCell.h"
#import "LXReorderableCollectionViewFlowLayout.h"
#import "MCUserDefinedLotteryCategoriesViewController.h"
#import "MCUserDefinedLotteryCategoriesModel.h"
#import "MCDataTool.h"
#import <MJRefresh/MJRefresh.h>

@interface MCHomePageLotteryCategoriesView()<UICollectionViewDelegate,LXReorderableCollectionViewDataSource>
#pragma mark - property
//根view
@property (nonatomic,weak) UIView *contentView;

//分割线
@property (nonatomic,weak) UIView *separatorView;
//collectionView

//数据源
@property (nonatomic,strong) NSMutableArray * dataMarry;

@end

@implementation MCHomePageLotteryCategoriesView

static NSString *const HomePageLotteryCategoriesID = @"MCHomePageLotteryCategoriesView";

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}



- (void)setUpUI{
    
    self.dataMarry=[MCDataTool MC_GetMarr_withID:MCHomePageLotteryCategoryData];
    //根view
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    [self addSubview:contentView];
    contentView.backgroundColor = [UIColor clearColor];
    
 
    //分割线
    UIView *separatorView = [[UIView alloc] init];
    [self addSubview:separatorView];
    separatorView.backgroundColor = RGB(238, 238, 238);
    self.separatorView = separatorView;
    
    
    //collectionView
    LXReorderableCollectionViewFlowLayout *layout = [[LXReorderableCollectionViewFlowLayout alloc] init];
    CGFloat W = (G_SCREENWIDTH-2)/3.0;
    CGFloat H = W;
    layout.itemSize = CGSizeMake(W,H);

    __weak typeof(self) weakSelf = self;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.footerReferenceSize = CGSizeMake(G_SCREENWIDTH, 50);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.scrollEnabled = NO;
//    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        [weakSelf loadDefaultCZList];
//    }];
//    layout.footerReferenceSize = CGSizeMake(G_SCREENWIDTH, 40);
    self.collectionView = collectionView;
    [contentView addSubview:collectionView];
    collectionView.backgroundColor=RGB(236, 236, 236);
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[MCHomePageLotteryCategoriesCollectionViewCell class] forCellWithReuseIdentifier:HomePageLotteryCategoriesID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
   
    
}
#pragma mark-加载用户自定义彩种
//-(void)loadDefaultCZList{
//    
//    __weak typeof(self) weakSelf = self;
//    
//    MCUserDefinedLotteryCategoriesViewController * vc=[[MCUserDefinedLotteryCategoriesViewController alloc]init];
//    [vc GetLotteryCustomArray:^(BOOL result, NSMutableArray *defaultCZArray) {
//        
//        [weakSelf.collectionView.mj_header endRefreshing];
//        if (result) {
//            [weakSelf relayOutUI];
//        }
//    }];
//    
//}
#pragma mark - Layout
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-MC_REALVALUE(40));
    }];
    
    [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@0.5);
        make.top.equalTo(self.contentView.mas_top).offset(0);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.separatorView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - collectionViewDelegate And UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataMarry.count + 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MCHomePageLotteryCategoriesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomePageLotteryCategoriesID forIndexPath:indexPath];
    
    if (indexPath.row == self.dataMarry.count) {
        
        MCUserDefinedLotteryCategoriesModel * model=[[MCUserDefinedLotteryCategoriesModel alloc]init];
        model.logo=@"tianjiaCZ";
        model.name=@"添加常玩彩种";
        cell.dataSource=model;
        cell.backgroundColor=[UIColor clearColor];
        
    } else {
        MCUserDefinedLotteryCategoriesModel * model=[self.dataMarry objectAtIndex:indexPath.row];
        cell.dataSource=model;
    }
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.dataMarry.count) {
        
        /*
         * 跳转自定义彩种
         */
        
        if ([self.delegate respondsToSelector:@selector(SetUserDefinedLotteryCategories)]) {
            [self.delegate SetUserDefinedLotteryCategories];
        }
        
    } else {
        MCUserDefinedLotteryCategoriesModel * model=[self.dataMarry objectAtIndex:indexPath.row];
        if (self.collectionViewDidSelectedCallBack != nil) {
            
            self.collectionViewDidSelectedCallBack(model);
        }
    }
    
    
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

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath {
    if (fromIndexPath.item > self.dataMarry.count -1 || toIndexPath.item>self.dataMarry.count -1) {
        return;
    }
    id object = [self.dataMarry objectAtIndex:fromIndexPath.item];
    [self.dataMarry removeObjectAtIndex:fromIndexPath.item];
    [self.dataMarry insertObject:object atIndex:toIndexPath.item];
    [MCDataTool MC_SaveMarr:self.dataMarry withID:MCHomePageLotteryCategoryData];
   
}

// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, footer.bounds.size.width-10*2, 35)];
        label.text = @"天利娱乐 © 2017 Copyright";
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor =RGB(136,136,136);
        label.font = [UIFont systemFontOfSize:9.0];
        [footer addSubview:label];
        footer.backgroundColor = [UIColor clearColor];
        return footer;
    }
    return nil;
}


- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath{
    if (fromIndexPath.item > self.dataMarry.count -1 || toIndexPath.item>self.dataMarry.count -1) {
        return NO;
    }else{
        return YES;
    }
}
#pragma mark - Datas parse
- (void)customLotteryCategoriesButtonClick:(UIButton *)btn{
    /*
     * 跳转自定义彩种
     */
    
    if ([self.delegate respondsToSelector:@selector(SetUserDefinedLotteryCategories)]) {
        [self.delegate SetUserDefinedLotteryCategories];
    }
    
}

#pragma mark-刷新数据
-(void)relayOutUI{
    [self.dataMarry removeAllObjects];
    self.dataMarry=[MCDataTool MC_GetMarr_withID:MCHomePageLotteryCategoryData];
    [self.collectionView reloadData];
    
}

@end







