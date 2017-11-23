//
//  MCKaiHuCenterViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMailCenterViewController.h"
#import "MCMailNavigationController.h"
#import "UIColor+MCColor.h"
#import "UIImage+Extension.h"
#import "MCInBoxListViewController.h"
#import "MCSendListViewController.h"
#import"MCSendMessageViewController.h"


@interface MCMailCenterViewController ()

@end

@implementation MCMailCenterViewController

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
    
    [self setChildViewController:[[MCInBoxListViewController alloc] init] title:@"收件箱" normalImage:[UIImage originalImageFromImageNamed:@"xx-fjx-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"xx-fjx-xz"]];
  
    [self setChildViewController:[[MCSendListViewController alloc] init] title:@"发件箱" normalImage:[UIImage originalImageFromImageNamed:@"xx-sjx-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"xx-sjx-xz"]];
    
    [self setChildViewController:[[MCSendMessageViewController alloc] init] title:@"发消息" normalImage:[UIImage originalImageFromImageNamed:@"xx-fxx-wxz"] selectedImage:[UIImage originalImageFromImageNamed:@"xx-fxx-xz"]];
    

}

- (void)setChildViewController:(UIViewController *)viewController title:(NSString *)title normalImage:
(UIImage *)image selectedImage:(UIImage *)selectedImage{
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    MCMailNavigationController *navi = [[MCMailNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:navi];
    
}

@end
