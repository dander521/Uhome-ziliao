//
//  MCInBoxTableViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/11/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCEmailListModel.h"
#import "MCSendListModel.h"

@interface MCInBoxTableViewCell : UITableViewCell
@property (nonatomic,strong) MCEmailListModel *dataSource;
@property (nonatomic,strong) MCSendListModel *dataSourceSend;
@end
