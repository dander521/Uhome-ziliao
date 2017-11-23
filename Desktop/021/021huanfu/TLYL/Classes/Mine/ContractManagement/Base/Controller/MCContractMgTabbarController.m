//
//  MCContractMgTabbarController.m
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCContractMgTabbarController.h"
#import "MCBonusContractViewController.h"
#import "MCBonusRecordViewController.h"
#import "MCWageContractViewController.h"
#import "MCWageRecordViewController.h"
#import "MCContractMgtNavigationViewController.h"
#import "UIColor+MCColor.h"
#import "UIImage+Extension.h"
#import "MCMineInfoModel.h"

@interface MCContractMgTabbarController ()

@end

@implementation MCContractMgTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChildViewController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(POP_MCContractMgtNavigationViewController) name:@"POP_MCContractMgtNavigationViewController" object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)POP_MCContractMgtNavigationViewController{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)setChildViewController{
    
    MCMineInfoModel *mineInfoModel =[MCMineInfoModel sharedMCMineInfoModel];

    if (mineInfoModel.IsDayWages) {
        [self setChildViewController:[[MCWageContractViewController alloc] init] title:@"日工资契约" normalImage:[UIImage originalImageFromImageNamed:@"qygl-gzqy-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"qygl-gzqy-xz"]];
        
        [self setChildViewController:[[MCWageRecordViewController alloc] init] title:@"日工资记录" normalImage:[UIImage originalImageFromImageNamed:@"qygl-gzjl-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"qygl-gzjl-xz"]];
    }
    
    if (mineInfoModel.IsDividend) {
        [self setChildViewController:[[MCBonusContractViewController alloc] init] title:@"分红契约" normalImage:[UIImage originalImageFromImageNamed:@"qygl-fhqy-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"qygl-fhqy-xz"]];
        
        [self setChildViewController:[[MCBonusRecordViewController alloc] init] title:@"分红记录" normalImage:[UIImage originalImageFromImageNamed:@"qygl-fhjl-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"qygl-fhjl-xz"]];
    }
   
}

- (void)setChildViewController:(UIViewController *)viewController title:(NSString *)title normalImage:
(UIImage *)image selectedImage:(UIImage *)selectedImage{
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    MCContractMgtNavigationViewController *navi = [[MCContractMgtNavigationViewController alloc] initWithRootViewController:viewController];
    [self addChildViewController:navi];
    
}


@end














