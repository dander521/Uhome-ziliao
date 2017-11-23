//
//  MCMineNavBarView.m
//  TLYL
//
//  Created by MC on 2017/9/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineNavBarView.h"
#import "UIView+MCParentController.h"

@implementation MCMineNavBarView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpViews];
        
    }
    
    return  self;
}

-(void)setUpViews{
    
    self.backgroundColor=RGB(90, 0, 148);
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(G_SCREENWIDTH/2-50, 20, 100, 44)];
    title.text = @"我的账户";
    self.titleLab = title;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textColor = RGB(255, 255, 255);
    [self addSubview:title];
    

    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:@"user-icon"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"user-icon"] forState:UIControlStateHighlighted];
//    button.size = CGSizeMake(70, 30);
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    button.contentEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
////    [button addTarget:self action:@selector(personInfoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:button];
//    button.frame=CGRectMake(10, 25, 20, 20);
    
}



-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.titleLab.text = _titleStr;
}


-(void)setAlphValue:(CGFloat)alphValue
{
    
    
}
@end
