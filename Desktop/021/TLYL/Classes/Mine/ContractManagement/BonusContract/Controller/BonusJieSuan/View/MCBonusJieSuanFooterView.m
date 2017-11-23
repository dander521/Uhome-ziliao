//
//  MCBonusJieSuanFooterView.m
//  TLYL
//
//  Created by MC on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBonusJieSuanFooterView.h"


@implementation MCBonusJieSuanFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    UIButton * btn = [[UIButton alloc]init];
    [self setFooter:btn];
    btn.frame=CGRectMake(0, 28, G_SCREENWIDTH-26, 40);
    
}

-(void)setFooter:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"结算" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.backgroundColor=RGB(144,8,215);
    [self addSubview:btn];
    [btn addTarget:self action:@selector(agreeContract) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=6.0;
    btn.clipsToBounds=YES;
}


-(void)agreeContract{
    if (self.block) {
        self.block();
    }
}

+(CGFloat)computeHeight:(id)info{
    return 28+40+30;
}

@end

