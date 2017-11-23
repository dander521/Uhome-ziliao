//
//  MCCancelPopView.h
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MCCancelPopViewBlock)(NSInteger type);

@interface MCCancelPopView : UIView
//快速创建
+(instancetype)InitPopViewWithTitle:(NSString *)title sureTitle:(NSString *)sureTitle andCancelTitle:(NSString *)cancelTitle;

//弹出
-(void)show;

@property (nonatomic,copy)MCCancelPopViewBlock block;

@end
