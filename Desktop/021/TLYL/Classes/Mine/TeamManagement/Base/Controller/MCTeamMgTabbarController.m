//
//  MCTeamMgTabbarController.m
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTeamMgTabbarController.h"
#import "MCMemberMViewController.h"
#import "MCProxyHPViewController.h"
#import "MCTeamBViewController.h"
#import "MCTeamCViewController.h"
#import "MCTeamChargeViewController.h"
#import "UIColor+MCColor.h"
#import "UIImage+Extension.h"
#import "MCTMNavigationViewController.h"

@interface MCTeamMgTabbarController ()

@end

@implementation MCTeamMgTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChildViewController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mCTMNavigationViewControllerPopBack) name:@"MCTMNavigationViewController" object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)mCTMNavigationViewControllerPopBack{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)setChildViewController{
    
    [self setChildViewController:[[MCProxyHPViewController alloc] init] title:@"代理首页" normalImage:[UIImage originalImageFromImageNamed:@"dlgl-dlsy-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"dlgl-dlsy-xz"]];
    MCMemberMViewController *vc = [[MCMemberMViewController alloc] init];
    vc.firstSubViewController = YES;
    [self setChildViewController:vc title:@"会员管理" normalImage:[UIImage originalImageFromImageNamed:@"dlgl-hygl-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"dlgl-hygl-xz"]];
    
    [self setChildViewController:[[MCTeamBViewController alloc] init] title:@"团队投注" normalImage:[UIImage originalImageFromImageNamed:@"dlgl-tdtz-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"dlgl-tdtz-xz"]];
    
    [self setChildViewController:[[MCTeamCViewController alloc] init] title:@"团队账变" normalImage:[UIImage originalImageFromImageNamed:@"dlgl-tdzb-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"dlgl-tdzb-xz"]];
    MCTeamChargeViewController *vc1 = [[MCTeamChargeViewController alloc] init];
    vc1.firstSubViewController = YES;
      [self setChildViewController:vc1 title:@"团队报表" normalImage:[UIImage originalImageFromImageNamed:@"dlgl-tdbb-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"dlgl-tdbb-xz"]];
}

- (void)setChildViewController:(UIViewController *)viewController title:(NSString *)title normalImage:
(UIImage *)image selectedImage:(UIImage *)selectedImage{
        viewController.tabBarItem.title = title;
        viewController.tabBarItem.image = image;
        viewController.tabBarItem.selectedImage = selectedImage;
        MCTMNavigationViewController *navi = [[MCTMNavigationViewController alloc] initWithRootViewController:viewController];
        [self addChildViewController:navi];
    
}

@end
