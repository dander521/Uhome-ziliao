
//
//  MCMMPopView.m
//  TLYL
//
//  Created by miaocai on 2017/10/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMPopView.h"
@interface MCMMPopView()

@end

@implementation MCMMPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    self.startDateLabDetail.text= @"";
    self.endDateLabDetail.text = @"";
    self.imgV.hidden = YES;
    self.frame = CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT);
    self.bgView.frame = CGRectMake(13, 64 + MC_REALVALUE(10), G_SCREENWIDTH - 26, 150);
    self.titleLabDetail.hidden  = YES;
    UITextField  *tf=[[UITextField alloc]init];
    [self.bgViewTitle addSubview:tf];
    self.tf = tf;
    tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入用户名称" attributes:@{NSForegroundColorAttributeName:RGB(181, 181, 181),NSFontAttributeName:[UIFont systemFontOfSize:MC_REALVALUE(14)]}];
    tf.textAlignment = NSTextAlignmentRight;
    [self.bgViewSt setHidden:YES];
    self.bgViewStart.frame = CGRectMake(0, 50, G_SCREENWIDTH - 26, 49.5);
    self.bgViewEnd.frame = CGRectMake(0, 100, G_SCREENWIDTH - 26, 49.5);
    [self.bgViewSt setUserInteractionEnabled:NO];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(17);
        make.left.equalTo(self.bgView).offset(11);
        make.height.equalTo(@(38));
        
    }];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.centerY.equalTo(self.titleLab);
        make.width.equalTo(@(MC_REALVALUE(129)));
    }];
    
 
    [self.startDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgViewTitle.mas_bottom).offset(11);
        make.left.equalTo(self.bgViewTitle).offset(11);
        make.height.equalTo(@(38));
    }];

    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.equalTo(self.bgView).offset(99.5);
        make.right.left.equalTo(self.bgViewStart);
    }];

    [self.startDateLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.centerY.equalTo(self.startDateLab);
        make.width.equalTo(@(MC_REALVALUE(129)));
    }];
    

//    [self.imgVs mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLabDetail.mas_right).offset(5);
//        make.centerY.equalTo(self.startDateLab);
//    }];

    
    [self.endDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startDateLab.mas_bottom).offset(11);
        make.left.equalTo(self.titleLab).offset(11);
        make.height.equalTo(@(38));
        
    }];
    
  
    
    [self.endDateLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.centerY.equalTo(self.endDateLab);
        make.width.equalTo(@(MC_REALVALUE(129)));
        
    }];
    
//    [imgVe mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLabDetail.mas_right).offset(5);
//        make.centerY.equalTo(self.endDateLab);
//    }];
}



- (void)bgViewClick{
    [self.tf resignFirstResponder];
    if (self.endDateBlock) {
        self.endDateBlock();
    }
}

- (void)bgViewStartClick{
    [self.tf resignFirstResponder];
    if (self.startDateBlock) {
        self.startDateBlock();
    }
}
- (void)bgViewStClick{
    [self.tf resignFirstResponder];
    if (self.statusBlock) {
        self.statusBlock();
    }
}

- (void)bgViewTitleClick{
    [self.tf resignFirstResponder];
    if (self.lotteryBlock) {
        self.lotteryBlock();
    }
}

- (void)searchBtnClick{
    [self.tf resignFirstResponder];
    if (self.searchBtnBlock) {
        self.searchBtnBlock(self.tf.text);
    }
    self.hidden = YES;
}
@end








