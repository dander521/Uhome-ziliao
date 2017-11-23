//
//  MCSystemNoticeTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSystemNoticeListModel.h"
@interface MCSystemNoticeTableViewCell : UITableViewCell


+(CGFloat)computeHeight:(id)info;
@property (nonatomic,strong) MCSystemNoticeListModel * dataSource;


@end
