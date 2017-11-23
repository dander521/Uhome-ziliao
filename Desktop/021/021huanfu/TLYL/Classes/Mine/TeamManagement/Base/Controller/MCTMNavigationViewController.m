//
//  MCTMNavigationViewController.m
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTMNavigationViewController.h"
#import "MCMemberMViewController.h"
#import "MCTeamChargeViewController.h"

@interface MCTMNavigationViewController ()

@end

@implementation MCTMNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        if ([viewController isKindOfClass:[MCMemberMViewController class]]||[viewController isKindOfClass:[MCTeamChargeViewController class]]) {
             viewController.hidesBottomBarWhenPushed = NO;
        } else {
             viewController.hidesBottomBarWhenPushed = YES;
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
