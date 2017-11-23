//
//  MCMesSendPersonTableViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCEmailAllModel.h"
@interface MCMesSendPersonTableViewCell : UITableViewCell
@property (nonatomic,strong) MCEmailAllModel *dataSource;
@property (nonatomic,strong) void(^selectedAllSubBlock)(BOOL);
@property (nonatomic,strong) void(^selectedSubBlock)();
@end
