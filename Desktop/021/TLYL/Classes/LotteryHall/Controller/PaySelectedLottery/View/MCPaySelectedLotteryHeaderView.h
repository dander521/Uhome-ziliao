//
//  MCPaySelectedLotteryHeaderView.h
//  TLYL
//
//  Created by MC on 2017/6/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MCPaySelectedLotteryHeaderView : UIView


+(CGFloat)computeHeight:(id)info;

@property (nonatomic,weak) UILabel *valueLabel;

@property (nonatomic,assign) int dataSource;

@property (nonatomic,strong)NSString * IssueNumber;

@property (nonatomic,strong)void (^timeISZeroBlock)();

-(void)stopTimer;
@end

