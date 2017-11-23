//
//  MCMCQiPaizhuanzhangTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, Zhuanzhang_Type){
    ZhuanzhangType_LottoryToQiPai=0,
    ZhuanzhangType_QiPaiToLottory
};

typedef void(^selectedTypeBlock)(Zhuanzhang_Type Type);
typedef void(^goToZhuanZhangBlock)();
@interface MCMCQiPaizhuanzhangTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,assign)Zhuanzhang_Type Type;

@property (nonatomic,copy) goToZhuanZhangBlock gBlock;

@property (weak, nonatomic)  UITextField * moneyTextField;
@property (weak, nonatomic)  UITextField * passwordTextField;

@property (nonatomic,assign) double DrawMaxMoney;
@property (nonatomic,copy)   selectedTypeBlock sBlock;

@end

