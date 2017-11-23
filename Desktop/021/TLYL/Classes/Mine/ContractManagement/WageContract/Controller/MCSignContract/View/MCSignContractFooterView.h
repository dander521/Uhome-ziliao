//
//  MCSignContractFooterView.h
//  TLYL
//
//  Created by MC on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyAndSubDayWagesThreeModel.h"

typedef void(^setSignContractBlock)();
@interface MCSignContractFooterView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,copy)setSignContractBlock block;

-(void)setFooterViewHidden:(MCGetMyAndSubDayWagesThreeDataModel *)info;

@end
