//
//  MCSettingFooterView.m
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSettingFooterView.h"

@interface MCSettingFooterView ()
@property (nonatomic,strong)UIButton * logOutBtn;
@end

@implementation MCSettingFooterView
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
    
    _logOutBtn=[[UIButton alloc]init];
    [_logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    _logOutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _logOutBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [_logOutBtn setBackgroundImage:[UIImage imageNamed:@"Button_Determine"] forState:UIControlStateNormal];
//    [_logOutBtn setImage:[UIImage imageNamed:@"Button_Determin_Right"] forState:UIControlStateNormal];
    [self addSubview:_logOutBtn];
    [_logOutBtn addTarget:self action:@selector(action_logOut) forControlEvents:UIControlEventTouchUpInside];
    _logOutBtn.layer.cornerRadius=10.0;
    _logOutBtn.clipsToBounds=YES;
    

    
    
    [self layOutConstraints];
    
}


-(void)action_logOut{
    
    if ([self.delegate respondsToSelector:@selector(performLogOut)]) {
        [self.delegate performLogOut];
    }
    
}

-(void)layOutConstraints{
    
    [_logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top).offset(50);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

+(CGFloat)computeHeight:(id)info{
    return 100;
}

@end
