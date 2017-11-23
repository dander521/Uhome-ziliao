//
//  MCQiPaiTeamSlideView.m
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQiPaiTeamSlideView.h"
#import "UIView+MCParentController.h"

#define TOPHEIGHT    45

#define BTNHEIGHT    45

#define SLIDEHEIGHT  2

#define Selected_Color   RGB(144,8,215)
@implementation MCQiPaiTeamProperty
singleton_m(MCQiPaiTeamProperty)

@end

@interface MCQiPaiTeamSlideView ()
<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIScrollView *_titleScrollView;
    UIButton *_selectedBtn;
    NSInteger _count;
}

@end

@implementation MCQiPaiTeamSlideView

+(MCQiPaiTeamSlideView *) segmentControlViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        _count = 0;
    }
    return self;
}

-(void) setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    _selectedTitleArray?[self createButtonAndSelectedView]:nil;
    
}

-(void)setSelectedTitleArray:(NSArray *)selectedTitleArray
{
    _selectedTitleArray = selectedTitleArray;
    _titleArray?[self createButtonAndSelectedView]:nil;
}

-(void)createButtonAndSelectedView
{
    if (!_titleScrollView)
    {
        [self createUICollectionView];
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, TOPHEIGHT)];
        _titleScrollView.backgroundColor = [UIColor whiteColor];
        _titleScrollView.contentOffset = CGPointMake(0, 0);
        [self addSubview:_titleScrollView];
        CGFloat buttonWidth = 0;
        if (self.titleArray.count <= 5)
        {
            _titleScrollView.scrollEnabled = NO;
            buttonWidth = self.frame.size.width/self.titleArray.count;
            _titleScrollView.contentSize=CGSizeMake(0, 0);
        }
        else
        {
            _titleScrollView.scrollEnabled = YES;
            buttonWidth = self.frame.size.width/5;
            _titleScrollView.contentSize = CGSizeMake(self.titleArray.count*buttonWidth, 0);
        }
        for (int i = 0; i<self.titleArray.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
            btn.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, BTNHEIGHT);
            btn.tag = 100+i;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:_normalColor==nil?[UIColor blackColor]:_normalColor forState:UIControlStateNormal];
            [btn setTitle:self.selectedTitleArray[i] forState:UIControlStateSelected];
            [btn setTitleColor:_selectedColor==nil?[UIColor cyanColor]:_selectedColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
            [_titleScrollView addSubview:btn];
            
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, btn.frame.size.height-SLIDEHEIGHT,G_SCREENWIDTH/3.0, SLIDEHEIGHT)];
            
            view1.tag = 2;
            [btn addSubview:view1];
            if (i == 0)
            {
                btn.selected = YES;
                _selectedBtn = btn;
                view1.backgroundColor = _SlideSelectedColor;
            } else
            {
                btn.selected = NO;
                view1.backgroundColor = [UIColor clearColor];
            }
            
        }
        
    }
}

-(void)btnTouch:(UIButton *)sender
{
    [self changeSelectedBtn:sender];
    
    //collctionView滚动到指定位置。
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:(sender.tag-100) inSection:0];
    [_collectionView scrollToItemAtIndexPath:scrollIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

-(void)changeSelectedBtn:(UIButton *)willSelectedBtn
{
//    if (willSelectedBtn.tag==100) {
//        MCQiPaiReportViewController * vc =(MCQiPaiReportViewController *)[UIView MCcurrentViewController];
//        vc.Type=MCQiPai_Team_XiaJiReport;
//    }else if(willSelectedBtn.tag==101){
//        MCQiPaiReportViewController * vc =(MCQiPaiReportViewController *)[UIView MCcurrentViewController];
//        vc.Type=MCQiPai_Team_MyselfReport;
//    }else if (willSelectedBtn.tag==102){
//        MCQiPaiReportViewController * vc =(MCQiPaiReportViewController *)[UIView MCcurrentViewController];
//        vc.Type=MCQiPai_Team_TeamReport;
//    }
    _selectedBtn.selected = NO;
    UIView *selectedView = [_selectedBtn viewWithTag:2];
    selectedView.backgroundColor = [UIColor clearColor];
    willSelectedBtn.selected = YES;
    _selectedBtn = willSelectedBtn;
    UIView *view1 = [willSelectedBtn viewWithTag:2];
    view1.backgroundColor=_SlideSelectedColor;
    
    if (willSelectedBtn.tag-100>1&&willSelectedBtn.tag-100<self.titleArray.count-2&&self.titleArray.count>5)
    {
        [_titleScrollView setContentOffset:CGPointMake(willSelectedBtn.frame.size.width*(willSelectedBtn.tag-100-2), 0) animated:YES];
    }
}

-(void)createUICollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height-TOPHEIGHT);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0.0f;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, self.frame.size.width, self.frame.size.height-TOPHEIGHT) collectionViewLayout:layout];
    
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[MCQiPaiXiaJiReportCollectionViewCell class]  forCellWithReuseIdentifier:NSStringFromClass([MCQiPaiXiaJiReportCollectionViewCell class]) ];
    
    [_collectionView registerClass:[MCQiPaiMyselfReportCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCQiPaiMyselfReportCollectionViewCell class])];
    
    [_collectionView registerClass:[MCQiPaiTeamReportCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCQiPaiTeamReportCollectionViewCell class])];
    
    
}

#pragma mark-UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---------%ld----%ld------",(long)indexPath.section,(long)indexPath.row);
    //    __weak __typeof__ (self) wself = self;
    
    if (indexPath.row==0)
    {
        MCQiPaiXiaJiReportCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MCQiPaiXiaJiReportCollectionViewCell class]) forIndexPath:indexPath];
        _xiaJiCell=cell;
        return cell;

    }else if(indexPath.row==1){
        
        MCQiPaiMyselfReportCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MCQiPaiMyselfReportCollectionViewCell class]) forIndexPath:indexPath];
        _myselfCell=cell;
        return cell;
        
    }else{
        MCQiPaiTeamReportCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MCQiPaiTeamReportCollectionViewCell class]) forIndexPath:indexPath];
        _teamCell=cell;
        return cell;
    }
    
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 0.1);
}

#pragma mark-collctionView拖拽功能。
//结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]&&_count==1)
    {
        NSInteger row=(scrollView.contentOffset.x+self.frame.size.width/2.0)/self.frame.size.width;
        //        NSLog(@"row========%ld",(long)row);
        UIButton *btn=(UIButton *)[_titleScrollView viewWithTag:(100+row)];
        [self changeSelectedBtn:btn];
        
    }
}

//结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isKindOfClass:[UICollectionView class]])
    {
        _count=1;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{//在此时收起键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
/**
 *   获取字符宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(CGFloat )font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:font];
    [label sizeToFit];
    return label.frame.size.width;
}


@end


















