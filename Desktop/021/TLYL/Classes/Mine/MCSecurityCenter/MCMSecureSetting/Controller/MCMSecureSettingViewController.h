//
//  MCMSecureSettingViewController.h
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineBaseViewController.h"

typedef NS_ENUM(NSInteger, MCMSecureSettingType){
    MCMSecureSettingType_FirstSet=0,           //第一次设置密保
    MCMSecureSettingType_ModifySet,            //修改密保
};

@interface MCMSecureSettingViewController : MCMineBaseViewController
@property (nonatomic,assign) MCMSecureSettingType Type;

@end
