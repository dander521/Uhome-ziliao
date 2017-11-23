//
//  MCBonusJieSuanFooterView.h
//  TLYL
//
//  Created by MC on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MCBonusJieSuanFooterViewBlock)();



@interface MCBonusJieSuanFooterView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,copy)MCBonusJieSuanFooterViewBlock block;

@end
