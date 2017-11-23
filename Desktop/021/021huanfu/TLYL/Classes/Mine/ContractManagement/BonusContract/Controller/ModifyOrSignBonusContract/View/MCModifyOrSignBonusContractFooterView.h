//
//  MCModifyOrSignBonusContractFooterView.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Type_MCModifyOrSignBonusContractFooterAction) {
    MC_ModifyOrSignBonusContractFooterAction_Delete=0,//CC
    MC_ModifyOrSignBonusContractFooterAction_Add,//AA
    MC_ModifyOrSignBonusContractFooterAction_Save
};

typedef void(^ModifyOrSignBonusContractFooterActionBlock)(Type_MCModifyOrSignBonusContractFooterAction type);
@interface MCModifyOrSignBonusContractFooterView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,copy)ModifyOrSignBonusContractFooterActionBlock footerActionBlock;

-(void)setDeleteBtnHidden:(BOOL)hidden;
@end
