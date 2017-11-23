//
//  MCPaySelectedLotteryFooterView.h
//  TLYL
//
//  Created by MC on 2017/6/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPaySelectedLotteryModel.h"
@protocol MCPaySelectedLotteryFooterDelegate <NSObject>
@required
/*
 * 立即开奖
 */
-(void)goToRunLotteryImmediately;

@end
typedef NS_ENUM(NSInteger, CZType) {
    MCMMC=0,//秒秒彩
    MCOther,//其他
    
};


typedef void(^SelectedLotteryFooter_ActionBlock)(NSInteger t);

@interface MCPaySelectedLotteryFooterView : UIView

@property (nonatomic, weak) id<MCPaySelectedLotteryFooterDelegate>delegate;

+(CGFloat)computeHeight:(CZType)type;

@property (nonatomic,strong) MCPaySLBaseModel* dataSource;

@property (nonatomic,  copy)SelectedLotteryFooter_ActionBlock    block;

-(void)relayOutWithType:(CZType)type;

@property (nonatomic, assign)int lianKaiCount;

@end

