//
//  MCTopSelectedView.m
//  TLYL
//
//  Created by miaocai on 2017/10/30.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTopSelectedView.h"
#import "MCTopSelectedCollectionViewCell.h"

@interface MCTopSelectedView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation MCTopSelectedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:@"dlgl-cjxs"];
        [self addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(18);
            make.top.equalTo(self).offset(12);
            make.width.height.equalTo(@(22));
        }];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.minimumLineSpacing = 10;
//        layout.minimumInteritemSpacing = 2;
        layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
        layout.estimatedItemSize = CGSizeMake(50, 40);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(45, 0, G_SCREENWIDTH, 40) collectionViewLayout:layout];
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MCTopSelectedCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
        [self addSubview:_collectionView];
    }
    return self;
}


#pragma mark -- collectionViewDelegate and datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MCTopSelectedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    cell.firstLabel.text = self.dataSource[indexPath.row];
    [cell layoutIfNeeded];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.topSectedBlock) {
        self.topSectedBlock(indexPath.row);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeZero;
}


- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self.collectionView reloadData];
  
}

@end
