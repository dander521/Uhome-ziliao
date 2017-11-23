//
//  MCBonusJieSuanViewController.h
//  TLYL
//
//  Created by MC on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMyXiaJiBonusContractListModel.h"

typedef void(^MCBonusJieSuanViewControllerGoBackBlock)();
@interface MCBonusJieSuanViewController : UIViewController

@property (nonatomic,strong)MCMyXiaJiBonusContractListDeatailDataModel * models;

@property (nonatomic,copy)MCBonusJieSuanViewControllerGoBackBlock goBackBlock;
@end
