//
//  MCMMCKaiJiangView.m
//  TLYL
//
//  Created by MC on 2017/9/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMCKaiJiangView.h"
#import "MMCHeader.h"

@interface MCMMCKaiJiangView ()

@property (nonatomic,strong)UIButton * btn_ball1;

@property (nonatomic,strong)UIButton * btn_ball2;

@property (nonatomic,strong)UIButton * btn_ball3;

@property (nonatomic,strong)UIButton * btn_ball4;

@property (nonatomic,strong)UIButton * btn_ball5;


@end

@implementation MCMMCKaiJiangView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UIImageView * backImgv = [[UIImageView alloc]init];
    [self addSubview:backImgv];
    backImgv.image=[UIImage imageNamed:@"mmc_backView"];
    backImgv.frame=CGRectMake(0, 0, W_MMC_VIEW, W_MMC_VIEW*0.94558);
    
    _btn_ball1=[[UIButton alloc]init];
    [self setBallBtn:_btn_ball1 andIndex:0];

    _btn_ball2=[[UIButton alloc]init];
    [self setBallBtn:_btn_ball2 andIndex:1];


    _btn_ball3=[[UIButton alloc]init];
    [self setBallBtn:_btn_ball3 andIndex:2];


    _btn_ball4=[[UIButton alloc]init];
    [self setBallBtn:_btn_ball4 andIndex:3];


    _btn_ball5=[[UIButton alloc]init];
    [self setBallBtn:_btn_ball5 andIndex:4];
    
    
    UIButton * btn_Stop=[[UIButton alloc]init];
    btn_Stop.backgroundColor=RGB(144,8,215);
    [btn_Stop setTitle:@"停止开奖" forState:UIControlStateNormal];
    [btn_Stop.titleLabel setTextColor:[UIColor whiteColor]];
    btn_Stop.layer.cornerRadius=17;
    [btn_Stop addTarget:self action:@selector(stopKaiJiang) forControlEvents:UIControlEventTouchUpInside];
    btn_Stop.clipsToBounds=YES;
    [self addSubview:btn_Stop];
    btn_Stop.frame=CGRectMake((W_MMC_VIEW-126)/2.0,H_MMC_VIEW-34,126,34);
    
    
    UILabel * lab_title=[[UILabel alloc]init];
    lab_title.text=@"第 01 次开奖";
    lab_title.font=[UIFont systemFontOfSize:12];
    lab_title.textColor=[UIColor whiteColor];
    [self addSubview:lab_title];
    lab_title.textAlignment=NSTextAlignmentCenter;
    _lab_title=lab_title;
    lab_title.frame=CGRectMake(0, 205, W_MMC_VIEW, 25);
    
}

-(void)stopKaiJiang{
    if (self.block) {
        self.block();
    }
}

-(void)setDataSource:(NSString *)dataSource{
    _dataSource=dataSource;
    
    NSArray * arrNum=[dataSource componentsSeparatedByString:@","];
    
    [_btn_ball1 setTitle:arrNum[0] forState:UIControlStateNormal];
    
    [_btn_ball2 setTitle:arrNum[1] forState:UIControlStateNormal];
    
    [_btn_ball3 setTitle:arrNum[2] forState:UIControlStateNormal];
    
    [_btn_ball4 setTitle:arrNum[3] forState:UIControlStateNormal];
    
    [_btn_ball5 setTitle:arrNum[4] forState:UIControlStateNormal];
    
}


-(void)setBallBtn:(UIButton*)btn andIndex:(int)index{
 
    CGFloat W=33;
    CGFloat padding = 3;
    CGFloat L = (W_MMC_VIEW-4*padding-W*5)/2.0 ;
    
    
    [btn setBackgroundImage:[UIImage imageNamed:@"mmc_kaidiyuan"] forState:UIControlStateNormal];
    [self addSubview:btn];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"0" forState:UIControlStateNormal];
    [btn.titleLabel setTextColor:[UIColor whiteColor]];
    btn.frame=CGRectMake(L+index*(W+padding), 148, W, W);
    btn.backgroundColor=[UIColor clearColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end














































