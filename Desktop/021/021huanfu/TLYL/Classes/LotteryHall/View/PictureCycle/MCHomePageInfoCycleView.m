//
//  MCHomePageInfoCycleView.m
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCHomePageInfoCycleView.h"


@interface MCHomePageInfoCycleView()<UIScrollViewDelegate>

#pragma mark - property
// 根部UIScrollView
@property (nonatomic,weak) UIScrollView *baseScrollView;
//资源
@property (nonatomic,strong) NSMutableArray *infoArray;
//当前页码
@property (nonatomic,assign) int currentIndex;
//定时器
@property (nonatomic,strong) NSTimer *timer;
//当前label
@property (nonatomic,weak) UILabel *label;
//下一个label
@property (nonatomic,weak) UILabel *nextLabel;
//图片
@property (nonatomic,weak) UIImageView *imageV;

@property (nonatomic,strong) MCSystemNoticeListModel *model;

@end


@implementation MCHomePageInfoCycleView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI{
   
    self.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    UIScrollView *baseScrollView = [[UIScrollView alloc] init];
    [self addSubview:baseScrollView];
    self.baseScrollView = baseScrollView;
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    baseScrollView.scrollEnabled = YES;
    baseScrollView.pagingEnabled = YES;
    self.baseScrollView.contentSize = CGSizeMake(0, MC_REALVALUE(60));
    baseScrollView.delegate = self;
    baseScrollView.contentOffset = CGPointMake(0, 0);
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"the-announcement"]];
    [self addSubview:imgV];
    self.imageV = imgV;
    UILabel *label = [[UILabel alloc] init];
    [baseScrollView addSubview:label];
    self.label = label;
    self.label.text = @"加载中...";
    self.label.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    label.textColor = MC_ColorWithAlpha(119, 119, 119, 1);
    UILabel *nextLabel = [[UILabel alloc] init];
    [baseScrollView addSubview:nextLabel];
    self.nextLabel = nextLabel;
    self.nextLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    nextLabel.textColor = MC_ColorWithAlpha(119, 119, 119, 1);

    [self setUpTimer];
    MCSystemNoticeListModel *model = [[MCSystemNoticeListModel alloc] init];
    self.model = model;
    model.isHomePage = YES;
    [model refreashDataAndShow];
    
    model.callBackSuccessBlock = ^(id manager) {
        self.infoArray = [MCSystemNoticeListModel mj_objectArrayWithKeyValuesArray:manager];
    };
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleTapRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
    singleTapRecognizer.numberOfTapsRequired = 1; // 单击
    [self addGestureRecognizer:singleTapRecognizer];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.widht, 1)];
    [self addSubview:line];
    line.backgroundColor = RGB(238, 238, 238);
}
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    if (self.infoArray.count == 0) {
        return;
    }
    self.currentIndex =  ( ++self.currentIndex )%self.infoArray.count;
    
    MCSystemNoticeListModel *model = self.infoArray[self.currentIndex-1];
    
    NSLog(@"%@-%@---model",model.NewsTittle,model.MerchantNews_ID);
    if (self.systemNoticeClickBlock) {
        self.systemNoticeClickBlock(model);
    }
    
}
#pragma mark - Layout
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.baseScrollView.frame = self.bounds;
    self.label.frame = CGRectMake(MC_REALVALUE(self.imageV.widht + 10+7), 0, MC_REALVALUE(G_SCREENWIDTH - self.imageV.widht - 7) , MC_REALVALUE(self.heiht));
    self.nextLabel.frame = CGRectMake(MC_REALVALUE(self.imageV.widht + 10+7), MC_REALVALUE(30), G_SCREENWIDTH, MC_REALVALUE(30));
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(MC_REALVALUE(10)));
        make.centerY.equalTo(self);
        make.height.equalTo(@(MC_REALVALUE(15)));
        make.width.equalTo(@(MC_REALVALUE(15)));
    }];
}



#pragma mark - scrollView delegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self reloadImage];
}

- (void)reloadImage{
    if (self.infoArray.count == 0) {
        return;
    }
    self.currentIndex =  ( ++self.currentIndex )%self.infoArray.count;
    MCSystemNoticeListModel *model = self.infoArray[self.currentIndex];
    MCSystemNoticeListModel *model1 = self.infoArray[(self.currentIndex +1)%self.infoArray.count];
    self.label.text = model.NewsTittle;
    self.nextLabel.text = model1.NewsTittle;
    [self.baseScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}
#pragma mark - timer
- (void)setUpTimer{
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(setBaseScollviewContentOffset) userInfo:nil repeats:YES];
  
    self.timer = timer;
    
    [[NSRunLoop mainRunLoop ] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setBaseScollviewContentOffset{
    __weak MCHomePageInfoCycleView *weakSelf = self;
    
    [weakSelf.baseScrollView setContentOffset:CGPointMake(0, MC_REALVALUE(30)) animated:YES];
}
- (void)stopTimer{
    
    [self.timer invalidate];
    
    self.timer = nil;
}

#pragma mark - setter And getter
- (NSMutableArray *)infoArray{
    
    if (_infoArray == nil) {
        
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}


@end
