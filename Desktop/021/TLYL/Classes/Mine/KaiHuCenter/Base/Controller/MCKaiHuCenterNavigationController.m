//
//  MCKaiHuCenterNavigationController.m
//  TLYL
//
//  Created by miaocai on 2017/11/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCKaiHuCenterNavigationController.h"
#import "MCPeiEFrtViewController.h"
#import "MCSecPeiEViewController.h"

@interface MCKaiHuCenterNavigationController ()

@end

@implementation MCKaiHuCenterNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //    viewController.navigationController.navigationBarHidden=NO;
    //    viewController.navigationController.navigationBar.translucent = NO;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"图层-6"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"图层-6"] forState:UIControlStateHighlighted];
    button.size = CGSizeMake(70, 30);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    // 如果push进来的不是第一个控制器
    if ( self.childViewControllers.count == 0) {
        [button addTarget:self action:@selector(popViewControllerAnimated) forControlEvents:UIControlEventTouchUpInside];
    }else{
        if ([viewController isKindOfClass:[MCPeiEFrtViewController class]]||[viewController isKindOfClass:[MCSecPeiEViewController class]]) {
            viewController.hidesBottomBarWhenPushed = YES;
        } else {
            viewController.hidesBottomBarWhenPushed = NO;
        }
        
        [button addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    [super pushViewController:viewController animated:animated];
}
- (void)popViewControllerAnimated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCTMNavigationViewController" object:nil];
    [self popViewControllerAnimated:YES];
}


@end
