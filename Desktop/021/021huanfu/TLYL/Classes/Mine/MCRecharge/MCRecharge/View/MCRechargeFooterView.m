//
//  MCRechargeFooterView.m
//  TLYL
//
//  Created by MC on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeFooterView.h"
@interface MCRechargeFooterView ()
@property (nonatomic,strong)UIButton * btn_recharge;
@end

@implementation MCRechargeFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=[UIColor clearColor];
    //充值
    _btn_recharge=[[UIButton alloc]init];
    [self setFooter:_btn_recharge];

}

/*
 * 点击确认充值
 */
-(void)action_Recharge{
    
    if ([self.delegate respondsToSelector:@selector(performRecharge)]) {
        [self.delegate performRecharge];
    }
    
}


-(void)setFooter:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"立即充值" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.backgroundColor =RGB(142, 0, 211);
//    [btn setBackgroundImage:[UIImage imageNamed:@"Button_Determine"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"Button_Determin_Right"] forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(action_Recharge) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=10.0;
    btn.clipsToBounds=YES;
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(40);
    }];
}
+(CGFloat)computeHeight:(id)info{
    return 60;
}

@end

























