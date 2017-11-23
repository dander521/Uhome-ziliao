//
//  MCBonusJieSuanYuLuanCellView.m
//  TLYL
//
//  Created by MC on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBonusJieSuanYuLuanCellView.h"


//TotalBets    Number    投注总额
//GrossProfit    Number    盈利总额
//ActivePeopleNum    Number    活跃人数
//DividendRatio    Number    分红比例（界面需乘以100，按%显示）
//DeservedDividend    Number    应得分红
@interface MCBonusJieSuanYuLuanCellView()
//投注总额：    盈利总额：      活跃人数：     分红比列： 
@property (nonatomic,strong) UILabel * TotalBets ;
@property (nonatomic,strong) UILabel * GrossProfit;
@property (nonatomic,strong) UILabel * ActivePeopleNum;
@property (nonatomic,strong) UILabel * DividendRatio;//分红比例

@end

@implementation MCBonusJieSuanYuLuanCellView

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
    
    //投注总额：    盈利总额：      活跃人数：     分红比列：
    UILabel *lab1 = [self GetAdaptiveLable:CGRectMake(0, T1, W/4.0, H) AndText:@"投注总额：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab1];
    
    UILabel *lab2 = [self GetAdaptiveLable:CGRectMake(W/4.0, T1, W/4.0, H) AndText:@"盈利总额：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab2];
    
    UILabel *lab3 = [self GetAdaptiveLable:CGRectMake(W*2/4.0, T1, W/4.0, H) AndText:@"活跃人数：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab3];
    
    UILabel *lab4 = [self GetAdaptiveLable:CGRectMake(W*3/4.0, T1, W/4.0, H) AndText:@"分红比例：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab4];

    
    _TotalBets = [self GetAdaptiveLable:CGRectMake(0, T2, W/4.0, H) AndText:@"加载中..." andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_TotalBets];
    
    _GrossProfit = [self GetAdaptiveLable:CGRectMake(W/4.0, T2, W/4.0, H) AndText:@"加载中..." andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_GrossProfit];
    
    _ActivePeopleNum = [self GetAdaptiveLable:CGRectMake(W*2/4.0, T2, W/4.0, H) AndText:@"加载中..." andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_ActivePeopleNum];
    
    _DividendRatio = [self GetAdaptiveLable:CGRectMake(W*3/4.0, T2, W/4.0, H) AndText:@"加载中..." andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_DividendRatio];
    
    
    
    
}


-(void)setDataSouce:(MCGetBonusPreviewModelsModel *)dataSouce{
    
    _dataSouce = dataSouce;
    
    _TotalBets.text = dataSouce.TotalBets;
    _GrossProfit.text = dataSouce.GrossProfit;
    _ActivePeopleNum.text = dataSouce.ActivePeopleNum;
    _DividendRatio.text = dataSouce.DividendRatio;
    
}


+(CGFloat)computeHeight:(id)info{
    return 75;
}

@end























