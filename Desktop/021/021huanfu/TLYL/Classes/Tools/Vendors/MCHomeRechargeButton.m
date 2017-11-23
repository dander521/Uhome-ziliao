//
//  MCHomeRechargeButton.m
//  TLYL
//
//  Created by miaocai on 2017/9/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCHomeRechargeButton.h"

@implementation MCHomeRechargeButton


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat h = 30;
    self.imageView.frame = CGRectMake((self.widht - h) *0.5, 0, h, h);
    self.titleLabel.frame = CGRectMake(0, 40, self.widht, 10);
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"2e2e2e"];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

 }
@end
