//
//  MCAgreeHigherBonusContractFooterView.h
//  TLYL
//
//  Created by MC on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MCAgreeHigherBonusContractBlock)();

@interface MCAgreeHigherBonusContractFooterView : UIView

@property (nonatomic,copy)MCAgreeHigherBonusContractBlock block;

+(CGFloat)computeHeight:(id)info;

@end
