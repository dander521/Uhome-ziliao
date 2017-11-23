//
//  MCSignContractViewController.h
//  TLYL
//
//  Created by MC on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMyXiaJiDayWagesThreeRdListModel.h"
typedef NS_ENUM(NSInteger, MCSignOrModifyContractVCType){
    MCSignOrModifyContractVCType_Sign=0,           //签订
    MCSignOrModifyContractVCType_Modify,           //修改
};

typedef void(^MCSignContractVCGoBackBlock)();

@interface MCSignContractViewController : UIViewController

@property (nonatomic,strong) MCMyXiaJiDayWagesThreeListModelsDataModel * xiaJiModel;

@property (nonatomic,assign) MCSignOrModifyContractVCType Type;

@property (nonatomic,copy) MCSignContractVCGoBackBlock goBackBlock;

@end
