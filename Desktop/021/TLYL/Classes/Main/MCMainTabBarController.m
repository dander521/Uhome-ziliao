//
//  MCMainTabBarController.m
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMainTabBarController.h"
#import "MCLotteryHallViewController.h"
#import "MCLotteryDrawViewController.h"
#import "MCBuyLotteryViewController.h"
#import "MCMineViewController.h"
#import "MCMainNavigationController.h"
#import "UIColor+MCColor.h"
#import "UIImage+Extension.h"
#import "MCLoginViewController.h"

//xcode配置 git 测试 这是一个测试 
@interface MCMainTabBarController ()
@property (nonatomic,weak) UIViewController *vc;
@property (nonatomic,assign) long count;
@end

@implementation MCMainTabBarController

+(void)load{
    
   UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MC_ColorWithAlpha(144, 8, 215, 1),NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} forState:UIControlStateSelected];
     [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MC_ColorWithAlpha(125, 125, 134, 1),NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setChildViewController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLoginVC) name:@"PRESENT_LOGINVC_NOTICATION" object:nil];
    
}

- (void)presentLoginVC{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userId"];
    MCLoginViewController *loginVC = [[MCLoginViewController alloc] init];
    loginVC.presented = YES;
    NSLog(@"%@----",self.presentedViewController);
    [self presentViewController:loginVC animated:YES completion:nil];
    
}

- (void)setChildViewController{
    
    [self setChildViewController:[[MCLotteryHallViewController alloc] init] title:@"首页" normalImage:[UIImage originalImageFromImageNamed:@"tabbar-home-normal"] selectedImage:[UIImage originalImageFromImageNamed:@"tabbar-home-highlight"]];
    
     [self setChildViewController:[[MCBuyLotteryViewController alloc] init] title:@"购彩" normalImage:[UIImage originalImageFromImageNamed:@"tabbar-lottery-normal"] selectedImage:[UIImage originalImageFromImageNamed:@"tabbar-lottery-highlight"]];
 
    [self setChildViewController:[[MCLotteryDrawViewController alloc] init] title:@"开奖" normalImage:[UIImage originalImageFromImageNamed:@"tabbar-prize-normal"] selectedImage:[UIImage originalImageFromImageNamed:@"tabbar-prize-highlight"]];
    
     [self setChildViewController:[[MCMineViewController alloc] init] title:@"账户" normalImage:[UIImage originalImageFromImageNamed:@"tabbar-my-normal"] selectedImage:[UIImage originalImageFromImageNamed:@"tabbar-my-highlight"]];
    
}

- (void)setChildViewController:(UIViewController *)viewController title:(NSString *)title normalImage:
(UIImage *)image selectedImage:(UIImage *)selectedImage{
    
    if (/* DISABLES CODE */ (0)) {
        [self requestTabBarIconFromServer];
    } else {
        viewController.tabBarItem.title = title;
        viewController.tabBarItem.image = image;
        viewController.tabBarItem.selectedImage = selectedImage;
        MCMainNavigationController *navi = [[MCMainNavigationController alloc] initWithRootViewController:viewController];
        [self addChildViewController:navi];
      
    }
}

- (void)requestTabBarIconFromServer{
    
    //从服务器获得tabbar数据
}


@end
