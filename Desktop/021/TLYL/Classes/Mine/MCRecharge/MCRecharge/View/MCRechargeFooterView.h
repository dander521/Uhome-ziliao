//
//  MCRechargeFooterView.h
//  TLYL
//
//  Created by MC on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MCRechargeFooterDelegate <NSObject>
@required
/*
 * 确认充值
 */
-(void)performRecharge;

@end

@interface MCRechargeFooterView : UIView

@property (nonatomic, weak) id<MCRechargeFooterDelegate>delegate;

+(CGFloat)computeHeight:(id)info;

@end
