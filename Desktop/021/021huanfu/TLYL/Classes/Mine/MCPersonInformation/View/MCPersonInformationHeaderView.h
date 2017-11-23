//
//  MCPersonInformationHeaderView.h
//  TLYL
//
//  Created by MC on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMineInfoModel.h"
@interface MCPersonInformationHeaderView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong) MCMineInfoModel * dataSource;

@end
