//
//  MCHomePagePictrueCycleView.m
//  Uhome
//
//  Created by miaocai on 2017/5/27.
//  Copyright © 2017年 menhao. All rights reserved.
//

#import "MCHomePagePictrueCycleView.h"

@interface MCHomePagePictrueCycleView()<UIScrollViewDelegate>
#pragma mark - property
// 根部UIScrollView
@property (nonatomic,weak) UIScrollView *baseScrollView;
//左侧图片
@property (nonatomic,weak) UIImageView *leftImageV;
//中间图片
@property (nonatomic,weak) UIImageView *midImageV;
//右侧图片
@property (nonatomic,weak) UIImageView *rightImageV;
//图片资源
@property (nonatomic,strong) NSMutableArray *pictrueNameArray;
//当前页码
@property (nonatomic,assign) int currentIndex;
//定时器
@property (nonatomic,strong) NSTimer *timer;
//页面pageControl
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation MCHomePagePictrueCycleView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI{
    
    UIScrollView *baseScrollView = [[UIScrollView alloc] init];
    [self addSubview:baseScrollView];
    self.baseScrollView = baseScrollView;
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    baseScrollView.scrollEnabled = YES;
    baseScrollView.pagingEnabled = YES;
    self.baseScrollView.contentSize = CGSizeMake(G_SCREENWIDTH *3, 0);
    baseScrollView.delegate = self;
    baseScrollView.contentOffset = CGPointMake(G_SCREENWIDTH, 0);
    
    UIImageView *leftImageV = [[UIImageView alloc] init];
    [baseScrollView addSubview:leftImageV];
    leftImageV.backgroundColor = [UIColor redColor];
    self.leftImageV = leftImageV;
    leftImageV.userInteractionEnabled = YES;
    leftImageV.image = [UIImage imageNamed:@""];

    UIImageView *midImageV = [[UIImageView alloc] init];
    [baseScrollView addSubview:midImageV];
    midImageV.backgroundColor = [UIColor yellowColor];
    self.midImageV = midImageV;
    midImageV.userInteractionEnabled = YES;
    
    UIImageView *rightImageV = [[UIImageView alloc] init];
    [baseScrollView addSubview:rightImageV];
    self.rightImageV = rightImageV;
    rightImageV.userInteractionEnabled = YES;
    
    [self.pictrueNameArray addObjectsFromArray:@[@"x_banner_01.jpg",@"x_banner_02.jpg",@"x_banner_03.jpg"]];
    leftImageV.image = [UIImage imageNamed:self.pictrueNameArray[0]];
    midImageV.image = [UIImage imageNamed:self.pictrueNameArray[1]];
    rightImageV.image = [UIImage imageNamed:self.pictrueNameArray[2]];

    self.currentIndex = 1;
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
    pageControl.numberOfPages = self.pictrueNameArray.count;
    pageControl.currentPage = 1;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl = pageControl;
    
    [self setUpTimer];
}
#pragma mark - Layout
- (void)layoutSubviews{
    [super layoutSubviews];
   
    self.baseScrollView.frame = self.bounds;
    self.leftImageV.frame = self.bounds;
    self.midImageV.frame = CGRectMake(G_SCREENWIDTH, 0, G_SCREENWIDTH, self.baseScrollView.bounds.size.height);
    self.rightImageV.frame = CGRectMake(2 *G_SCREENWIDTH, 0, G_SCREENWIDTH, self.baseScrollView.bounds.size.height);
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
    
}

#pragma mark - scrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
    
    [self reloadImage];

    [self setUpTimer];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self stopTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self reloadImage];
}

- (void)reloadImage{
    
    if (self.baseScrollView.contentOffset.x == 2 * G_SCREENWIDTH) {//右
        
        self.currentIndex =  ( ++self.currentIndex )%self.pictrueNameArray.count;
        
    } else if (self.baseScrollView.contentOffset.x == 0) {//左
        
        self.currentIndex =  ((int)self.pictrueNameArray.count + --self.currentIndex)%self.pictrueNameArray.count;
    }
    
    self.pageControl.currentPage = self.currentIndex;
    self.midImageV.image= [UIImage imageNamed:self.pictrueNameArray[self.currentIndex]];
    self.leftImageV.image= [UIImage imageNamed:self.pictrueNameArray[(self.currentIndex-1 + self.pictrueNameArray.count)%self.pictrueNameArray.count]];
    self.rightImageV.image =[UIImage imageNamed:self.pictrueNameArray[(self.currentIndex+1)%self.pictrueNameArray.count]];
    
    [self.baseScrollView setContentOffset:CGPointMake(G_SCREENWIDTH, 0) animated:NO];
}
#pragma mark - timer
- (void)setUpTimer{
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scollViewDidChangeContentSize) userInfo:nil repeats:YES];

    self.timer = timer;
    
    [[NSRunLoop mainRunLoop ] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)scollViewDidChangeContentSize{
    
    __weak MCHomePagePictrueCycleView *weakSelf = self;
    
    [weakSelf.baseScrollView setContentOffset:CGPointMake(G_SCREENWIDTH * 2, 0) animated:YES];
}
- (void)stopTimer{
    
    [self.timer invalidate];
    
    self.timer = nil;
}

#pragma mark - setter And getter
- (NSMutableArray *)pictrueNameArray{
    
    if (_pictrueNameArray == nil) {
        
        _pictrueNameArray = [NSMutableArray array];
    }
    return _pictrueNameArray;
}
@end
