//
//  MCBankcardManageHeader.m
//  TLYL
//
//  Created by MC on 2017/9/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBankcardManageHeader.h"

@interface MCBankcardManageHeader ()

@property (nonatomic,strong)UIButton *btn_Add;

@end

@implementation MCBankcardManageHeader
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
    //添加银行卡
    _btn_Add=[[UIButton alloc]init];
    [self setFooter:_btn_Add];

    [self layOutConstraints];
    
}

/*
 * 点击 添加银行卡
 */
-(void)action_Add{
    
    if ([self.delegate respondsToSelector:@selector(goToAddBankcardViewController)]) {
        [self.delegate goToAddBankcardViewController];
    }
    
}

-(void)layOutConstraints{
    
    [_btn_Add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(40);
    }];
}

+(CGFloat)computeHeight:(id)info{

    return 40+20;
    
}
-(void)setHiddenBtn{
    _btn_Add.hidden=YES;
}
-(void)setFooter:(UIButton *)btn{
    [_btn_Add setTitleColor:RGB(144,8,215) forState:UIControlStateNormal];
    [_btn_Add setTitle:@"+ 添加银行卡" forState:UIControlStateNormal];
    _btn_Add.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _btn_Add.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    [_btn_Add setBackgroundImage:[UIImage imageNamed:@"Button_Determine"] forState:UIControlStateNormal];
    [_btn_Add setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_btn_Add];
    [_btn_Add addTarget:self action:@selector(action_Add) forControlEvents:UIControlEventTouchUpInside];
    _btn_Add.layer.cornerRadius=10.0;
    _btn_Add.clipsToBounds=YES;
    
    
}


@end
