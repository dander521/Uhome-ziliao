//
//  MCCZTXView.m
//  TLYL
//
//  Created by miaocai on 2017/6/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCCZTXView.h"
#import "MCRechargeViewController.h"
#import "MCWithdrawRecDeltailViewController.h"
#import "UIView+MCParentController.h"
#import "MCHomeRechargeButton.h"

@interface MCCZTXView()

@property (nonatomic,weak) MCHomeRechargeButton *czBtn;

@property (nonatomic,weak) MCHomeRechargeButton *txBtn;

@property (nonatomic,weak) MCHomeRechargeButton *activityBtn;

@property (nonatomic,weak) MCHomeRechargeButton *gameBtn;

@end

@implementation MCCZTXView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    self.backgroundColor = [UIColor whiteColor];
    MCHomeRechargeButton *czBtn = [[MCHomeRechargeButton alloc] init];
    [czBtn setTitle:@"快速充值" forState:UIControlStateNormal];
    [czBtn setImage:[UIImage imageNamed:@"home-iocn-recharge"] forState:UIControlStateNormal];
    [czBtn setTitleColor:RGB(39, 38, 54) forState:UIControlStateNormal];
    czBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(15)];
    [czBtn addTarget:self action:@selector(action_recharge) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:czBtn];
    self.czBtn = czBtn;
    
    MCHomeRechargeButton *txBtn = [[MCHomeRechargeButton alloc] init];
    [txBtn setTitle:@"立即提款" forState:UIControlStateNormal];
    [txBtn setImage:[UIImage imageNamed:@"home-icon-withdrawals"] forState:UIControlStateNormal];
    [txBtn setTitleColor:RGB(39, 38, 54) forState:UIControlStateNormal];
    txBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(15)];
    [txBtn addTarget:self action:@selector(action_withdraw) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:txBtn];
    self.txBtn = txBtn;
    
    MCHomeRechargeButton *gameBtn = [[MCHomeRechargeButton alloc] init];
    [gameBtn setTitle:@"投注记录" forState:UIControlStateNormal];
    [gameBtn setImage:[UIImage imageNamed:@"home-icon-record"] forState:UIControlStateNormal];
    [gameBtn setTitleColor:RGB(39, 38, 54) forState:UIControlStateNormal];
    gameBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(15)];
    [gameBtn addTarget:self action:@selector(gameBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:gameBtn];
    self.gameBtn = gameBtn;
    
    MCHomeRechargeButton *activityBtn = [[MCHomeRechargeButton alloc] init];
    [activityBtn setTitle:@"优惠活动" forState:UIControlStateNormal];
    [activityBtn setImage:[UIImage imageNamed:@"home-icon-activity"] forState:UIControlStateNormal];
    [activityBtn setTitleColor:RGB(39, 38, 54) forState:UIControlStateNormal];
    activityBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(15)];
    [activityBtn addTarget:self action:@selector(activityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:activityBtn];
    self.activityBtn = activityBtn;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.czBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(MC_REALVALUE(24));
        make.left.equalTo(self).mas_offset(MC_REALVALUE(0));
        make.width.equalTo(@(G_SCREENWIDTH * 0.25));
        make.height.equalTo(@(50));
    }];
    
    [self.txBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.czBtn);
        make.width.equalTo(@(G_SCREENWIDTH * 0.25));
        make.left.equalTo(self.czBtn.mas_right);
        make.height.equalTo(@(50));
    }];
    [self.gameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.czBtn);
        make.width.equalTo(@(G_SCREENWIDTH * 0.25));
        make.left.equalTo(self.txBtn.mas_right);
        make.height.equalTo(@(50));
    }];
    
    [self.activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.czBtn);
        make.width.equalTo(@(G_SCREENWIDTH * 0.25));
        make.left.equalTo(self.gameBtn.mas_right);
        make.height.equalTo(@(50));
    }];
    
}

#pragma mark-充值


-(void)action_recharge{
    
    if (self.chongzhiBtnClickBlock) {
        self.chongzhiBtnClickBlock();
    }

}

#pragma mark-提现
-(void)action_withdraw{
        if (self.tixianBtnClickBlock) {
        self.tixianBtnClickBlock();
    }
}


- (void)gameBtnClick{
    if (self.gameBtnClickBlock) {
        self.gameBtnClickBlock();
    }
    
}

- (void)activityBtnClick{
    if (self.activityBtnClickBlock) {
        self.activityBtnClickBlock();
    }
}
@end
