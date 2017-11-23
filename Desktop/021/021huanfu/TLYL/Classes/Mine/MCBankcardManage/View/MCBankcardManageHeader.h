//
//  MCBankcardManageHeader.h
//  TLYL
//
//  Created by MC on 2017/9/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCBankcardManageHeaderDelegate <NSObject>
@required
/*
 * 添加银行卡
 */
-(void)goToAddBankcardViewController;

@end

@interface MCBankcardManageHeader : UIView

@property (nonatomic, weak) id<MCBankcardManageHeaderDelegate>delegate;

-(void)setHiddenBtn;

+(CGFloat)computeHeight:(id)info;

@end
