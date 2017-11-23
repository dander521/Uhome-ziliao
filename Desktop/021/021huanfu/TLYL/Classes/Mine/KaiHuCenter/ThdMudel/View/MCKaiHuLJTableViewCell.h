//
//  MCKaiHuLJTableViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCRegisteredLinksModel.h"
@interface MCKaiHuLJTableViewCell : UITableViewCell
@property (nonatomic,weak) UILabel *numLabel;
@property (nonatomic,strong) MCRegisteredLinksModel *dataSource;
@end
