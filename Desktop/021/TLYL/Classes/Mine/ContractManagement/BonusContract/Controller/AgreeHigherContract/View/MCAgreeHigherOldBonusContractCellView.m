//
//  MCAgreeHigherOldBonusContractCellView.m
//  TLYL
//
//  Created by MC on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCAgreeHigherOldBonusContractCellView.h"

@interface MCAgreeHigherOldBonusContractCellView()

//消费额：      活跃人数：       亏损额：      分红比例：
@property (nonatomic,strong) UILabel * BetMoneyMin ;//消费额
@property (nonatomic,strong) UILabel * ActivePersonNum;//活跃人数
@property (nonatomic,strong) UILabel * LossMoneyMin;//亏损额
@property (nonatomic,strong) UILabel * DividendRatio;//分红比例

@end

@implementation MCAgreeHigherOldBonusContractCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andFont:(CGFloat)font  andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)textAlignment;
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.text = contentStr;
    contentLbl.textAlignment = textAlignment;
    contentLbl.font = [UIFont systemFontOfSize:font];
    contentLbl.textColor=textColor;
    contentLbl.clipsToBounds=YES;
    
    return contentLbl;
}

-(void)createUI{
    
    
    self.backgroundColor = RGB(246,243,248);
    self.layer.cornerRadius = 5;
    self.clipsToBounds=YES;
    
    CGFloat W = G_SCREENWIDTH-60 ,T1 = 10 ,T2 = 40,H = 24;
    
    //消费额：      活跃人数：       亏损额：      分红比例：
    UILabel *lab1 = [self GetAdaptiveLable:CGRectMake(0, T1, W/4.0, H) AndText:@"消费额：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab1];
    
    UILabel *lab2 = [self GetAdaptiveLable:CGRectMake(W/4.0, T1, W/4.0, H) AndText:@"活跃人数：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab2];
    
    UILabel *lab3 = [self GetAdaptiveLable:CGRectMake(W*2/4.0, T1, W/4.0, H) AndText:@"亏损额：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab3];
    
    UILabel *lab4 = [self GetAdaptiveLable:CGRectMake(W*3/4.0, T1, W/4.0, H) AndText:@"分红比例：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab4];
    
    
    _BetMoneyMin = [self GetAdaptiveLable:CGRectMake(0, T2, W/4.0, H) AndText:@"加载中..." andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_BetMoneyMin];
    
    _ActivePersonNum = [self GetAdaptiveLable:CGRectMake(W/4.0, T2, W/4.0, H) AndText:@"活跃人数：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_ActivePersonNum];
    
    _LossMoneyMin = [self GetAdaptiveLable:CGRectMake(W*2/4.0, T2, W/4.0, H) AndText:@"亏损额：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_LossMoneyMin];
    
    _DividendRatio = [self GetAdaptiveLable:CGRectMake(W*3/4.0, T2, W/4.0, H) AndText:@"分红比例：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_DividendRatio];
    
    
    
    
}


-(void)setDataSouce:(MCMyBonusContractListDeatailDataModel *)dataSouce{
    
    _dataSouce = dataSouce;
    
    _BetMoneyMin.text = dataSouce.BetMoneyMin;//消费额
    _ActivePersonNum.text = dataSouce.ActivePersonNum;//活跃人数
    _LossMoneyMin.text = dataSouce.LossMoneyMin;//亏损额
    _DividendRatio.text = dataSouce.DividendRatio;//分红比例
    
}


+(CGFloat)computeHeight:(id)info{
    return 75;
}

@end






















