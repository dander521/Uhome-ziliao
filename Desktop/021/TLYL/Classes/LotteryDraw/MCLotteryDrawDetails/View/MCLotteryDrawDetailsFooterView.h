//
//  MCLotteryDrawDetailsFooterView.h
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LotteryDrawDetailsFooterBlock)();

@interface MCLotteryDrawDetailsFooterView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong) id dataSource;

@property (nonatomic,  copy)LotteryDrawDetailsFooterBlock    block;

@end
