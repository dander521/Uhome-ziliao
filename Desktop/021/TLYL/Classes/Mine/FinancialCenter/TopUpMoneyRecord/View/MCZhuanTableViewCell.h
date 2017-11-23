//
//  MCZhuanTableViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCZhuanRecordModel.h"

@interface MCZhuanTableViewCell : UITableViewCell
@property (nonatomic,strong) MCZhuanRecordModel *dataSource;
@end
