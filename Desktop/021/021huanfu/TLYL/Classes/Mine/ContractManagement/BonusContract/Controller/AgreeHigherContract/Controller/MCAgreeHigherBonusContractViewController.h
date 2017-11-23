//
//  MCAgreeHigherBonusContractViewController.h
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MCAgreeHigherBonusContractViewControllerGoBackBlock)();
@interface MCAgreeHigherBonusContractViewController : UIViewController

@property(nonatomic,copy)MCAgreeHigherBonusContractViewControllerGoBackBlock goBackBlock;
@end
