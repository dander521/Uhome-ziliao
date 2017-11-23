//
//  MCMoreNavView.m
//  TLYL
//
//  Created by MC on 2017/7/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMoreNavView.h"

@implementation MCMoreNavView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI{
    
    self.backgroundColor=RGB(255, 255, 255);
    self.layer.cornerRadius=10;
    self.clipsToBounds=YES;
    
    UIButton * btn_WFexplain = [[UIButton alloc]init];
    [self addSubview:btn_WFexplain];
    btn_WFexplain.frame=CGRectMake(0, 10, WIDTH_MCMoreNav, (HEIGHT_MCMoreNav-20)/2.0);
    _btn_WFexplain=btn_WFexplain;
    [btn_WFexplain setTitle:@"玩法说明" forState:UIControlStateNormal];
    [btn_WFexplain setTitleColor:RGB(46, 46, 46) forState:UIControlStateNormal];

    btn_WFexplain.titleLabel.font=[UIFont systemFontOfSize:12];
    
    UIView * line =[[UIView alloc]init];
    line.backgroundColor=[UIColor whiteColor];
    [self addSubview:line];
    line.frame=CGRectMake(17.5, 44.5, 55, 1);
    
    UIButton * btn_PlayRecord = [[UIButton alloc]init];
    [self addSubview:btn_PlayRecord];
    btn_PlayRecord.frame=CGRectMake(0, HEIGHT_MCMoreNav/2.0, WIDTH_MCMoreNav, (HEIGHT_MCMoreNav-20)/2.0);
    _btn_PlayRecord=btn_PlayRecord;
    [btn_PlayRecord setTitle:@"投注记录" forState:UIControlStateNormal];
    [btn_PlayRecord setTitleColor:RGB(46, 46, 46) forState:UIControlStateNormal];
    btn_PlayRecord.titleLabel.font=[UIFont systemFontOfSize:12];
    
}




@end
