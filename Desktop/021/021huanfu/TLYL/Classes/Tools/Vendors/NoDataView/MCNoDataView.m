//
//  MCNoDataView.m
//  TLYL
//
//  Created by miaocai on 2017/7/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCNoDataView.h"
static UIView *_customView;
@interface MCNoDataView()

@end

@implementation MCNoDataView

+ (void)show{
 
//        
//        UIView *view = [[UIApplication sharedApplication].windows lastObject];
//    
//        UIView *customView = [[UIView alloc] init];
//        customView.backgroundColor = [UIColor blueColor];
//        customView.frame = CGRectMake(100, 100, 200, 200);
//        _customView = customView;
//        [view addSubview:customView];
//    
//    UIButton *btn = [[UIButton alloc] init];
//    [customView addSubview:btn];
//    btn.backgroundColor = [UIColor redColor];
//    btn.frame = CGRectMake(100, 100, 50, 50);
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

+ (void)btnClick{
//    [MCNoDataView hiden];
}

+ (void)hiden{
    
    [_customView removeFromSuperview];
}
@end
