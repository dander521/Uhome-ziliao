//
//  MCWageRecordHeaderView.m
//  TLYL
//
//  Created by MC on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCWageRecordHeaderView.h"

@implementation MCWageRecordHeaderView

- (instancetype)initWithTitleArr:(NSArray *)titleArr{
    if (self == [super init]) {
        self.backgroundColor=RGB(249, 249, 249);
        [self setUpUI:titleArr];
    }
    
    return self;
}


- (void)setUpUI:(NSArray *)titleArr{
    CGFloat H = 40;
    CGFloat K1= 0.25;
    CGFloat K2= 0.15;
    CGFloat K3= 0.225;
    CGFloat W = G_SCREENWIDTH-26;
    
    CGFloat W1=W*K1;
    CGFloat W2=W*K2;
    CGFloat W3=W*K3;
    CGFloat W4=W-W1-W2-W3;
    UILabel *lab1=[[UILabel alloc]init];
    lab1.frame=CGRectMake(13, 0, W1, H);
    [self setLab:lab1 Font:12 Color:RGB(46, 46, 46) TextAlignment:NSTextAlignmentCenter Text:titleArr[0]];
    UIView * line1=[[UIView alloc]init];
    line1.backgroundColor=RGB(237, 237, 237);
    [self addSubview:line1];
    line1.frame=CGRectMake(13+W1, 0, 0.8, H);
    
    
    UILabel *lab2=[[UILabel alloc]init];
    [self setLab:lab2 Font:12 Color:RGB(46, 46, 46) TextAlignment:NSTextAlignmentCenter Text:titleArr[1]];
    lab2.frame=CGRectMake(13+W1, 0, W2, H);
    UIView * line2=[[UIView alloc]init];
    line2.backgroundColor=RGB(237, 237, 237);
    [self addSubview:line2];
    line2.frame=CGRectMake(13+W1+W2, 0, 0.8, H);
    
    UILabel *lab3=[[UILabel alloc]init];
    [self setLab:lab3 Font:12 Color:RGB(46, 46, 46) TextAlignment:NSTextAlignmentCenter Text:titleArr[2]];
    lab3.frame=CGRectMake(13+W1+W2, 0, W3, H);
    UIView * line3=[[UIView alloc]init];
    line3.backgroundColor=RGB(237, 237, 237);
    [self addSubview:line3];
    line3.frame=CGRectMake(13+W1+W2+W3, 0, 0.8, H);
    
    UILabel *lab4=[[UILabel alloc]init];
    [self setLab:lab4 Font:12 Color:RGB(46, 46, 46) TextAlignment:NSTextAlignmentCenter Text:titleArr[3]];
    lab4.frame=CGRectMake(13+W1+W2+W3, 0, W4, H);
    
}

-(void)setLab:(UILabel *)lab Font:(CGFloat)font Color:(UIColor *)color TextAlignment:(NSTextAlignment)textAlignment Text:(NSString *)text{
    lab.textColor=color;
    lab.font=[UIFont systemFontOfSize:font];
    lab.text = text;
    lab.textAlignment=textAlignment;
    [self  addSubview:lab];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

