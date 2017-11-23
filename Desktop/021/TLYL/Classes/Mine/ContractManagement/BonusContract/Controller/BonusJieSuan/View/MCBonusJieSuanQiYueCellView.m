//
//  MCBonusJieSuanQiYueCellView.m
//  TLYL
//
//  Created by MC on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBonusJieSuanQiYueCellView.h"

@interface MCBonusJieSuanQiYueCellView()
//Expenditure    Number    消费额
//LossAmount    Number    亏损额
//ActivePeopleNum    Number    活跃人数
//DividendRatio    Number    分红比例（界面需乘以100，按%显示）
//消费额：      活跃人数：       亏损额：      分红比列：
@property (nonatomic,strong) UILabel * Expenditure ;
@property (nonatomic,strong) UILabel * LossAmount;
@property (nonatomic,strong) UILabel * ActivePeopleNum;
@property (nonatomic,strong) UILabel * DividendRatio;//分红比例

@end

@implementation MCBonusJieSuanQiYueCellView

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
    
    //消费额：      活跃人数：       亏损额：      分红比列：
    UILabel *lab1 = [self GetAdaptiveLable:CGRectMake(0, T1, W/4.0, H) AndText:@"消费额：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab1];
    
    UILabel *lab2 = [self GetAdaptiveLable:CGRectMake(W/4.0, T1, W/4.0, H) AndText:@"活跃人数：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab2];
    
    UILabel *lab3 = [self GetAdaptiveLable:CGRectMake(W*2/4.0, T1, W/4.0, H) AndText:@"亏损额：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab3];
    
    UILabel *lab4 = [self GetAdaptiveLable:CGRectMake(W*3/4.0, T1, W/4.0, H) AndText:@"分红比例：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab4];
    

    _Expenditure = [self GetAdaptiveLable:CGRectMake(0, T2, W/4.0, H) AndText:@"加载中..." andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_Expenditure];
    
    _LossAmount = [self GetAdaptiveLable:CGRectMake(W/4.0, T2, W/4.0, H) AndText:@"加载中..." andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_LossAmount];
    
    _ActivePeopleNum = [self GetAdaptiveLable:CGRectMake(W*2/4.0, T2, W/4.0, H) AndText:@"加载中..." andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_ActivePeopleNum];
    
    _DividendRatio = [self GetAdaptiveLable:CGRectMake(W*3/4.0, T2, W/4.0, H) AndText:@"加载中..." andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_DividendRatio];
    
    
    
    
}


-(void)setDataSouce:(MCGetDividendContractListModel *)dataSouce{
    
    _dataSouce = dataSouce;

    _Expenditure.text = dataSouce.Expenditure;
    _LossAmount.text = dataSouce.LossAmount;
    _ActivePeopleNum.text = dataSouce.ActivePeopleNum;
    _DividendRatio.text = dataSouce.DividendRatio;
    
}


+(CGFloat)computeHeight:(id)info{
    return 75;
}

@end
























