//
//  MCMCSystemNoticeDetailCell.h
//  TLYL
//
//  Created by MC on 2017/8/4.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSystemNoticeDetailModel.h"
@interface MCMCSystemNoticeDetailCell : UITableViewCell

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong) MCSystemNoticeDetailModel *dataSource;

@end
