//
//  MCContractMgtNavigationViewController.m
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCContractMgtNavigationViewController.h"

@interface MCContractMgtNavigationViewController ()

@end

@implementation MCContractMgtNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.navigationController.navigationBarHidden=NO;
    viewController.navigationController.navigationBar.translucent = NO;
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
        [button addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
    [super pushViewController:viewController animated:animated];
}
- (void)popViewControllerAnimated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POP_MCContractMgtNavigationViewController" object:nil];
    [self popViewControllerAnimated:YES];
}

@end

