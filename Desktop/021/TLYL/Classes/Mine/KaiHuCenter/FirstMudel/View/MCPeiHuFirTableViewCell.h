//
//  MCPeiHuFirTableViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPeiEFModel.h"

@interface MCPeiHuFirTableViewCell : UITableViewCell

@property (nonatomic,strong) MCPeiEFModel *dataSource;
//序号
@property (nonatomic,weak) UILabel *numLabel;
@end
