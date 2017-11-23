//
//  MCRechargeTextField.m
//  TLYL
//
//  Created by MC on 2017/7/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeTextField.h"

@implementation MCRechargeTextField
//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
//    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width -15, bounds.size.height);
    CGFloat Left=G_SCREENWIDTH/2.0-60;
    CGRect inset = CGRectMake(Left, bounds.origin.y, bounds.size.width -Left, bounds.size.height);
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width -15, bounds.size.height);
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +15, bounds.origin.y, bounds.size.width -15, bounds.size.height);
    return inset;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
