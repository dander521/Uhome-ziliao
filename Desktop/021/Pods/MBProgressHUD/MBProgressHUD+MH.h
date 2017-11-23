//
//  MBProgressHUD+MH.h
//  Pods
//
//  Created by miaocai on 2017/6/22.
//
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (MH)

+ (void)showSuccess:(NSString *)success;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;

+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;


@end
