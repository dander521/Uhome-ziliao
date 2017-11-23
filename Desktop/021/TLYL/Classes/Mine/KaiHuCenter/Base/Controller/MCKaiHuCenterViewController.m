//
//  MCKaiHuCenterViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCKaiHuCenterViewController.h"
#import "UIColor+MCColor.h"
#import "UIImage+Extension.h"
#import "MCKaiHuFViewController.h"
#import "MCKaiHuSecViewController.h"
#import "MCKaiHuThdViewController.h"
#import "MCKaiHuCenterNavigationController.h"

@interface MCKaiHuCenterViewController ()

@end

@implementation MCKaiHuCenterViewController

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
    
    [self setChildViewController:[[MCKaiHuFViewController alloc] init] title:@"精准开户" normalImage:[UIImage originalImageFromImageNamed:@"dlgl-dlsy-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"dlgl-dlsy-xz"]];
  
    [self setChildViewController:[[MCKaiHuSecViewController alloc] init] title:@"链接开户" normalImage:[UIImage originalImageFromImageNamed:@"dlgl-hygl-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"dlgl-hygl-xz"]];
    
    [self setChildViewController:[[MCKaiHuThdViewController alloc] init] title:@"链接管理" normalImage:[UIImage originalImageFromImageNamed:@"dlgl-tdtz-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"dlgl-tdtz-xz"]];
    

}

- (void)setChildViewController:(UIViewController *)viewController title:(NSString *)title normalImage:
(UIImage *)image selectedImage:(UIImage *)selectedImage{
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    MCKaiHuCenterNavigationController *navi = [[MCKaiHuCenterNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:navi];
    
}

@end
