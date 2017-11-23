//
//  MCRechargeDetailUserInfoTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/8/9.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCRechargeModel.h"
@interface MCRechargeDetailUserInfoTableViewCell : UITableViewCell
+(CGFloat)computeHeight:(id)info;
@property (nonatomic,strong) MCRechargeModel* dataSource;
@end
