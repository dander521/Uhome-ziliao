//
//  BKIndicationView.h
//  TLYL
//
//  Created by MC on 2017/10/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKIndicationView : UIActivityIndicatorView


+(void)showInView:(UIView *)view;
+(void)dismiss;
+(void)showInView:(UIView *)view Point:(CGPoint)point;
+(void)dismissWithCenter:(CGPoint)point;


@end
