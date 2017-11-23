//
//  MCDatePickerView.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sureButtonBlock)(NSString * selectDateStr);

@interface MCDatePickerView : UIView

@property (nonatomic,strong) sureButtonBlock sureBlock;


//快速创建
+(instancetype)InitWithTitle:(NSString *)title Mindate:(NSDate *)minDate MaxDate:(NSDate *)maxdate;
//弹出
-(void)show;


@end
