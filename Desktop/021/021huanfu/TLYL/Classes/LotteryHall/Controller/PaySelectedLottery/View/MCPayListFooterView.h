//
//  MCPayListFooterView.h
//  TLYL
//
//  Created by MC on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPaySelectedLotteryModel.h"

typedef void(^SelectedLotteryFooter_ActionBlock)(NSInteger t);

@interface MCPayListFooterView : UIView


+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong) MCPaySLBaseModel* dataSource;

@property (nonatomic,  copy)SelectedLotteryFooter_ActionBlock    block;


@end

