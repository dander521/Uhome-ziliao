//
//  MCMMCPayListFooterView.h
//  TLYL
//
//  Created by MC on 2017/9/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MMCSelectedLotteryFooter_ActionBlock)(NSInteger t);

@interface MCMMCPayListFooterView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,  copy)MMCSelectedLotteryFooter_ActionBlock    block;

@property (nonatomic,strong) MCPaySLBaseModel* dataSource;

@property (nonatomic, assign)int lianKaiCount;

@end
