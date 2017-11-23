//
//  MCQiPaizhuanzhangHeaderView.h
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QiPaiCompeletion)(BOOL result);

@interface MCQiPaizhuanzhangHeaderView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong) id dataSource;

-(void)shuaXinYuE:(QiPaiCompeletion)compeletion;

/*
 * 账户余额
 */
@property (nonatomic,strong)UILabel * qipai_yuElab;
@property (nonatomic,strong)UILabel * lottory_yuElab;

@end
