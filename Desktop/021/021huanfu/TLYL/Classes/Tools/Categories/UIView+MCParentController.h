//
//  UIView+MCParentController.h
//  TLYL
//
//  Created by MC on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MCParentController)

//通过控制器的布局视图可以获取到控制器实例对象(modal的展现方式需要取到控制器的根视图)
+ (UIViewController *)MCcurrentViewController;
- (UIView *)findFirstResponder;
@end
